object Form1: TForm1
  Left = 270
  Top = 116
  BorderStyle = bsSingle
  Caption = 'Skill check scanner'
  ClientHeight = 411
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 224
    Width = 130
    Height = 13
    Caption = 'Notes for the player option'
  end
  object Label6: TLabel
    Left = 376
    Top = 304
    Width = 225
    Height = 57
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label7: TLabel
    Left = 8
    Top = 152
    Width = 86
    Height = 13
    Caption = 'Player option text'
  end
  object Label2: TLabel
    Left = 8
    Top = 316
    Width = 115
    Height = 13
    Caption = 'Suggested failure node:'
  end
  object Label3: TLabel
    Left = 8
    Top = 340
    Width = 122
    Height = 13
    Caption = 'Suggested success node:'
  end
  object Label4: TLabel
    Left = 8
    Top = 364
    Width = 96
    Height = 13
    Caption = 'Suggested modifier:'
  end
  object Label5: TLabel
    Left = 8
    Top = 388
    Width = 74
    Height = 13
    Caption = 'Suggested skill:'
  end
  object Memo1: TMemo
    Left = 8
    Top = 240
    Width = 601
    Height = 57
    TabOrder = 1
    OnKeyUp = Memo1KeyUp
  end
  object Button1: TButton
    Left = 376
    Top = 376
    Width = 97
    Height = 25
    Caption = 'create skill check'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ListView1: TJvListView
    Left = 8
    Top = 8
    Width = 601
    Height = 137
    BevelWidth = 0
    Columns = <
      item
        Caption = 'Node'
        Width = 120
      end
      item
        Caption = 'Option Index'
        Width = 90
      end
      item
        Caption = 'Notes'
        Width = 387
      end>
    GridLines = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
    ColumnsOrder = '0=120,1=90,2=387'
    ExtendedColumns = <
      item
      end
      item
      end
      item
      end>
  end
  object Memo2: TMemo
    Left = 8
    Top = 168
    Width = 601
    Height = 49
    TabOrder = 3
  end
  object Button2: TButton
    Left = 480
    Top = 376
    Width = 81
    Height = 25
    Caption = 'Generate all'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 136
    Top = 308
    Width = 233
    Height = 21
    TabOrder = 5
  end
  object Edit2: TEdit
    Left = 136
    Top = 332
    Width = 233
    Height = 21
    TabOrder = 6
  end
  object Edit3: TEdit
    Left = 136
    Top = 356
    Width = 65
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object ComboBox1: TComboBox
    Left = 136
    Top = 380
    Width = 233
    Height = 21
    TabOrder = 8
    Items.Strings = (
      'Small Guns'
      'Big Guns'
      'Energy Weapons'
      'Unarmed Combat'
      'Melee'
      'Throwing'
      'First Aid'
      'Doctor'
      'Sneak'
      'Lockpick'
      'Steal'
      'Traps'
      'Science'
      'Repair'
      'Speech'
      'Barter'
      'Gambling'
      'Outdoorsman')
  end
  object UpDown1: TUpDown
    Left = 201
    Top = 356
    Width = 16
    Height = 21
    Associate = Edit3
    Min = -999
    Max = 999
    TabOrder = 9
  end
  object Button3: TButton
    Left = 568
    Top = 376
    Width = 41
    Height = 25
    Caption = 'Close'
    TabOrder = 10
    OnClick = Button3Click
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 120
    Top = 128
    object Editplayeroption1: TMenuItem
      Caption = 'Edit player option'
      Visible = False
      OnClick = Editplayeroption1Click
    end
  end
end
