unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, Menus, ComCtrls, MMSystem, Spin,
  UPantallaRadiogoniometroAmplitud, UVisorDeAmplitudPorAntenas,
  URadioProcesador, ToolWin, ActnList, ImgList, Buttons,
  IdBaseComponent, IdComponent, IniFiles, ShellApi;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ActionUtilizacion: TAction;
    ActionProcedencia: TAction;
    ActionMover: TAction;
    ActionAmpliarDinamicamente: TAction;
    ActionExportarImagen: TAction;
    ActionBorrarMarcasYRutas: TAction;
    ActionVerCompleto: TAction;
    ImageList1: TImageList;
    ActionMostrarAzimutInstantaneo: TAction;
    ActionMostrarAzimutMedio: TAction;
    ActionMostrarVariacionDeAzimut: TAction;
    ActionMostrarLobulosDeAmplitudes: TAction;
    ActionMostrarEjesDeAntenas: TAction;
    ActionMostrarMarcasDeReferencia: TAction;
    ActionMostrarEjesDeReferencia: TAction;
    ActionMostrarEtiquetas: TAction;
    ActionMostrarAmplitudes: TAction;
    ActionMostrarAmplitudesMedia: TAction;
    ActionMostrarAmplitudesVariacion: TAction;
    ActionMostrarSaturacion: TAction;
    ActionMostrarFraccionesDeAntena: TAction;
    ActionMostrarVariacionDeLimites: TAction;
    ActionMostrarIntervalosDeAntenas: TAction;
    ActionActivado: TAction;
    ActionGraficosDetenidos: TAction;
    ActionLimpiarPantallaDeSucesos: TAction;
    ActionConfigurarReceptor: TAction;
    ActionInsertarCoordenada: TAction;
    ActionInformacionFormatoDeCoordenadas: TAction;
    ActionInformacionOrientacion: TAction;
    ActionGuardarConfiguracion: TAction;
    ActionDefinirRutaDeGrabaciones: TAction;
    PopupMenuFrecuencias: TPopupMenu;
    Borrarlistadefrecuencias1: TMenuItem;
    Guardarlalistadefrecuencias1: TMenuItem;
    Cargarlalistadefrecuencias1: TMenuItem;
    ActionAmpliarArea: TAction;
    ActionAmpliar: TAction;
    ActionReducir: TAction;
    ActionMoverArriba: TAction;
    ActionMoverAbajo: TAction;
    ActionMoverIzquierda: TAction;
    ActionMoverDerecha: TAction;
    ActionControlDeUsuarios: TAction;
    ActionReproduccionGrabacion: TAction;
    ActionCerrarPrograma: TAction;
    ActionCargarConfiguracion: TAction;
    PopupMenuCoordenadas: TPopupMenu;
    Definircoordenadadelgonimetro1: TMenuItem;
    Formatosdecoordenadasaceptados1: TMenuItem;
    ActionDetenerReproduccion: TAction;
    ActionReporteAutomatico: TAction;
    ActionDefinirExploracion: TAction;
    ActionEscanear: TAction;
    ActionEstablecerFrecuencia: TAction;
    ActionRreproducir: TAction;
    ActionDetener: TAction;
    ActionDefinirControlRemoto: TAction;
    ActionIC8500: TAction;
    ActionAR5000A: TAction;
    Panel6: TPanel;
    GroupBox7: TGroupBox;
    RadioProcesador1: TRadioProcesador;
    Splitter1: TSplitter;
    GroupBox6: TGroupBox;
    GroupBox8: TGroupBox;
    VisorDeAmplitudPorAntenas1: TVisorDeAmplitudPorAntenas;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditA1Amplitud: TEdit;
    EditA1TendenciaCentral: TEdit;
    EditA1Variacion: TEdit;
    GroupBox9: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    VisorDeAmplitudPorAntenas2: TVisorDeAmplitudPorAntenas;
    EditA2Amplitud: TEdit;
    EditA2TendenciaCentral: TEdit;
    EditA2Variacion: TEdit;
    GroupBox10: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    VisorDeAmplitudPorAntenas3: TVisorDeAmplitudPorAntenas;
    EditA3Amplitud: TEdit;
    EditA3TendenciaCentral: TEdit;
    EditA3Variacion: TEdit;
    GroupBox11: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    VisorDeAmplitudPorAntenas4: TVisorDeAmplitudPorAntenas;
    EditA4Amplitud: TEdit;
    EditA4TendenciaCentral: TEdit;
    EditA4Variacion: TEdit;
    GroupBox12: TGroupBox;
    CheckBoxMostrarAmplitudes: TCheckBox;
    CheckBoxMostrarMedioDeAmplitudes: TCheckBox;
    CheckBoxMostrarVariacionDeAmplitudes: TCheckBox;
    CheckBox1: TCheckBox;
    Splitter2: TSplitter;
    Panel7: TPanel;
    PantallaRadiogoniometroAmplitud1: TPantallaRadiogoniometroAmplitud;
    Panel5: TPanel;
    LabelAzimutMedio: TLabel;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    CheckBoxMostrarAzimutinstantaneo: TCheckBox;
    CheckBoxMostrarAzimutMedio: TCheckBox;
    CheckBoxMostrarVariacionDeAzimut: TCheckBox;
    CheckBoxMostrarLobulosDeAmplitud: TCheckBox;
    CheckBoxMostrarEjesDeAntenas: TCheckBox;
    CheckBoxMostrarMarcasDeReferencia: TCheckBox;
    CheckBoxMostrarEjesDeReferencia: TCheckBox;
    CheckBoxMostrarEtiquetasDeReferencia: TCheckBox;
    TrackBarHuellas: TTrackBar;
    GroupBoxAzimutInstantaneo: TGroupBox;
    EditAzimutInstantaneo: TEdit;
    GroupBoxAzimutMedio: TGroupBox;
    EditAzimutMedio: TEdit;
    GroupBoxAzimutVariacion: TGroupBox;
    EditAzimutVariacion: TEdit;
    GroupBoxAmplitudResultante: TGroupBox;
    EditAmplitudResultante: TEdit;
    Panel4: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Panel1: TPanel;
    GroupBoxInerciaDeMarcacion: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SpinEditInerciaDeMarcacion: TSpinEdit;
    SpinEditInerciaDeAmplitudes: TSpinEdit;
    GroupBox13: TGroupBox;
    SpinEditUmbralNivel: TSpinEdit;
    GroupBox3: TGroupBox;
    SpinEditOrientacion: TSpinEdit;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure TrackBarHuellasChange(Sender: TObject);
    procedure SpinEditOrientacionChange(Sender: TObject);
    procedure SpinEditInerciaDeMarcacionChange(Sender: TObject);
    procedure PantallaRadiogoniometroAmplitud1NuevosDatos(Sender: TObject);
    procedure RadioProcesador1Desactivado(Sender: TObject);
    procedure RadioProcesador1Activado(Sender: TObject);
    procedure VisorDeAmplitudPorAntenas1NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
    procedure VisorDeAmplitudPorAntenas2NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
    procedure VisorDeAmplitudPorAntenas3NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
    procedure VisorDeAmplitudPorAntenas4NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
    procedure PantallaRadiogoniometroAmplitud1CalculosTerminados(Sender: TObject; Resultado: TResultadosDelCalculo);
    procedure SpinEditInerciaDeAmplitudesChange(Sender: TObject);
    procedure ActionMostrarAzimutInstantaneoExecute(Sender: TObject);
    procedure ActionMostrarAzimutMedioExecute(Sender: TObject);
    procedure ActionMostrarVariacionDeAzimutExecute(Sender: TObject);
    procedure ActionMostrarLobulosDeAmplitudesExecute(Sender: TObject);
    procedure ActionMostrarEjesDeAntenasExecute(Sender: TObject);
    procedure ActionMostrarMarcasDeReferenciaExecute(Sender: TObject);
    procedure ActionMostrarEjesDeReferenciaExecute(Sender: TObject);
    procedure ActionMostrarEtiquetasExecute(Sender: TObject);
    procedure ActionMostrarAzimutInstantaneoUpdate(Sender: TObject);
    procedure ActionMostrarAzimutMedioUpdate(Sender: TObject);
    procedure ActionMostrarVariacionDeAzimutUpdate(Sender: TObject);
    procedure ActionMostrarLobulosDeAmplitudesUpdate(Sender: TObject);
    procedure ActionMostrarEjesDeAntenasUpdate(Sender: TObject);
    procedure ActionMostrarMarcasDeReferenciaUpdate(Sender: TObject);
    procedure ActionMostrarEjesDeReferenciaUpdate(Sender: TObject);
    procedure ActionMostrarEtiquetasUpdate(Sender: TObject);
    procedure ActionMostrarAmplitudesExecute(Sender: TObject);
    procedure ActionMostrarAmplitudesMediaExecute(Sender: TObject);
    procedure ActionMostrarAmplitudesVariacionExecute(Sender: TObject);
    procedure ActionMostrarAmplitudesUpdate(Sender: TObject);
    procedure ActionMostrarAmplitudesMediaUpdate(Sender: TObject);
    procedure ActionMostrarAmplitudesVariacionUpdate(Sender: TObject);
    procedure ActionMostrarSaturacionUpdate(Sender: TObject);
    procedure ActionMostrarFraccionesDeAntenaUpdate(Sender: TObject);
    procedure ActionMostrarVariacionDeLimitesUpdate(Sender: TObject);
    procedure ActionMostrarIntervalosDeAntenasUpdate(Sender: TObject);
    procedure ActionActivadoExecute(Sender: TObject);
    procedure ActionActivadoUpdate(Sender: TObject);
    procedure ActionGraficosDetenidosExecute(Sender: TObject);
    procedure ActionGraficosDetenidosUpdate(Sender: TObject);
    procedure PantallaRadiogoniometroAmplitud1Marcacion(Sender: TObject; Resultado: TResultadosDelCalculo);
    procedure SpinEditUmbralNivelChange(Sender: TObject);
    procedure CheckBoxMostrarAzimutinstantaneoClick(Sender: TObject);
    procedure CheckBoxMostrarAzimutMedioClick(Sender: TObject);
    procedure CheckBoxMostrarVariacionDeAzimutClick(Sender: TObject);
    procedure CheckBoxMostrarLobulosDeAmplitudClick(Sender: TObject);
    procedure CheckBoxMostrarEjesDeAntenasClick(Sender: TObject);
    procedure CheckBoxMostrarMarcasDeReferenciaClick(Sender: TObject);
    procedure CheckBoxMostrarEjesDeReferenciaClick(Sender: TObject);
    procedure CheckBoxMostrarEtiquetasDeReferenciaClick(Sender: TObject);
    procedure CheckBoxMostrarAmplitudesClick(Sender: TObject);
    procedure CheckBoxMostrarMedioDeAmplitudesClick(Sender: TObject);
    procedure CheckBoxMostrarVariacionDeAmplitudesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionInformacionOrientacionExecute(Sender: TObject);
    procedure RadioProcesador1ProcesamientoTerminado(Sender: TObject; A1, A2, A3, A4: Double; Saturacion: Boolean);
    procedure ActionUtilizacionExecute(Sender: TObject);
    procedure ActionProcedenciaExecute(Sender: TObject);

    procedure ActionCerrarProgramaExecute(Sender: TObject);
    procedure PantallaRadiogoniometroAmplitud1NotMarcacion(Sender: TObject; Resultado: TResultadosDelCalculo);
    procedure SucesosClick(Sender: TObject);
  private
    Marcacion: TResultadosDelCalculo;
  public
  end;

