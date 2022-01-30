////////////////////////////////////////////////////////////////////////////////
// Modificado por: Santiago A. Orellana Pérez, 15/1/2014
// Se utiliza para implementar un Radiogoniómetro por Amplitud de 4 antenas.
// Creado sobre la base del código de Kambiz R. Khojasteh con contacto email
// kambiz@delphiarea.com. Código disponible en http://www.delphiarea.com
// Se mantienen los comentarios originales del autor en ingles.
////////////////////////////////////////////////////////////////////////////////

unit UAudioAlmacenamiento;

interface

uses
  Windows, Messages, Classes, mmSystem, UAudioUtiles;

type

  // Encapsulates a wave audio as a stream and provides easy access to its
  // informational fields.
  TWave = class(TMemoryStream)
  private
    fDirty: Boolean;
    fValid: Boolean;
    fDataSize: DWORD;
    fDataOffset: DWORD;
    fData: Pointer;
    fWaveFormat: PWaveFormatEx;
    fOnChange: TNotifyEvent;
    function GetValid: Boolean;
    function GetData: Pointer;
    function GetDataSize: DWORD;
    function GetDataOffset: DWORD;
    function GetLength: DWORD;
    function GetBitRate: DWORD;
    function GetPeakLevel: Integer;
    function GetPCMFormat: TPCMFormat;
    function GetWaveFormat: PWaveFormatEx;
    function GetAudioFormat: String;
  protected
    function Realloc(var NewCapacity: Longint): Pointer; override;
    function UpdateDetails: Boolean; virtual;
    function MSecToByte(MSec: DWORD): DWORD;
    procedure DoChange;
    property Dirty: Boolean read fDirty;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Equals(Wave: TWave): Boolean;
    function SameFormat(Wave: TWave): Boolean;
    procedure Crop;
    function Invert: Boolean;
    function ChangeVolume(Percent: Integer): Boolean;
    function ConvertTo(const pTargetWaveFormat: PWaveFormatEx): Boolean;
    function ConvertToPCM(TargetFormat: TPCMFormat): Boolean;
    function Delete(Pos: DWORD; Len: DWORD): Boolean;
    function Insert(Pos: DWORD; Wave: TWave): Boolean;
    function InsertSilence(Pos: DWORD; Len: DWORD): Boolean;
    function Write(const Buffer; Count: Longint): Longint; override;
    property Valid: Boolean read GetValid;
    property Data: Pointer read GetData;
    property DataSize: DWORD read GetDataSize;
    property DataOffset: DWORD read GetDataOffset;
    property PCMFormat: TPCMFormat read GetPCMFormat;
    property WaveFormat: PWaveFormatEx read GetWaveFormat;
    property AudioFormat: String read GetAudioFormat;
    property Length: DWORD read GetLength;              // in milliseconds
    property BitRate: DWORD read GetBitRate;            // in kbps
    property PeakLevel: Integer read GetPeakLevel;      // in percent
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

  // Base class for wave storage classes
  TCustomWaveStorage = class(TComponent)
  protected
    function GetWaveStream(Index: Integer): TStream; virtual; abstract;
  public
    function Equals(Another: TCustomWaveStorage): Boolean; virtual; abstract;
    property WaveStream[Index: Integer]: TStream read GetWaveStream;
  end;

  // Stores one wave audio
  TWaveStorage = class(TCustomWaveStorage)
  private
    fWave: TWave;
    procedure SetWave(Value: TWave);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetWaveStream(Index: Integer): TStream; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Equals(Another: TCustomWaveStorage): Boolean; override;
  published
    property Wave: TWave read fWave write SetWave;
  end;

  // Stores a collection of wave audios

  TWaveItem = class;
  TWaveItems = class;

  TWaveItemClass = class of TWaveItem;

  // TWave Item
  TWaveItem = class(TCollectionItem)
  private
    fName: String;
    fWave: TWave;
    fTag: Integer;
    procedure SetWave(Value: TWave);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDisplayName: String; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Wave: TWave read fWave write SetWave;
    property Name: String read fName write fName;
    property Tag: Integer read fTag write fTag default 0;
  end;

  // TWaveItems
  TWaveItems = class(TCollection)
  private
    fOwner: TPersistent;
    function GetItem(Index: Integer): TWaveItem;
    procedure SetItem(Index: Integer; Value: TWaveItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TWaveItemClass); reintroduce; virtual;
    function Add: TWaveItem;
    function Insert(Index: Integer): TWaveItem;
    property Items[Index: Integer]: TWaveItem read GetItem write SetItem; default;
  end;

  // TWaveCollection
  TWaveCollection = class(TCustomWaveStorage)
  private
    fWaves: TWaveItems;
    procedure SetWaves(const Value: TWaveItems);
  protected
    function GetWaveStream(Index: Integer): TStream; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Equals(Another: TCustomWaveStorage): Boolean; override;
    function ExportWaveNames(const List: TStrings): Integer; virtual;
    function IndexOfName(const AName: String): Integer; virtual;
  published
    property Waves: TWaveItems read fWaves write SetWaves;
  end;

