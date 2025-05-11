object Form1: TForm1
  Left = 92
  Top = 0
  Caption = 'Register script'
  ClientHeight = 408
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 71
    Height = 13
    Caption = 'Existing scripts'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 539
    Height = 408
    Align = alClient
    Shape = bsFrame
    ExplicitWidth = 537
    ExplicitHeight = 457
  end
  object JvHTLabel1: TJvHTLabel
    Left = 208
    Top = 16
    Width = 184
    Height = 14
    AutoSize = False
    Caption = 'xxx'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    SuperSubScriptRatio = 0.666666666666666600
    Transparent = False
    Layout = tlCenter
  end
  object ListView1: TListView
    Left = 16
    Top = 32
    Width = 521
    Height = 257
    Columns = <
      item
        Caption = 'Filename'
        Width = 120
      end
      item
        Caption = 'Description'
        Width = 310
      end
      item
        Caption = 'LocalVars'
        Width = 90
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
  end
  object Button1: TButton
    Left = 472
    Top = 424
    Width = 65
    Height = 33
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 296
    Width = 529
    Height = 121
    Caption = 'Script entry info'
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 70
      Height = 13
      Caption = 'Script filename'
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object Label4: TLabel
      Left = 360
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Local vars'
    end
    object Edit2: TEdit
      Left = 8
      Top = 80
      Width = 425
      Height = 21
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 360
      Top = 40
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 417
      Top = 40
      Width = 16
      Height = 21
      Associate = Edit3
      TabOrder = 3
    end
    object Button2: TButton
      Left = 456
      Top = 80
      Width = 57
      Height = 25
      Caption = 'Add new'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Edit1: TJvFilenameEdit
      Left = 8
      Top = 40
      Width = 337
      Height = 21
      OnBeforeDialog = Edit1BeforeDialog
      OnAfterDialog = Edit1AfterDialog
      OnButtonClick = Edit1ButtonClick
      Filter = 'Compiled fallout 2 scripts (*.int)|*.int'
      DialogOptions = [ofHideReadOnly, ofNoChangeDir]
      TabOrder = 0
      Text = ''
      OnChange = Edit1Change
    end
    object Button3: TButton
      Left = 456
      Top = 48
      Width = 57
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 5
      OnClick = Button3Click
    end
  end
end
