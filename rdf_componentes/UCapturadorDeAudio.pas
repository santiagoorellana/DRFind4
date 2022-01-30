////////////////////////////////////////////////////////////////////////////////
// Modificado por: Santiago A. Orellana Pérez, 15/1/2014
// Propósito: Exporta un componente que se utiliza para procesar
//            y visualizar las señales de radio que recibe por medio de
//            la tarjeta de sonido de la computadora.
// Se utiliza para implementar un Radiogoniómetro por Amplitud de 4 antenas.
// Creado sobre la base del código de Kambiz R. Khojasteh con contacto email
// kambiz@delphiarea.com. Código disponible en http://www.delphiarea.com
// Se mantienen los comentarios originales del autor en ingles.
////////////////////////////////////////////////////////////////////////////////

unit UCapturadorDeAudio;

interface

uses
  Windows, Messages, Classes, mmSystem, UAudioEntradaBasico, UAudioUtiles, UAudioAlmacenamiento;

type

//-----------------------------------------------------------------------------
//Graba el audio capturado por la tarjeta de sonido en un buffer.
//-----------------------------------------------------------------------------
TCapturadorDeAudio = class(TWaveAudioIn)
  private
    fOnData: TWaveAudioDataReadyEvent;
  protected
    procedure DatosListos(const Buffer: Pointer;
                          BufferSize: DWORD;
                          var FreeIt: Boolean
                          ); override;
  public
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property LastError;
    property LastErrorText;
    property Position;          //En milisegundos.
    property DeviceID;
    property Paused;
    property Active;
  published
    property PCMFormat;
    property BufferLength;      //En milisegundos.
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
    property OnFormat;
    property OnData: TWaveAudioDataReadyEvent read fOnData write fOnData;
  end;

implementation

uses SysUtils;

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
procedure TCapturadorDeAudio.DatosListos(const Buffer: Pointer;
                                         BufferSize: DWORD;
                                         var FreeIt: Boolean
                                         );
begin
if Assigned(fOnData) then fOnData(Self, Buffer, BufferSize, FreeIt);
end;

end.