implementation

uses
  SysUtils;

{ TWave }

constructor TWave.Create;
begin
  inherited Create;
  fDirty := False;
  fWaveFormat := nil;
end;

destructor TWave.Destroy;
begin
  if Assigned(fWaveFormat) then
    FreeMem(fWaveFormat);
  inherited Destroy;
end;

function TWave.Realloc(var NewCapacity: Integer): Pointer;
begin
  Result := inherited Realloc(NewCapacity);
  if not Dirty then DoChange;
end;

function TWave.Write(const Buffer; Count: Integer): Longint;
begin
  Result := inherited Write(Buffer, Count);
  if not Dirty then DoChange;
end;

procedure TWave.DoChange;
begin
  fDirty := True;
  if Assigned(fOnChange) then
    fOnChange(Self);
end;

function TWave.MSecToByte(MSec: DWORD): DWORD;
begin
  with fWaveFormat^ do
    Result := MulDiv(nAvgBytesPerSec, MSec, 1000)
          and ($FFFFFFFF shl (nChannels * wBitsPerSample div 16));
end;

function TWave.UpdateDetails: Boolean;
begin
  if fDirty then
  begin
    fValid := False;
    fDirty := False;
    if Assigned(fWaveFormat) then
    begin
      FreeMem(fWaveFormat);
      fWaveFormat := nil;
    end;
    if GetStreamWaveAudioInfo(Self, fWaveFormat, fDataSize, fDataOffset) then
    begin
      fData := Pointer(DWORD(Memory) + fDataOffset);
      fValid := True;
    end;
  end;
  Result := fValid;
end;

function TWave.GetAudioFormat: String;
begin
  if UpdateDetails then
    Result := GetWaveAudioFormat(fWaveFormat)
  else
    Result := '';
end;

function TWave.GetBitRate: DWORD;
begin
  if UpdateDetails then
    Result := GetWaveAudioBitRate(fWaveFormat)
  else
    Result := 0;
end;

function TWave.GetPeakLevel: Integer;
begin
  if PCMFormat <> nonePCM then
    Result := GetWaveAudioPeakLevel(fData, fDataSize, fWaveFormat.wBitsPerSample)
  else
    Result := -1;
end;

function TWave.GetLength: DWORD;
begin
  if UpdateDetails then
    Result := GetWaveAudioLength(fWaveFormat, fDataSize)
  else
    Result := 0;
end;

function TWave.GetData: Pointer;
begin
  if UpdateDetails then
    Result := fData
  else
    Result := nil;
end;

function TWave.GetDataSize: DWORD;
begin
  if UpdateDetails then
    Result := fDataSize
  else
    Result := 0;
end;

function TWave.GetDataOffset: DWORD;
begin
  if UpdateDetails then
    Result := fDataOffset
  else
    Result := 0;
end;

function TWave.GetValid: Boolean;
begin
  Result := UpdateDetails;
end;

function TWave.GetPCMFormat: TPCMFormat;
begin
  if UpdateDetails then
    Result := GetPCMAudioFormat(fWaveFormat)
  else
    Result := nonePCM;
