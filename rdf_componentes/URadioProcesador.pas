
////////////////////////////////////////////////////////////////////////////////
// Autor: Santiago A. Orellana Pérez
// Creado: 17/8/2013
// Propósito: Exporta un componente gráfico que se utiliza para procesar
//            y visualizar las señales de radio que recibe por medio de
//            la tarjeta de sonido de la computadora.
//            El procesamiento básicamente consiste en detectar si la
//            señal de antena está saturada y detectar la señal de la
//            sincronía para separar la señal de antena en los cuatro
//            segmentos correspondientes a las antenas 1, 2, 3 y 4.
//            Se utiliza en la implementación de un Radiogoniómetro por
//            Amplitud de cuatro antenas conmutadas.
////////////////////////////////////////////////////////////////////////////////

unit URadioProcesador;

interface

uses Windows, SysUtils, Classes, Controls, Graphics, Math, ExtCtrls,
     UCapturadorDeAudio, UAudioUtiles, SyncObjs;

//-----------------------------------------------------------------------------
// Valores relacionados con la amplitud de las muestras de datos.
//-----------------------------------------------------------------------------
const CMaxDatoAbsoluto    = 32767;                        //Valor absoluto máximo que puede tomar una muestra.
const CMaxDatoRango       = 32767 * 2;                    //Rango dinámico de variación del valor de los datos. (-32768..32767)
const CUmbralDeSaturacion = CMaxDatoAbsoluto - 100;       //Si hay muestras cuyo valor absoluto sobrepasan este valor, la señal está saturada.
                                              
//-----------------------------------------------------------------------------
const CMuestrasMinimasPorAntena = 1;                      //Cantidad mínima de muestras por intervalo de antena.
const CAmplitudMinimaDetectable = CMaxDatoRango div 6;
const CDistanciaDeSubida        = 10;
const CDesplazamientoDeMarca    = 0;
const CEspaciadoAdicional       = 5;

//-----------------------------------------------------------------------------
// Colores del gráfico de Señal y Sincronía.
//-----------------------------------------------------------------------------
const clFondoDelComponente    = clbtnFace;
const clFondoDelGrafico       = clBlack;
const clIntervaloDeLaAntena_1 = $00A0A0A0;
const clIntervaloDeLaAntena_2 = $00606060;
const clIntervaloDeLaAntena_3 = $00606060;
const clIntervaloDeLaAntena_4 = $00606060;
const clVariacion             = clTeal;
const clInicioDeCiclo         = clRed;
const clUnCuartoDeCiclo       = clYellow;
const clDosCuartosDeCiclo     = clYellow;
const clTresCuartosDeCiclo    = clYellow;

const Sep = 3;


//-----------------------------------------------------------------------------
// Selector del buffer a utilizar.
//-----------------------------------------------------------------------------
const CanalL     = 0;
const CanalR     = 1;
const Marcas     = 2;
const Longitudes = 3;

//-----------------------------------------------------------------------------
// Marcas que se le realizan a la señal.
//-----------------------------------------------------------------------------
const CNadaRelevante        = 0;
const CInicioDeLaAntena_1   = 1;
const CInicioDeLaAntena_2   = 2;
const CInicioDeLaAntena_3   = 3;
const CInicioDeLaAntena_4   = 4;
const CVariacion            = 5;
const CInicioDeCiclo        = 6;
const CUnCuartoDeCiclo      = 7;
const CDosCuartosDeCiclo    = 8;
const CTresCuartosDeCiclo   = 9;

//-----------------------------------------------------------------------------
// Arreglos para el almacenamiento de datos y operaciones DSP.
//-----------------------------------------------------------------------------
type TDato = Array of Smallint;            //Arreglo que guarda las señales de los canales L y R.
type TDatos = Array [0..3] of TDato;       //Arreglo que agrupa los datos de los canales L, R y otros arreglos de procesamiento.

//-----------------------------------------------------------------------------
type TProcesamientoTerminado = procedure(Sender: TObject; A1, A2, A3, A4: Double; Saturacion: Boolean) of object;

//-----------------------------------------------------------------------------
type TTipoDeRectificador = (trValorAbsoluto,          //Convierte a positivos todos los valores negativos.
                            trRecorte                 //Sustituye los valores negativos con ceros.
                            );

