////////////////////////////////////////////////////////////////////////////////
// Autor: Santiago A. Orellana Pérez
// Creado: 14/8/2013
// Propósito: Exporta un componente gráfico que se utiliza para visualizar
//            la amplitud, tendencia central (media) y variación de la
//            amplitud de una antena.
//            Se utiliza en la implementación de un Radiogoniómetro por
//            Amplitud de cuatro antenas.
////////////////////////////////////////////////////////////////////////////////

unit UVisorDeAmplitudPorAntenas;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Math, ExtCtrls;

//-----------------------------------------------------------------------------
// Colores de la pantalla de azimut.
//-----------------------------------------------------------------------------
const clFondo               = clWhite;
const clBorde               = clBlack;
const clMarca               = clBlack;
const clAmplitudInstantanea = clRed;
const clAmplitudMedia       = clGreen; 
const clAmplitudVariacion   = clBlue;
const clAmplitudBarra       = clLime;

//-----------------------------------------------------------------------------
const CMaxEscala = 100;

//-----------------------------------------------------------------------------
type TNuevosDatos = procedure(Sender: TObject; AmplitudInstantanea, AmplitudMedia,AmplitudVariacion: Double) of object;

//-----------------------------------------------------------------------------
type
  TVisorDeAmplitudPorAntenas = class(TGraphicControl)
  private
     //Para la visualización.
     BMP: Graphics.TBitmap;
     FActualizador: TTimer;                         //Componente que actualiza el gráfico.
     FActualizacionDelGrafico: Integer;             //Intervalo en milisegundos de actualización del gráfico de la pantalla.

     FAmplitudInstantanea: Double;                  //Guarda la amplitud de la antena 1.
     FAmplitudMedia: Double;
     FAmplitudVariacion: Double;

     //Apariencia.
     FMostrarMarcasDeAmplitud: Boolean;
     FMostrarAmplitud: Boolean;
     FMostrarMedia: Boolean;
     FMostrarVariacion: Boolean;

     //Eventos nuevos de este componente.
     FOnNuevosDatosDeAmplitud: TNuevosDatos;
     FOnDibujoTerminado: TNotifyEvent;

     function InterpolarColores(Fraccion: Double; Color1, Color2: TColor): TColor;
     procedure GraficarDatos;
     procedure ActualizarGrafico(Sender: TObject);

     procedure SetActualizacionDelGrafico(valor: Integer);
     procedure SetMostrarVariacion(valor: Boolean);
     procedure SetMostrarMedia(valor: Boolean);
     procedure SetMostrarAmplitud(valor: Boolean);
     procedure SetMostrarMarcasDeAmplitud(valor: Boolean);
  protected
     procedure Paint; override;
     procedure ReSize;  override;
  public
     CongelarGrafica: Boolean;
     constructor Create(AOwner:TComponent); override;
     procedure AgregarDatos(AmpitudInstantanea, TendenciaCentral, Variacion: Double);

     property AmplitudInstantanea: Double read FAmplitudInstantanea;
     property AmplitudMedia: Double read FAmplitudMedia;
     property AmplitudVariacion: Double read FAmplitudVariacion;
     procedure Reiniciar;
  published
     //Propiedades que hereda de sus ancestros.
     property Align;
     property Anchors;
     property Constraints;
     property Enabled;
     property PopupMenu;
     property Hint;
     property ShowHint;
     property Visible;

     //Eventos que hereda de sus ancestros.
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;

     //Propiedades nuevas que implementa.
     property MostrarAmplitud: Boolean read FMostrarAmplitud Write SetMostrarAmplitud default True;
     property MostrarMedia: Boolean read FMostrarMedia Write SetMostrarMedia default True;
     property MostrarVariacion: Boolean read FMostrarVariacion Write SetMostrarVariacion default True;
     property MostrarMarcasDeRosaNautica: Boolean read FMostrarMarcasDeAmplitud Write SetMostrarMarcasDeAmplitud default True;

     //Nuevos eventos de este componente.
     property OnNuevosDatos: TNuevosDatos read FOnNuevosDatosDeAmplitud Write FOnNuevosDatosDeAmplitud;
     property OnDibujoTerminado: TNotifyEvent read FOnDibujoTerminado Write FOnDibujoTerminado;
  end;

procedure Register;

implementation

//-----------------------------------------------------------------------------
// Inserta nuevos datos en el objeto para que sean mostrados gráficamente.
//
// Entradas:
// AmpitudInstantanea = Valor de ampitud instantáneo que se debe mostrar.
// TendenciaCentral   = Tendencia central de las ampitudes que se debe mostrar.
// Variacion          = Variación de las ampitudes que se debe mostrar.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.AgregarDatos(AmpitudInstantanea, TendenciaCentral, Variacion: Double);
begin
//Copia los datos en el interior del objeto.
FAmplitudInstantanea := AmpitudInstantanea;
FAmplitudMedia := TendenciaCentral;
FAmplitudVariacion := Variacion;

