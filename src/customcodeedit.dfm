object Form25: TForm25
  Left = 518
  Top = 315
  Width = 616
  Height = 430
  Caption = 'Node-specific code editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 585
    Height = 57
    AutoSize = False
    Caption = 
      'This code will be inserted to the beginning of the node procedur' +
      'e. Here you can'#13#10'perform actions such as transferring items, mon' +
      'ey, manipulating variables etc. The'#13#10'code is executed every time' +
      ' the node is reached so if you need a procedure call'#13#10'with a bra' +
      'nching link, create a new custom procedure instead. '
  end
  object Label2: TLabel
    Left = 8
    Top = 344
    Width = 145
    Height = 13
    Caption = 'Generate code from template:'
  end
  object SynMemo1: TSynMemo
    Left = 8
    Top = 72
    Width = 593
    Height = 265
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = Form19.SynGeneralSyn1
    WantTabs = True
  end
  object Button1: TButton
    Left = 464
    Top = 360
    Width = 65
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 536
    Top = 360
    Width = 65
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 360
    Width = 369
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
  object Button3: TButton
    Left = 384
    Top = 360
    Width = 49
    Height = 25
    Caption = 'Create'
    TabOrder = 4
    OnClick = Button3Click
  end
end
