object Form12: TForm12
  Left = 1032
  Top = 484
  Width = 708
  Height = 392
  Caption = '[DEV] Function description editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 354
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 74
      Height = 13
      Caption = 'Script functions'
    end
    object Label2: TLabel
      Left = 256
      Top = 8
      Width = 178
      Height = 13
      Caption = 'Description for the selected function:'
    end
    object ListBox1: TListBox
      Left = 8
      Top = 24
      Width = 225
      Height = 273
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object Memo1: TMemo
      Left = 256
      Top = 24
      Width = 417
      Height = 273
      TabOrder = 1
      OnChange = Memo1Change
    end
    object Button1: TButton
      Left = 576
      Top = 304
      Width = 97
      Height = 33
      Caption = 'OK'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
