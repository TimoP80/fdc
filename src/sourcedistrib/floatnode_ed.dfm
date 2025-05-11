object Form17: TForm17
  Left = 744
  Top = 137
  BorderStyle = bsDialog
  Caption = 'Float node strings editor'
  ClientHeight = 514
  ClientWidth = 568
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
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 568
    Height = 514
    Align = alClient
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 193
    Height = 13
    AutoSize = False
    Caption = 'Float node name:'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 57
    Height = 13
    Caption = 'Description:'
  end
  object Label3: TLabel
    Left = 8
    Top = 144
    Width = 89
    Height = 13
    Caption = 'Random messages'
  end
  object Label4: TLabel
    Left = 8
    Top = 384
    Width = 151
    Height = 13
    Caption = 'Text for new/selected message'
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 193
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 80
    Width = 545
    Height = 57
    TabOrder = 1
  end
  object ListView1: TListView
    Left = 8
    Top = 160
    Width = 545
    Height = 217
    Columns = <
      item
        Caption = 'Index'
        Width = 60
      end
      item
        AutoSize = True
        Caption = 'Message text'
      end>
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = ListView1Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 400
    Width = 545
    Height = 57
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 464
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 464
    Width = 65
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 400
    Top = 464
    Width = 73
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 480
    Top = 464
    Width = 73
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 80
    Top = 464
    Width = 65
    Height = 25
    Caption = 'Modify'
    Enabled = False
    TabOrder = 8
    OnClick = Button5Click
  end
end
