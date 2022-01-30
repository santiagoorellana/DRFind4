////////////////////////////////////////////////////////////////////////////////
// Autor: Santiago A. Orellana P�rez
// Creado: 11/8/2013
// Prop�sito: Exporta un componente gr�fico que se utiliza para el c�lculo
//            de la direcci�n (azimut de llegada) de una se�al radioel�ctrica.
//            Se utiliza en la implementaci�n de un Radiogoni�metro por
//            Amplitud de cuatro antenas conmutadas.
////////////////////////////////////////////////////////////////////////////////

unit UPantallaRadiogoniometroAmplitud;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Math, ExtCtrls;

//-----------------------------------------------------------------------------
// Colores de la pantalla de azimut.
//-----------------------------------------------------------------------------
const clFondo               = clBlack;      //Color de fondo de la gr�fica.
const clMarcacion           = clRed;        //Color de la l�nea de marcaci�n.
const clHuellas             = clTeal;       //Color de las huellas.
const clMediana             = clYellow;     //Color de las huellas.
const clVariacion           = clWhite;      //Color de las huellas.
const clEjesDeAntenas       = clGray;       //Color de los ejes de las antenas.
const clEjesDeRosanautica   = clGreen;      //Colorde los ejes de la Rosa N�utica
const clAntenaDeReferencia  = clRed;        //Color de la antena de referencia.
const clAntenas             = clGreen;      //Color del resto de las antenas.
const clAmplitudPorAntenas  = clBlue;       //Color para representar la se�al de las antenas.
const clEtiquetaRosaNautica = clLime;       //Color de las etiquetas de la Rosa N�utica.

//-----------------------------------------------------------------------------
// Para c�lculos de vectores.
//-----------------------------------------------------------------------------
const PIp2 = 360;                           //Representa a PI * 2 en grados.
const PId2 = 90;                            //Representa a PI / 2 en grados.

//-----------------------------------------------------------------------------
// Constantes de visualizaci�n de las etiquetas.
//-----------------------------------------------------------------------------
const CAlturaDeFuente = 10;
const Etiqueta: Array [0..1, 0..3] of Integer =
      ((0, 90, 180, 270), (Ord('N'), Ord('E'), Ord('S'), Ord('W')));


//-----------------------------------------------------------------------------
const CMaxHistorialMarcaciones = 500;
const CMaxHistorialAmplitudes = 200;

//-----------------------------------------------------------------------------
// Par�metros de visualizaci�n de la pantalla.
//-----------------------------------------------------------------------------
const CMarca = 6;
const CIntervaloDeMarca = 90;
const CCirculos = 3;
const CAnchoDeAntenas = 5;
const CAnchoDeSeparador = 5;
const CAntenas = 4;
const CAnchoMarcacion = 7;


type TTipoDeFicheroDeGoniometro = (fWAV, fCSV);

//-----------------------------------------------------------------------------
// Dato de marcaci�n.
//-----------------------------------------------------------------------------
type TMarcacion = record
                  Angulo: Double;         //�ngulo del vector de marcaci�n.
                  Modulo: Double;         //M�dulo del vector de marcaci�n.
                  end;

type TMarcaciones = Array of TMarcacion;
type TAmplitudes = Array of Double;
type TValores = Array of Double;

type TPunto = record
              X: Double;
              Y: Double;
              end;

type TResultadosDelCalculo = record
                             MarcacionAnguloInstantaneo: Double;       //Guarda el �ngulo instantaneo de las marcaciones.
                             MarcacionAnguloMedia: Double;             //Guarda la media del �ngulo de las marcaciones.
                             MarcacionAnguloVariacion: Double;         //Guarda la variaci�n del �ngulo de las marcaciones.
                             MarcacionModuloInstantaneo: Double;       //Guarda el m�dulo instantaneo de las marcacines.
                             MarcacionModuloMedia: Double;             //Guarda la media del m�dulo de las marcacines.
                             MarcacionModuloVariacion: Double;         //Guarda la variaci�n del m�dulo de las marcacines.

                             Antena1AmplitudInstantanea: Double;       //Guarda la amplitud instant�nea de la antena #1.
                             Antena2AmplitudInstantanea: Double;       //Guarda la amplitud instant�nea de la antena #2,
                             Antena3AmplitudInstantanea: Double;       //de la antena 2
                             Antena4AmplitudInstantanea: Double;       //y de la #3.

                             Antena1AmplitudMedia: Double;
                             Antena2AmplitudMedia: Double;
                             Antena3AmplitudMedia: Double;
                             Antena4AmplitudMedia: Double;
                             
                             Antena1AmplitudVariacion: Double;
                             Antena2AmplitudVariacion: Double;
                             Antena3AmplitudVariacion: Double;
                             Antena4AmplitudVariacion: Double;
                             end;

//-----------------------------------------------------------------------------
// Nuevos tipos de eventos de este componente.
//-----------------------------------------------------------------------------
type TMouseMovidoEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y: Integer; Azimut: Double) of object;

type TCalculosTerminadosEvent = procedure(Sender: TObject; Resultado: TResultadosDelCalculo) of object;

type TMarcacionEvent = procedure(Sender: TObject; Resultado: TResultadosDelCalculo) of object;

type TGrabacionEvent = procedure(Sender: TObject; Fichero: String) of object;

