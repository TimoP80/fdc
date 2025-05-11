object Form13: TForm13
  Left = 1037
  Top = 169
  BorderStyle = bsDialog
  Caption = 'Dialogue transcript'
  ClientHeight = 383
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 481
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Dialogue transcript:'
  end
  object Button1: TButton
    Left = 160
    Top = 344
    Width = 89
    Height = 33
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object JvRichEdit1: TJvRichEdit
    Left = 8
    Top = 40
    Width = 481
    Height = 289
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 272
    Top = 344
    Width = 89
    Height = 33
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button2Click
  end
end