//-----------------------------------------------------------------------------
// Componente que realiza la captura de la señal de antena y de sincronía.
//-----------------------------------------------------------------------------
type
  TRadioProcesador = class(TGraphicControl)   //TGraphicControl  //TCustomControl
  private
     FEntradaDeAudio: TCapturadorDeAudio;                    //Interfase con el dispositivo de audio que captura las muestras en un buffer.
     FReproduciendo: Boolean;

     FrecuenciaDeMuestreo: Integer;                          //Frecuencia de muestreo con que se capturan las señales.
     LongitudDelBuffer: Integer;                             //Tamaño del buffer de captura del audio.
     FDato: TDatos;                                          //Guarda los datos del canal L, R así como otros datos necesarios para los cálculos.
     LongitudDeDato: Integer;
     FSaturacion: Boolean;                                   //Indica si existe saturación en el canal de entrada L.
     FErrorDeSincronia: Boolean;                             //Indica si no existe sincronía.

     FDetectarCrecientes: Boolean;
     FAmplitudMinimaDetectable: Integer;                     //Amplitud mínima que debe tener una subida para ser detectada.
     FDistanciaDeSubida: Integer;                            //Distancia de comprobación de la subida.
     FDesplazamientoDeMarca: Integer;                        //Desplazamiento de las marcas de la señal del canal R.
     FEspaciadoAdicional: Integer;                           //Separación adicional entre los intervalos de antenas.
     FPorcientoDeMuestrasVisibles: Double;                   //Cantidad de muestras desde el comienzo que se visualizan en el gráfico.

     //Para la visualización.
     BMP: Graphics.TBitmap;
     FActualizador: TTimer;                                  //Componente que actualiza el gráfico.
     FActualizacionDelGrafico: Integer;                      //Intervalo en milisegundos de actualización del gráfico de la pantalla.

     AmplitudAntena1: Double;                                //Guarda la amplitud de la antena #1.
     AmplitudAntena2: Double;                                //Guarda la amplitud de la antena #2,
     AmplitudAntena3: Double;                                //de la antena 3
     AmplitudAntena4: Double;                                //y de la #4.

     //Apariencia.
     FMostrarIntervalos: Boolean;
     FMostrarVariacion: Boolean;
     FMostrarFracciones: Boolean;
     FMostrarSaturacion: Boolean;

     //Eventos nuevos de este componente.
     FOnActivado: TNotifyEvent;
     FOnDesactivado: TNotifyEvent;
     FOnProcesamientoTerminado: TProcesamientoTerminado;
     FOnDibujoTerminado: TNotifyEvent;

     procedure GraficarDatos;
     procedure ActualizarGrafico(Sender: TObject);

     procedure SetActualizacionDelGrafico(valor: Integer);
     procedure SetMostrarVariacion(valor: Boolean);
     procedure SetMostrarIntervalos(valor: Boolean);
     procedure SetMostrarFracciones(valor: Boolean);
     procedure SetMostrarSaturacion(valor: Boolean);
     procedure SetPorcientoDeMuestrasVisibles(valor: Double);

     procedure SetDetectarCrecientes(valor: Boolean);
     procedure SetAmplitudMinimaDetectable(valor: Double);
     function GetAmplitudMinimaDetectable: Double;
     procedure SetDistanciaDeSubida(valor: Integer);
     procedure SetDesplazamientoDeMarca(valor: Integer);
     procedure SetEspaciadoAdicional(valor: Integer);

     function NuevoDispositivo(ID: Integer; Formato: TPCMFormat; LongitudDelBuffer: Integer): TCapturadorDeAudio;
     procedure FEntradaDeAudioActivada(Sender: TObject);
     procedure FEntradaDeAudioDesactivada(Sender: TObject);
     function ExtraerFrecuenciaDeMuestreo(Formato: TPCMFormat): Integer;
     function EscalarY(Valor: Double; Area: TRect): Integer;
     function EscalarX(Valor: Integer; Area: TRect): Integer;
  protected
     procedure Paint; override;
     procedure ReSize;  override;
  public
     CalcularResultados: Boolean;                           //Indica si se deben calcular los resultados o ignorarlos.
     CongelarGrafica: Boolean;
     constructor Create(AOwner:TComponent); override;
     procedure IniciarCaptura;
     procedure DetenerCaptura;
     procedure PrepararReproduccion;
     procedure DetenerReproduccion;
     function Capturando: Boolean;
     function Reproduciendo: Boolean;
     property PorcientoDeMuestrasVisibles: Double read FPorcientoDeMuestrasVisibles write SetPorcientoDeMuestrasVisibles;
     procedure Reiniciar;
     property Saturacion: Boolean read FSaturacion;
     property ErrorDeSincronia: Boolean read FErrorDeSincronia;
     procedure DatosCapturados(Sender: TObject; const Buffer: Pointer; BufferSize: Cardinal; var FreeIt: Boolean);
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
     property ActualizacionDelGrafico: Integer read FActualizacionDelGrafico Write SetActualizacionDelGrafico default 50;
     property MostrarSaturacion: Boolean read FMostrarSaturacion Write SetMostrarSaturacion default True;
     property MostrarFraccionesDeTiempoDeAntena: Boolean read FMostrarFracciones Write SetMostrarFracciones default False;
     property MostrarVariacion: Boolean read FMostrarVariacion Write SetMostrarVariacion default False;
     property MostrarIntervalosDeAntena: Boolean read FMostrarIntervalos Write SetMostrarIntervalos default False;

     property DetectarCrecientes: Boolean read FDetectarCrecientes Write SetDetectarCrecientes default False;
     property PorcientoDeAmplitudMinimaDetectable: Double read GetAmplitudMinimaDetectable Write SetAmplitudMinimaDetectable;
     property DistanciaDeSubida: Integer read FDistanciaDeSubida Write SetDistanciaDeSubida default CDistanciaDeSubida;
     property DesplazamientoDeMarca: Integer read FDesplazamientoDeMarca Write SetDesplazamientoDeMarca default CDesplazamientoDeMarca;
     property EspaciadoAdicional: Integer read FEspaciadoAdicional Write SetEspaciadoAdicional default CEspaciadoAdicional;

     //Nuevos eventos de este componente.
     property OnActivado: TNotifyEvent read FOnActivado Write FOnActivado;
     property OnDesactivado: TNotifyEvent read FOnDesactivado Write FOnDesactivado;
     property OnProcesamientoTerminado: TProcesamientoTerminado read FOnProcesamientoTerminado Write FOnProcesamientoTerminado;
     property OnDibujoTerminado: TNotifyEvent read FOnDibujoTerminado Write FOnDibujoTerminado;
  end;