//-----------------------------------------------------------------------------
type
  TPantallaRadiogoniometroAmplitud = class(TGraphicControl)
  private
     Activado: Boolean;

     //Para la visualizaci�n.
     BMP: Graphics.TBitmap;
     FActualizador: TTimer;                       //Componente que actualiza el gr�fico.
     FActualizacionDelGrafico: Integer;           //Intervalo en milisegundos de actualizaci�n del gr�fico de la pantalla.
     FHuellas: Double;                            //Porciento de 0 a 1 de marcaciones que se muestran como huellas en la pantalla.

     FAjusteDeReferencia: Integer;                //Diferencia entre el norte real y la antena de referencia.

     //Historial para las marcaciones.
     FHistorialMarcaciones: Array of TMarcacion;  //Arreglo donde se guardan las marcaciones anteriores.
     FHistorialMarcacionesGuardado: Integer;      //Cantidad de marcaciones en el historial. (Se debe iniciar a cero cada vez que se cambia de frecuencia)
     FHistorialMarcacionesAUtilizar: Integer;     //Cantidad de marcaciones del historial que se utilizan.

     //Historial de amplitudes por antenas.
     FHistoriaAntena1: TAmplitudes;
     FHistoriaAntena2: TAmplitudes;
     FHistoriaAntena3: TAmplitudes;
     FHistoriaAntena4: TAmplitudes;
     FLongHistorialAmplitudes: Integer;
     FHistorialDeAntenasGuardado: Integer;
     FUtilizarMediaDeAmplitudes: Boolean;         //Indica si se deben utilizar las medias de las amplitudes en los c�lculos.

     //Datos de amplitudes de antenas calculados.
     FAntena1AmplitudInstantanea: Double;                          //Guarda la amplitud de la antena 1.
     FAntena2AmplitudInstantanea: Double;                          //Guarda la amplitud de la antena #1,
     FAntena3AmplitudInstantanea: Double;                          //de la antena 2
     FAntena4AmplitudInstantanea: Double;                          //y de la #3.
     FAntena1AmplitudMedia: Double;
     FAntena2AmplitudMedia: Double;
     FAntena3AmplitudMedia: Double;
     FAntena4AmplitudMedia: Double;
     FAntena1AmplitudVariacion: Double;
     FAntena2AmplitudVariacion: Double;
     FAntena3AmplitudVariacion: Double;
     FAntena4AmplitudVariacion: Double;
     FAntena: Array [0..3] of Double;

     //Par�metros de filtrado de las marcaciones.
     FUmbralDeNivel: Double;
     FUmbralDeAnguloCentro: Double;
     FUmbralDeAnguloAmplitud: Double;

     //Apariencia.
     FMostrarEjesDeRosaNautica: Boolean;
     FMostrarMarcasDeRosaNautica: Boolean;
     FMostrarEjesDelSistemaDeAntenas: Boolean;
     FMostrarAmplitudPorAntenasComoLineas: Boolean;
     FMostrarAmplitudPorAntenasComoLobulos: Boolean;
     FMostrarPuntosCardinales: Boolean;
     FMostrarMarcacion: Boolean;
     FMostrarMedia: Boolean;
     FMostrarVariacion: Boolean;
     FMostrarNiveles: Boolean;
     FMostrarUmbral: Boolean;

     //Resultados del c�lculo del azimut.
     FAnguloMedia: Double;                      //Guarda la media del �ngulo de las marcaciones.
     FAnguloVariacion: Double;                  //Guarda la variaci�n del �ngulo de las marcaciones.
     FModuloMedia: Double;                      //Guarda la media del m�dulo de las marcacines.
     FModuloVariacion: Double;                  //Guarda la variaci�n del m�dulo de las marcacines.

     //Eventos nuevos de este componente.
     FOnNuevosDatosDeAntenas: TNotifyEvent;
     FOnCalculosTerminados: TCalculosTerminadosEvent;
     FOnDibujoTerminado: TNotifyEvent;
     FOnAjusteDeReferencia: TNotifyEvent;
     FOnCambioDeInercia: TNotifyEvent;
     FOnCambioDeHuella: TNotifyEvent;
     FOnMouseMovidoEvent: TMouseMovidoEvent;
     FOnMarcacionEvent: TMarcacionEvent;
     FOnNotMarcacionEvent: TMarcacionEvent;
     FOnGrabacionActivada: TGrabacionEvent;
     FOnGrabacionDesactivada: TNotifyEvent;

     //Para controlar el proceso de grabaci�n.
     FGrabando: Boolean;
     FrecuenciaDeMuestreo: Integer;               //Frecuencia de muestreo con que se capturan las se�ales.
     LongitudDelBuffer: Integer;                  //Tama�o del buffer de captura del audio.
     InstanteInicial: Cardinal;                   //Instante en que comienza la grabaci�n.
     NombreFicheroActual: String;
     NombreRutaFicheroWAVActual: String;
     NombreRutaFicheroCSVActual: String;
     RutaParaGuardarGrabaciones: String;
     FImporta: Boolean;
     FGrabarEntradaDeAntenasWAV: Boolean;
     FGrabarMarcacionesCSV: Boolean;
     FCSV: TextFile;
     CSVAvierto: Boolean;
     ContadorDemarcaciones: Integer;

     function Seno(x: Double): Double;
     function Coseno(x: Double): Double;
     function ArcoTangente(a: Double): Double;
     function Vector(p: TPoint; d: Integer; m: Double): TPoint;
     function VectorReal(p: TPunto; d: Double; m: Double): TPunto;
     function InterpolarColores(Fraccion: Double; Color1, Color2: TColor): TColor;
     function Modulo(R, I: Extended): Extended;
     function Fase(R, I: Extended): Extended;
     function ComoReloj(valor: Double): Double;
     function CorregirModulo(Marcacion: TMarcacion): TMarcacion;
     procedure GraficarDatos;
     procedure ActualizarGrafico(Sender: TObject);

     procedure SetActualizacionDelGrafico(valor: Integer);
     procedure SetPorcientoDeHuellas(valor: Integer);
     function GetPorcientoDeHuellas: Integer;
     procedure SetAjusteDeReferencia(valor: Integer);
     procedure SetLongHistorialMarcaciones(valor: Integer);
     procedure SetLongHistorialAmplitudes(valor: Integer);
     function GetAnguloInstantaneo: Double;
     function GetModuloInstantaneo: Double;
     procedure SetUtilizarMediaDeAmplitudes(valor: Boolean);
     procedure SetUmbralDeNivel(valor: Double);
     procedure SetUmbralDeAnguloCentro(valor: Double);
     procedure SetUmbralDeAnguloAmplitud(valor: Double);

     procedure SetMostrarVariacion(valor: Boolean);
     procedure SetMostrarMedia(valor: Boolean);
     procedure SetMostrarMarcacion(valor: Boolean);
     procedure SetMostrarPuntosCardinales(valor: Boolean);
     procedure SetMostrarAmplitudPorAntenasComoLobulos(valor: Boolean);
     procedure SetMostrarAmplitudPorAntenasComoLineas(valor: Boolean);
     procedure SetMostrarEjesDelSistemaDeAntenas(valor: Boolean);
     procedure SetMostrarMarcasDeRosaNautica(valor: Boolean);
     procedure SetMostrarEjesDeRosaNautica(valor: Boolean);
     procedure SetMostrarNiveles(valor: Boolean);
     procedure SetMostrarUmbral(valor: Boolean);
     procedure SetGrabarMarcacionesCSV(valor: Boolean);

     procedure CalcularMarcacion;

     //Para la grabaci�n.
     function DiferenciaAngular(A, B: Double): Double;
     function Importante(Modulo, Angulo: Double): Boolean;
  protected
     procedure Paint; override;
     procedure ReSize;  override;
     procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
     CongelarGrafica: Boolean;
     TiempoDeCaida: Cardinal;                                                    //Tiempo que demora en terminar la grabaci�n luego de desaparecer la se�al.
     Latitud: Double;
     Longitud: Double;
     FrecuenciaMhz: Double;
     Reproduciendo: Boolean;

     constructor Create(AOwner:TComponent); override;
     procedure AgregarAmplitudes(A1, A2, A3, A4: Double);
     procedure AgregarMarcacion(Angulo: Double; Longitud: Double);
     procedure Reiniciar;
     procedure Activar;
     procedure Desactivar;

     property AmplitudAntena1Instantanea: Double read FAntena1AmplitudInstantanea;
     property AmplitudAntena2Instantanea: Double read FAntena2AmplitudInstantanea;
     property AmplitudAntena3Instantanea: Double read FAntena3AmplitudInstantanea;
     property AmplitudAntena4Instantanea: Double read FAntena4AmplitudInstantanea;
     property AmplitudAntena1Media: Double read FAntena1AmplitudMedia;
     property AmplitudAntena2Media: Double read FAntena2AmplitudMedia;
     property AmplitudAntena3Media: Double read FAntena3AmplitudMedia;
     property AmplitudAntena4Media: Double read FAntena4AmplitudMedia;
     property AmplitudAntena1Variacion: Double read FAntena1AmplitudVariacion;
     property AmplitudAntena2Variacion: Double read FAntena2AmplitudVariacion;
     property AmplitudAntena3Variacion: Double read FAntena3AmplitudVariacion;
     property AmplitudAntena4Variacion: Double read FAntena4AmplitudVariacion;

     property AnguloInstantaneo: Double read GetAnguloInstantaneo;
     property AnguloTendenciaCentral: Double read FAnguloMedia;
     property AnguloDesviacion: Double read FAnguloVariacion;
     property ModuloInstantaneo: Double read GetModuloInstantaneo;
     property ModuloTendenciaCentral: Double read FModuloMedia;
     property ModuloDesviacion: Double read FModuloVariacion;

     property UmbralDeNivel: Double read FUmbralDeNivel write SetUmbralDeNivel;
     property UmbralDeAnguloCentro: Double read FUmbralDeAnguloCentro write SetUmbralDeAnguloCentro;
     property UmbralDeAnguloAmplitud: Double read FUmbralDeAnguloAmplitud write SetUmbralDeAnguloAmplitud;

     property Importa: Boolean read FImporta;
     property HistorialDeMarcacionesGuardado: Integer read FHistorialMarcacionesGuardado;
     property GrabarMarcacionesCSV: Boolean read FGrabarMarcacionesCSV write SetGrabarMarcacionesCSV;
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
     property PorcientoDeHuellas: Integer read GetPorcientoDeHuellas Write SetPorcientoDeHuellas default 100;
     property AjusteDeReferencia: Integer read FAjusteDeReferencia Write SetAjusteDeReferencia default 0;
     property InerciaAmplitudes: Integer read FLongHistorialAmplitudes Write SetLongHistorialAmplitudes default CMaxHistorialAmplitudes div 2;
     property InerciaMarcaciones: Integer read FHistorialMarcacionesAUtilizar Write SetLongHistorialMarcaciones default CMaxHistorialMarcaciones div 2;
     property UtilizarMediaDeAmplitudes: Boolean read FUtilizarMediaDeAmplitudes write SetUtilizarMediaDeAmplitudes default True;

     property MostrarVariacion: Boolean read FMostrarVariacion Write SetMostrarVariacion default True;
     property MostrarMedia: Boolean read FMostrarMedia Write SetMostrarMedia default True;
     property MostrarMarcacion: Boolean read FMostrarMarcacion Write SetMostrarMarcacion default True;
     property MostrarPuntosCardinales: Boolean read FMostrarPuntosCardinales Write SetMostrarPuntosCardinales default True;
     property MostrarAmplitudPorAntenasComoLobulos: Boolean read FMostrarAmplitudPorAntenasComoLobulos Write SetMostrarAmplitudPorAntenasComoLobulos default True;
     property MostrarAmplitudPorAntenasComoLineas: Boolean read FMostrarAmplitudPorAntenasComoLineas Write SetMostrarAmplitudPorAntenasComoLineas default True;
     property MostrarEjesDelSistemaDeAntenas: Boolean read FMostrarEjesDelSistemaDeAntenas Write SetMostrarEjesDelSistemaDeAntenas default True;
     property MostrarMarcasDeRosaNautica: Boolean read FMostrarMarcasDeRosaNautica Write SetMostrarMarcasDeRosaNautica default True;
     property MostrarEjesDeRosaNautica: Boolean read FMostrarEjesDeRosaNautica Write SetMostrarEjesDeRosaNautica default True;
     property MostrarNiveles: Boolean read FMostrarNiveles Write SetMostrarNiveles default True;
     property MostrarUmbral: Boolean read FMostrarUmbral Write SetMostrarUmbral default True;

     //Nuevos eventos de este componente.
     property OnNuevosDatos: TNotifyEvent read FOnNuevosDatosDeAntenas Write FOnNuevosDatosDeAntenas;
     property OnCalculosTerminados: TCalculosTerminadosEvent read FOnCalculosTerminados Write FOnCalculosTerminados;
     property OnDibujoTerminado: TNotifyEvent read FOnDibujoTerminado Write FOnDibujoTerminado;
     property OnAjusteDeReferencia: TNotifyEvent read FOnAjusteDeReferencia Write FOnAjusteDeReferencia;
     property OnCambioDeInercia: TNotifyEvent read FOnCambioDeInercia Write FOnCambioDeInercia;
     property OnCambioDeHuella: TNotifyEvent read FOnCambioDeHuella Write FOnCambioDeHuella;
     property OnMouseMovido: TMouseMovidoEvent read FOnMouseMovidoEvent Write FOnMouseMovidoEvent;
     property OnMarcacion: TMarcacionEvent read FOnMarcacionEvent Write FOnMarcacionEvent;
     property OnNotMarcacion: TMarcacionEvent read FOnNotMarcacionEvent Write FOnNotMarcacionEvent;
     property OnGrabacionActivada: TGrabacionEvent read FOnGrabacionActivada Write FOnGrabacionActivada;
     property OnGrabacionDesactivada: TNotifyEvent read FOnGrabacionDesactivada Write FOnGrabacionDesactivada;
  end;

