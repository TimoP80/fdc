object SSLForm: TSSLForm
  Left = 796
  Top = 335
  Width = 507
  Height = 349
  Caption = 'Import procedures'
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
    Left = 32
    Top = 32
    Width = 219
    Height = 13
    Caption = 'List of nodes / procedures found in the script:'
  end
  object CheckListBox1: TCheckListBox
    Left = 32
    Top = 48
    Width = 425
    Height = 209
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 256
    Top = 264
    Width = 105
    Height = 25
    Caption = 'Import'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 368
    Top = 264
    Width = 89
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object opendlgssl: TOpenDialog
    Filter = 'SSL files (*.ssl)|*.ssl'
    Left = 120
    Top = 248
  end
  object opendlgmsg: TOpenDialog
    Filter = 'MSG files (*.msg)|*.msg'
    Left = 160
    Top = 248
  end
end