var
  Form1: TForm1;

implementation

uses UProcedencia, DateUtils;

{$R *.dfm}

// Inicia el goniómetro.
procedure TForm1.FormCreate(Sender: TObject);
begin
//Activa el graficado rápido duplicando los buffers.
DoubleBuffered := True;
//GroupBox7.DoubleBuffered := True;
//Panel5.DoubleBuffered := True;

//Pantalla de resultados.
CheckBoxMostrarAzimutinstantaneo.Checked := True;
CheckBoxMostrarAzimutMedio.Checked := True;
CheckBoxMostrarVariacionDeAzimut.Checked := True;
CheckBoxMostrarLobulosDeAmplitud.Checked := True;
CheckBoxMostrarEjesDeAntenas.Checked := True;
CheckBoxMostrarMarcasDeReferencia.Checked := True;
CheckBoxMostrarEjesDeReferencia.Checked := True;
CheckBoxMostrarEtiquetasDeReferencia.Checked := True;
TrackBarHuellas.Position := TrackBarHuellas.Max;
TrackBarHuellasChange(Self);

//Pantalla de Amplitudes.
CheckBoxMostrarAmplitudes.Checked := True;
CheckBoxMostrarMedioDeAmplitudes.Checked := True;
CheckBoxMostrarVariacionDeAmplitudes.Checked := True;