procedure Register;

implementation

//-----------------------------------------------------------------------------
//  Devuelve el seno.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Seno(x: Double): Double;
begin
Result := Sin(DegToRad(x));
end;

//-----------------------------------------------------------------------------
//  Devuelve el coseno.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Coseno(x: Double): Double;
begin
Result := Cos(DegToRad(x));
end;

//-----------------------------------------------------------------------------
//  Devuelve el arco (�ngulo) en grados, cuya tangente es igual al valor X.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.ArcoTangente(a: Double): Double;
begin
Result := RadToDeg(ArcTan(a));
end;

//-----------------------------------------------------------------------------
// Dado un vector (segmento) que va desde el punto P1 hasta el punto P2,
// esta funci�n devuelve el punto P2 del vector (segmento) dado, si se
// conoce el punto P1, su m�dulo (longitud) y el �ngulo del vector
// (azimut en grados) con que se inclina el vector (segmento)
// con respecto al eje X.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Vector(p: TPoint;     //Coordenadas del punto de partida (P1) del vector.
                                                 d: Integer;    //Longitud (m�dulo) del vector.
                                                 m: Double      //�ngulo de inclinaci�n del vector.
                                                 ): TPoint;
begin
m := m - PId2;
Result.x := Round(d * Coseno(m) + p.x);
Result.y := Round(d * Seno(m) + p.y);
end;

function TPantallaRadiogoniometroAmplitud.VectorReal(p: TPunto;     //Coordenadas del punto de partida (P1) del vector.
                                                     d: Double;     //Longitud (m�dulo) del vector.
                                                     m: Double      //�ngulo de inclinaci�n del vector.
                                                     ): TPunto;
begin
m := m - PId2;
Result.x := d * Coseno(m) + p.x;
Result.y := d * Seno(m) + p.y;
end;

//-----------------------------------------------------------------------------
// Dado un n�mero complejo, esta funci�n calcula el m�dulo del vector
// a partir de la parte Real e Imaginaria. Los par�metros son:
// R = Parte real del n�mero complejo.
// I = Parte imaginaria del n�mero complejo.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Modulo(R, I: Extended): Extended;
begin
Result := Sqrt(Sqr(R) + Sqr(I));
end;

//-----------------------------------------------------------------------------
// Dado un n�mero complejo, esta funci�n calcula la fase del vector
// a partir de la parte Real e Imaginaria. Los par�metros son:
// R = Parte real del n�mero complejo.
// I = Parte imaginaria del n�mero complejo.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Fase(R, I: Extended): Extended;
begin
Result := 0; 
if R = 0 then
   begin
   if I = 0 then Result := 0 else                              //Si el vector tiene m�dulo 0.
   if I > 0 then Result := 90 else                             //Si coincide con la parte positiva del eje Y.
   if I < 0 then Result := 270;                                //Si coincide con la parte negativa del eje Y.
   end
else
   if R > 0 then
      begin
      if I = 0 then Result := 0 else                           //Si coincide con la parte positiva del eje X.
      if I > 0 then Result := ArcoTangente(I / R) else         //Si se encuentra en el primer cuadrante.
      if I < 0 then Result := 360 + ArcoTangente(I / R);       //Si se encuentra en el cuarto cuadrante.
      end
   else
      begin
      Result := 180;                                           //Si coincide con la parte negativa del eje X.
      if I <> 0 then Result := Result + ArcoTangente(I / R);   //Si se encuentra en el segundo o tercer cuadrante.
      end;
end;

//-----------------------------------------------------------------------------
// Esta funci�n toma un valor de �ngulo de un sistema cartesiano
// normal y lo transforma haciendolo girar hasta que el cero
// coincida con la parte positiva del eje Y. Tambi�n lo invierte
// de manera tal que los �ngulos se incrementen en el sentido
// de las manecillas del reloj a partir de las 12.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.ComoReloj(valor: Double): Double;
begin
Result := 360 - valor + 90;
if Result > 360 then Result := Result - 360;
end;

//-----------------------------------------------------------------------------
// Inserta nuevos datos de amplitud de antenas y comienza a realizar los
// c�lculos de marcaci�n a partir de los nuevos datos y los anteriores.
//
// Entradas:
// A1, A2, A3 y A4 = Son las amplitudes de las antenas 1, 2, 3 y 4 como
//                   un valor Double en el rango de 0 a 1. (Ver nota).
//                   Si alguno de estos valores es negativo, el componente
//                   entiende que no se debe representar ninguna marcaci�n.
//
// Nota:
// Los valores de amplitud de las antenas que sobrepasen el 1 ser�n recortados
// a 1. Esto se realiza para evitar errores indeseados en los c�lculos y en la
// gr�fica. A�n as�, es responsabilidad del invocador asegurarse de que los
// valores permanezcan en el rango de 0 a 1 o de lo contrario la marcaci�n
// resultante no ser� precisa.
// Lo correcto es que las amplitudes pasadas a esta funci�n sean la raz�n de
// las amplitudes originales que se muestrearon con la tarjeta de sonido y
// la amplitud m�xima que se puede muestrear con dicha tarjeta, con lo cual
// se asegura que los valores siempre permanezcan entre 0 y 1.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.AgregarAmplitudes(A1, A2, A3, A4: Double);
var n: Integer;
    s1, s2, s3, s4: Double;
begin
//Si los datos son negativos, significa que no deben representar las marcaciones.
if (A1 < 0) or (A2 < 0) or (A3 < 0) or (A4 < 0) then
   begin
   A1 := 0;
   A2 := 0;
   A3 := 0;
   A4 := 0;
   Reiniciar;
   end;

//Limita los valores de amplitud al rango permitido
if A1 > 1 then A1 := 1;                                          //Si alguno de los valores sobrepasa
if A2 > 1 then A2 := 1;                                          //el uno, se recorta a uno.
if A3 > 1 then A3 := 1;
if A4 > 1 then A4 := 1;

//Agrega los datos de amplitud en el historial de amplitudes.
if FHistorialDeAntenasGuardado < FLongHistorialAmplitudes then   //Si no se ha llegado al m�ximo de marcaciones:
   Inc(FHistorialDeAntenasGuardado)                              //incrementa el contador de marcaciones.
else
   FHistorialDeAntenasGuardado := FLongHistorialAmplitudes;
for n := FLongHistorialAmplitudes - 1 downto 1 do                //Elimina un elemento del inicio de la cola dejando un
    begin                                                        //espacio al final de la cola para el nuevo elemento.
    FHistoriaAntena1[n] := FHistoriaAntena1[n - 1];
    FHistoriaAntena2[n] := FHistoriaAntena2[n - 1];
    FHistoriaAntena3[n] := FHistoriaAntena3[n - 1];
    FHistoriaAntena4[n] := FHistoriaAntena4[n - 1];
    end;
FHistoriaAntena1[0] := A1;                                       //Inserta el nuevo elemento en el
FHistoriaAntena2[0] := A2;                                       //historial de cada antena.
FHistoriaAntena3[0] := A3;
FHistoriaAntena4[0] := A4;
FAntena1AmplitudInstantanea := A1;                               //Guarda la amplitud instantanes
FAntena2AmplitudInstantanea := A2;                               //de cada una de las antenas.
FAntena3AmplitudInstantanea := A3;
FAntena4AmplitudInstantanea := A4;

//Calcula las medias de las amplitudes de cada antena.
s1 := 0;
s2 := 0;
s3 := 0;
s4 := 0;
for n := 0 to FHistorialDeAntenasGuardado - 1 do
    begin
    s1 := s1 + Abs(FHistoriaAntena1[n]);
    s2 := s2 + Abs(FHistoriaAntena2[n]);
    s3 := s3 + Abs(FHistoriaAntena3[n]);
    s4 := s4 + Abs(FHistoriaAntena4[n]);
    end;
FAntena1AmplitudMedia := s1 / FHistorialDeAntenasGuardado;
FAntena2AmplitudMedia := s2 / FHistorialDeAntenasGuardado;
FAntena3AmplitudMedia := s3 / FHistorialDeAntenasGuardado;
FAntena4AmplitudMedia := s4 / FHistorialDeAntenasGuardado;

