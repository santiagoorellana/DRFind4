object Form1: TForm1
  Left = 205
  Top = 121
  Width = 853
  Height = 538
  Caption = 'RDFind4'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000EEEEEEEEEEEEEE0000000000000
    00000EEEEEEEEEEEEEE000000000000000000EEEEEEEEEEEEEE0000000000000
    00000EEEEEEEEEEEEEE000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000002222000000000000000000
    00000002220000222000000000000EEEE0000020000000000200000999900EEE
    E0000200000000000020000999900EEEE0002000000000000002000999900EEE
    E0002000000000000002000999900EEEE0002000000000000002000999900EEE
    E0020000000000000000200999900EEEE0020000000990000000200999900EEE
    E0020000000990000000200999900EEEE002000000000B000000200999900EEE
    E0002000000000B00002000999900EEEE00020000000000B0002000999900EEE
    E000200000000000B002000999900EEEE0000200000000000020000999900EEE
    E000002000000000020000099990000000000002220000222000000000000000
    0000000000222200000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000999999999999990000000000000
    0000099999999999999000000000000000000999999999999990000000000000
    000009999999999999900000000000000000000000000000000000000000FF00
    00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFFFC3FFF03E0
    07C003C003C0038001C0030000C0030000C0030000C002000040020000400200
    004002000040030000C0030000C0030000C0038001C003C003C003E007C0FFFC
    3FFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF}
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter2: TSplitter
    Left = 305
    Top = 0
    Width = 8
    Height = 507
    Cursor = crHSplit
    Color = clSilver
    ParentColor = False
  end
  object Panel7: TPanel
    Left = 313
    Top = 0
    Width = 532
    Height = 507
    Align = alClient
    Constraints.MinHeight = 507
    Constraints.MinWidth = 532
    TabOrder = 1
    DesignSize = (
      532
      507)
    object PantallaRadiogoniometroAmplitud1: TPantallaRadiogoniometroAmplitud
      Left = 2
      Top = 2
      Width = 391
      Height = 409
      Anchors = [akLeft, akTop, akRight, akBottom]
      PorcientoDeHuellas = 50
      InerciaAmplitudes = 1
      InerciaMarcaciones = 20
      UtilizarMediaDeAmplitudes = False
      MostrarAmplitudPorAntenasComoLineas = False
      OnNuevosDatos = PantallaRadiogoniometroAmplitud1NuevosDatos
      OnCalculosTerminados = PantallaRadiogoniometroAmplitud1CalculosTerminados
      OnMarcacion = PantallaRadiogoniometroAmplitud1Marcacion
      OnNotMarcacion = PantallaRadiogoniometroAmplitud1NotMarcacion
    end
    object Panel5: TPanel
      Left = 8
      Top = 418
      Width = 386
      Height = 82
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Panel5'
      TabOrder = 0
      DesignSize = (
        386
        82)
      object LabelAzimutMedio: TLabel
        Left = 5
        Top = 5
        Width = 376
        Height = 72
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -64
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
    object GroupBox2: TGroupBox
      Left = 399
      Top = 187
      Width = 127
      Height = 190
      Anchors = [akRight, akBottom]
      Caption = 'Visualizaci'#243'n'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        127
        190)
      object Label15: TLabel
        Left = 6
        Top = 165
        Width = 35
        Height = 14
        Caption = 'Huellas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object CheckBoxMostrarAzimutinstantaneo: TCheckBox
        Left = 5
        Top = 18
        Width = 83
        Height = 17
        Caption = 'Instant'#225'neo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxMostrarAzimutinstantaneoClick
      end
      object CheckBoxMostrarAzimutMedio: TCheckBox
        Left = 5
        Top = 35
        Width = 61
        Height = 17
        Caption = 'Media'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = CheckBoxMostrarAzimutMedioClick
      end
      object CheckBoxMostrarVariacionDeAzimut: TCheckBox
        Left = 5
        Top = 52
        Width = 79
        Height = 17
        Caption = 'Variaci'#243'n'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = CheckBoxMostrarVariacionDeAzimutClick
      end
      object CheckBoxMostrarLobulosDeAmplitud: TCheckBox
        Left = 5
        Top = 70
        Width = 116
        Height = 17
        Caption = 'L'#243'bulos de antena'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = CheckBoxMostrarLobulosDeAmplitudClick
      end
      object CheckBoxMostrarEjesDeAntenas: TCheckBox
        Left = 5
        Top = 88
        Width = 104
        Height = 17
        Caption = 'Ejes de antenas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = CheckBoxMostrarEjesDeAntenasClick
      end
      object CheckBoxMostrarMarcasDeReferencia: TCheckBox
        Left = 5
        Top = 107
        Width = 114
        Height = 17
        Caption = 'Marcas cardinales'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = CheckBoxMostrarMarcasDeReferenciaClick
      end
      object CheckBoxMostrarEjesDeReferencia: TCheckBox
        Left = 5
        Top = 125
        Width = 114
        Height = 17
        Caption = 'Ejes cardinales'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = CheckBoxMostrarEjesDeReferenciaClick
      end
      object CheckBoxMostrarEtiquetasDeReferencia: TCheckBox
        Left = 5
        Top = 144
        Width = 73
        Height = 17
        Caption = 'Etiquetas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = CheckBoxMostrarEtiquetasDeReferenciaClick
      end
      object TrackBarHuellas: TTrackBar
        Left = 43
        Top = 162
        Width = 79
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Max = 63
        Orientation = trHorizontal
        Frequency = 10
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 8
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = TrackBarHuellasChange
      end
      object BitBtn1: TBitBtn
        Left = 96
        Top = 11
        Width = 25
        Height = 25
        Action = ActionProcedencia
        Anchors = [akTop, akRight]
        TabOrder = 9
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF000000
          0000808080008080800080808000808080008080800080808000808080000000
          0000000000000000000080808000C0C0C00000000000FF00FF00FF00FF000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
          0000FFFF00000000000080808000C0C0C00000000000FF00FF00FF00FF000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
          0000FFFF00000000000080808000C0C0C00000000000FF00FF00FF00FF000000
          0000C0C0C000C0C0C00080808000808080008080800080808000C0C0C0000000
          0000FFFF00000000000080808000C0C0C00000000000FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000000000000000000080808000C0C0C0000000
          0000FFFF00000000000080808000C0C0C00000000000FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000FFFF00000000000080808000C0C0C0000000
          0000FFFF00000000000080808000C0C0C00000000000FF00FF00000080000000
          000080808000C0C0C00000000000000000000000000080808000C0C0C0000000
          00000000000000000000C0C0C000808080000000000000008000000080000000
          FF000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C00080808000000000000000FF0000008000FF00FF000000
          80000000FF000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C00080808000000000000000FF0000008000FF00FF00FF00FF00FF00
          FF00000080000000FF000000000080808000C0C0C000C0C0C000C0C0C000C0C0
          C00080808000000000000000FF0000008000FF00FF00FF00FF00FF00FF00FF00
          FF0000008000000080000000FF000000000080808000C0C0C000C0C0C0008080
          8000000000000000FF0000008000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000080000000FF00000080000000FF000000000080808000808080000000
          00000000FF0000008000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000080000000FF0000008000000080000000FF0000000000000000000000
          FF0000008000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000080000000FF0000008000FF00FF00000080000000FF000000FF000000
          8000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000080000000800000008000FF00FF00FF00FF000000800000008000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
    end
    object GroupBoxAzimutInstantaneo: TGroupBox
      Left = 426
      Top = 2
      Width = 100
      Height = 42
      Anchors = [akRight, akBottom]
      Caption = 'Instantaneo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        100
        42)
      object EditAzimutInstantaneo: TEdit
        Left = 4
        Top = 15
        Width = 91
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
    end
    object GroupBoxAzimutMedio: TGroupBox
      Left = 426
      Top = 48
      Width = 100
      Height = 42
      Anchors = [akRight, akBottom]
      Caption = 'Media'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        100
        42)
      object EditAzimutMedio: TEdit
        Left = 4
        Top = 15
        Width = 91
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
    end
    object GroupBoxAzimutVariacion: TGroupBox
      Left = 426
      Top = 94
      Width = 100
      Height = 42
      Anchors = [akRight, akBottom]
      Caption = 'Variaci'#243'n'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        100
        42)
      object EditAzimutVariacion: TEdit
        Left = 4
        Top = 15
        Width = 91
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
    end
    object GroupBoxAmplitudResultante: TGroupBox
      Left = 426
      Top = 141
      Width = 100
      Height = 42
      Anchors = [akRight, akBottom]
      Caption = 'Amplitud '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      DesignSize = (
        100
        42)
      object EditAmplitudResultante: TEdit
        Left = 4
        Top = 15
        Width = 91
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
    end
    object Panel4: TPanel
      Left = 408
      Top = 158
      Width = 14
      Height = 18
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Color = clNavy
      TabOrder = 6
    end
    object Panel3: TPanel
      Left = 408
      Top = 111
      Width = 14
      Height = 18
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 7
    end
    object Panel2: TPanel
      Left = 408
      Top = 65
      Width = 14
      Height = 18
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Color = clYellow
      TabOrder = 8
    end
    object Panel1: TPanel
      Left = 408
      Top = 19
      Width = 14
      Height = 18
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Color = clRed
      TabOrder = 9
    end
    object GroupBoxInerciaDeMarcacion: TGroupBox
      Left = 399
      Top = 380
      Width = 127
      Height = 75
      Anchors = [akRight, akBottom]
      Caption = 'Inercia de:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object Label1: TLabel
        Left = 11
        Top = 22
        Width = 50
        Height = 14
        Caption = 'Marcaci'#243'n'
      end
      object Label2: TLabel
        Left = 19
        Top = 48
        Width = 41
        Height = 14
        Caption = 'Amplitud'
      end
      object SpinEditInerciaDeMarcacion: TSpinEdit
        Left = 65
        Top = 17
        Width = 55
        Height = 23
        MaxValue = 200
        MinValue = 1
        TabOrder = 0
        Value = 1
        OnChange = SpinEditInerciaDeMarcacionChange
      end
      object SpinEditInerciaDeAmplitudes: TSpinEdit
        Left = 65
        Top = 44
        Width = 55
        Height = 23
        MaxValue = 200
        MinValue = 1
        TabOrder = 1
        Value = 1
        OnChange = SpinEditInerciaDeAmplitudesChange
      end
    end
    object GroupBox13: TGroupBox
      Left = 400
      Top = 456
      Width = 55
      Height = 45
      Anchors = [akRight, akBottom]
      Caption = 'Umbral'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      DesignSize = (
        55
        45)
      object SpinEditUmbralNivel: TSpinEdit
        Left = 5
        Top = 16
        Width = 44
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        MaxValue = 100
        MinValue = 1
        TabOrder = 0
        Value = 1
        OnChange = SpinEditUmbralNivelChange
      end
    end
    object GroupBox3: TGroupBox
      Left = 457
      Top = 456
      Width = 69
      Height = 45
      Anchors = [akRight, akBottom]
      Caption = 'Orientaci'#243'n'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      DesignSize = (
        69
        45)
      object SpinEditOrientacion: TSpinEdit
        Left = 4
        Top = 16
        Width = 60
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        MaxValue = 180
        MinValue = -180
        TabOrder = 0
        Value = 0
        OnChange = SpinEditOrientacionChange
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 507
    Align = alLeft
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 135
      Width = 303
      Height = 9
      Cursor = crVSplit
      Align = alBottom
      Color = clSilver
      ParentColor = False
    end
    object GroupBox7: TGroupBox
      Left = 1
      Top = 1
      Width = 303
      Height = 134
      Align = alClient
      Caption = 'Se'#241'al de RF y de Sincron'#237'a'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object RadioProcesador1: TRadioProcesador
        Left = 2
        Top = 18
        Width = 299
        Height = 114
        Align = alClient
        MostrarFraccionesDeTiempoDeAntena = True
        MostrarIntervalosDeAntena = True
        DetectarCrecientes = True
        PorcientoDeAmplitudMinimaDetectable = 0.166661580248421
        EspaciadoAdicional = 0
        OnActivado = RadioProcesador1Activado
        OnDesactivado = RadioProcesador1Desactivado
        OnProcesamientoTerminado = RadioProcesador1ProcesamientoTerminado
      end
    end
    object GroupBox6: TGroupBox
      Left = 1
      Top = 144
      Width = 303
      Height = 362
      Align = alBottom
      Caption = 'Amplitud de se'#241'al en antenas'
      Constraints.MinHeight = 362
      Constraints.MinWidth = 303
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        303
        362)
      object GroupBox8: TGroupBox
        Left = 2
        Top = 20
        Width = 298
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Antena #1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          298
          67)
        object VisorDeAmplitudPorAntenas1: TVisorDeAmplitudPorAntenas
          Left = 7
          Top = 20
          Width = 283
          Height = 15
          Hint = 'Amplitud de la antena #1.'
          Anchors = [akLeft, akTop, akRight]
          ShowHint = True
          OnNuevosDatos = VisorDeAmplitudPorAntenas1NuevosDatos
        end
        object Label3: TLabel
          Left = 9
          Top = 44
          Width = 41
          Height = 14
          Caption = 'Amplitud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 120
          Top = 44
          Width = 20
          Height = 14
          Caption = 'Med'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 210
          Top = 44
          Width = 17
          Height = 14
          Caption = 'Var'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object EditA1Amplitud: TEdit
          Left = 54
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Amplitud instantanea.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
        end
        object EditA1TendenciaCentral: TEdit
          Left = 142
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Tendencia central de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 1
        end
        object EditA1Variacion: TEdit
          Left = 229
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Variaci'#243'n de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
        end
      end
      object GroupBox9: TGroupBox
        Left = 2
        Top = 93
        Width = 298
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Antena #2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          298
          67)
        object Label6: TLabel
          Left = 9
          Top = 44
          Width = 41
          Height = 14
          Caption = 'Amplitud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 120
          Top = 44
          Width = 20
          Height = 14
          Caption = 'Med'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 210
          Top = 44
          Width = 17
          Height = 14
          Caption = 'Var'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object VisorDeAmplitudPorAntenas2: TVisorDeAmplitudPorAntenas
          Left = 7
          Top = 20
          Width = 283
          Height = 15
          Hint = 'Amplitud de la antena #2.'
          Anchors = [akLeft, akTop, akRight]
          ShowHint = True
          OnNuevosDatos = VisorDeAmplitudPorAntenas2NuevosDatos
        end
        object EditA2Amplitud: TEdit
          Left = 54
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Amplitud instantanea.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
        end
        object EditA2TendenciaCentral: TEdit
          Left = 142
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Tendencia central de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 1
        end
        object EditA2Variacion: TEdit
          Left = 229
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Variaci'#243'n de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
        end
      end
      object GroupBox10: TGroupBox
        Left = 2
        Top = 167
        Width = 298
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Antena #3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          298
          67)
        object Label9: TLabel
          Left = 9
          Top = 44
          Width = 41
          Height = 14
          Caption = 'Amplitud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 120
          Top = 44
          Width = 20
          Height = 14
          Caption = 'Med'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 210
          Top = 44
          Width = 17
          Height = 14
          Caption = 'Var'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object VisorDeAmplitudPorAntenas3: TVisorDeAmplitudPorAntenas
          Left = 7
          Top = 20
          Width = 283
          Height = 15
          Hint = 'Amplitud de la antena #3.'
          Anchors = [akLeft, akTop, akRight]
          ShowHint = True
          OnNuevosDatos = VisorDeAmplitudPorAntenas3NuevosDatos
        end
        object EditA3Amplitud: TEdit
          Left = 54
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Amplitud instantanea.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
        end
        object EditA3TendenciaCentral: TEdit
          Left = 142
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Tendencia central de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 1
        end
        object EditA3Variacion: TEdit
          Left = 229
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Variaci'#243'n de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
        end
      end
      object GroupBox11: TGroupBox
        Left = 2
        Top = 239
        Width = 298
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Antena #4'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        DesignSize = (
          298
          67)
        object Label12: TLabel
          Left = 9
          Top = 44
          Width = 41
          Height = 14
          Caption = 'Amplitud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 120
          Top = 44
          Width = 20
          Height = 14
          Caption = 'Med'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 210
          Top = 44
          Width = 17
          Height = 14
          Caption = 'Var'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object VisorDeAmplitudPorAntenas4: TVisorDeAmplitudPorAntenas
          Left = 7
          Top = 20
          Width = 283
          Height = 15
          Hint = 'Amplitud de la antena #4.'
          Anchors = [akLeft, akTop, akRight]
          ShowHint = True
          OnNuevosDatos = VisorDeAmplitudPorAntenas4NuevosDatos
        end
        object EditA4Amplitud: TEdit
          Left = 54
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Amplitud instantanea.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
        end
        object EditA4TendenciaCentral: TEdit
          Left = 142
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Tendencia central de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 1
        end
        object EditA4Variacion: TEdit
          Left = 229
          Top = 40
          Width = 55
          Height = 22
          Hint = 'Variaci'#243'n de la amplitud.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
        end
      end
      object GroupBox12: TGroupBox
        Left = 2
        Top = 311
        Width = 298
        Height = 45
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Visualizaci'#243'n'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object CheckBoxMostrarAmplitudes: TCheckBox
          Left = 6
          Top = 16
          Width = 66
          Height = 25
          Caption = 'Amplitud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CheckBoxMostrarAmplitudesClick
        end
        object CheckBoxMostrarMedioDeAmplitudes: TCheckBox
          Left = 76
          Top = 16
          Width = 52
          Height = 25
          Caption = 'Media'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = CheckBoxMostrarMedioDeAmplitudesClick
        end
        object CheckBoxMostrarVariacionDeAmplitudes: TCheckBox
          Left = 138
          Top = 16
          Width = 70
          Height = 25
          Caption = 'Variaci'#243'n'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = CheckBoxMostrarVariacionDeAmplitudesClick
        end
        object CheckBox1: TCheckBox
          Left = 216
          Top = 17
          Width = 64
          Height = 24
          Action = ActionGraficosDetenidos
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 384
    Top = 144
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 384
    Top = 112
    object ActionUtilizacion: TAction
      Category = 'Ayuda'
      Caption = 'Utilizacion'
      Hint = 'Utilizaci'#243'n'
      ImageIndex = 9
      ShortCut = 112
      OnExecute = ActionUtilizacionExecute
    end
    object ActionProcedencia: TAction
      Category = 'Ayuda'
      Hint = 'Procedencia de la aplicaci'#243'n.'
      ImageIndex = 8
      OnExecute = ActionProcedenciaExecute
    end
    object ActionMover: TAction
      Category = 'Mapa'
      Caption = 'Mover'
      Hint = 'Mover el mapa.'
      ImageIndex = 4
    end
    object ActionAmpliarDinamicamente: TAction
      Category = 'Mapa'
      Caption = 'Ampliar din'#225'micamente'
      Hint = 'Ampliar din'#225'micamente.'
      ImageIndex = 2
    end
    object ActionExportarImagen: TAction
      Category = 'Mapa'
      Caption = 'Exportar imagen'
      Hint = 'Exportar imagen del mapa.'
      ImageIndex = 5
    end
    object ActionBorrarMarcasYRutas: TAction
      Category = 'Mapa'
      Caption = 'Borrar marcas y rutas'
      Hint = 'Borrar marcas y rutas.'
      ImageIndex = 24
    end
    object ActionVerCompleto: TAction
      Category = 'Mapa'
      Caption = 'Ver mapa completo'
      Hint = 'Ver mapa completo.'
      ImageIndex = 3
    end
    object ActionMostrarAzimutInstantaneo: TAction
      Category = 'Visual'
      Caption = 'Azimut instantaneo'
      OnExecute = ActionMostrarAzimutInstantaneoExecute
      OnUpdate = ActionMostrarAzimutInstantaneoUpdate
    end
    object ActionMostrarAzimutMedio: TAction
      Category = 'Visual'
      Caption = 'Azimut medio'
      OnExecute = ActionMostrarAzimutMedioExecute
      OnUpdate = ActionMostrarAzimutMedioUpdate
    end
    object ActionMostrarVariacionDeAzimut: TAction
      Category = 'Visual'
      Caption = 'Variaci'#243'n del azimut'
      OnExecute = ActionMostrarVariacionDeAzimutExecute
      OnUpdate = ActionMostrarVariacionDeAzimutUpdate
    end
    object ActionMostrarLobulosDeAmplitudes: TAction
      Category = 'Visual'
      Caption = 'L'#243'bulos de amplitud'
      OnExecute = ActionMostrarLobulosDeAmplitudesExecute
      OnUpdate = ActionMostrarLobulosDeAmplitudesUpdate
    end
    object ActionMostrarEjesDeAntenas: TAction
      Category = 'Visual'
      Caption = 'Ejes de las antenas'
      OnExecute = ActionMostrarEjesDeAntenasExecute
      OnUpdate = ActionMostrarEjesDeAntenasUpdate
    end
    object ActionMostrarMarcasDeReferencia: TAction
      Category = 'Visual'
      Caption = 'Marcas de referencia'
      OnExecute = ActionMostrarMarcasDeReferenciaExecute
      OnUpdate = ActionMostrarMarcasDeReferenciaUpdate
    end
    object ActionMostrarEjesDeReferencia: TAction
      Category = 'Visual'
      Caption = 'Ejes de referencia'
      OnExecute = ActionMostrarEjesDeReferenciaExecute
      OnUpdate = ActionMostrarEjesDeReferenciaUpdate
    end
    object ActionMostrarEtiquetas: TAction
      Category = 'Visual'
      Caption = 'Etiquetas'
      OnExecute = ActionMostrarEtiquetasExecute
      OnUpdate = ActionMostrarEtiquetasUpdate
    end
    object ActionMostrarAmplitudes: TAction
      Category = 'Visual'
      Caption = 'Mostrar amplitudes'
      OnExecute = ActionMostrarAmplitudesExecute
      OnUpdate = ActionMostrarAmplitudesUpdate
    end
    object ActionMostrarAmplitudesMedia: TAction
      Category = 'Visual'
      Caption = 'Mostrar medio'
      OnExecute = ActionMostrarAmplitudesMediaExecute
      OnUpdate = ActionMostrarAmplitudesMediaUpdate
    end
    object ActionMostrarAmplitudesVariacion: TAction
      Category = 'Visual'
      Caption = 'Mostrar variaci'#243'n'
      OnExecute = ActionMostrarAmplitudesVariacionExecute
      OnUpdate = ActionMostrarAmplitudesVariacionUpdate
    end
    object ActionMostrarSaturacion: TAction
      Category = 'Visual'
      Caption = 'Saturaci'#243'n de la RF'
      OnUpdate = ActionMostrarSaturacionUpdate
    end
    object ActionMostrarFraccionesDeAntena: TAction
      Category = 'Visual'
      Caption = 'Fracciones de tiempo de antenas'
      OnUpdate = ActionMostrarFraccionesDeAntenaUpdate
    end
    object ActionMostrarVariacionDeLimites: TAction
      Category = 'Visual'
      Caption = 'Variaci'#243'n de los l'#237'mites'
      OnUpdate = ActionMostrarVariacionDeLimitesUpdate
    end
    object ActionMostrarIntervalosDeAntenas: TAction
      Category = 'Visual'
      Caption = 'Intervalos de antenas'
      OnUpdate = ActionMostrarIntervalosDeAntenasUpdate
    end
    object ActionActivado: TAction
      Category = 'Inicio'
      Caption = 'Activado'
      Hint = 'Activado'
      OnExecute = ActionActivadoExecute
      OnUpdate = ActionActivadoUpdate
    end
    object ActionGraficosDetenidos: TAction
      Category = 'Visual'
      Caption = 'Gr'#225'ficos detenidos'
      OnExecute = ActionGraficosDetenidosExecute
      OnUpdate = ActionGraficosDetenidosUpdate
    end
    object ActionLimpiarPantallaDeSucesos: TAction
      Category = 'Sucesos'
      Caption = 'Limpiar pantalla de sucesos'
    end
    object ActionConfigurarReceptor: TAction
      Category = 'Inicio'
      Caption = 'Controlar receptor'
      ImageIndex = 17
    end
    object ActionInsertarCoordenada: TAction
      Caption = 'Definir coordenadas del goni'#243'metro'
      ImageIndex = 0
    end
    object ActionInformacionFormatoDeCoordenadas: TAction
      Category = 'Informacion'
      Caption = 'Formatos de coordenadas aceptados'
      Hint = 'Formatos de coordenadas aceptados.'
      ImageIndex = 1
    end
    object ActionInformacionOrientacion: TAction
      Category = 'Informacion'
      ImageIndex = 1
      OnExecute = ActionInformacionOrientacionExecute
    end
    object ActionGuardarConfiguracion: TAction
      Category = 'Configuracion'
      Caption = 'Guardar fichero de configuraci'#243'n'
      Hint = 'Guardar fichero de configuraci'#243'n.'
      ImageIndex = 20
    end
    object ActionDefinirRutaDeGrabaciones: TAction
      Category = 'Configuracion'
      Caption = 'Definir ruta de grabaciones'
      ImageIndex = 19
    end
    object ActionAmpliarArea: TAction
      Category = 'Mapa'
      Caption = 'Ampliar '#225'rea'
      Hint = 'Ampliar '#225'rea'
      ImageIndex = 11
    end
    object ActionAmpliar: TAction
      Category = 'Mapa'
      Caption = 'Ampliar'
      Hint = 'Ampliar'
      ShortCut = 16422
    end
    object ActionReducir: TAction
      Category = 'Mapa'
      Caption = 'Reducir'
      Hint = 'Reducir'
      ShortCut = 16424
    end
    object ActionMoverArriba: TAction
      Category = 'Mapa'
      Caption = 'Mover arriba'
      Hint = 'Mover arriba'
      ShortCut = 38
    end
    object ActionMoverAbajo: TAction
      Category = 'Mapa'
      Caption = 'Mover abajo'
      Hint = 'Mover abajo'
      ShortCut = 40
    end
    object ActionMoverIzquierda: TAction
      Category = 'Mapa'
      Caption = 'Mover izquierda'
      Hint = 'Mover izquierda'
    end
    object ActionMoverDerecha: TAction
      Category = 'Mapa'
      Caption = 'Mover derecha'
      Hint = 'Mover derecha'
    end
    object ActionControlDeUsuarios: TAction
      Category = 'Inicio'
      Caption = 'Control de usuarios'
      Hint = 'Control de usuarios.'
      ImageIndex = 16
    end
    object ActionReproduccionGrabacion: TAction
      Category = 'Inicio'
      Caption = 'Reproducir grabaci'#243'n'
      Hint = 'Reproducir grabaci'#243'n.'
      ImageIndex = 24
    end
    object ActionCerrarPrograma: TAction
      Category = 'Inicio'
      Caption = 'Cerrar programa'
      Hint = 'Cerrar programa.'
      ImageIndex = 6
      OnExecute = ActionCerrarProgramaExecute
    end
    object ActionCargarConfiguracion: TAction
      Category = 'Configuracion'
      Caption = 'Cargar fichero de configuraci'#243'n'
      Hint = 'Cargar fichero de configuraci'#243'n.'
      ImageIndex = 21
    end
    object ActionDetenerReproduccion: TAction
      Category = 'Inicio'
      Caption = 'Detener reproducci'#243'n'
      Hint = 'Detener reproducci'#243'n.'
      ImageIndex = 23
    end
    object ActionReporteAutomatico: TAction
      Category = 'Configuracion'
      Caption = 'Reporte autom'#225'tico por la red'
      Hint = 'Reporte automatico por la red.'
      ImageIndex = 22
    end
    object ActionDefinirExploracion: TAction
      Category = 'Inicio'
      Caption = 'Definir exploraci'#243'n'
      Hint = 'Definir exploraci'#243'n.'
      ImageIndex = 18
    end
    object ActionEscanear: TAction
      Category = 'Inicio'
      Caption = 'Exploraci'#243'n activada'
      Hint = 'Escanear frecuencias de inter'#233's.'
    end
    object ActionEstablecerFrecuencia: TAction
      Hint = 'Establecer frecuencia.'
      ImageIndex = 7
    end
    object ActionRreproducir: TAction
      Category = 'Inicio'
      ImageIndex = 24
    end
    object ActionDetener: TAction
      Category = 'Inicio'
      ImageIndex = 23
    end
    object ActionDefinirControlRemoto: TAction
      Category = 'Configuracion'
      Caption = 'Control remoto por la red'
      Hint = 'Definir control remoto.'
      ImageIndex = 25
    end
    object ActionIC8500: TAction
      Category = 'Configuracion'
      Caption = 'IC-8500'
      Hint = 'IC-8500'
    end
    object ActionAR5000A: TAction
      Category = 'Configuracion'
      Caption = 'AR5000A'
      Hint = 'AR5000A'
    end
  end
  object ImageList1: TImageList
    Left = 384
    Top = 72
    Bitmap = {
      494C01011A001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000008000000080000000
      8000000080000000800000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      8000000080000000800000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000C0C0C0000000000000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000C0C0C000000000000080800000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000000000000000000000808000000000000000
      000000000000FFFFFF0000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000000000FFFFFF00000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000808000008080000080
      800000808000008080000080800000808000008080000080800000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      80000080800000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000000000000080800000808000000000000000
      000000000000FFFFFF0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000000000000080800000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000808000000000000000
      000000000000FFFFFF0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000800000008000000080
      0000008000000080000000800000008000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0C000000000000000
      000000000000FFFFFF0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000008000000000
      0000008000000000000000800000000000000080000000000000008000000000
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000800000008000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000008000000000
      0000008000000000000000800000000000000080000000000000008000000000
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000800000008000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000008000000000
      0000008000000000000000800000000000000080000000000000008000000000
      0000008000000000000000800000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000008000000080000000
      80000000800000008000000080000000800000008000FF000000FF000000FF00
      00000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C00080808000C0C0C00080808000C0C0C00080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000008000000000
      0000008000000000000000800000000000000080000000000000008000000000
      0000008000000000000000800000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000008000FF000000FF000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000C0C0C00000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C000000000000000000000000000008000000000
      0000000000000000000000800000000000000080000000000000008000000000
      00000000000000000000008000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      00000000800000008000FF000000FF000000FF000000FF000000FF000000FF00
      00000080800000808000008080000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000008080
      80008080800000000000C0C0C000000000000000000000000000008000000000
      0000000000000000000000800000000000000080000000000000008000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      8000000080000000800000008000FF000000FF000000FF000000008080000080
      80000080800000808000008080000000000000000000C0C0C00000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C000000000008080
      80008080800000000000C0C0C000000000000000000000000000008000000000
      0000000000000000000000000000000000000080000000000000008000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000008000FF000000FF00000000808000008080000080
      80000080800000808000008080000000000000000000C0C0C00000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C0000000
      000000000000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000008000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000008000FF000000FF000000FF000000008080000080
      80000080800000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000008000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      8000000080000000800000008000FF000000FF000000FF000000008080000080
      80000000000000000000000000000000000000000000C0C0C000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      00000080000000800000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000008000000000000000000000000000000000
      00000000800000008000FF000000FF000000FF000000FF000000008080000080
      80000080800000000000000000000000000000000000C0C0C000008000000080
      0000008000000080000000800000008000000080000000800000008000000080
      00000080000000800000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000000000000800000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000008080000080
      80000080800000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000800000000000000080
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008000000000000000800000000000000080
      0000008000000000000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000000000000080800000000000000000000000000000000000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000000000000080800000000000000000000000000000000000000000000000
      0000000080000000800000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000000000000080800000000000000000000000000000008000000080000000
      8000000080000000800000008000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000008000000000000000
      0000000080000000800000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000000000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000080800000000000000000000000000000008000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000080800000000000000000000000000000008000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000080800000000000000000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000008000000000FFFF0000FFFF0000FF
      FF00800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C0C0C00000000000000000008000000000FFFF0000FFFF0000FF
      FF00800000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000FFFF0000FFFF0000FF
      FF00800000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF00000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008080
      8000808080000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF00000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000808080008080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C00080808000808080008080800080808000C0C0C00000000000FFFF00000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080808000808080000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C00000000000000000000000000080808000C0C0C00000000000FFFF00000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000000000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C00000000000FFFF00000000000080808000C0C0C00000000000FFFF00000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000800000008000000000000000000000008000000080000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      000000000000000000000000000000000000000080000000000080808000C0C0
      C00000000000000000000000000080808000C0C0C00000000000000000000000
      0000C0C0C0008080800000000000000080000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      000000000000000000000000000000000000000080000000FF00000000008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00080808000000000000000FF00000080000000000000000000000000000000
      0000000000000000000000000000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      80000000800000008000000080000000800000000000000080000000FF000000
      000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000000000000000FF0000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      FF000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      00000000FF000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000000
      0000000080000000800000008000000000000000000000008000000080000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      80000000FF000000000080808000C0C0C000C0C0C00080808000000000000000
      FF00000080000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000080000000
      8000000080000000800000000000000000000000000000000000000080000000
      800000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      FF00000080000000FF00000000008080800080808000000000000000FF000000
      8000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000008000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      FF0000008000000080000000FF0000000000000000000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      FF000000800000000000000080000000FF000000FF0000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000080000000
      8000000080000000000000000000000080000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      8000000080000000800000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00C0C0C000C0C0C0008080800080808000000000000000
      0000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000C0C0C0000000000000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000808080000000
      0000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000C0C0C0000000000000808000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0008080
      8000000000000000000000000000000000000000000000808000008080000000
      0000000000000000000000000000000000000000000000808000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000080000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000000000000000000000000000000000000000000000808000008080000080
      800000808000008080000080800000808000008080000080800000000000FF00
      0000FF00000000FF000000FF0000000000000000000000000000000000000000
      8000000080000000800000008000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000008000000080000000800000008000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00808080000000000000000000000000000000000000808000008080000000
      000000000000000000000000000000000000008080000080800000000000FF00
      0000FF00000000FF000000FF0000000000000000000000000000000000000000
      0000000080000000800000008000000080000000000000000000000000000000
      8000000080000000800000000000000000000000000000000000000000000080
      0000008000000080000000800000008000000080000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0080808000000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000808000000000000000
      FF000000FF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000008000000080
      0000008000000080000000800000008000000080000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0080808000000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000808000000000000000
      FF000000FF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000008000000080
      0000008000000000000000800000008000000080000000800000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000008080
      800000000000000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      FF000000FF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      0000000000000000000000000000008000000080000000800000008000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0C0000000000000FF
      000000FF00000000FF000000FF00000000000000000000000000000000000000
      0000000080000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000800000008000000000
      0000000000000000000000000000000000000080000000800000008000000080
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF00000000FF000000FF00000000000000000000000000000080000000
      8000000080000000800000008000000000000000000000008000000080000000
      8000000000000000000000000000000000000080000000800000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00FF000000FF000000FF00000000FF000000FF
      000000FF00000000FF000000FF00000000000000800000008000000080000000
      8000000080000000000000000000000000000000000000000000000080000000
      8000000080000000000000000000000000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000080
      0000008000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000FF000000FF000000FF0000FF000000FF00
      0000FF00000000FFFF0000FFFF00000000000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      0000008000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000FF000000FF000000FF0000FF000000FF00
      0000FF00000000FFFF0000FFFF00000000000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000FF000000FF000000FF0000FF000000FF00
      0000FF00000000FFFF0000FFFF00000000000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000808080008080
      8000000000000000000000000000000000000000000000000000000000008000
      00008000000080800000FFFF0000FFFF0000FFFF000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      80000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080808000808080000000
      0000000000000000000000000000000000000000000000000000800000008080
      0000FFFF0000FFFF0000FFFF0000FFFF00008000000080000000008000000080
      0000008000008000000000000000000000000000800000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      80000000800000008000000080000000800000000000000000000000800000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008080800080808000000000000000
      000000000000000080000000000000000000000000000000000080000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00008000000000800000008000000080
      0000008000008000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      000000008000000000000000000000000000000000000000800000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF000000800000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000000000008080800000000000000000000000
      000000008000000080000000800000000000000000008000000080800000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00008000000000800000008000000080
      0000008000000080000080000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      000000008000000000000000000000000000000000000000800000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF0000008000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      8000000080000000800000008000000080000000000080000000FFFF00008000
      0000FFFF0000FFFF000080000000800000008000000080000000800000008000
      0000800000000080000080000000000000000000800000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      8000000080000000800000008000000080000000800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000800000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000800000000000000000000000000080000000FFFF0000FFFF
      0000FFFF0000800000008000000080000000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00008000000080000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000800000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000800000000000000000000000000080000000FFFF0000FFFF
      0000FFFF000080000000008000000080000080000000FFFF0000800000008000
      0000FFFF00008080000080000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000800000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000800000000000000000000000000080000000FFFF0000FFFF
      0000800000000080000000800000008000000080000080000000FFFF0000FFFF
      0000FFFF00008000000080000000000000000000800000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      8000000080000000800000008000000080000000800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000800000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      000000000000000080000000000000000000000000008000000080800000FFFF
      0000800000000080000000800000008000000080000080000000FFFF0000FFFF
      0000FFFF00008000000080000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      000000008000000000000000000000000000000000000000800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000080000000800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000008000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      000000000000000080000000000000000000000000000000000080000000FFFF
      0000FFFF0000800000000080000000800000008000000080000080000000FFFF
      0000800000008000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      000000008000000000000000000000000000000000000000800000FFFF0000FF
      FF0000FFFF0000FFFF000000800000008000000080000000800000FFFF0000FF
      FF0000FFFF0000FFFF000000800000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000800000008080
      0000800000008000000080000000008000000080000000800000800000008080
      0000800000008000000000000000000000000000800000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      80000000800000008000000080000000800000000000000000000000800000FF
      FF0000FFFF0000FFFF0000FFFF00000080000000800000FFFF0000FFFF0000FF
      FF0000FFFF000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000008000000080000000000000000000000000008000
      0000800000000080000000800000008000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      80000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000800000008000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000008000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFF800000000E0FFFFD700000000
      E07F004F00000000E03F004700000000E01F007F00000000E00F007F00000000
      E007E3EF00000000E00380CF00000000E003808000000000E00780CF00000000
      E00F80EF00000000E01F80FF00000000E03F80FF00000000E07F808F00000000
      E0FFFF9F00000000FFFFFFA000000000001FFFFFFFF1FFFF00010001FFF98001
      000100010075800100010001004F800100010001007F800100010001007F8001
      00010000E3FB80010001000180F9800100010001808080010001000180F98001
      00018C0180FB8001FC01FC0180FF8001FC01FC01808F8001FC01FC0180F58001
      FC03FC03FFF98001FC07FC07FFF1FFFFFFFFFFFF5555FFFF807FFFFF5555001F
      807F00005555000F800F0000D5550007E00F0000DD5D0003F0010000DD5F0001
      E0010000DF5F0000E0010000FF5F001FE0070000FF5F001EE00F0000FF7F0016
      F0070000FF7F8FF5FC070000FF7FFF25FE070000FFFFFEA5FF87FFFFFFFFFFD9
      FFCFFFFFFFFFFFDBFFFFFFFFFFFFFFFBFFFFFFFFFFFFFFFFFC1FFFFF8001FFFF
      F80FFFFF8001F7FFFFC7FFFF8001F300FFE3001F80018100EFF3000F8001B300
      C7F300078001B7FF838040038001BFFF01C120018001BF00CFE350008001BF7E
      CFF72A9F8001FF00C7FF555F800107FFE3FF2011800107FFF01F8FF980010700
      F83FFF758001077EFFFFFF8FFFFF07008001FFFFFFFFFFEF8001FFFFDFFBFFE7
      8001FE3F8FFFFFC38001FE3F87F7FF878001FFFFC7EFF00F8001FE3FE3CFE01F
      8001FE3FF19FC03F0000FE0FF83F801F0000FE07FC7F80008001FFE3F83F801E
      C003FFF1F19F801EC007E3F1C3CFC03EC00FE3F187E7E07EC01FF1E38FFBF0FE
      C43FF807FFFFFDFEC67FFC0FFFFFFC00F83F001FFFFFFFFFF01F001FFFFFFFFF
      E00F001F87FFFFFFC0070000C3FEF9FFC0030000E1F9F0FFC0030000F0E3E07F
      C0030000F80FC07FC0030000FC1FC43FC0030000FC3F8E1FC0070000F01F9F0F
      C01F0000C18F3F8FC01FE00007C77FC7E01FE0000FE7FFE7F03FE0001FF3FFF3
      FCFFE0007FF9FFF9FFFFE000FFFCFFFCFFFFFFFFFFDFFFFFFFFFFFFFFFCFF81F
      EDB7F81FFF87E007EDB7E007FF0FC0030000C003E01BC003EDB78001C0318001
      EDB780018060800100000000003B8001EDB70000003B8001EDB70000003B8001
      00000000003B8001EDB78001807BC003EDB78001C0FBC0030000C003E1E0E007
      EDB7E007FFF1F81FEDB7F81FFFFBFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenuFrecuencias: TPopupMenu
    Left = 188
    Top = 8
    object Borrarlistadefrecuencias1: TMenuItem
      Caption = 'Borrar lista de frecuencias'
    end
    object Guardarlalistadefrecuencias1: TMenuItem
      Caption = 'Guardar la lista de frecuencias'
    end
    object Cargarlalistadefrecuencias1: TMenuItem
      Caption = 'Cargar la lista de frecuencias'
    end
  end
  object PopupMenuCoordenadas: TPopupMenu
    Images = ImageList1
    Left = 220
    Top = 11
    object Definircoordenadadelgonimetro1: TMenuItem
      Action = ActionInsertarCoordenada
    end
    object Formatosdecoordenadasaceptados1: TMenuItem
      Action = ActionInformacionFormatoDeCoordenadas
    end
  end
end
