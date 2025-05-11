object Form19: TForm19
  Left = 1126
  Top = 173
  BorderStyle = bsDialog
  Caption = 'Timed event data editor'
  ClientHeight = 501
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 128
    Width = 148
    Height = 13
    Caption = 'Code for the timed event block'
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 92
    Height = 13
    Caption = 'Timed event name:'
  end
  object Label3: TLabel
    Left = 344
    Top = 16
    Width = 55
    Height = 13
    Caption = 'Enum value'
  end
  object Label4: TLabel
    Left = 344
    Top = 64
    Width = 63
    Height = 13
    Caption = 'Interval type'
  end
  object SynMemo1: TSynMemo
    Left = 8
    Top = 144
    Width = 529
    Height = 305
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    PopupMenu = PopupMenu1
    TabOrder = 0
    Gutter.Color = clMenuBar
    Gutter.DigitCount = 2
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.LeadingZeros = True
    Gutter.LeftOffset = 12
    Gutter.RightOffset = 4
    Gutter.ShowLineNumbers = True
    Highlighter = SynGeneralSyn1
    Options = [eoDragDropEditing, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 249
    Height = 21
    TabOrder = 1
  end
  object UpDown1: TUpDown
    Left = 401
    Top = 32
    Width = 16
    Height = 21
    Associate = Edit2
    Max = 20000
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 344
    Top = 32
    Width = 57
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object ComboBox1: TComboBox
    Left = 344
    Top = 80
    Width = 73
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 4
    Text = 'Static'
    Items.Strings = (
      'Static'
      'Random')
  end
  object GroupBox1: TGroupBox
    Left = 424
    Top = 16
    Width = 113
    Height = 105
    Caption = 'Interval data'
    TabOrder = 5
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 67
      Height = 13
      Caption = 'Minimum time:'
    end
    object Label6: TLabel
      Left = 8
      Top = 56
      Width = 71
      Height = 13
      Caption = 'Maximum time:'
    end
    object Edit3: TEdit
      Left = 8
      Top = 32
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit4: TEdit
      Left = 8
      Top = 72
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object UpDown2: TUpDown
      Left = 81
      Top = 32
      Width = 16
      Height = 21
      Associate = Edit3
      TabOrder = 2
    end
    object UpDown3: TUpDown
      Left = 81
      Top = 72
      Width = 16
      Height = 21
      Associate = Edit4
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 416
    Top = 464
    Width = 57
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 464
    Width = 57
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = Button2Click
  end
  object SynGeneralSyn1: TSynGeneralSyn
    CommentAttri.Foreground = clNavy
    Comments = [csPasStyle, csCStyle, csCPPStyle]
    DetectPreprocessor = False
    IdentifierAttri.Foreground = clBlack
    IdentifierChars = 
      '!"#$%&'#39'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`' +
      'abcdefghijklmnopqrstuvwxyz{|}~'#8364#129#8218#402#8222#8230#8224#8225#710#8240#352#8249#338#141#381#143#144#8216#8217#8220#8221#8226#8211#8212#732#8482#353#8250#339#157#382#376#160 +
      #161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224 +
      #225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255
    KeyWords.Strings = (
      'AND'
      'BEGIN'
      'BWAND'
      'BWOR'
      'CALL'
      'CRITICAL'
      'DO'
      'ELSE'
      'END'
      'EXPORT'
      'FOR'
      'IF'
      'IMPORT'
      'NOT'
      'OR'
      'PROCEDURE'
      'THEN'
      'VARIABLE'
      'WHILE')
    NumberAttri.Foreground = 11498844
    StringAttri.Foreground = 8483403
    StringDelim = sdDoubleQuote
    Left = 216
    Top = 288
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 224
    object Insertcommand1: TMenuItem
      Caption = 'Insert command'
    end
  end
end