//Calcula las variaciones de las amplitudes de cada antena.
s1 := 0;
s2 := 0;
s3 := 0;
s4 := 0;
for n := 0 to FHistorialDeAntenasGuardado - 1 do
    begin
    s1 := s1 + Sqr(FHistoriaAntena1[n] - FAntena1AmplitudMedia);
    s2 := s2 + Sqr(FHistoriaAntena2[n] - FAntena2AmplitudMedia);
    s3 := s3 + Sqr(FHistoriaAntena3[n] - FAntena3AmplitudMedia);
    s4 := s4 + Sqr(FHistoriaAntena4[n] - FAntena4AmplitudMedia);
    end;
FAntena1AmplitudVariacion := Sqrt(s1 / FHistorialDeAntenasGuardado);
FAntena2AmplitudVariacion := Sqrt(s2 / FHistorialDeAntenasGuardado);
FAntena3AmplitudVariacion := Sqrt(s3 / FHistorialDeAntenasGuardado);
FAntena4AmplitudVariacion := Sqrt(s4 / FHistorialDeAntenasGuardado);

//Informa que han llegado nuevos datos de marcaciones.
if Assigned(FOnNuevosDatosDeAntenas) then FOnNuevosDatosDeAntenas(Self);

//Inicia el c�lculo de la marcaci�n teniendo en cuenta
//los valores anteriormente guardados. Es decir, que
//estos c�lculos se realizan con los valores nuevos
//m�s los que se encuentran guardados en el historial
//de amplitudes.
CalcularMarcacion;
end;

//-----------------------------------------------------------------------------
// Corrige la magnitud del m�dulo del vector de marcaci�n en
// dependencia del �ngulo del vector.
//
// Entrada:
// Marcacion  = Es el vector de marcaci�n al que se le debe corregir el m�dulo.
//
// Salida:
// Devuelve el vector de marcaci�n con el m�dulo corregido.
//
// Funcionamiento:
// Debido a que la marcaci�n del goni�metro se representa internamente
// como un vector (�ngulo y m�dulo), el cual se calcula a partir de sus
// componentes X e Y mediante las t�cnicas del c�lculo vectorial; la
// magnitud del m�dulo del vector obtenida no representa exactamente
// la realidad que se quiere simular. Para que pueda ser utilizada
// el m�dulo del vector debe ser corregido de manera tal que la
// amplitud se mantenga constante en todos los �ngulos de la
// marcaci�n de una se�al de amplitud constante.
//
// Es decir, que si se recibe una se�al de amplitud constante, en
// cualquiera de sus �ngulos el m�dulo del vector de marcaci�n
// debe ser el mismo. Esto se debe a que el m�dulo del vector
// debe representar la amplitud de la se�al recibida por el
// goni�metro.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.CorregirModulo(Marcacion: TMarcacion): TMarcacion;
begin
Result := Marcacion;
end;

//-----------------------------------------------------------------------------
// Calcula el azimut y el m�dulo de la marcai�n utilizando los valores
// de amplitud de las cuatro antenas que se encuentran en el Historial
// de Amplitudes. Guarda en el Historial de Marcaciones el �ngulo y
// m�dulo del vector de la marcaci�n calculada.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.CalcularMarcacion;
var X, Y: Double;
    m: TMarcacion;
begin
if FUtilizarMediaDeAmplitudes then                                 //Si se deben utilizar las amplitudes promediadas:
   begin
   X := FAntena2AmplitudMedia - FAntena4AmplitudMedia;             //Calcula la resultante de cada par de antenas opuestas.
   Y := FAntena1AmplitudMedia - FAntena3AmplitudMedia;             //Luego asume que las resultantes son un n�mero complejo.
   FAntena[0] := FAntena1AmplitudMedia;
   FAntena[1] := FAntena2AmplitudMedia;
   FAntena[2] := FAntena3AmplitudMedia;
   FAntena[3] := FAntena4AmplitudMedia;
   end
else                                                               //De lo contrario, utilizar las ampiltudes instantaneas:
   begin
   X := FAntena2AmplitudInstantanea - FAntena4AmplitudInstantanea; //Calcula la resultante de cada par de antenas opuestas.
   Y := FAntena1AmplitudInstantanea - FAntena3AmplitudInstantanea; //Luego asume que las resultantes son un n�mero complejo.
   FAntena[0] := FHistoriaAntena1[0];
   FAntena[1] := FHistoriaAntena2[0];
   FAntena[2] := FHistoriaAntena3[0];
   FAntena[3] := FHistoriaAntena4[0];
   end;
m.Modulo := Modulo(X, Y);                                          //Calcula el m�dulo a partir del n�mero complejo.
m.Modulo := m.Modulo / Sqrt(2);                                    //Pone el m�dulo en el rango de 0 a 1.
m.Angulo := ComoReloj(Fase(X, Y));                                 //Calcula el �ngulo a partir del n�mero complejo.
m.Angulo := m.Angulo + FAjusteDeReferencia;                        //Le aplica el ajuste de la referencia.
m := CorregirModulo(m);                                            //Hace que el m�dulo de la marcaci�n se mantenga constante independientemente del �ngulo.
AgregarMarcacion(m.Angulo, m.Modulo);                              //Guarda la marcaci�n en el historial y la representa gr�ficamente.
end;

//-----------------------------------------------------------------------------
// Calcula la diferencia geom�trica entre dos �ngulos.
// Esto se realiza midiendo la diferencia m�s peque�a entre los dos �ngulos.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.DiferenciaAngular(A, B: Double): Double;
begin
Result := A - B;                                  //Calcula la diferencia entre los �ngulos de dos vectores.
if Result > 180 then Result := Result - 360;      //Esto se hace para medir la diferencia m�s peque�a
if Result < -180 then Result := Result + 360;     //entre los �ngulos de los vectores.
end;

//-----------------------------------------------------------------------------
// Devuelve TRUE si la amplitud del vector de marcaci�n sobrepasa
// el umbral de nivel establecido y el �ngulo del vector se encuentra
// en el rango establecido.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.Importante(Modulo, Angulo: Double): Boolean;
var d: Double;
begin
Result := False;
if Modulo >= FUmbralDeNivel then                                  //Si el m�dulo sobrepasa el umbral:
   begin
   d := Abs(DiferenciaAngular(Angulo, FUmbralDeAnguloCentro));    //Calcula la diferencia entre la marcaci�n y el centro del rango permitido.
   if d <= FUmbralDeAnguloAmplitud then Result := True;           //Si la diferencia se encuentra en el rango permitido:
   end;
end;

//-----------------------------------------------------------------------------
// Agrega una nueva marcaci�n en el historial de marcaciones y calcula
// la tendencia central y la desviaci�n de las marcaciones acumuladas.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.AgregarMarcacion(Angulo: Double; Longitud: Double);
var n: Integer;
    p1, p2: TPunto;
    mx, my, dif, va, vm, d: Double;
    r: TResultadosDelCalculo;
    Linea: String;
begin
if FHistorialMarcacionesGuardado < CMaxHistorialMarcaciones then    //Si no se ha llegado al m�ximo de marcaciones:
   Inc(FHistorialMarcacionesGuardado)                               //incrementa el contador de marcaciones.
else
   FHistorialMarcacionesGuardado := CMaxHistorialMarcaciones;
for n := CMaxHistorialMarcaciones - 1 downto 1 do                   //Elimina un elemento del inicio de la cola dejando un
    FHistorialMarcaciones[n] := FHistorialMarcaciones[n - 1];       //espacio al final de la cola para el nuevo elemento.
FHistorialMarcaciones[0].Angulo := Angulo;                          //Inserta el nuevo elemento al
FHistorialMarcaciones[0].Modulo := Longitud;                        //final de la cola.

FAnguloMedia := -1;                                                 //Hace inv�lida la mediana del �ngulo
FModuloMedia := -1;                                                 //y la del m�dulo.
FAnguloVariacion := -1;                                             //Hace inv�lida la variaci�n del �ngulo
FModuloVariacion := -1;                                             //y la del m�dulo.

//Calcula la media aritm�tica vectorial de los m�dulos
//y los �ngulos de los vectores de marcaci�n.
p1.X := 0;
p1.Y := 0;                                                          //Declara el centro del sistema de coordenadas
mx := 0;                                                            //con que se desea trabajar.
my := 0;                                                            //Inicia las variables de suma.
for n := 0 to FHistorialMarcacionesAUtilizar - 1 do
    begin                                                           //Crea un vector con cada �ngulo de marcaci�n del historial.
    p2 := VectorReal(p1,                                            //Calcula el punto final de cada vector formado
                     FHistorialMarcaciones[n].Modulo,               //por medio del �ngulo y el m�dulo de cada una
                     FHistorialMarcaciones[n].Angulo);              //de las marcaciones.
    mx := mx + p2.X;                                                //Calcula la sumatoria del valor de las
    my := my + p2.Y;                                                //componentes X e Y de cada vector.
    end;
mx := mx / FHistorialMarcacionesAUtilizar;                          //Divide luego entre la cantidad de vectores.
my := my / FHistorialMarcacionesAUtilizar;
FAnguloMedia := Fase(mx, my) + 90;                                  //Obtiene el vector resultante.
if FAnguloMedia > 360 then                                          //Con esta l�nea se convierten los �ngulos mayores de
   FAnguloMedia := FAnguloMedia - 360;                              //360 en su correspondiente dentro del rango 0 - 360.
FModuloMedia := Modulo(mx, my);                                     //Obtiene la media aritm�tica de los m�dulos de las marcaciones.

