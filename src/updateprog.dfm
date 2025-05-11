object Form6: TForm6
  Left = 1330
  Top = 893
  BorderStyle = bsDialog
  Caption = 'Update progress'
  ClientHeight = 115
  ClientWidth = 459
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
    Left = 16
    Top = 16
    Width = 433
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Downloaded %s bytes of %s bytes'
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 433
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'File: %s'
    WordWrap = True
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 40
    Width = 433
    Height = 25
    TabOrder = 0
  end
end
