object Form1: TForm1
  Left = 420
  Top = 265
  BorderStyle = bsToolWindow
  Caption = 'Import progress'
  ClientHeight = 64
  ClientWidth = 344
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
  object JvSpecialProgress1: TJvSpecialProgress
    Left = 16
    Top = 24
    Width = 313
    Height = 25
    BorderStyle = bsSingle
    Caption = 'Importing data'
    EndColor = clBlue
    Maximum = 200
    Solid = True
    StartColor = clBlue
    TextCentered = True
    TextOption = toPercent
  end
  object JvStaticText1: TJvStaticText
    Left = 16
    Top = 8
    Width = 139
    Height = 17
    Caption = 'Importing data, please wait...'
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Layout = tlTop
    TabOrder = 0
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
  end
end
