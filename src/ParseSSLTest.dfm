object Form1: TForm1
  Left = 503
  Top = 126
  Width = 872
  Height = 648
  Caption = 'Simplified SSL Parser test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 64
    Width = 56
    Height = 13
    Caption = 'Log output:'
  end
  object Label2: TLabel
    Left = 24
    Top = 296
    Width = 34
    Height = 13
    Caption = 'Nodes:'
  end
  object log_output: TMemo
    Left = 24
    Top = 80
    Width = 817
    Height = 209
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 97
    Height = 25
    Caption = 'Load script'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 24
    Width = 121
    Height = 25
    Caption = 'Load MSG'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ListView1: TListView
    Left = 24
    Top = 320
    Width = 809
    Height = 241
    Columns = <
      item
        Caption = 'Node name'
        Width = 145
      end
      item
        Caption = 'Text'
        Width = 390
      end
      item
        Caption = 'Player option count'
        Width = 142
      end>
    TabOrder = 3
    ViewStyle = vsReport
  end
  object OpenDialog1: TOpenDialog
    Filter = 'SSL Scripts (*.ssl)|*.ssl'
    Left = 368
    Top = 32
  end
  object OpenDialog2: TOpenDialog
    Filter = 'MSG Files (*.msg)|*.msg'
    Left = 440
    Top = 40
  end
end
