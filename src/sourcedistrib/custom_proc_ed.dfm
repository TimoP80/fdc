object Form23: TForm23
  Left = 533
  Top = 488
  Width = 758
  Height = 480
  Caption = 'Custom procedure editor'
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
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 742
    Height = 442
    Align = alClient
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 29
    Height = 13
    Caption = 'Code:'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 82
    Height = 13
    Caption = 'Procedure name:'
  end
  object Label3: TLabel
    Left = 496
    Top = 56
    Width = 69
    Height = 13
    Caption = 'Procedure list:'
  end
  object Label4: TLabel
    Left = 232
    Top = 8
    Width = 100
    Height = 13
    Caption = 'Associate with node:'
  end
  object Label5: TLabel
    Left = 8
    Top = 408
    Width = 145
    Height = 13
    Caption = 'Generate code from template:'
  end
  object SynMemo1: TSynMemo
    Left = 8
    Top = 72
    Width = 481
    Height = 321
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
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 209
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 592
    Top = 400
    Width = 65
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 664
    Top = 400
    Width = 65
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object ListBox1: TListBox
    Left = 496
    Top = 72
    Width = 233
    Height = 321
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 4
    OnClick = ListBox1Click
    OnMouseDown = ListBox1MouseDown
  end
  object Button3: TButton
    Left = 600
    Top = 16
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 232
    Top = 24
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    OnClick = ComboBox1Click
  end
  object Delete: TButton
    Left = 672
    Top = 16
    Width = 57
    Height = 25
    Caption = 'Delete'
    TabOrder = 7
    OnClick = DeleteClick
  end
  object ComboBox2: TComboBox
    Left = 160
    Top = 400
    Width = 249
    Height = 21
    ItemHeight = 13
    TabOrder = 8
  end
  object Button4: TButton
    Left = 416
    Top = 400
    Width = 81
    Height = 25
    Hint = 
      'This button will invoke the parameter input dialog'#13#10'which goes t' +
      'hrough the parameters in the'#13#10'code template and inserts the code' +
      ' to the'#13#10'editor when finished.'#13#10
    Caption = 'Generate'
    TabOrder = 9
    OnClick = Button4Click
  end
end