procedure Register;

////////////////////////////////////////////////////////////////////////////////

implementation

uses Types;


//-----------------------------------------------------------------------------
// Devuelve los valores Y ajustados al tamaño del rectángulo del gráfico.
//-----------------------------------------------------------------------------
function TRadioProcesador.EscalarY(Valor: Double; Area: TRect): Integer;
var m: Integer;
begin
with Area do
     begin
     m := (Bottom + Top) div 2;                                                    //Calcula la mitad del gráfico.
     Result := m - Round(Valor / CMaxDatoAbsoluto * ((Bottom - Top) / 2 - Sep));   //Realiza la transformación de coordenadas.
     end;
end;

//-----------------------------------------------------------------------------
// Devuelve los valores X ajustados al tamaño del rectángulo del gráfico.
//-----------------------------------------------------------------------------
function TRadioProcesador.EscalarX(Valor: Integer; Area: TRect): Integer;
begin
with Area do
     Result := Left + Sep + Round(Valor / LongitudDeDato * (Right - Left - Sep));  //Realiza la transformación de coordenadas.
end;

//-----------------------------------------------------------------------------
// Dibuja los gráficos de señal de antena en un Mapa de Bits creado en memoria.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.GraficarDatos;
var Alto, Ancho, Medio, i: Integer;
    RectL, RectR: TRect;

    //Dibuja las marcas de los intervalos.
    procedure Marca(Color: TColor; Area: TRect);
    begin
    BMP.Canvas.Pen.Color := Color;
    BMP.Canvas.MoveTo(EscalarX(i, Area), Area.Top + 1);            //Dibuja una línea desde este punto hasta
    BMP.Canvas.LineTo(EscalarX(i, Area), Area.Bottom - 1);           //este otro para representar la marca.
    end;

    //Dibuja los intervalos de antena.
    procedure Intervalo(Color: TColor; Area: TRect);
    begin
    BMP.Canvas.Brush.Color := Color;                                 //Selecciona el color del intervalo.
    BMP.Canvas.FillRect(Rect(EscalarX(i, Area), Area.Top + 1,        //Dibuja un rectangulo para representar el intervalo.
                        EscalarX(i + FDato[Longitudes][i], Area),
                        Area.Bottom - 1));
    end;

begin
if CongelarGrafica then Exit;                                        //Sale si la gráfica está congelada.

//Actualiza las dimensiones del Mapa de Bits interno.
BMP.Width := ClientWidth;                                            //Establece el ancho del Mapa de Bits.
BMP.Height := ClientHeight;                                          //Establece la altura del Mapa de Bits.

//Calcula el alto y ancho para no repetirlo en el código.
Alto := BMP.Height - 0;
Ancho := BMP.Width - 0;
Medio := BMP.Height div 2;

RectL := Rect(Sep, Sep, Ancho - Sep, Medio - Sep);                   //Calcula las dimensiones del gráfico de la señal del canal L.
RectR := Rect(Sep, Medio + Sep, Ancho - Sep, Alto - Sep);            //Calcula las dimensiones del gráfico del canal R.

//Dibuja el fondo del rectángulo contenedor.
BMP.Canvas.Brush.Style := bsSolid;
BMP.Canvas.Brush.Color := clFondoDelComponente;
BMP.Canvas.Pen.Style := psSolid;
BMP.Canvas.Pen.Color := clGray;
BMP.Canvas.Pen.Width := 1;
BMP.Canvas.Rectangle(Rect(0, 0, Ancho, Alto));

//Dibuja el área de los dos gráficos L y R.
BMP.Canvas.Brush.Color := clFondoDelGrafico;
BMP.Canvas.Pen.Color := clGray;
BMP.Canvas.Rectangle(RectL);
BMP.Canvas.Rectangle(RectR);

if (Length(FDato[CanalL]) = 0) or (Length(FDato[CanalR]) = 0) then Exit;

//Primero muestra los intervalos de antenas.
for i := 0 to Length(FDato[CanalR]) - 2 do
    case FDato[Marcas][i] of
         CInicioDeLaAntena_1: if FMostrarIntervalos then Intervalo(clIntervaloDeLaAntena_1, RectR);
         CInicioDeLaAntena_2: if FMostrarIntervalos then Intervalo(clIntervaloDeLaAntena_2, RectR);
         CInicioDeLaAntena_3: if FMostrarIntervalos then Intervalo(clIntervaloDeLaAntena_3, RectR);
         CInicioDeLaAntena_4: if FMostrarIntervalos then Intervalo(clIntervaloDeLaAntena_4, RectR);
         CVariacion:          if FMostrarVariacion then Marca(clVariacion, RectR);
         end;

