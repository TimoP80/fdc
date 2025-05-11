object progressform: Tprogressform
  Left = 854
  Top = 481
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Progress'
  ClientHeight = 73
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 425
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = '%caption%'
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 32
    Width = 425
    Height = 25
    TabOrder = 0
  end
end