//Calcula las variaciones de los �ngulos y m�dulos.
va := 0;
vm := 0;
for n := 0 to FHistorialMarcacionesAUtilizar - 1 do                           //Copia los valores de todas las marcaciones del historial para
    begin                                                                     //realizar luego el c�lculo de la mediana y la variaci�n.
    dif := DiferenciaAngular(FHistorialMarcaciones[n].Angulo, FAnguloMedia);  //Calcula la diferencia m�s peque�a entre dos �ngulos.
    va := va + Sqr(dif);                                                      //Guarda la suma de los cuadrados de las diferencias
    vm := vm + Sqr(FHistorialMarcaciones[n].Modulo - FModuloMedia);           //de los �ngulos y m�dulos con respecto a sus medias.
    end;
FAnguloVariacion := Sqrt(va / FHistorialMarcacionesAUtilizar);                //Termina de calcular las variaciones y las
FModuloVariacion := Sqrt(vm / FHistorialMarcacionesAUtilizar);                //guarda en sus respectivas variables.

//Llena una estructura con el resultado de los c�lculos.
r.MarcacionAnguloInstantaneo := Angulo;
r.MarcacionAnguloMedia := FAnguloMedia;
r.MarcacionAnguloVariacion := FAnguloVariacion;
r.MarcacionModuloInstantaneo := Longitud;
r.MarcacionModuloMedia := FModuloMedia;
r.MarcacionModuloVariacion := FModuloVariacion;

r.Antena1AmplitudInstantanea := FAntena1AmplitudInstantanea;
r.Antena2AmplitudInstantanea := FAntena2AmplitudInstantanea;
r.Antena3AmplitudInstantanea := FAntena3AmplitudInstantanea;
r.Antena4AmplitudInstantanea := FAntena4AmplitudInstantanea;

r.Antena1AmplitudMedia := FAntena1AmplitudMedia;
r.Antena2AmplitudMedia := FAntena2AmplitudMedia;
r.Antena3AmplitudMedia := FAntena3AmplitudMedia;
r.Antena4AmplitudMedia := FAntena4AmplitudMedia;

r.Antena1AmplitudVariacion := FAntena1AmplitudVariacion;
r.Antena2AmplitudVariacion := FAntena2AmplitudVariacion;
r.Antena3AmplitudVariacion := FAntena3AmplitudVariacion;
r.Antena4AmplitudVariacion := FAntena4AmplitudVariacion;

//Si la marcaci�n es relevante:
FImporta := Importante(r.MarcacionModuloInstantaneo, r.MarcacionAnguloInstantaneo);  //Comprueba si las se�ales sobrepasan los umbrales.
if FImporta and Activado then                                                        //Si la se�al sobrepasa el umbral y la pantalla est� activada:
   begin
   InstanteInicial := GetTickCount;                                                  //Marca el tiempo de este instante.

   //Guardar los datos de marcaci�n en el fichero CSV.
   if GrabarMarcacionesCSV and CSVAvierto then
      try
         Linea := TimeToStr(Now) + ';' +
                  FloatToStrF(r.MarcacionAnguloInstantaneo, ffFixed, 15, 1) + ';' +
                  FloatToStrF(r.MarcacionAnguloMedia, ffFixed, 15, 1) + ';' +
                  FloatToStrF(r.MarcacionAnguloVariacion, ffFixed, 15, 1);
         Writeln(FCSV, Linea);
      except
         //...
      end;
   FGrabando := True;                                                          //indica que se inici� la grabaci�n.
   end;

//Informa que se han terminado todos los c�lculos de marcaci�n.
if Assigned(FOnCalculosTerminados) then FOnCalculosTerminados(Self, r);

//Informa la relevancia de los datos de la marcaci�n.
if FImporta then
   begin
   if Assigned(FOnMarcacionEvent) then             //Si el evento est� activado:
      FOnMarcacionEvent(Self, r);                  //Llama al evento.
   end
else
   begin
   if Assigned(FOnNotMarcacionEvent) then          //Si el evento est� activado:
      FOnNotMarcacionEvent(Self, r);               //Llama al evento.
   end;   
end;

//----------------------------------------------------------------------------
// Devuelve la interpolaci�n de dos colores.
//
// Entradas:
// Fraccion = Valor entre 0 y 1 que representa la posici�n a interpolar.
// Color1 = Color inicial de la interpolaci�n que representa el cero.
// Color2 = Color final de la interpolaci�n que representa el uno.
//----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.InterpolarColores(Fraccion: Double; Color1, Color2: TColor): TColor;
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
      Result := RGB(Round(complement * R1 + Fraccion * R2),
                    Round(complement * G1 + Fraccion * G2),
                    Round(complement * B1 + Fraccion * B2));
      end
end;

//-----------------------------------------------------------------------------
// Dibujan los gr�ficos de los �ngulos.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.GraficarDatos;
var p1, p2, pf1, pf2: TPoint;
    re, ri, n, f, a, j, t, ru: Integer;
    Interpolacion, ff, i, m: Double;
    Triangulo: Array [0..2] of TPoint;

    //Dibuja una aguja en la pantalla de azimut.
    procedure DibujarAguja(Color: TColor; Ancho: Integer; Angulo: Double; Longitud: Double);
    var p: Integer;
    begin
    BMP.Canvas.Pen.Color := Color;
    for p := 1 to Ancho do
        begin
        ff := (p - 1) / Ancho;                                   //Calcula la fracci�n de la reducci�n.
        BMP.Canvas.Pen.Width := Round(Ancho * ff);               //Calcula el ancho de la aguja.
        ff := 1 - ff;                                            //Invierte la fracci�n para calcular la longitud.
        BMP.Canvas.MoveTo(round(p1.x), round(p1.y));             //Desde el centro...
        p2 := Vector(p1, Round(ri * Longitud * ff), Angulo);     //Calcula el vector de la aguja.
        BMP.Canvas.LineTo(round(p2.x), round(p2.y));             //Traza la l�nea.
        end;
    end;

begin
if CongelarGrafica then Exit;                                    //Sale si la gr�fica est� congelada.
if (ClientWidth <= 1) or (ClientHeight <= 1) then Exit;          //Sale si el componente tiene dimensiones negativas.

//Actualiza las dimensiones del Mapa de Bits interno.
BMP.Width := ClientWidth;                                        //Establece el ancho del Mapa de Bits.
BMP.Height := ClientHeight;                                      //Establece la altura del Mapa de Bits.

//Dibuja el fondo del componente.
BMP.Canvas.Brush.Style := bsSolid;                               //Relleno de color s�lido.
BMP.Canvas.Brush.Color := clBtnFace;                             //Color de fondo del componente.
BMP.Canvas.Pen.Color := clGrayText;                              //Color del borde del componente.
BMP.Canvas.Pen.Width := 1;                                       //Ancho de las l�neas.
BMP.Canvas.Rectangle(0, 0, BMP.Width, BMP.Height);               //Dibuja el fondo.

//Calcula las dimensiones de referencia.
p1.x := BMP.Width div 2;                                         //Calcula el medio de las X
p1.y := BMP.Height div 2;                                        //Calcula el medio de las Y
re := (Min(BMP.Width, BMP.Height) div 2) - 5;                    //Calcula el radio del exterior de la pantalla.
ri := re - (CAnchoDeAntenas * 2);

//Dibuja las areas circulares de la pantalla.
BMP.Canvas.Ellipse(p1.x -re, p1.y -re, p1.x +re, p1.y +re);      //Dibuja el c�rculo exterior para las marcas de las antenas.
BMP.Canvas.Pen.Color := clEjesDeRosaNautica;                     //Color de las marcas de la Rosa N�utica.
BMP.Canvas.Brush.Color := clFondo;                               //Color de fondo de la pantalla.
BMP.Canvas.Ellipse(p1.x -ri, p1.y -ri, p1.x +ri, p1.y +ri);      //Dibuja el c�rculo exterior de la pantalla interior.
BMP.Canvas.Brush.Style := bsClear;                               //No se utiliza relleno para los aros interiores.
if FMostrarNiveles and (CCirculos > 0) then
   For n := 1 to CCirculos + 1 do                                //Comienza a dibujar los C�rculos Interiores.
       begin
       f := Round(ri / (CCirculos + 1) * n);                     //Calcula la posici�n del aro interior n�mero n.
       BMP.Canvas.Ellipse(p1.x -f, p1.y -f, p1.x +f, p1.y +f);   //Dibuja el aro interior n�mero n.
       end;

//Dibuja los ejes de la Rosa N�utica para la referencia del azimut.
if FMostrarEjesDeRosaNautica then                                //Si se dibuja la segmentaci�n completa:
   begin
   BMP.Canvas.Pen.Width := 1;                                    //Ancho de las l�neas.
   n := 0;
   while n < PIp2 do                                             //Realiza un recorrido completo por todos
         begin                                                   //los �ngulos de 0 a 360 y:
         BMP.Canvas.Pen.Color := clEjesDeRosanautica;            //Color del eje de la rosa n�utica.
         BMP.Canvas.MoveTo(p1.x, p1.y);                          //Parte desde el centro de la circunferencia.
         p2 := Vector(p1, ri, n);                                //Calcula el punto final del radio.
         BMP.Canvas.LineTo(p2.x, p2.y);                          //Traza el radio desde el centro al punto final.
         Inc(n, CIntervaloDeMarca);                              //Incrementa para dibujar la pr�xima marca.
         end;
   end;