end;

function TWave.GetWaveFormat: PWaveFormatEx;
begin
  if UpdateDetails then
    Result := fWaveFormat
  else
    Result := nil;
end;

function TWave.Equals(Wave: TWave): Boolean;
begin
  if Valid = Wave.Valid then
    if fValid and Wave.fValid then
      Result :=
        (fDataSize = Wave.fDataSize) and
        (fWaveFormat^.cbSize = Wave.fWaveFormat^.cbSize) and
         CompareMem(fWaveFormat, Wave.fWaveFormat,
                    SizeOf(TWaveFormatEx) + fWaveFormat^.cbSize) and
         CompareMem(fData, Wave.fData, fDataSize)
    else
      Result :=
       (Size = Wave.Size) and
        CompareMem(Memory, Wave.Memory, Size)
  else
    Result := False;
end;

function TWave.SameFormat(Wave: TWave): Boolean;
begin
  if Valid and Wave.Valid then
    Result :=
      (fWaveFormat^.cbSize = Wave.fWaveFormat^.cbSize) and
       CompareMem(fWaveFormat, Wave.fWaveFormat,
                  SizeOf(TWaveFormatEx) + fWaveFormat^.cbSize)
  else
    Result := False;
end;

procedure TWave.Crop;
begin
  Size := DataOffset + DataSize;
end;

function TWave.Invert: Boolean;
begin
  Result := False;
  if PCMFormat <> nonePCM then
  begin
    InvertWaveAudio(fData, fDataSize, fWaveFormat.wBitsPerSample);
    Result := True;
  end;
end;

function TWave.ChangeVolume(Percent: Integer): Boolean;
begin
  Result := False;
  if PCMFormat <> nonePCM then
  begin
    ChangeWaveAudioVolume(fData, fDataSize, fWaveFormat.wBitsPerSample, Percent);
    Result := True;
  end;
end;

function TWave.ConvertTo(const pTargetWaveFormat: PWaveFormatEx): Boolean;
var
  NewData: Pointer;
  NewDataSize: DWORD;
  ckInfo, ckData: TMMCKInfo;
  mmIO: HMMIO;
begin
  Result := False;
  if Valid then
  begin
    if (fWaveFormat.cbSize <> pTargetWaveFormat^.cbSize) or
       not CompareMem(fWaveFormat, pTargetWaveFormat, SizeOf(TWaveFormatEx) + fWaveFormat.cbSize) then
    begin
      if ConvertWaveFormat(fWaveFormat, fData, fDataSize, pTargetWaveFormat, NewData, NewDataSize) then
        try
          mmIO := CreateStreamWaveAudio(Self, pTargetWaveFormat, ckInfo, ckData);
          try
            mmioWrite(mmIO, NewData, NewDataSize);
          finally
            CloseWaveAudio(mmio, ckInfo, ckData);
          end;
          Result := True;
        finally
          ReallocMem(NewData, 0);
        end;
    end
    else
      Result := True;
  end;
end;

function TWave.ConvertToPCM(TargetFormat: TPCMFormat): Boolean;
var
  NewWaveFormat: TWaveFormatEx;
begin
  Result := False;
  if TargetFormat <> nonePCM then
  begin
    SetPCMAudioFormatS(@NewWaveFormat, TargetFormat);
    Result := ConvertTo(@NewWaveFormat);
  end;
end;

function TWave.Delete(Pos, Len: DWORD): Boolean;
var
  Index: DWORD;
  NewWave: TWave;
  ckInfo, ckData: TMMCKInfo;
  mmIO: HMMIO;
begin
  Result := False;
  if Valid and (Len > 0) and (Pos < Length) then
  begin
    NewWave := TWave.Create;
    try
      mmIO := CreateStreamWaveAudio(NewWave, fWaveFormat, ckInfo, ckData);
      try
        Index := MSecToByte(Pos);
        if Index > fDataSize then
          Index := fDataSize;
        if Index > 0 then
          mmioWrite(mmIO, fData, Index);
        Inc(Index, MSecToByte(Len));
        if Index < fDataSize then
          mmioWrite(mmIO, Pointer(DWORD(fData) + Index), fDataSize - Index);
      finally
        CloseWaveAudio(mmio, ckInfo, ckData);
      end;
      LoadFromStream(NewWave);
      Result := True;
    finally
      NewWave.Free;
    end;
  end;