RadioProcesador1.IniciarCaptura;
end;

// Realiza las acciones de cierre del programa.
procedure TForm1.FormDestroy(Sender: TObject);
begin
RadioProcesador1.DetenerCaptura;
end;

procedure TForm1.SpinEditOrientacionChange(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.AjusteDeReferencia := SpinEditOrientacion.Value;
end;

procedure TForm1.SpinEditInerciaDeMarcacionChange(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.InerciaMarcaciones := SpinEditInerciaDeMarcacion.Value;
end;

procedure TForm1.SpinEditInerciaDeAmplitudesChange(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.InerciaAmplitudes := SpinEditInerciaDeAmplitudes.Value;
end;

// Le pasa los datos al visualizador de amplitud.
procedure TForm1.PantallaRadiogoniometroAmplitud1NuevosDatos(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     begin
     VisorDeAmplitudPorAntenas1.AgregarDatos(AmplitudAntena1Instantanea, AmplitudAntena1Media, AmplitudAntena1Variacion);
     VisorDeAmplitudPorAntenas2.AgregarDatos(AmplitudAntena2Instantanea, AmplitudAntena2Media, AmplitudAntena2Variacion);
     VisorDeAmplitudPorAntenas3.AgregarDatos(AmplitudAntena3Instantanea, AmplitudAntena3Media, AmplitudAntena3Variacion);
     VisorDeAmplitudPorAntenas4.AgregarDatos(AmplitudAntena4Instantanea, AmplitudAntena4Media, AmplitudAntena4Variacion);
     end;
end;

//Pasa los valores de amplitud al componente que calcula la marcación.
procedure TForm1.RadioProcesador1ProcesamientoTerminado(Sender: TObject; A1, A2, A3, A4: Double; Saturacion: Boolean);
begin
PantallaRadiogoniometroAmplitud1.AgregarAmplitudes(A1, A2, A3, A4);
end;

procedure TForm1.RadioProcesador1Desactivado(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.Desactivar;
end;

procedure TForm1.RadioProcesador1Activado(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.Activar;
end;


////////  Pantalla de Resultados  ///////////

// Muestra los resultados del cálculo de la marcación.
procedure TForm1.PantallaRadiogoniometroAmplitud1CalculosTerminados(
  Sender: TObject; Resultado: TResultadosDelCalculo);
begin
if not PantallaRadiogoniometroAmplitud1.CongelarGrafica then
   begin
   EditAzimutInstantaneo.Text := FloatToStrF(Resultado.MarcacionAnguloInstantaneo, ffFixed, 15, 2) + 'º';
   EditAzimutMedio.Text := FloatToStrF(Resultado.MarcacionAnguloMedia, ffFixed, 15, 2) + 'º';
   EditAzimutVariacion.Text := FloatToStrF(Resultado.MarcacionAnguloVariacion, ffFixed, 15, 2) + 'º';
   EditAzimutVariacion.Enabled := Resultado.MarcacionAnguloVariacion <> 0;
   EditAmplitudResultante.Text := FloatToStrF(Resultado.MarcacionModuloMedia * 100, ffFixed, 15, 2) + '%';
   end;
end;

// Cambia la cantidad de huellas de marcación que se muestran.
procedure TForm1.TrackBarHuellasChange(Sender: TObject);
begin
PantallaRadiogoniometroAmplitud1.PorcientoDeHuellas := TrackBarHuellas.Position;
end;


////////  Pantalla de Amplitudes por Antenas ///////////

// Muestra los datos de la amplitud por antenas.
procedure TForm1.VisorDeAmplitudPorAntenas1NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
begin
if not VisorDeAmplitudPorAntenas1.CongelarGrafica then
   begin
   EditA1Amplitud.Text := FloatToStrF(AmplitudInstantanea * 100, ffFixed, 15, 2) + '%';
   EditA1TendenciaCentral.Text := FloatToStrF(AmplitudMedia * 100, ffFixed, 15, 2) + '%';
   EditA1Variacion.Text := FloatToStrF(AmplitudVariacion * 100, ffFixed, 15, 2) + '%';
   EditA1Variacion.Enabled := AmplitudVariacion <> 0;
   end;
end;

procedure TForm1.VisorDeAmplitudPorAntenas2NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
begin
if not VisorDeAmplitudPorAntenas1.CongelarGrafica then
   begin
   EditA2Amplitud.Text := FloatToStrF(AmplitudInstantanea * 100, ffFixed, 15, 2) + '%';
   EditA2TendenciaCentral.Text := FloatToStrF(AmplitudMedia * 100, ffFixed, 15, 2) + '%';
   EditA2Variacion.Text := FloatToStrF(AmplitudVariacion * 100, ffFixed, 15, 2) + '%';
   EditA2Variacion.Enabled := AmplitudVariacion <> 0;
   end;
end;

procedure TForm1.VisorDeAmplitudPorAntenas3NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
begin
if not VisorDeAmplitudPorAntenas1.CongelarGrafica then
   begin
   EditA3Amplitud.Text := FloatToStrF(AmplitudInstantanea * 100, ffFixed, 15, 2) + '%';
   EditA3TendenciaCentral.Text := FloatToStrF(AmplitudMedia * 100, ffFixed, 15, 2) + '%';
   EditA3Variacion.Text := FloatToStrF(AmplitudVariacion * 100, ffFixed, 15, 2) + '%';
   EditA3Variacion.Enabled := AmplitudVariacion <> 0;
   end;
end;

procedure TForm1.VisorDeAmplitudPorAntenas4NuevosDatos(Sender: TObject; AmplitudInstantanea, AmplitudMedia, AmplitudVariacion: Double);
begin
if not VisorDeAmplitudPorAntenas1.CongelarGrafica then
   begin
   EditA4Amplitud.Text := FloatToStrF(AmplitudInstantanea * 100, ffFixed, 15, 2) + '%';
   EditA4TendenciaCentral.Text := FloatToStrF(AmplitudMedia * 100, ffFixed, 15, 2) + '%';
   EditA4Variacion.Text := FloatToStrF(AmplitudVariacion * 100, ffFixed, 15, 2) + '%';
   EditA4Variacion.Enabled := AmplitudVariacion <> 0;
   end;
end;


////////// Muestra u oculta algunas características visuales de los gráficos. //////////////

//Para la pantalla de resultados del raiogoniómetro.
procedure TForm1.ActionMostrarAzimutInstantaneoExecute(Sender: TObject);
begin
with CheckBoxMostrarAzimutinstantaneo do Checked := not Checked;
end;

procedure TForm1.ActionMostrarAzimutMedioExecute(Sender: TObject);
begin
with CheckBoxMostrarAzimutMedio do Checked := not Checked;
end;

procedure TForm1.ActionMostrarVariacionDeAzimutExecute(Sender: TObject);
begin
with CheckBoxMostrarVariacionDeAzimut do Checked := not Checked;
end;

procedure TForm1.ActionMostrarLobulosDeAmplitudesExecute(Sender: TObject);
begin
with CheckBoxMostrarLobulosDeAmplitud do Checked := not Checked;
end;

procedure TForm1.ActionMostrarEjesDeAntenasExecute(Sender: TObject);
begin
with CheckBoxMostrarEjesDeAntenas do Checked := not Checked;
end;

procedure TForm1.ActionMostrarMarcasDeReferenciaExecute(Sender: TObject);
begin
with CheckBoxMostrarMarcasDeReferencia do Checked := not Checked;
end;

procedure TForm1.ActionMostrarEjesDeReferenciaExecute(Sender: TObject);
begin
with CheckBoxMostrarEjesDeReferencia do Checked := not Checked;
end;

procedure TForm1.ActionMostrarEtiquetasExecute(Sender: TObject);
begin
with CheckBoxMostrarEtiquetasDeReferencia do Checked := not Checked;
end;

//Para el visor de amplitudes de antenas.
procedure TForm1.ActionMostrarAmplitudesExecute(Sender: TObject);
begin
with CheckBoxMostrarAmplitudes do Checked := not Checked;
end;

procedure TForm1.ActionMostrarAmplitudesMediaExecute(Sender: TObject);
begin
with CheckBoxMostrarMedioDeAmplitudes do Checked := not Checked;
end;

procedure TForm1.ActionMostrarAmplitudesVariacionExecute(Sender: TObject);
begin
with CheckBoxMostrarVariacionDeAmplitudes do Checked := not Checked;
end;


////////// Actualiza el estado visual de los controles de mostrar u ocultar.////////

//Para la pantalla de resultados del raiogoniómetro.
procedure TForm1.ActionMostrarAzimutInstantaneoUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarAzimutInstantaneo.Checked := MostrarMarcacion;
end;

procedure TForm1.ActionMostrarAzimutMedioUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarAzimutMedio.Checked := MostrarMedia;
end;

procedure TForm1.ActionMostrarVariacionDeAzimutUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarVariacionDeAzimut.Checked := MostrarVariacion;
end;

procedure TForm1.ActionMostrarLobulosDeAmplitudesUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarLobulosDeAmplitudes.Checked := MostrarAmplitudPorAntenasComoLobulos;
end;

procedure TForm1.ActionMostrarEjesDeAntenasUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarEjesDeAntenas.Checked := MostrarEjesDelSistemaDeAntenas;
end;

procedure TForm1.ActionMostrarMarcasDeReferenciaUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarMarcasDeReferencia.Checked := MostrarMarcasDeRosaNautica;
end;

procedure TForm1.ActionMostrarEjesDeReferenciaUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarEjesDeReferencia.Checked := MostrarEjesDeRosaNautica;
end;

procedure TForm1.ActionMostrarEtiquetasUpdate(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do ActionMostrarEtiquetas.Checked := MostrarPuntosCardinales;
end;

//Para el visor de amplitudes de antenas.
procedure TForm1.ActionMostrarAmplitudesUpdate(Sender: TObject);
begin
with VisorDeAmplitudPorAntenas1 do ActionMostrarAmplitudes.Checked := MostrarAmplitud;
end;

procedure TForm1.ActionMostrarAmplitudesMediaUpdate(Sender: TObject);
begin
with VisorDeAmplitudPorAntenas1 do ActionMostrarAmplitudesMedia.Checked := MostrarMedia;
end;

procedure TForm1.ActionMostrarAmplitudesVariacionUpdate(Sender: TObject);
begin
with VisorDeAmplitudPorAntenas1 do ActionMostrarAmplitudesVariacion.Checked := MostrarVariacion;
end;

//Para el radioprocesador.
procedure TForm1.ActionMostrarSaturacionUpdate(Sender: TObject);
begin
with RadioProcesador1 do ActionMostrarSaturacion.Checked := MostrarSaturacion;
end;

procedure TForm1.ActionMostrarFraccionesDeAntenaUpdate(Sender: TObject);
begin
with RadioProcesador1 do ActionMostrarFraccionesDeAntena.Checked := MostrarFraccionesDeTiempoDeAntena;
end;

procedure TForm1.ActionMostrarVariacionDeLimitesUpdate(Sender: TObject);
begin
with RadioProcesador1 do ActionMostrarVariacionDeLimites.Checked := MostrarVariacion;
end;

procedure TForm1.ActionMostrarIntervalosDeAntenasUpdate(Sender: TObject);
begin
with RadioProcesador1 do ActionMostrarIntervalosDeAntenas.Checked := MostrarIntervalosDeAntena;
end;

// Inicia o detiene la captura de audio por la tarjeta de sonido.
procedure TForm1.ActionActivadoExecute(Sender: TObject);
begin
if RadioProcesador1.Capturando then
   RadioProcesador1.DetenerCaptura
else
   RadioProcesador1.IniciarCaptura;
end;

procedure TForm1.ActionActivadoUpdate(Sender: TObject);
begin
ActionActivado.Checked := RadioProcesador1.Capturando;
end;

// Detiene o reinicia la representación gráfica.
procedure TForm1.ActionGraficosDetenidosExecute(Sender: TObject);
begin
with RadioProcesador1 do CongelarGrafica := not CongelarGrafica;
with PantallaRadiogoniometroAmplitud1 do CongelarGrafica := not CongelarGrafica;
with VisorDeAmplitudPorAntenas1 do CongelarGrafica := not CongelarGrafica;
with VisorDeAmplitudPorAntenas2 do CongelarGrafica := not CongelarGrafica;
with VisorDeAmplitudPorAntenas3 do CongelarGrafica := not CongelarGrafica;
with VisorDeAmplitudPorAntenas4 do CongelarGrafica := not CongelarGrafica;
end;

procedure TForm1.ActionGraficosDetenidosUpdate(Sender: TObject);
begin
ActionGraficosDetenidos.Checked := RadioProcesador1.CongelarGrafica;
end;

// Modifica el nivel del umbral de nivel y rango.
procedure TForm1.SpinEditUmbralNivelChange(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     UmbralDeNivel := SpinEditUmbralNivel.Value / SpinEditUmbralNivel.MaxValue;
end;

// Informa sobre la relevancia de las marcaciones.
procedure TForm1.PantallaRadiogoniometroAmplitud1Marcacion(Sender: TObject; Resultado: TResultadosDelCalculo);
begin
//Muestra el medio de la marcación en una etiqueta grande de color amarillo.
LabelAzimutMedio.Caption := FloatToStrF(Resultado.MarcacionAnguloMedia, ffFixed, 15, 1) + 'º';
LabelAzimutMedio.Font.Color := clBlack;
LabelAzimutMedio.Color := clYellow;

//Guarda el resultado de las marcaciones.
Marcacion := Resultado;
end;

// Informa sobre la irelevancia de las marcaciones.
procedure TForm1.PantallaRadiogoniometroAmplitud1NotMarcacion(Sender: TObject; Resultado: TResultadosDelCalculo);
begin
//Muestra el medio de la marcación en una etiqueta grande de color griz.
LabelAzimutMedio.Caption := FloatToStrF(Resultado.MarcacionAnguloMedia, ffFixed, 15, 1) + 'º';
LabelAzimutMedio.Font.Color := clGray;
LabelAzimutMedio.Color := clBtnFace;

//Guarda el resultado de las marcaciones.
Marcacion := Resultado;
end;

// Modifica la visualización de las gráficas por medio de los CheckBoxs.
procedure TForm1.CheckBoxMostrarAzimutinstantaneoClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarMarcacion := CheckBoxMostrarAzimutinstantaneo.Checked;
end;

procedure TForm1.CheckBoxMostrarAzimutMedioClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarMedia := CheckBoxMostrarAzimutMedio.Checked;
end;

procedure TForm1.CheckBoxMostrarVariacionDeAzimutClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarVariacion := CheckBoxMostrarVariacionDeAzimut.Checked;
end;

procedure TForm1.CheckBoxMostrarLobulosDeAmplitudClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarAmplitudPorAntenasComoLobulos := CheckBoxMostrarLobulosDeAmplitud.Checked;
end;

procedure TForm1.CheckBoxMostrarEjesDeAntenasClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarEjesDelSistemaDeAntenas := CheckBoxMostrarEjesDeAntenas.Checked;
end;

procedure TForm1.CheckBoxMostrarMarcasDeReferenciaClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarMarcasDeRosaNautica := CheckBoxMostrarMarcasDeReferencia.Checked;
end;

procedure TForm1.CheckBoxMostrarEjesDeReferenciaClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarEjesDeRosaNautica := CheckBoxMostrarEjesDeReferencia.Checked;
end;

procedure TForm1.CheckBoxMostrarEtiquetasDeReferenciaClick(Sender: TObject);
begin
with PantallaRadiogoniometroAmplitud1 do
     MostrarPuntosCardinales := CheckBoxMostrarEtiquetasDeReferencia.Checked;
end;

procedure TForm1.CheckBoxMostrarAmplitudesClick(Sender: TObject);
begin
VisorDeAmplitudPorAntenas1.MostrarAmplitud := CheckBoxMostrarAmplitudes.Checked;
VisorDeAmplitudPorAntenas2.MostrarAmplitud := CheckBoxMostrarAmplitudes.Checked;
VisorDeAmplitudPorAntenas3.MostrarAmplitud := CheckBoxMostrarAmplitudes.Checked;
VisorDeAmplitudPorAntenas4.MostrarAmplitud := CheckBoxMostrarAmplitudes.Checked;
end;

procedure TForm1.CheckBoxMostrarMedioDeAmplitudesClick(Sender: TObject);
begin
VisorDeAmplitudPorAntenas1.MostrarMedia := CheckBoxMostrarMedioDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas2.MostrarMedia := CheckBoxMostrarMedioDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas3.MostrarMedia := CheckBoxMostrarMedioDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas4.MostrarMedia := CheckBoxMostrarMedioDeAmplitudes.Checked;
end;

procedure TForm1.CheckBoxMostrarVariacionDeAmplitudesClick(Sender: TObject);
begin
VisorDeAmplitudPorAntenas1.MostrarVariacion := CheckBoxMostrarVariacionDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas2.MostrarVariacion := CheckBoxMostrarVariacionDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas3.MostrarVariacion := CheckBoxMostrarVariacionDeAmplitudes.Checked;
VisorDeAmplitudPorAntenas4.MostrarVariacion := CheckBoxMostrarVariacionDeAmplitudes.Checked;
end;

procedure TForm1.ActionInformacionOrientacionExecute(Sender: TObject);
var msg: String;
begin
msg := 'ORIENTACIÓN DEL SISTEMA DE ANTENAS' + #13#13;
msg := msg + 'Se utiliza para definir la orientación del sistema' + #13;
msg := msg + 'de antenas con respecto al norte geográfico.' + #13;
msg := msg + 'El valor se debe introducir en grados y representa' + #13;
msg := msg + 'el azimut real de la antena #1 del goniómetro con' + #13;
msg := msg + 'respecto al norte geográfico.';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

// Muestra la ayuda sobre la utilización del programa.
procedure TForm1.ActionUtilizacionExecute(Sender: TObject);
var Fich: String;
begin
Fich := ExtractFilePath(Application.ExeName) + '\Ayuda';
if FileExists(Fich + '.html') then ShellExecute(Handle, nil, PChar(Fich + '.html'), '', '', SW_SHOWNORMAL) else
if FileExists(Fich + '.htm') then ShellExecute(Handle, nil, PChar(Fich + '.htm'), '', '', SW_SHOWNORMAL) else
if FileExists(Fich + '.doc') then ShellExecute(Handle, nil, PChar(Fich + '.doc'), '', '', SW_SHOWNORMAL) else
if FileExists(Fich + '.docx') then ShellExecute(Handle, nil, PChar(Fich + '.docx'), '', '', SW_SHOWNORMAL) else
if FileExists(Fich + '.pdf') then ShellExecute(Handle, nil, PChar(Fich + '.pdf'), '', '', SW_SHOWNORMAL) else
MessageBox(Handle, 'No se encuentra el fichero de ayuda.', '', MB_OK);
end;

// Muestra la procedencia del programa.
procedure TForm1.ActionProcedenciaExecute(Sender: TObject);
begin
with TFormProcedencia.Create(Self) do ShowModal;
end;

// Cierra el programa.
procedure TForm1.ActionCerrarProgramaExecute(Sender: TObject);
begin
Close;
end;

// Permite seleccionar una línea del visor de sucesos.
procedure TForm1.SucesosClick(Sender: TObject);
var Linea: Integer;
begin
with (Sender as Tmemo) do
     begin
     Linea:= Perform(EM_LINEFROMCHAR, SelStart, 0);
     SelStart := Perform(EM_LINEINDEX, Linea, 0);
     SelLength:=Length(Lines[Linea]);
     end;
end;


end.