//Encima de los intervalos dibuja la señal de los canales L y R.
for i := 0 to Length(FDato[CanalL]) - 2 do
    begin
    //Muestra la señal del canal L (Señal de las antenas).
    BMP.Canvas.Pen.Color := clLime;
    BMP.Canvas.MoveTo(EscalarX(i, RectL), EscalarY(FDato[CanalL][i], RectL));
    BMP.Canvas.LineTo(EscalarX(i + 1, RectL), EscalarY(FDato[CanalL][i + 1], RectL));

    //Muestra la sobresaturación de la señal del canal L.
    if FMostrarSaturacion then
       if Abs(FDato[CanalL][i]) >= CUmbralDeSaturacion then
          BMP.Canvas.Pixels[EscalarX(i, RectL), EscalarY(FDato[CanalL][i], RectL)] := clRed;
          
    //Muestra la señal de sincronía (Indicador de antena).
    BMP.Canvas.Pen.Color := clLime;
    BMP.Canvas.MoveTo(EscalarX(i, RectR), EscalarY(FDato[CanalR][i], RectR));
    BMP.Canvas.LineTo(EscalarX(i + 1, RectR), EscalarY(FDato[CanalR][i + 1], RectR));

    //Muestra las marcas.
    if FMostrarFracciones then
       case FDato[Marcas][i] of
            CInicioDeCiclo:      Marca(clInicioDeCiclo, RectR);
            CUnCuartoDeCiclo:    Marca(clUnCuartoDeCiclo, RectR);
            CDosCuartosDeCiclo:  Marca(clDosCuartosDeCiclo, RectR);
            CTresCuartosDeCiclo: Marca(clTresCuartosDeCiclo, RectR);
            end;
    end;

//Indica si existe sobresaturación en el canal L.
BMP.Canvas.Brush.Style := bsSolid;
BMP.Canvas.Brush.Color := clYellow;
BMP.Canvas.Font.Color := clRed;
BMP.Canvas.Font.Size := 12;
BMP.Canvas.Font.Style := [fsBold];
if FSaturacion then BMP.Canvas.TextOut(RectL.Left + Sep, RectL.Top + Sep, 'Saturación');

//Indica si no se ha podido sincronizar con la señal del canal R.
BMP.Canvas.Brush.Style := bsSolid;
BMP.Canvas.Brush.Color := clYellow;
BMP.Canvas.Font.Color := clRed;
BMP.Canvas.Font.Size := 12;
BMP.Canvas.Font.Style := [fsBold];
if FErrorDeSincronia then BMP.Canvas.TextOut(RectR.Left + Sep, RectR.Top + Sep, 'Error de sincronización');
end;

//-----------------------------------------------------------------------------
// Copia el gráfico del Mapa de Bits al canvas (parte visual) del componente.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.Paint;
begin
if csDesigning in ComponentState then GraficarDatos;             //Crea el dibujo de la pantalla.
SetStretchBltMode(Canvas.Handle, COLORONCOLOR);                  //Método de dibujado.
Canvas.StretchDraw(ClientRect, BMP);                             //Muestra el dibujo del gráfico.
if Assigned(FOnDibujoTerminado) then FOnDibujoTerminado(Self);   //Informa que ha terminado el dibujado.
end;

//-----------------------------------------------------------------------------
// Ajusta las dimensiones del Mapa de Bits interno.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.ReSize;
begin
Invalidate;
end;

//-----------------------------------------------------------------------------
// Toma el audio estéreo de la tarjeta de sonido y le saca una copia
// dividida por canales L y R. luego procesa os canales para extraer
// l ainformación correspondiente a las antenas 1, 2, 3 y 4.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.DatosCapturados(Sender: TObject;
                                           const Buffer: Pointer;
                                           BufferSize: Cardinal;
                                           var FreeIt: Boolean
                                           );
var i, c, a, d, a1, a2, a3, a4, m1, m2, m3, m4: Integer;
    Muestras, Inicio, IC, Anterior, LC, VIC: Integer;
    Transicion: Boolean;
    m: Double;
    amp1, amp2, amp3, amp4: Double;
    mue1, mue2, mue3, mue4: Integer;
    CopiaDato: TDato;

    //Calcula la suma de la amplitud del segmento de señal indicado.
    function Sumatoria(Desde: Integer; Longitud: Integer): Double;
    var j: Integer;
        m, d: Integer;
    begin
    case 0 of
         //Sumatoria de los valores absolutos.
         0: begin
            Result := 0;
            if Longitud > 0 then
               for j := Desde to Desde + Longitud - 1 do
                   Result := Result + (Abs(FDato[CanalL][j]) / CMaxDatoAbsoluto);
            end;       
         1: begin
            Result := 0;
            if Longitud > 0 then
               for j := Desde to Desde + Longitud - 1 do
                   Result := Result + (Abs(FDato[CanalL][j]));
            Result := Result / (CMaxDatoAbsoluto);
            end;
         end;
    end;

begin
FreeIt := True;                                                        //Indica que se debe liberar el buffer al finalizar.

//Inicia las variables de estadística de amplitud por Buffer.
amp1 := 0;   amp2 := 0;   amp3 := 0;   amp4 := 0;                      //Estas son las sumatorias de las antenas.
mue1 := 0;   mue2 := 0;   mue3 := 0;   mue4 := 0;                      //Estas son las cantidades de muestras por antenas.

//Guarda una copia de los canales L y R en arreglos separados.
//Parsea los datos como un Smallint, por lo que los valores son
//de 16 y van desde -32768 hasta 32767.
for i := 0 to BufferSize div 2 - 1 do                                  //Busca cada muestra del buffer de entrada y
    FDato[i and 1][i div 2] := TDato(Buffer)[i];                       //la coloca en el canal que le corresponde.