end;

function TWave.Insert(Pos: DWORD; Wave: TWave): Boolean;
var
  Index: DWORD;
  NewWave: TWave;
  ckInfo, ckData: TMMCKInfo;
  mmIO: HMMIO;
begin
  Result := False;
  if SameFormat(Wave) then
  begin
    NewWave := TWave.Create;
    try
      mmIO := CreateStreamWaveAudio(NewWave, fWaveFormat, ckInfo, ckData);
      try
        Index := MSecToByte(Pos);
        if Index > fDataSize then
          Index := fDataSize;
        if Index > 0 then
          mmioWrite(mmIO, fData, Index);
        mmioWrite(mmIO, Wave.fData, Wave.fDataSize);
        if Index < fDataSize then
          mmioWrite(mmIO, Pointer(DWORD(fData) + Index), fDataSize - Index);
      finally
        CloseWaveAudio(mmio, ckInfo, ckData);
      end;
      LoadFromStream(NewWave);
      Result := True;
    finally
      NewWave.Free;
    end;
  end;
end;

function TWave.InsertSilence(Pos, Len: DWORD): Boolean;
var
  Index: DWORD;
  SilenceBytes: DWORD;
  Silence: Byte;
  NewWave: TWave;
  ckInfo, ckData: TMMCKInfo;
  mmIO: HMMIO;
begin
  Result := False;
  if (PCMFormat <> nonePCM) and (Len > 0) then
  begin
    NewWave := TWave.Create;
    try
      mmIO := CreateStreamWaveAudio(NewWave, fWaveFormat, ckInfo, ckData);
      try
        Index := MSecToByte(Pos);
        if Index > fDataSize then
          Index := fDataSize;
        if Index > 0 then
          mmioWrite(mmIO, fData, Index);
        if fWaveFormat.wBitsPerSample = 8 then
          Silence := 128
        else
          Silence := 0;
        SilenceBytes := MSecToByte(Len);
        while SilenceBytes > 0 do
        begin
          mmioWrite(mmIO, PChar(@Silence), 1);
          Dec(SilenceBytes);
        end;
        if Index < fDataSize then
          mmioWrite(mmIO, Pointer(DWORD(fData) + Index), fDataSize - Index);
      finally
        CloseWaveAudio(mmio, ckInfo, ckData);
      end;
      LoadFromStream(NewWave);
      Result := True;
    finally
      NewWave.Free;
    end;
  end;
end;

{ TWaveStorage }

constructor TWaveStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fWave := TWave.Create;
end;

destructor TWaveStorage.Destroy;
begin
  fWave.Free;
  inherited Destroy;
end;

procedure TWaveStorage.SetWave(Value: TWave);
begin
  if Wave <> Value then
  begin
    if Assigned(Value) then
      Wave.LoadFromStream(Value)
    else
      Wave.Clear;
  end;
end;

procedure TWaveStorage.ReadData(Stream: TStream);
begin
  Wave.LoadFromStream(Stream);
end;

procedure TWaveStorage.WriteData(Stream: TStream);
begin
  Wave.SaveToStream(Stream);
end;

procedure TWaveStorage.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, Wave.Size > 0);
end;

procedure TWaveStorage.Assign(Source: TPersistent);
begin
  if Source is TWaveStorage then
    Wave := TWaveStorage(Source).Wave
  else if Source is TWaveItem then
    Wave := TWaveItem(Source).Wave
  else
    inherited Assign(Source);
end;

function TWaveStorage.GetWaveStream(Index: Integer): TStream;
begin
  Result := Wave;
end;

function TWaveStorage.Equals(Another: TCustomWaveStorage): Boolean;
begin
  if Another is TWaveStorage then
    Result := Wave.Equals(TWaveStorage(Another).Wave)
  else
    Result := False;
end;

