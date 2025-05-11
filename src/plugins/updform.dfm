object Form1: TForm1
  Left = 369
  Top = 188
  Width = 279
  Height = 272
  Caption = 'Beta updater'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 79
    Height = 13
    Caption = 'Current version:'
  end
  object Label2: TLabel
    Left = 24
    Top = 32
    Width = 85
    Height = 13
    Caption = 'Available version:'
  end
  object Label3: TLabel
    Left = 24
    Top = 72
    Width = 35
    Height = 13
    Caption = 'Status:'
  end
  object curver: TLabel
    Left = 136
    Top = 8
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object availver: TLabel
    Left = 136
    Top = 32
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object status: TLabel
    Left = 64
    Top = 72
    Width = 201
    Height = 41
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 120
    Width = 257
    Height = 65
    Shape = bsFrame
  end
  object JvGradientProgressBar1: TJvGradientProgressBar
    Left = 16
    Top = 160
    Width = 241
    Height = 17
    BarColorFrom = clMenuHighlight
    BarColorTo = clInfoText
    Smooth = True
    ParentColor = True
  end
  object progress: TLabel
    Left = 16
    Top = 128
    Width = 241
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Button1: TButton
    Left = 128
    Top = 192
    Width = 57
    Height = 33
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 152
    Top = 48
  end
end
