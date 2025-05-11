object Form18: TForm18
  Left = 1025
  Top = 414
  BorderStyle = bsDialog
  Caption = 'Timed events editor'
  ClientHeight = 387
  ClientWidth = 682
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 387
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 75
      Height = 13
      Caption = 'Timed event list'
    end
    object Label2: TLabel
      Left = 248
      Top = 328
      Width = 205
      Height = 13
      Caption = 'Timed event to add in the '#39'start'#39' procedure'
    end
    object Button1: TButton
      Left = 592
      Top = 344
      Width = 73
      Height = 25
      Caption = 'OK'
      TabOrder = 5
      OnClick = Button1Click
    end
    object ListView1: TListView
      Left = 8
      Top = 24
      Width = 665
      Height = 297
      Columns = <
        item
          Caption = 'Timed event name'
          Width = 130
        end
        item
          Caption = 'Action count'
          Width = 140
        end
        item
          Caption = 'Random Time'
          Width = 140
        end
        item
          Caption = 'Interval (in seconds)'
          Width = 251
        end>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = ListView1DblClick
    end
    object Button2: TButton
      Left = 8
      Top = 344
      Width = 65
      Height = 25
      Caption = 'Add'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 152
      Top = 344
      Width = 65
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 248
      Top = 344
      Width = 265
      Height = 21
      ItemHeight = 13
      TabOrder = 4
    end
    object Button4: TButton
      Left = 80
      Top = 344
      Width = 65
      Height = 25
      Caption = 'Edit'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
end
