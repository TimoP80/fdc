object dlg_form: Tdlg_form
  Left = 683
  Top = 164
  BorderStyle = bsSingle
  Caption = 'Fallout Dialogue Creator - Dialogue Converter - []'
  ClientHeight = 531
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label11: TLabel
    Left = 16
    Top = 504
    Width = 59
    Height = 13
    Caption = 'MSG ID step'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 121
    Caption = 'Output filenames'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 36
      Height = 13
      Caption = 'SSL File'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 40
      Height = 13
      Caption = 'MSG File'
    end
    object LMDFileOpenEdit1: TJvFilenameEdit
      Left = 16
      Top = 40
      Width = 361
      Height = 19
      Cursor = crIBeam
      DefaultExt = 'ssl'
      AutoCompleteOptions = []
      AutoCompleteFileOptions = []
      Flat = True
      ParentFlat = False
      Filter = 'SSL Files (*.ssl)|*.ssl'
      DialogOptions = [ofHideReadOnly, ofNoChangeDir]
      AutoSelect = False
      ButtonFlat = True
      Color = clWhite
      ImageIndex = 0
      ButtonWidth = 20
      TabOrder = 0
    end
    object LMDFileOpenEdit2: TJvFilenameEdit
      Left = 16
      Top = 80
      Width = 361
      Height = 19
      Cursor = crIBeam
      DefaultExt = 'msg'
      AutoCompleteOptions = []
      AutoCompleteFileOptions = []
      Flat = True
      ParentFlat = False
      Filter = 'MSG Files (*.msg)|*.msg'
      DialogOptions = [ofHideReadOnly, ofNoChangeDir]
      AutoSelect = False
      ButtonFlat = True
      Color = clWhite
      ImageIndex = 0
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 137
    Width = 393
    Height = 344
    Caption = 'Script Global Data'
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 74
      Height = 13
      Caption = 'Script Template'
    end
    object Label4: TLabel
      Left = 16
      Top = 72
      Width = 47
      Height = 13
      Caption = 'NPCName'
    end
    object Label5: TLabel
      Left = 16
      Top = 104
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object Label6: TLabel
      Left = 24
      Top = 152
      Width = 40
      Height = 13
      Caption = 'Location'
    end
    object Label10: TLabel
      Left = 22
      Top = 176
      Width = 44
      Height = 26
      Alignment = taRightJustify
      Caption = 'Script ID'#13#10'Constant'
    end
    object Edit1: TEdit
      Left = 72
      Top = 65
      Width = 305
      Height = 21
      Hint = 
        'The content of this edit box is '#13#10'retrieved from the global npc ' +
        'properties '#13#10'in the dialogue so you don'#39't need to do '#13#10'anything ' +
        'to this if you have already '#13#10'specified the properties earlier'
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 72
      Top = 152
      Width = 305
      Height = 21
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 72
      Top = 176
      Width = 305
      Height = 21
      AutoSize = False
      TabOrder = 4
    end
    object Edit2: TMemo
      Left = 72
      Top = 96
      Width = 305
      Height = 49
      Hint = 
        'The content of this edit box is '#13#10'retrieved from the global npc ' +
        'properties '#13#10'in the dialogue so you don'#39't need to do '#13#10'anything ' +
        'to this if you have already '#13#10'specified the properties earlier'
      TabOrder = 2
    end
    object LMDFileOpenEdit3: TJvFilenameEdit
      Left = 16
      Top = 32
      Width = 361
      Height = 19
      Cursor = crIBeam
      Hint = 'This specifies the script template to use'
      DefaultExt = 'ssl'
      Flat = True
      ParentFlat = False
      Filter = 'SSL Files (*.ssl)|*.ssl'
      DialogOptions = [ofHideReadOnly, ofNoChangeDir]
      AutoSelect = False
      ButtonFlat = True
      Color = clWhite
      ImageIndex = 0
      TabOrder = 0
    end
    object templateList: TComboBox
      Left = 16
      Top = 32
      Width = 361
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 5
    end
    object write_text: TCheckBox
      Left = 8
      Top = 216
      Width = 321
      Height = 17
      Caption = 'Include MSG text references to the script'
      TabOrder = 6
    end
    object node_names: TCheckBox
      Left = 8
      Top = 264
      Width = 353
      Height = 17
      Caption = 'Insert node names to the beginning of each node procedure'
      TabOrder = 7
    end
    object debug_dump: TCheckBox
      Left = 8
      Top = 288
      Width = 353
      Height = 17
      Caption = 'Show debug dump of local variables on dialogue start'
      TabOrder = 8
    end
    object debug_info: TCheckBox
      Left = 8
      Top = 312
      Width = 377
      Height = 17
      Caption = 'Add debug info for skill checks'
      TabOrder = 9
    end
    object varnotes: TCheckBox
      Left = 8
      Top = 240
      Width = 353
      Height = 17
      Caption = 'Include variable notes to the script'
      TabOrder = 10
    end
  end
  object GroupBox3: TGroupBox
    Left = 407
    Top = 16
    Width = 321
    Height = 369
    Caption = 'Descriptions'
    TabOrder = 2
    object Label7: TLabel
      Left = 8
      Top = 24
      Width = 44
      Height = 13
      Caption = 'Unknown'
    end
    object Label8: TLabel
      Left = 8
      Top = 120
      Width = 32
      Height = 13
      Caption = 'Known'
    end
    object Label9: TLabel
      Left = 8
      Top = 232
      Width = 110
      Height = 13
      Caption = 'Detailed (glance desc.)'
    end
    object Memo1: TMemo
      Left = 8
      Top = 40
      Width = 305
      Height = 73
      Hint = 
        'The content of this memo control is '#13#10'retrieved from the global ' +
        'npc properties '#13#10'in the dialogue so you don'#39't need to do '#13#10'anyth' +
        'ing to this if you have already '#13#10'specified the properties earli' +
        'er'
      TabOrder = 0
    end
    object Memo2: TMemo
      Left = 8
      Top = 136
      Width = 305
      Height = 89
      Hint = 
        'The content of this memo control is '#13#10'retrieved from the global ' +
        'npc properties '#13#10'in the dialogue so you don'#39't need to do '#13#10'anyth' +
        'ing to this if you have already '#13#10'specified the properties earli' +
        'er'
      TabOrder = 1
    end
    object Memo3: TMemo
      Left = 8
      Top = 248
      Width = 305
      Height = 105
      Hint = 
        'The content of this memo control is '#13#10'retrieved from the global ' +
        'npc properties '#13#10'in the dialogue so you don'#39't need to do '#13#10'anyth' +
        'ing to this if you have already '#13#10'specified the properties earli' +
        'er'
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 648
    Top = 488
    Width = 81
    Height = 33
    Caption = 'Convert'
    TabOrder = 3
    OnClick = Button1Click
  end
  object msgstep: TEdit
    Left = 80
    Top = 496
    Width = 49
    Height = 21
    TabOrder = 4
    Text = '30'
    OnKeyUp = msgstepKeyUp
  end
  object UpDown1: TUpDown
    Left = 129
    Top = 496
    Width = 16
    Height = 21
    Associate = msgstep
    Max = 200
    Position = 30
    TabOrder = 5
  end
  object GroupBox4: TGroupBox
    Left = 408
    Top = 392
    Width = 321
    Height = 73
    Caption = 'Direct compile'
    TabOrder = 6
    object CheckBox2: TCheckBox
      Left = 8
      Top = 16
      Width = 209
      Height = 17
      Caption = 'Compile script to the following directory:'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    object JvDirectoryEdit1: TJvDirectoryEdit
      Left = 8
      Top = 38
      Width = 305
      Height = 19
      DialogKind = dkWin32
      AutoCompleteOptions = []
      AutoCompleteFileOptions = []
      Flat = True
      ParentFlat = False
      ButtonFlat = True
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 136
    Top = 64
    object Filr1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'Clear'
        OnClick = New1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object LoadFMFfile1: TMenuItem
        Caption = 'Load FMF file'
        OnClick = LoadFMFfile1Click
      end
      object SaveasSSLMSG1: TMenuItem
        Caption = 'Save as SSL+MSG'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        OnClick = Quit1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'FMF Files (*.fmf)|*.fmf'
    Left = 232
    Top = 56
  end
  object XPManifest1: TXPManifest
    Left = 543
  end
end