Muestras := Length(FDato[0]);                                          //Obtiene la longitud de los buffers.

//Detecta la sobresaturación de la señal de entrada en el canal L.
//Calcula el Nivel Medio de la señal de entrada en el canal R.
//Pone a cero todas las marcas de la señal.
FSaturacion := False;                                                  //Inicia el indicador de sobresaturación.
FErrorDeSincronia := True;                                             //Inicia el indicador de Error de Sincronía.
c := 0;                                                                //Inicia el contador de muestras sobresaturadas de L.
for i := 0 to Muestras - 1 do                                          //Recorre los arreglos L y R.
    begin
    if Abs(FDato[CanalL][i]) >= CUmbralDeSaturacion then Inc(c);       //Cuenta las muestras de L que sobrepasan los extremos.
    FDato[Marcas][i] := CNadaRelevante;                                //Pone a cero todas las marcas.
    FDato[Longitudes][i] := 0;                                         //Pone a cero las marcas de longitud.
    end;
if c > (Muestras * 0.03) then FSaturacion := True;                     //Si hay muchas muestras que sobrepasan los extremos, se indica la existencia de sobresaturación.

//Detecta las grandes variaciones de la señal del canal R y las utiliza
//para sincronizar el algoritmo con el sistema de conmutación.
d := FDistanciaDeSubida;
a := FAmplitudMinimaDetectable;
Inicio := -1;                                                          //Al comenzar, no se han encontrado crecientes.
Anterior := -1;                                                        //Por lo que tampoco hay marcas.
for i := d to Muestras - 1 - d do                                      //Recorre los arreglos L y R.
    begin
    if FDetectarCrecientes then                                        //Si se deben detectar las Crecientes:
       Transicion := FDato[CanalR][i + d] - FDato[CanalR][i - d] > a   //Detecta las crecientes...
    else                                                               //Si se deben detectar las Decrecientes:
       Transicion := FDato[CanalR][i - d] - FDato[CanalR][i + d] > a;  //Detecta las decrecientes...
    if Transicion then                                                 //Si se ha encontrado una transición creciente bastante grande:
       begin
       if Inicio = -1 then Inicio := i;                                //Guarda la posición de inicio de la creciente.
       FDato[Marcas][i] := CVariacion;                                 //Marca las grandes transiciones crecientes.
       end
    else                                                               //Al no encontrarse transiciones:
       if Inicio <> -1 then                                            //Si se ha marcado un inicio:
          begin
          VIC := Round((i - Inicio) / 2);                              //Calcula la variación del inicio del ciclo.
          VIC := VIC + FEspaciadoAdicional;                            //Le agrega el espacio del ruido más un valor ajustable.
          IC := Round((i + Inicio) / 2);                               //Calcula el medio de la creciente, que es el inicio del ciclo.
          IC := IC + FDesplazamientoDeMarca;                           //Desplaza las marcas la cantidad indicada.
          if (IC >= 0) and (IC < Muestras) then                        //Si la posición se encuentra dentro del arreglo:
             begin
             if Anterior <> -1 then                                    //Si existe una marca anterior:
                begin
                FDato[Marcas][IC] := CInicioDeCiclo;                   //Marca el inicio del ciclo de rotación de las antenas.
                LC := IC - Anterior;                                   //Calcula la longitud en muestras del ciclo del pulso anterior.
                if LC > (VIC + CMuestrasMinimasPorAntena) * 8 then     //Si los intervalos son suficientemente grandes:
                   begin
                   FErrorDeSincronia := False;                         //Indica que se ha podido detectar la sincronía.
                   
                   //Marca las diviciones del ciclo en cuatro partes.
                   m1 := Anterior;                                     //Inicio de un ciclo de rotación de las antenas.
                   m2 := Anterior + Round(LC * 0.25);                  //Un Cuarto del ciclo de rotación de las antenas.
                   m3 := Anterior + Round(LC * 0.50);                  //Dos Cuartos del ciclo. (La mitad)
                   m4 := Anterior + Round(LC * 0.75);                  //Tres Cuartos del ciclo de rotación.
                   FDato[Marcas][m1] := CInicioDeCiclo;                //Marca el inicio de la creciente (Del ciclo de rotación).
                   FDato[Marcas][m2] := CUnCuartoDeCiclo;              //Marca a un cuarto de ciclo.
                   FDato[Marcas][m3] := CDosCuartosDeCiclo;            //Marca a los dos cuartos de ciclo.
                   FDato[Marcas][m4] := CTresCuartosDeCiclo;           //Marca a los tres cuartos de ciclo.

                   //Marca los inicios de los intervalos de las antenas.
                   a1 := m1 + VIC;                                     //Calcula el inicio del intervalo de la antena #1.
                   a2 := m2 + VIC;                                     //Calcula el inicio de la antena #2.
                   a3 := m3 + VIC;                                     //De la antena #3 y
                   a4 := m4 + VIC;                                     //de la #4.
                   FDato[Marcas][a1] := CInicioDeLaAntena_1;           //Marca el inicio de la creciente (Antena #1).
                   FDato[Marcas][a2] := CInicioDeLaAntena_2;           //Marca el inicio de la Antena #2.
                   FDato[Marcas][a3] := CInicioDeLaAntena_3;           //De la Antena #3.
                   FDato[Marcas][a4] := CInicioDeLaAntena_4;           //Y de la Antena #4.

                   //Guarda la duración de los intervalos de las antenas.
                   FDato[Longitudes][a1] := m2 - a1 - VIC;             //Calcula y guarda la longitud del tiempo de la Antena #1.
                   FDato[Longitudes][a2] := m3 - a2 - VIC;             //Luego el de la Antena #2.
                   FDato[Longitudes][a3] := m4 - a3 - VIC;             //El de la Antena #3.
                   FDato[Longitudes][a4] := IC - a4 - VIC;             //Y el de la Antena #4.

                   //Calcula la sumatoria de la amplitud de las muestras de cada antena.
                   amp1 := amp1 + Sumatoria(a1, FDato[Longitudes][a1]);
                   amp2 := amp2 + Sumatoria(a2, FDato[Longitudes][a2]);
                   amp3 := amp3 + Sumatoria(a3, FDato[Longitudes][a3]);
                   amp4 := amp4 + Sumatoria(a4, FDato[Longitudes][a4]);

                   //Calcula la cantidad de muestras por cada antena.
                   mue1 := mue1 + FDato[Longitudes][a1];
                   mue2 := mue2 + FDato[Longitudes][a2];
                   mue3 := mue3 + FDato[Longitudes][a3];
                   mue4 := mue4 + FDato[Longitudes][a4];
                   end;
                end;
             Anterior := IC;                                           //Guarda la posición de la última marca encontrada.
             end;
          Inicio := -1;                                                //Libera el valor del inicio.
          end;
    end;