{ TWaveItem }

constructor TWaveItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  fWave := TWave.Create;
end;

destructor TWaveItem.Destroy;
begin
  fWave.Free;
  inherited Destroy;
end;

procedure TWaveItem.SetWave(Value: TWave);
begin
  if Wave <> Value then
  begin
    if Assigned(Value) then
      Wave.LoadFromStream(Value)
    else
      Wave.Clear;
  end;
end;

procedure TWaveItem.ReadData(Stream: TStream);
begin
  Wave.LoadFromStream(Stream);
end;

procedure TWaveItem.WriteData(Stream: TStream);
begin
  Wave.SaveToStream(Stream);
end;

procedure TWaveItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, Wave.Size > 0);
end;

procedure TWaveItem.Assign(Source: TPersistent);
begin
  if Source is TWaveItem then
  begin
    Wave := TWaveItem(Source).Wave;
    Name := TWaveItem(Source).Name;
    Tag := TWaveItem(Source).Tag;
  end
  else if Source is TWaveStorage then
    Wave := TWaveStorage(Source).Wave
  else
    inherited Assign(Source);
end;

function TWaveItem.GetDisplayName: String;
var
  WaveInfo: String;
begin
  if (Wave <> nil) and (Wave.Size <> 0) then
  begin
    if Wave.Valid then
      WaveInfo := Wave.AudioFormat + ', ' +
                  IntToStr(Wave.BitRate) + ' kbps, ' +
                  MS2Str(Wave.Length, msAh) + ' sec.'
    else
      WaveInfo := 'Invalid Content';
  end
  else
    WaveInfo := 'Empty';
  Result := Name + ' (' + WaveInfo + ')';
end;

{ TWaveItems }

constructor TWaveItems.Create(AOwner: TPersistent; ItemClass: TWaveItemClass);
begin
  inherited Create(ItemClass);
  fOwner := AOwner;
end;

function TWaveItems.GetOwner: TPersistent;
begin
  Result := fOwner;
end;

function TWaveItems.Add: TWaveItem;
begin
  Result := TWaveItem(inherited Add);
end;

function TWaveItems.Insert(Index: Integer): TWaveItem;
begin
  Result := TWaveItem(inherited Insert(Index));
end;

function TWaveItems.GetItem(Index: Integer): TWaveItem;
begin
  Result := TWaveItem(inherited Items[Index]);
end;

procedure TWaveItems.SetItem(Index: Integer; Value: TWaveItem);
begin
  inherited Items[Index] := Value;
end;

{ TWaveCollection }

constructor TWaveCollection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fWaves := TWaveItems.Create(Self, TWaveItem);
end;

destructor TWaveCollection.Destroy;
begin
  fWaves.Free;
  inherited Destroy;
end;

procedure TWaveCollection.SetWaves(const Value: TWaveItems);
begin
  if Waves <> Value then
    Waves.Assign(Value);
end;

function TWaveCollection.GetWaveStream(Index: Integer): TStream;
begin
  Result := Waves[Index].Wave;
end;

function TWaveCollection.Equals(Another: TCustomWaveStorage): Boolean;
var
  I: Integer;
begin
  if (Another is TWaveCollection) and
     (Waves.Count = TWaveCollection(Another).Waves.Count) then
  begin
    Result := True;
    for I := 0 to Waves.Count - 1 do
      if not Waves[I].Wave.Equals(TWaveCollection(Another).Waves[I].Wave) then
      begin
        Result := False;
        Break;
      end;
  end
  else
    Result := False;
end;

function TWaveCollection.ExportWaveNames(const List: TStrings): Integer;
var
  Index: Integer;
begin
  for Index := 0 to Waves.Count - 1 do
    List.Add(Waves[Index].Name);
  Result := Waves.Count;
end;

function TWaveCollection.IndexOfName(const AName: String): Integer;
var
  Index: Integer;
begin
  Result := -1;
  for Index := 0 to Waves.Count - 1 do
    if CompareText(Waves[Index].Name, AName) = 0 then
    begin
      Result := Index;
      Break;
    end;
end;

end.
