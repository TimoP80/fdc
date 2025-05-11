object Form2: TForm2
  Tag = 6
  Left = 404
  Top = 240
  Width = 270
  Height = 239
  Caption = 'Configuration dialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 59
    Height = 13
    Caption = 'Console font'
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 124
    Height = 13
    Caption = 'Console background color'
  end
  object Label3: TLabel
    Left = 16
    Top = 112
    Width = 85
    Height = 13
    Caption = 'Console font color'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 262
    Height = 205
    Align = alClient
    Shape = bsFrame
  end
  object ColorBox1: TColorBox
    Left = 16
    Top = 80
    Width = 233
    Height = 22
    ItemHeight = 16
    TabOrder = 0
  end
  object ColorBox2: TColorBox
    Left = 16
    Top = 128
    Width = 233
    Height = 22
    ItemHeight = 16
    TabOrder = 1
  end
  object Button1: TButton
    Left = 112
    Top = 168
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 168
    Width = 65
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object JvFontComboBox1: TJvFontComboBox
    Left = 16
    Top = 32
    Width = 233
    Height = 22
    DroppedDownWidth = 233
    MaxMRUCount = 0
    FontName = 'MS Sans Serif'
    ItemIndex = 16
    Sorted = False
    TabOrder = 4
  end
end