if not FErrorDeSincronia then                                          //Si se ha podido sincronizar:
   begin
   AmplitudAntena1 := 0;                                               //Primero establece a cero las amplitudes
   AmplitudAntena2 := 0;                                               //de las antenas para si no se realiza la
   AmplitudAntena3 := 0;                                               //división entre el número de muestras.
   AmplitudAntena4 := 0;
   if mue1 > 0 then AmplitudAntena1 := amp1 / mue1;                    //Calcula la media aritmética de las
   if mue2 > 0 then AmplitudAntena2 := amp2 / mue2;                    //amplitudes de las muestras de cada
   if mue3 > 0 then AmplitudAntena3 := amp3 / mue3;                    //una de las antenas.
   if mue4 > 0 then AmplitudAntena4 := amp4 / mue4;
   if Assigned(FOnProcesamientoTerminado) then                         //Si se ha asignado el evento que
      FOnProcesamientoTerminado(Self,                                  //avisa sobre la terminación de los
                                AmplitudAntena1,                       //cálculos del procesamiento, llama
                                AmplitudAntena2,                       //al evento pasando los datos de
                                AmplitudAntena3,                       //amplitud calculados; La media
                                AmplitudAntena4,                       //aritmética de las muestras.
                                FSaturacion
                                )
   else                                                                //Si no se ha sincronizado:
      FOnProcesamientoTerminado(Self, -1, -1, -1, -1, True);           //Manda datos que indican el error.
   end
end;

//-----------------------------------------------------------------------------
// Borra los datos anteriormente guardados en el objeto.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.Reiniciar;
var i: Integer;
begin
AmplitudAntena1 := 0;
AmplitudAntena2 := 0;
AmplitudAntena3 := 0;
AmplitudAntena4 := 0;
for i := 0 to Length(FDato[CanalR]) - 2 do
    begin
    FDato[CanalL][i] := 0;
    FDato[CanalR][i] := 0;
    FDato[Marcas][i] := 0;
    FDato[Longitudes][i] := 0;
    end;
end;

//-----------------------------------------------------------------------------
// Informa que se ha activado la captura de señales de antena.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.FEntradaDeAudioActivada(Sender: TObject);
begin
if Assigned(FOnActivado) then FOnActivado(Self);
end;

//-----------------------------------------------------------------------------
// Informa la desactivación de la captura de señales de antena.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.FEntradaDeAudioDesactivada(Sender: TObject);
begin
Reiniciar;
GraficarDatos;
Invalidate;
if Assigned(FOnDesactivado) then FOnDesactivado(Self);
end;

//-----------------------------------------------------------------------------
// Devuelve la frecuencia de muestreo de un TPCMFormat.
//-----------------------------------------------------------------------------
function TRadioProcesador.ExtraerFrecuenciaDeMuestreo(Formato: TPCMFormat): Integer;
begin
Result := 0;
case Formato of
     Mono8Bit8000Hz, Stereo8bit8000Hz,
     Mono16bit8000Hz, Stereo16bit8000Hz: Result := 8000;

     Mono8bit11025Hz, Stereo8bit11025Hz,
     Mono16bit11025Hz, Stereo16bit11025Hz: Result := 11025;

     Mono8bit22050Hz, Stereo8bit22050Hz,
     Mono16bit22050Hz, Stereo16bit22050Hz: Result := 22050;

     Mono8bit44100Hz, Stereo8bit44100Hz,
     Mono16bit44100Hz, Stereo16bit44100Hz: Result := 44100;

     Mono8bit48000Hz, Stereo8bit48000Hz,
     Mono16bit48000Hz, Stereo16bit48000Hz: Result := 48000;
     end;
end;