//Dibuja las marcas de unidades de �ngulos de la Rosa N�utica.
if FMostrarMarcasDeRosaNautica then                                                     
   begin
   BMP.Canvas.Pen.Width := 1;                                    //Ancho de las l�neas.
   n := 0;
   if CCirculos > 0 then                                         //Si se representanar�n los c�rculos:
      f := Round(ri / (CCirculos + 1)) div 3                     //Calcula el tama�o de las marcas.
   else                                                          //De lo contrario:
      f := Round(ri * 0.1);                                      //Establece el tama�o por porciento.
   while n < PIp2 do                                             //Realiza un recorrido completo por todos
         begin                                                   //los �ngulos de 0 a 360 y:
         if n mod 10 > 0 then
            p2 := Vector(p1, ri - (f div 3), n)                  //Calcula el inicio de la linea de marca.
         else
            p2 := Vector(p1, ri - f, n);                         //Calcula el inicio de la linea de marca.
         BMP.Canvas.MoveTo(round(p2.x), round(p2.y));            //Parte desde el inicio.
         p2 := Vector(p1, ri, n);                                //Calcula el punto final de la marca.
         BMP.Canvas.LineTo(round(p2.x), round(p2.y));            //Traza el radio hasta el final de la marca.
         Inc(n, 5);                                              //Incrementa para dibujar la pr�xima marca.
         end;
   end;

//Dibuja los ejes del sistema de antenas y la
//amplitud de la se�al por cada antena.
m := 0;                                                          //Contador de los �ngulos.
a := 0;                                                          //Empieza con la primera antena.
i := PIp2 / CAntenas;                                            //Calcula la separaci�n de las antenas en grados.
j := FAjusteDeReferencia;                                        //Copia el ajuste de referencia.
while m < PIp2 do                                                //Realiza una rotaci�n completa de 0 a 360.
      begin
      if m = 0 then                                              //Si es la primera antena:
         BMP.Canvas.Brush.Color := clAntenaDeReferencia          //La dibuja como antena de referencia.
      else                                                       //Si no es la primera, la dibuja
         BMP.Canvas.Brush.Color := clAntenas;                    //con otro color.
      BMP.Canvas.Pen.Color := clMaroon;                          //Color del borde de las antenas.
      BMP.Canvas.Pen.Width := 1;                                 //Ancho del borde de las antenas.
      Triangulo[0] := Vector(p1, ri, m + j);                     //Calcula el v�rtice #1 del ti�ngulo.
      Triangulo[1] := Vector(p1, re, m + CAnchoDeAntenas + j);   //El v�rtice #2 del ti�ngulo.
      Triangulo[2] := Vector(p1, re, m - CAnchoDeAntenas + j);   //Y el v�rtice #3.
      BMP.Canvas.Polygon(Triangulo);                             //Dibuja el tri�ngulo para representar la antena.
      //Dibuja los ejes de referencia de las antenas.
      if FMostrarEjesDelSistemaDeAntenas then                    //Si se deben dibujar los ejes del sistema de antenas:
         begin
         BMP.Canvas.Pen.Color := clEjesDeAntenas;                //Color del eje de las antenas.
         BMP.Canvas.MoveTo(p1.X, p1.Y);                          //Traza la l�nea de los ejes de las antenas
         BMP.Canvas.LineTo(Triangulo[0].X, Triangulo[0].Y);      //desde el centro hasta las antenas.
         end;
      //Dibuja la amplitud de la se�al de las antenas como l�neas.
      if FMostrarAmplitudPorAntenasComoLineas then               //Si se debe representar la se�al de cada antenas:
         begin
         BMP.Canvas.Pen.Width := 3;
         BMP.Canvas.Pen.Color := clAmplitudPorAntenas;           //Color del eje de las antenas.
         p2 := Vector(p1,                                        //Calcula el vector que representa la amplitu.
                      Round(ri * FAntena[a]),                    //Este es el m�dulo (amplitud).
                      m + j                                      //Este es el �ngulo del vector.
                      );
         BMP.Canvas.MoveTo(p1.X, p1.Y);                          //Traza la l�nea que representa la amplitud
         BMP.Canvas.LineTo(p2.X, p2.Y);                          //de la se�al recibida por la antena.
         end;
      //Dibuja la amplitud de la se�al de las antenas como l�bulos.
      if FMostrarAmplitudPorAntenasComoLobulos then              //Si se debe representar la se�al de cada antenas:
         begin
         BMP.Canvas.Pen.Width := 1;                              //El ancho es de un pixel.
         BMP.Canvas.Pen.Color := clAmplitudPorAntenas;           //Color de la amplitud de se�al de las antenas.
         BMP.Canvas.Brush.Style := bsClear;                      //No se rellena.
         f := Round(ri * FAntena[a] / 2);                        //Calcula el radio del l�bulo.
         p2 := Vector(p1, f, m + j);                             //Calcula el centro del l�bulo.
         BMP.Canvas.Ellipse(p2.X - f, p2.Y - f,                  //Dibuja el l�bulo con el tama�o
                            p2.X + f, p2.Y + f);                 //calculado por la amplitud.
         end;
      m := m + i;                                                //Incrementa para dibujar la antena siguiente.
      Inc(a);                                                    //Incrementa para trabajar con la otra antena.
      end;

//Dibuja las etiquetas de los puntos cardinales de la Rosa N�utica.
if FMostrarPuntosCardinales then                                 //Si se dibuja la segmentaci�n completa:
   begin
   BMP.Canvas.Pen.Width := 1;                                    //Ancho de las l�neas.
   BMP.Canvas.Brush.Style := bsSolid;                            //Para borrar los gr�ficos que est�n debajo de la etiqueta
   BMP.Canvas.Brush.Color := clFondo;                            //se emplea el color del fondo de la pantalla circular.
   BMP.Canvas.Font.Pitch := fpFixed;                             //Todos los caracteres tendr�n el mismo ancho.
   BMP.Canvas.Font.Style := [];                                  //y sus atributos ser�n normales.
   BMP.Canvas.Font.Color := clEtiquetaRosaNautica;               //Color de las etiquetas.
   BMP.Canvas.Font.Size := -CAlturaDeFuente;
   for n := 0 to 3 do                                            //Realiza todo el arreglo de etiquetas.
         begin
         p2 := Vector(p1, ri - CAlturaDeFuente, Etiqueta[0][n]); //Calcula la posici�n del texto del punto cardinal.
         BMP.Canvas.TextOut(p2.X - (CAlturaDeFuente div 3),      //Modifica la posici�n XY para que el texto
                            p2.Y - (CAlturaDeFuente div 2) - 2,  //quede centrado en la posici�n calculada.
                            Chr(Etiqueta[1][n])                  //Nombre del punto cardinal.
                            );
         end;
   end;

//Dibuja la l�nea de marcaci�n, su mediana y su variaci�n
//as� como sus huellas en la pantalla.
if FHistorialMarcacionesGuardado > 0 then                        //Si existen marcaciones:
   begin
   //Dibuja las huellas como agujas.
   t := Round(FHuellas * (FHistorialMarcacionesGuardado - 1));   //Calcula la cantidad de huellas.
   for n := t - 1 downto 1 do                                    //Recorre la cola de historial tomando la cantidad de huellas indicadas.
       with FHistorialMarcaciones[n], BMP.Canvas do
            begin                                                //Calcula por interpolaci�n el color de la l�nea de marcaci�n.
            Interpolacion := 1 - n / t;                          //Calcula el valor de interpolaci�n.
            Pen.Color := InterpolarColores(Interpolacion,        //Valor de interpolaci�n.
                                           clFondo,              //Color inicial de la interpolaci�n.
                                           clHuellas             //Color final de la interpolaci�n.
                                           );
            DibujarAguja(Pen.Color, CAnchoMarcacion,             //Dibuja las huellas como agujas.
                         Angulo, Modulo);
            end;
   //Esta parte dibuja la marcaci�n, su mediana y variaci�n.
   with FHistorialMarcaciones[0], BMP.Canvas do
        begin
        //Dibuja la media y la variaci�n solo cuando la marcaci�n
        //sobrepasa las pruebas de nivel y rango.
        if Importante(FModuloMedia, FAnguloMedia) then
           begin                                                        //suficientemente grande:
           //Dibuja la mediana como una aguja.
           if FMostrarMedia and (FModuloMedia > 0.01) then              //Si el m�dulo de la mediana no es
              DibujarAguja(clMediana,                                   //lo suficientemente grande, entonces
                           CAnchoMarcacion,                             //se entiende que la mediana no debe
                           FAnguloMedia,                                //ser representana debido a su poca
                           1);                                          //confiabilidad.
           //Dibuja la variaci�n.
           if (FMostrarVariacion) and                                   //Si se debe dibujar la variaci�n y
              (FHistorialMarcacionesAUtilizar > 5) and                  //existen al menos 6 muestras de historial
              (FAnguloVariacion > 0) then                               //y la variaci�n es mayor que cero:
              begin
              Pen.Color := clVariacion;                                 //Color para la variaci�n.
              Pen.Width := 1;                                           //Ancho de la l�nea de variaci�n.
              p2 := Vector(p1, ri, FAnguloMedia + FAnguloVariacion);    //Calcula el final de la linea de variaci�n.
              BMP.Canvas.MoveTo(round(p1.x), round(p1.y));              //Parte desde el centro.
              BMP.Canvas.LineTo(round(p2.x), round(p2.y));              //Traza el radio hasta el final de la marca.
              p2 := Vector(p1, ri, FAnguloMedia - FAnguloVariacion);    //Calcula el final de la linea de variaci�n.
              BMP.Canvas.MoveTo(round(p1.x), round(p1.y));              //Parte desde el centro.
              BMP.Canvas.LineTo(round(p2.x), round(p2.y));              //Traza el radio hasta el final de la marca.
              end;
           end;
        //Dibuja la marcaci�n como una aguja.
        if FMostrarMarcacion then
           DibujarAguja(clMarcacion,                             //Color de la aguja.
                        CAnchoMarcacion,                         //Ancho inicial de la aguja.
                        Angulo,                                  //�ngulo de la aguja.
                        Modulo                                   //Longitud de la aguja.
                        );
        end;
   end;

