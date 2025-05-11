object Form21: TForm21
  Left = 926
  Top = 423
  Width = 708
  Height = 443
  Caption = 'Script variable manager'
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
  object Label1: TLabel
    Left = 448
    Top = 40
    Width = 71
    Height = 13
    Caption = 'Variable name:'
  end
  object Label2: TLabel
    Left = 448
    Top = 112
    Width = 67
    Height = 13
    Caption = 'Variable type:'
  end
  object Label3: TLabel
    Left = 448
    Top = 152
    Width = 90
    Height = 13
    Caption = 'Initialization value:'
  end
  object Label4: TLabel
    Left = 448
    Top = 200
    Width = 64
    Height = 13
    Caption = 'Variable flags'
  end
  object Label5: TLabel
    Left = 448
    Top = 248
    Width = 28
    Height = 13
    Caption = 'Notes'
  end
  object ListView1: TListView
    Left = 8
    Top = 40
    Width = 433
    Height = 321
    Columns = <
      item
        AutoSize = True
        Caption = 'Variable name'
      end
      item
        Caption = 'Variable type'
        Width = 80
      end
      item
        Caption = 'Initialization value'
        Width = 105
      end>
    MultiSelect = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
  end
  object Edit1: TEdit
    Left = 448
    Top = 56
    Width = 233
    Height = 21
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 448
    Top = 128
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'String'
      'Integer'
      'Float')
  end
  object Edit2: TEdit
    Left = 448
    Top = 168
    Width = 137
    Height = 21
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 448
    Top = 88
    Width = 193
    Height = 17
    Caption = 'Has default value'
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object Button1: TButton
    Left = 8
    Top = 368
    Width = 57
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 368
    Width = 65
    Height = 25
    Caption = 'Delete'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 504
    Top = 368
    Width = 57
    Height = 25
    Caption = 'Apply'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 576
    Top = 368
    Width = 49
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 8
  end
  object Button5: TButton
    Left = 632
    Top = 368
    Width = 49
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object ComboBox2: TComboBox
    Left = 448
    Top = 216
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 10
    Text = 'None'
    Items.Strings = (
      'None'
      'Imported variable'
      'Exported variable'
      'Local variable'
      'Global variable')
  end
  object Memo1: TMemo
    Left = 448
    Top = 264
    Width = 233
    Height = 97
    Color = clCream
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 11
  end
  object Button6: TButton
    Left = 288
    Top = 368
    Width = 73
    Height = 25
    Caption = 'Move Up'
    TabOrder = 12
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 368
    Top = 368
    Width = 73
    Height = 25
    Caption = 'Move Down'
    TabOrder = 13
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 216
    Top = 368
    Width = 65
    Height = 25
    Caption = 'Rearrange'
    TabOrder = 14
    OnClick = Button8Click
  end
end
