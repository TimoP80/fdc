object Form1: TForm1
  Left = 377
  Top = 207
  Width = 378
  Height = 172
  Caption = 'Text Exporter configuration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 370
    Height = 138
    Align = alClient
    Shape = bsFrame
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 40
    Width = 337
    Height = 25
    Caption = 'Open exported file in an external application'
    TabOrder = 0
  end
  object JvFilenameEdit1: TJvFilenameEdit
    Left = 16
    Top = 72
    Width = 345
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 16
    Width = 337
    Height = 17
    Caption = 'Export NPC properties'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 232
    Top = 104
    Width = 73
    Height = 25
    Caption = 'Save settings'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 104
    Width = 49
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = Button2Click
  end
end
