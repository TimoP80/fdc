object Form28: TForm28
  Left = 1181
  Top = 601
  BorderIcons = []
  BorderStyle = bsSingle
  BorderWidth = 2
  Caption = 'Help window'
  ClientHeight = 344
  ClientWidth = 520
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 481
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Fallout Dialogue Creator Online Help System v1.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 232
    Top = 312
    Width = 97
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TJvRichEdit
    Left = 8
    Top = 32
    Width = 505
    Height = 265
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    SelText = ''
    StreamFormat = sfRichText
    TabOrder = 0
    OnURLClick = Memo1URLClick
  end
end
