object scrseqedit: Tscrseqedit
  Left = 787
  Top = 466
  Width = 696
  Height = 475
  Caption = 'Scripted Sequence editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Sequence ID'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 33
    Height = 13
    Caption = 'Actors:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 217
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 88
    Width = 225
    Height = 113
    TabOrder = 1
  end
  object Button1: TButton
    Left = 240
    Top = 88
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 2
  end
  object Button2: TButton
    Left = 240
    Top = 120
    Width = 65
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
  end
end