//-----------------------------------------------------------------------------
// Inicia la captura de señales de antena.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.IniciarCaptura;
begin
FrecuenciaDeMuestreo := ExtraerFrecuenciaDeMuestreo(FEntradaDeAudio.PCMFormat);       //Obtiene la frecuencia de muestreo.
LongitudDeDato := Round(FEntradaDeAudio.BufferLength / 1000 * FrecuenciaDeMuestreo);  //Calcula la longitud del buffer de datos en muestras.
SetLength(FDato[CanalL], LongitudDeDato);                                             //Espacio para el Buffer L.
SetLength(FDato[CanalR], LongitudDeDato);                                             //Buffer R.
SetLength(FDato[Marcas], LongitudDeDato);                                             //Buffer de Marcas de sincronización.
SetLength(FDato[Longitudes], LongitudDeDato);                                         //Buffer de Longitudes de los segmentos.
FEntradaDeAudio.Active := True;                                                       //Activa la captación de sonido.
FActualizador.Enabled := True;                                                        //Activa el actualizador del gráfico.
end;

//-----------------------------------------------------------------------------
// Detiene la captura de señales de antena.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.DetenerCaptura;
begin
FActualizador.Enabled := False;                 //Desactiva el actualizador del gráfico.
FEntradaDeAudio.Active := False;                //Desactiva la captura de la señal de antena.
FEntradaDeAudio.WaitForStop;                    //Espera a que se desactive.
end;

//-----------------------------------------------------------------------------
// Inicia la reproducción de señales desde un WAV.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.PrepararReproduccion;
begin
FrecuenciaDeMuestreo := ExtraerFrecuenciaDeMuestreo(FEntradaDeAudio.PCMFormat);       //Obtiene la frecuencia de muestreo.
LongitudDeDato := Round(FEntradaDeAudio.BufferLength / 1000 * FrecuenciaDeMuestreo);  //Calcula la longitud del buffer de datos en muestras.
SetLength(FDato[CanalL], LongitudDeDato);                                             //Espacio para el Buffer L.
SetLength(FDato[CanalR], LongitudDeDato);                                             //Buffer R.
SetLength(FDato[Marcas], LongitudDeDato);                                             //Buffer de Marcas de sincronización.
SetLength(FDato[Longitudes], LongitudDeDato);                                         //Buffer de Longitudes de los segmentos.
FReproduciendo := True;                         //Indica que se está reproduciendo un fichero WAV.
FEntradaDeAudio.Active := False;                //Desactiva la captura de la señal de antena.
FEntradaDeAudio.WaitForStop;                    //Espera a que se desactive.
end;

//-----------------------------------------------------------------------------
// Detiene la reproducción de señales desde un WAV.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.DetenerReproduccion;
begin
FReproduciendo := False;                        //Indica que no se están reproduciendo ficheros WAV.
FEntradaDeAudio.Active := True;                 //Activa la captura de la señal de antena.
FEntradaDeAudio.WaitForStart;                   //Espera a que se active.
end;

//-----------------------------------------------------------------------------
// Devuelve TRUE si se están capturando datos. 
//-----------------------------------------------------------------------------
function TRadioProcesador.Capturando: Boolean;
begin
Result := FEntradaDeAudio.Active;
end;

//-----------------------------------------------------------------------------
// Devuelve TRUE si se están reproduciendo datos desde un WAV. 
//-----------------------------------------------------------------------------
function TRadioProcesador.Reproduciendo: Boolean;
begin
Result := FReproduciendo;
end;

//-----------------------------------------------------------------------------
// Crear nuevo dispositivo de análisis.
//
// Parámetros:
// ID = Identificador del dispositivos de Audio al que se desea acceder.
//      En Windows el primero es 0, el segundo 1 y así en adelante.
// Formato = Formato del dispositivo de audio.
// MuestrasNecesitadas = Cantidad de muestras que debe almacenar el búffer.
//-----------------------------------------------------------------------------
function TRadioProcesador.NuevoDispositivo(ID: Integer; Formato: TPCMFormat; LongitudDelBuffer: Integer): TCapturadorDeAudio;
begin
Result := TCapturadorDeAudio.Create(nil);                //Crea un objeto para analizar lo que entra por un dispositivo de sonido.
Result.DeviceID := ID;                                   //Identificador del dispositivo de audio al que se le analizará la entrada.
Result.Async := False;                                   //El analizador debe sincronizado con la aplicación.
Result.PCMFormat := Formato;                             //Formato en el que se analizada la señal.
Result.BufferCount := 4;                                 //Cantidad de buffers del analizador.
if LongitudDelBuffer = 0 then LongitudDelBuffer := 100;  //Por defecto utiliza un buffer de 100 milisegundos de longitud.
Result.BufferLength := LongitudDelBuffer;                //Depende de la velocidad de conmutación de las antenas.

Result.OnData := DatosCapturados;                        //Le asigna un manejador para que atienda la captura de datos.
Result.OnActivate := FEntradaDeAudioActivada;            //Un manejador para que atienda la Activación de la captura.
Result.OnDeactivate := FEntradaDeAudioDesactivada;       //Otro para que atienda la Desactivación de la captura.
end;

//-----------------------------------------------------------------------------
// Inicia el goniómetro.
//-----------------------------------------------------------------------------
constructor TRadioProcesador.Create(AOwner:TComponent);
begin
inherited;