//Informa que han llegado nuevos datos de marcaciones.
if Assigned(FOnNuevosDatosDeAmplitud) then
   FOnNuevosDatosDeAmplitud(Self,
                            FAmplitudInstantanea,
                            FAmplitudMedia,
                            FAmplitudVariacion
                            );
end;

//----------------------------------------------------------------------------
// Devuelve la interpolación de dos colores.
//
// Entradas:
// Fraccion = Valor entre 0 y 1 que representa la posición a interpolar.
// Color1 = Color inicial de la interpolación que representa el cero.
// Color2 = Color final de la interpolación que representa el uno.
//----------------------------------------------------------------------------
function TVisorDeAmplitudPorAntenas.InterpolarColores(Fraccion: Double; Color1, Color2: TColor): TColor;
var complement: Double;
    R1, R2, G1, G2, B1, B2: BYTE;
begin
Fraccion := Sqr(Fraccion);

if Fraccion <= 0 then
   Result := Color1
else
   if Fraccion >= 1.0 then
      Result := Color2
   else
      begin
      R1 := GetRValue(Color1);
      G1 := GetGValue(Color1);
      B1 := GetBValue(Color1);
      R2 := GetRValue(Color2);
      G2 := GetGValue(Color2);
      B2 := GetBValue(Color2);
      complement := 1.0 - Fraccion;
      Result := RGB( Round(complement * R1 + Fraccion * R2),
                     Round(complement * G1 + Fraccion * G2),
                     Round(complement * B1 + Fraccion * B2));
      end
end;

//-----------------------------------------------------------------------------
// Dibuja el gráfico de amplitud en un Mapa de Bits creado en memoria.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.GraficarDatos;
var p, n, Alto, Ancho, i: Integer;
    t: Double;
begin
if CongelarGrafica then Exit;                                    //Sale si la gráfica está congelada.

//Actualiza las dimensiones del Mapa de Bits interno.
BMP.Width := ClientWidth;                                        //Establece el ancho del Mapa de Bits.
BMP.Height := ClientHeight;                                      //Establece la altura del Mapa de Bits.

//Calcula el alto y ancho para no repetirlo en el código.
Alto := BMP.Height;
Ancho := BMP.Width;

//Dibuja el fondo del rectángulo contenedor.
BMP.Canvas.Brush.Style := bsSolid;
BMP.Canvas.Brush.Color := clFondo;
BMP.Canvas.FillRect(Rect(0, 0, Ancho, Alto));

//Dibuja la barra de amplitud inercial.
if FMostrarMedia then
   begin
   BMP.Canvas.Pen.Style := psSolid;
   BMP.Canvas.Pen.Width := 1;
   BMP.Canvas.Pen.Color := clBorde;
   BMP.Canvas.Brush.Color := clAmplitudBarra;
   p := Round(Ancho * FAmplitudMedia);
   BMP.Canvas.Rectangle(0, 0, Round(Ancho * FAmplitudMedia) , Alto);
   BMP.Canvas.Pen.Width := 3;
   BMP.Canvas.Pen.Color := clAmplitudMedia;
   BMP.Canvas.MoveTo(p - 1, 0);
   BMP.Canvas.LineTo(p - 1, Alto);
   end;

//Dibuja la marca de amplitud instantanea.
if FMostrarAmplitud then
   begin
   BMP.Canvas.Pen.Color := clAmplitudInstantanea;
   BMP.Canvas.Pen.Width := 3;
   p := Round(Ancho * FAmplitudInstantanea);
   BMP.Canvas.MoveTo(p, 0);
   BMP.Canvas.LineTo(p, Alto);
   end;

//Dibuja las marca de variación.
if FMostrarVariacion then
   begin
   BMP.Canvas.Pen.Color := clAmplitudVariacion;
   BMP.Canvas.Pen.Width := 3;
   BMP.Canvas.Brush.Style := bsClear;
   BMP.Canvas.Rectangle(Round(Ancho * (FAmplitudMedia - FAmplitudVariacion)),
                        2,
                        Round(Ancho * (FAmplitudMedia + FAmplitudVariacion)),
                        Alto - 2
                        );
   end;

//Dibuja el borde del rectángulo contenedor.
BMP.Canvas.Pen.Width := 1;
BMP.Canvas.Pen.Style := psSolid;
BMP.Canvas.Pen.Color := clBorde;
BMP.Canvas.Brush.Style := bsClear;
BMP.Canvas.Rectangle(Rect(0, 0, Ancho, Alto));