//Dibuja el umbral de amplitud y rango angular.
if FMostrarUmbral then
   begin
   BMP.Canvas.Pen.Width := 1;                                       //Ancho de la l�nea.
   BMP.Canvas.Pen.Style := psSolid;                                 //Estilo de la l�nea.
   BMP.Canvas.Brush.Style := bsClear;                               //Sin relleno el c�rculo.
   BMP.Canvas.Pen.Color := clRed;                                   //Color de las marcas de la Rosa N�utica.
   ru := Round(ri * FUmbralDeNivel);
   pf1 := Vector(p1, 100, FUmbralDeAnguloCentro + FUmbralDeAnguloAmplitud);
   pf2 := Vector(p1, 100, FUmbralDeAnguloCentro - FUmbralDeAnguloAmplitud);
   BMP.Canvas.Arc(p1.x -ru, p1.y -ru, p1.x +ru, p1.y +ru,
                  pf1.X, pf1.Y, pf2.X, pf2.Y);      
   end;

end;

//-----------------------------------------------------------------------------
// Copia el gr�fico del Mapa de Bits al canvas (parte visual) del componente.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.Paint;
begin
if csDesigning in ComponentState then GraficarDatos;             //Crea el dibujo de la pantalla.
SetStretchBltMode(Canvas.Handle, COLORONCOLOR);                  //M�todo de dibujado.
Canvas.StretchDraw(ClientRect, BMP);                             //Muestra el dibujo del gr�fico.
if Assigned(FOnDibujoTerminado) then FOnDibujoTerminado(Self);   //Informa que han llegado nuevos datos.
end;

//-----------------------------------------------------------------------------
// Ajusta las dimensiones del Mapa de Bits interno.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.ReSize;
begin
Invalidate;
end;

//-----------------------------------------------------------------------------
// Inicia el goni�metro.
//-----------------------------------------------------------------------------
constructor TPantallaRadiogoniometroAmplitud.Create(AOwner:TComponent);
var n: Integer;
begin
inherited;
FGrabando := False;
Activado := False;
Reproduciendo := False;

//Inicia el estado visual.
FMostrarEjesDeRosaNautica := True;
FMostrarMarcasDeRosaNautica := True;
FMostrarEjesDelSistemaDeAntenas := True;
FMostrarAmplitudPorAntenasComoLineas := False;
FMostrarAmplitudPorAntenasComoLobulos := True;
FMostrarPuntosCardinales := True;
FMostrarMarcacion := True;
FMostrarMedia := True;
FMostrarVariacion := True;
FMostrarNiveles := True;
FMostrarUmbral := True;
CongelarGrafica := False;

//Inicia el historial de las amplitudes de las antenas.
SetLength(FHistoriaAntena1, CMaxHistorialAmplitudes);         //Crea el arreglo donde se guardan las amplitudes anteriores.
SetLength(FHistoriaAntena2, CMaxHistorialAmplitudes);         //Crea el arreglo donde se guardan las amplitudes anteriores.
SetLength(FHistoriaAntena3, CMaxHistorialAmplitudes);         //Crea el arreglo donde se guardan las amplitudes anteriores.
SetLength(FHistoriaAntena4, CMaxHistorialAmplitudes);         //Crea el arreglo donde se guardan las amplitudes anteriores.
For n := 0 to FLongHistorialAmplitudes - 1 do                 //Rellena todos los valores del historial
    begin                                                     //con valores nulos.
    FHistoriaAntena1[n] := 0;
    FHistoriaAntena2[n] := 0;                                 //las amplitudes son cero desde el inicio.
    FHistoriaAntena3[n] := 0;
    FHistoriaAntena4[n] := 0;
    end;
FHistorialDeAntenasGuardado := 0;                             //Al comienzo no hay datos en el historial.
FLongHistorialAmplitudes := CMaxHistorialAmplitudes div 3;    //Cantidad de amplitudes de historial que se guardan.
FUtilizarMediaDeAmplitudes := True;                           //Por defecto se utilizan las medias de las amplitudes de antenas.

//Inicia el historial para las marcaciones.
SetLength(FHistorialMarcaciones, CMaxHistorialMarcaciones);   //Crea el arreglo donde se guardan las l�neas anteriores.
For n := 0 to CMaxHistorialMarcaciones - 1 do                 //Rellena todos los valores del historial
    begin                                                     //con valores no representativos.
    FHistorialMarcaciones[n].Angulo := 0;                     //El �ngulo en cero
    FHistorialMarcaciones[n].Modulo := 0;                     //y la longitud nula.
    end;
FHistorialMarcacionesGuardado := 0;                                //Al comienzo no hay datos en el historial.
FHistorialMarcacionesAUtilizar := CMaxHistorialAmplitudes div 3;   //Cantidad de marcaciones de historial que se guardan.
FHuellas := 0.5;                                                   //Inicia la cantidad de huellas.

//Inicia el ajuste de referencia.
FAjusteDeReferencia := 0;

//Inicia el estado del filtrado.
FUmbralDeNivel := 0.05;
FUmbralDeAnguloCentro := 0;
FUmbralDeAnguloAmplitud := 180;

//Crea e inicia el Mapa de Bits para dibujado.
BMP := TBitmap.Create;                                        //Crea un mapa de bits.
BMP.Width := 100;                                             //Establece el ancho del Mapa de Bits.
BMP.Height := 100;                                            //Establece la altura del Mapa de Bits.

GraficarDatos;                                                //Dibuja la gr�fica en un Mapa de Bits.
Invalidate;                                                   //Copia la imagen a la parte gr�fica del componente.

//Inicia el Temporizador que actualiza el gr�fico.
FActualizacionDelGrafico := 50;
FActualizador := TTimer.Create(Self);
FActualizador.Interval := FActualizacionDelGrafico;
FActualizador.OnTimer := ActualizarGrafico;
FActualizador.Enabled := True;

//Informa sobre los eventos ocurridos:
if Assigned(FOnCambioDeInercia) then FOnCambioDeInercia(Self);
if Assigned(FOnCambioDeHuella) then FOnCambioDeHuella(Self);
if Assigned(FOnAjusteDeReferencia) then FOnAjusteDeReferencia(Self);
end;

//-----------------------------------------------------------------------------
// Reinicia los datos del componente.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.Reiniciar;
var i: Integer;
begin
//Reproduciendo := False;
Activado := True;

//Borra las marcaciones anteriores.
if FHistorialMarcacionesGuardado > 0 then
   for i := 0 to FHistorialMarcacionesGuardado - 1 do
       begin
       FHistorialMarcaciones[i].Angulo := 0;
       FHistorialMarcaciones[i].Modulo := 0;
       end;
FHistorialMarcacionesGuardado := 0;

//Borra las amplitudes anteriores.
if FHistorialDeAntenasGuardado > 0 then
   for i := 0 to FHistorialDeAntenasGuardado - 1 do
       begin
       FHistoriaAntena1[i] := 0;
       FHistoriaAntena2[i] := 0;
       FHistoriaAntena3[i] := 0;
       FHistoriaAntena4[i] := 0;
       end;
FHistorialDeAntenasGuardado := 0;

//Borra las estad�sticas de las amplitudes de las antenas.
FAntena1AmplitudInstantanea := 0;
FAntena2AmplitudInstantanea := 0;
FAntena3AmplitudInstantanea := 0;
FAntena4AmplitudInstantanea := 0;
FAntena1AmplitudMedia := 0;
FAntena2AmplitudMedia := 0;
FAntena3AmplitudMedia := 0;
FAntena4AmplitudMedia := 0;
FAntena1AmplitudVariacion := 0;
FAntena2AmplitudVariacion := 0;
FAntena3AmplitudVariacion := 0;
FAntena4AmplitudVariacion := 0;

//Borra las amplitudes de antena representables. 
FAntena[0] := 0;
FAntena[1] := 0;
FAntena[2] := 0;
FAntena[3] := 0;

//Pide que se actualicen los nuevos datos de marcaciones.
if Assigned(FOnNuevosDatosDeAntenas) then FOnNuevosDatosDeAntenas(Self);
end;

