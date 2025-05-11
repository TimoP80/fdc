object Form1: TForm1
  Left = 441
  Top = 306
  Caption = 'Rename settings'
  ClientHeight = 108
  ClientWidth = 215
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
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 209
    Height = 65
    Caption = 'Rename type'
    ItemIndex = 0
    Items.Strings = (
      'Simple'
      'Complex')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 80
    Width = 89
    Height = 25
    Caption = 'Perform rename'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 120
    Top = 80
    Width = 81
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