//Inicia el estado visual.
FMostrarIntervalos := False;
FMostrarVariacion := False;
FMostrarFracciones := False;
FMostrarSaturacion := True;
FPorcientoDeMuestrasVisibles := 1;
CongelarGrafica := False;

//Inicia el estado de funcionamiento.
FReproduciendo := False;
FSaturacion := False;
FErrorDeSincronia := False;
FDetectarCrecientes := False;
FAmplitudMinimaDetectable := CAmplitudMinimaDetectable;
FDistanciaDeSubida := CDistanciaDeSubida;
FDesplazamientoDeMarca := CDesplazamientoDeMarca;
FEspaciadoAdicional := CEspaciadoAdicional;

//Crea los dispositivos de captura y grabación del audio.
LongitudDelBuffer := 20;
FEntradaDeAudio := NuevoDispositivo(0, Formato16Bits(3), LongitudDelBuffer);        //*********************************************

//Crea e inicia el Mapa de Bits para dibujado.
BMP := TBitmap.Create;                                   //Crea un mapa de bits.
BMP.Width := 100;                                        //Establece el ancho del Mapa de Bits.
BMP.Height := 100;                                       //Establece la altura del Mapa de Bits.

//Crea l aprimera imagen de la gráfica.
GraficarDatos;                                           //Dibuja la gráfica en un Mapa de Bits.
Invalidate;                                              //Copia la imagen a la parte gráfica del componente.

//Inicia el Temporizador que actualiza el gráfico.
FActualizacionDelGrafico := 50;
FActualizador := TTimer.Create(Self);
FActualizador.Interval := FActualizacionDelGrafico;
FActualizador.OnTimer := ActualizarGrafico;
FActualizador.Enabled := True;

CalcularResultados := True;
end;

//-----------------------------------------------------------------------------
// Actualiza la vista de los datos.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.ActualizarGrafico(Sender: TObject);
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
procedure TRadioProcesador.SetActualizacionDelGrafico(valor: Integer);
begin
if valor > 10 then
   begin
   FActualizacionDelGrafico := Abs(valor);
   FActualizador.Interval := FActualizacionDelGrafico;
   end;
end;

//-----------------------------------------------------------------------------
// Determina si se deben detectar las crecientes o las decrecientes.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetDetectarCrecientes(valor: Boolean);
begin
FDetectarCrecientes := valor;
end;

//-----------------------------------------------------------------------------
// Establece la amplitud mínima que debe tener una creciente o
// decreciente para que sea detectada por el algoritmo.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetAmplitudMinimaDetectable(valor: Double);
begin
if valor > 1 then valor := 1;                               //Limita el valor al rango de 0 a 1.
if valor < 0 then valor := 0;
FAmplitudMinimaDetectable := Round(valor * CMaxDatoRango);  //Calcula la amplitud a partir del porciento.
end;

//-----------------------------------------------------------------------------
// Obtiene la amplitud mínima que debe tener una creciente o
// decreciente para que sea detectada por el algoritmo.
//-----------------------------------------------------------------------------
function TRadioProcesador.GetAmplitudMinimaDetectable: Double;
begin
Result := FAmplitudMinimaDetectable / CMaxDatoRango;        //Calcula el porciento a partir de la amplitud.
end;

//-----------------------------------------------------------------------------
// Establece la suavidad que deben tener la crecientes y
// decrecientes para ser detectadas por el algoritmo.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetDistanciaDeSubida(valor: Integer);
begin
FDistanciaDeSubida := valor;
end;

//-----------------------------------------------------------------------------
// Establece el desplazamiento de las marcas de sincronía con
// respecto a la señal de sincronía. Esto se usa para corregir
// algunos defectos que puedan ocurrir durante el funcionamiento.
// Este valor se da en muestras.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetDesplazamientoDeMarca(valor: Integer);
begin
FDesplazamientoDeMarca := valor;
end;

//-----------------------------------------------------------------------------
// Establece la separación en muestras entre los intervalos de antenas.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetEspaciadoAdicional(valor: Integer);
begin
FEspaciadoAdicional := valor;
end;

//-----------------------------------------------------------------------------
// Establece las propiedades de visualización.
//-----------------------------------------------------------------------------
procedure TRadioProcesador.SetMostrarVariacion(valor: Boolean);
begin
FMostrarVariacion := valor;
GraficarDatos;
Invalidate;
end;

procedure TRadioProcesador.SetMostrarIntervalos(valor: Boolean);
begin
FMostrarIntervalos := valor;
GraficarDatos;
Invalidate;
end;

procedure TRadioProcesador.SetMostrarFracciones(valor: Boolean);
begin
FMostrarFracciones := valor;
GraficarDatos;
Invalidate;
end;

procedure TRadioProcesador.SetMostrarSaturacion(valor: Boolean);
begin
FMostrarSaturacion := valor;
GraficarDatos;
Invalidate;
end;

procedure TRadioProcesador.SetPorcientoDeMuestrasVisibles(valor: Double);
begin
FPorcientoDeMuestrasVisibles := valor;
GraficarDatos;
Invalidate;
end;


////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Registra el componente en la paleta del IDE.
//-----------------------------------------------------------------------------
procedure Register;
begin
RegisterComponents('RDF', [TRadioProcesador]);
end;

end.