//-----------------------------------------------------------------------------
// Activa el componente.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.Activar;
begin
Activado := True;
Reiniciar;
GraficarDatos;
Invalidate;
end;

//-----------------------------------------------------------------------------
// Desactiva el componente.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.Desactivar;
begin
Activado := False;
Reiniciar;
GraficarDatos;
Invalidate;
end;

//-----------------------------------------------------------------------------
// Actualiza la vista de los datos.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.ActualizarGrafico(Sender: TObject);
begin
if csDesigning in ComponentState then Exit;  //Si est� en fase de dise�o, no hace nada.
GraficarDatos;                               //Dibuja la gr�fica en un Mapa de Bits.
Invalidate;                                  //Copia la imagen al componente gr�fico.
end;

////////////////////////////////////////////////////////////////////////////////
//////////// Establecimiento de propiedades del componente.  ///////////////////
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Establece el tiempo de actualizaci�n del gr�fico de la pantalla.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetActualizacionDelGrafico(valor: Integer);
begin
if valor > 10 then
   begin
   FActualizacionDelGrafico := Abs(valor);
   FActualizador.Interval := FActualizacionDelGrafico;
   end;
end;

//-----------------------------------------------------------------------------
// Establece el porciento de huellas que se dejan en la pantalla.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetPorcientoDeHuellas(valor: Integer);
begin
if (valor >= 0) and (valor <= 100) then                           //Si el valor es de 0 a 100.
   begin
   FHuellas := valor / 100;                                       //Lo convierte al rango 0-1 y lo guarda.
   if Assigned(FOnCambioDeHuella) then FOnCambioDeHuella(Self);   //Informa que se ha cambiado el valor de la huella.
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Obtiene el porciento de huellas que se dejan en la pantalla.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.GetPorcientoDeHuellas: Integer;
begin
Result := Round(FHuellas * 100);
end;

//-----------------------------------------------------------------------------
// Establece el ajuste del sistema de referencia de las antenas con el
// sistema de referencia de la Rosa N�utica. Pueden ser valores positivos
// o negativos seg�n la direcci�n del ajuste.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetAjusteDeReferencia(valor: Integer);
begin
FAjusteDeReferencia := valor;                                          //Cambia el valor del ajuste de la referencia.
if Assigned(FOnAjusteDeReferencia) then FOnAjusteDeReferencia(Self);   //Informa que se ha cambiado el valor del ajuste de referencia.
GraficarDatos;
Invalidate;
end;

//-----------------------------------------------------------------------------
// Establece la longitud del Historial de Marcaciones.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetLongHistorialMarcaciones(valor: Integer);
begin
if valor > 0 then                                                   //Si el valor se encuentra en el rango permitido:
   begin
   if valor <= CMaxHistorialMarcaciones then                        //Si el valor se encuentra en el rango permitido:
      FHistorialMarcacionesAUtilizar := valor                       //Cambia el valor.
   else
      FHistorialMarcacionesAUtilizar := CMaxHistorialMarcaciones;   //Cambia el valor.
   if Assigned(FOnCambioDeInercia) then FOnCambioDeInercia(Self);   //Informa que se ha cambiado el valor de la inercia.
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Establece la longitud del Historial de Amplitudes de Antenas.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetLongHistorialAmplitudes(valor: Integer);
begin
if (valor > 0) and (valor <= CMaxHistorialAmplitudes) then          //Si el valor se encuentra en el rango permitido:
   begin
   FLongHistorialAmplitudes := valor;                               //Cambia el valor.
   if Assigned(FOnCambioDeInercia) then FOnCambioDeInercia(Self);   //Informa que se ha cambiado el valor de la inercia.
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Establece la utilizaci�n de la tendencia central (media) del Historial
// de Amplitudes de Antenas para el c�lculo de la marcaci�n.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetUtilizarMediaDeAmplitudes(valor: Boolean);
begin
FUtilizarMediaDeAmplitudes := valor;
GraficarDatos;
Invalidate;
end;

//-----------------------------------------------------------------------------
// Establece el nivel de disparo del umbral de nivel.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetUmbralDeNivel(valor: Double);
begin
if (valor >= 0) and (valor <= 1) then
   begin
   FUmbralDeNivel := valor;
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Establece el extremo inferior del umbral de �ngulo.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetUmbralDeAnguloCentro(valor: Double);
begin
if (valor >= 0) and (valor <= 360) then                   //Si el valor se encuentra en el rango permitido:
   begin
   FUmbralDeAnguloCentro := valor;                        //Cambia el valor.
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Establece el extremo superior del umbral de �ngulo.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetUmbralDeAnguloAmplitud(valor: Double);
begin
if (valor >= 0) and (valor <= 360) then                   //Si el valor se encuentra en el rango permitido:
   begin
   FUmbralDeAnguloAmplitud := valor;                      //Cambia el valor.
   GraficarDatos;
   Invalidate;
   end;
end;

//-----------------------------------------------------------------------------
// Establece las propiedades de visualizaci�n.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetMostrarVariacion(valor: Boolean);
begin
FMostrarVariacion := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarMedia(valor: Boolean);
begin
FMostrarMedia := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarMarcacion(valor: Boolean);
begin
FMostrarMarcacion := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarPuntosCardinales(valor: Boolean);
begin
FMostrarPuntosCardinales := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarAmplitudPorAntenasComoLobulos(valor: Boolean);
begin
FMostrarAmplitudPorAntenasComoLobulos := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarAmplitudPorAntenasComoLineas(valor: Boolean);
begin
FMostrarAmplitudPorAntenasComoLineas := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarEjesDelSistemaDeAntenas(valor: Boolean);
begin
FMostrarEjesDelSistemaDeAntenas := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarMarcasDeRosaNautica(valor: Boolean);
begin
FMostrarMarcasDeRosaNautica := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarEjesDeRosaNautica(valor: Boolean);
begin
FMostrarEjesDeRosaNautica := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarNiveles(valor: Boolean);
begin
FMostrarNiveles := valor;
GraficarDatos;
Invalidate;
end;

procedure TPantallaRadiogoniometroAmplitud.SetMostrarUmbral(valor: Boolean);
begin
FMostrarUmbral := valor;
GraficarDatos;
Invalidate;
end;


//-----------------------------------------------------------------------------
// Determina si se debe grabar la entrada de antenas en un WAV.
//-----------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.SetGrabarMarcacionesCSV(valor: Boolean);
begin
FGrabarMarcacionesCSV := valor;
end;


////////////////////////////////////////////////////////////////////////////////
///////////////   Obtensi�n de valores de resultado.      //////////////////////
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Obtiene el �ngulo de la marcaci�n instantanea.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.GetAnguloInstantaneo: Double;
begin
Result := MaxDouble;
if FHistorialMarcacionesGuardado > 0 then
   Result := FHistorialMarcaciones[0].Angulo;
end;

//-----------------------------------------------------------------------------
// Obtiene el m�dulo de la marcaci�n instantanea.
// El m�dulo es un valor de 0 a 1 que indica si la marcaci�n es
// confiable o si se debe dudar de esta. Mientras m�s cercano sea
// el valor a 1, significa que la se�al est� fuerte y definida, por
// lo que el algoritmo puede detectar sin problemas la direcci�n.
// Si la se�al es muy baaja, es decir, si la diferencia de se�al
// entre las antenas es muy poca, entonces el valor del m�dulo
// ser� muy peque�o.
//-----------------------------------------------------------------------------
function TPantallaRadiogoniometroAmplitud.GetModuloInstantaneo: Double;
begin
Result := MaxDouble;
if FHistorialMarcacionesGuardado > 0 then
   Result := FHistorialMarcaciones[0].Modulo;
end;

//------------------------------------------------------------------------------
// Permite ver el azimut que existe entre el centro del
// gr�fico y el punto donde se encuentra el mouse.
//------------------------------------------------------------------------------
procedure TPantallaRadiogoniometroAmplitud.MouseMove(Shift: TShiftState; X, Y: Integer);
var pc: TPunto;
    px, py, Azimut, ri, re: Double;
begin
inherited;
if Assigned(FOnMouseMovidoEvent) then                     //Si se ha asignado el evento:
   begin
   px := X - (Width / 2);                                 //Calcula el medio de la pantalla
   py := Y - (Height / 2);                                //para los ejes de coordenadas XY.
   re := (Min(Width, Height) div 2) - 5;                  //Calcula el radio del exterior de la pantalla.
   ri := re - (CAnchoDeAntenas * 2);                      //Calcula el radio interior de la pantalla.
   if (Modulo(px, py) <= ri) then                         //Si el mouse se encuentra dentro de la
      begin                                               //circunferencia de la pantalla:
      Azimut := Fase(px, py) + 90;                        //Calcula el azimut y lo transforma.
      if Azimut > 360 then Azimut := Azimut - 360;        //Corrige la transformaci�n.
      FOnMouseMovidoEvent(Self, Shift, X, Y, Azimut);     //Llama al evento pas�ndole los par�metros calculados.
      end
   else
      FOnMouseMovidoEvent(Self, Shift, -1, -1, Azimut);     
   end;
end;

////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Registra el componente en la paleta del IDE.
//-----------------------------------------------------------------------------
procedure Register;
begin
RegisterComponents('RDF', [TPantallaRadiogoniometroAmplitud]);
end;

end.
