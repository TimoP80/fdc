object Form1: TForm1
  Left = 225
  Top = 131
  Width = 1305
  Height = 675
  Caption = 'Simplified SSL Parser test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 64
    Width = 56
    Height = 13
    Caption = 'Log output:'
  end
  object log_output: TMemo
    Left = 24
    Top = 80
    Width = 817
    Height = 209
    Lines.Strings = (
      'log_output')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 112
    Top = 16
    Width = 97
    Height = 25
    Caption = 'Load file'
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'SSL Scripts (*.ssl)|*.ssl'
    Left = 368
    Top = 32
  end
end