//Dibuja las marcas de amplitud.
if FMostrarMarcasDeAmplitud then
   begin
   BMP.Canvas.Pen.Width := 1;                                 //Ancho de las líneas.
   BMP.Canvas.Pen.Color := clMarca;
   n := 0;
   if Ancho div 2 > CMaxEscala then i := 1 else i := 5;       //Muestra las líneas según el largo del componente.
   while n < CMaxEscala do                                    //Realiza un recorrido completo por todos
         begin                                                //los valores de 0 a 100 y:
         if n mod 10 > 0 then                                 //Si no es un múltiplo de 10:
            t := Alto * 0.15                                  //Dibuja una línea pequeña.
         else                                                 //Si es un múltiplo de 10:
            t := Alto * 0.30;                                 //Dibuja una línea grande.
         p := Round(n / CMaxEscala * Width);                  //Calcula la posición de la linea de marca.
         BMP.Canvas.MoveTo(p, 0);                             //Parte desde el inicio.
         BMP.Canvas.LineTo(p, Round(t));                      //Traza el radio hasta el final de la marca.
         BMP.Canvas.MoveTo(p, Alto);                          //Parte desde el inicio.
         BMP.Canvas.LineTo(p, Alto - Round(t) - 1);           //Traza el radio hasta el final de la marca.
         Inc(n, i);                                           //Incrementa para dibujar la próxima marca.
         end;
   end;
end;

//-----------------------------------------------------------------------------
// Copia el gráfico del Mapa de Bits al canvas (parte visual) del componente.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.Paint;
begin
if csDesigning in ComponentState then GraficarDatos;             //Crea el dibujo de la pantalla.
SetStretchBltMode(Canvas.Handle, COLORONCOLOR);                  //Método de dibujado.
Canvas.StretchDraw(ClientRect, BMP);                             //Muestra el dibujo del gráfico.
if Assigned(FOnDibujoTerminado) then FOnDibujoTerminado(Self);   //Informa que ha terminado el dibujado.
end;

//-----------------------------------------------------------------------------
// Ajusta las dimensiones del Mapa de Bits interno.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.ReSize;
begin
Invalidate;
end;

//-----------------------------------------------------------------------------
// Inicia el goniómetro.
//-----------------------------------------------------------------------------
constructor TVisorDeAmplitudPorAntenas.Create(AOwner:TComponent);
begin
inherited;
FMostrarMarcasDeAmplitud := True;
FMostrarAmplitud := True;
FMostrarMedia := True;
FMostrarVariacion := True;
CongelarGrafica := False;

//Crea e inicia el Mapa de Bits para dibujado.
BMP := TBitmap.Create;                                   //Crea un mapa de bits.
BMP.Width := 100;                                        //Establece el ancho del Mapa de Bits.
BMP.Height := 100;                                       //Establece la altura del Mapa de Bits.

GraficarDatos;                                           //Dibuja la gráfica en un Mapa de Bits.
Invalidate;                                              //Copia la imagen a la parte gráfica del componente.

//Inicia el Temporizador que actualiza el gráfico.
FActualizacionDelGrafico := 50;
FActualizador := TTimer.Create(Self);
FActualizador.Interval := FActualizacionDelGrafico;
FActualizador.OnTimer := ActualizarGrafico;
FActualizador.Enabled := True;
end;

//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.Reiniciar;
begin
FAmplitudInstantanea := 0;
FAmplitudMedia := 0;
FAmplitudVariacion := 0;
end;

//-----------------------------------------------------------------------------
// Actualiza la vista de los datos.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.ActualizarGrafico(Sender: TObject);
begin
if csDesigning in ComponentState then Exit;  //Si está en fase de diseño, no hace nada.
GraficarDatos;                               //Dibuja la gráfica en un Mapa de Bits.
Invalidate;                                  //Copia la imagen al componente gráfico.
end;

////////////////////////////////////////////////////////////////////////////////
//////////// Establecimiento de propiedades del componente.  ///////////////////
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Establece el tiempo de actualización del gráfico de la pantalla.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.SetActualizacionDelGrafico(valor: Integer);
begin
if valor > 10 then
   begin
   FActualizacionDelGrafico := Abs(valor);
   FActualizador.Interval := FActualizacionDelGrafico;
   end;
end;

//-----------------------------------------------------------------------------
// Establece las propiedades de visualización.
//-----------------------------------------------------------------------------
procedure TVisorDeAmplitudPorAntenas.SetMostrarVariacion(valor: Boolean);
begin
FMostrarVariacion := valor;
GraficarDatos;
Invalidate;
end;

procedure TVisorDeAmplitudPorAntenas.SetMostrarMedia(valor: Boolean);
begin
FMostrarMedia := valor;
GraficarDatos;
Invalidate;
end;

procedure TVisorDeAmplitudPorAntenas.SetMostrarAmplitud(valor: Boolean);
begin
FMostrarAmplitud := valor;
GraficarDatos;
Invalidate;
end;

procedure TVisorDeAmplitudPorAntenas.SetMostrarMarcasDeAmplitud(valor: Boolean);
begin
FMostrarMarcasDeAmplitud := valor;
GraficarDatos;
Invalidate;
//color := cl
end;


////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Registra el componente en la paleta del IDE.
//-----------------------------------------------------------------------------
procedure Register;
begin
RegisterComponents('RDF', [TVisorDeAmplitudPorAntenas]);
end;

end.
