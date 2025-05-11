object Form22: TForm22
  Left = 456
  Top = 400
  Width = 825
  Height = 531
  Caption = 'Dialogue start conditions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 809
    Height = 493
    Align = alClient
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 88
    Height = 13
    Caption = 'Current conditions'
  end
  object ListView1: TListView
    Left = 8
    Top = 24
    Width = 313
    Height = 417
    Columns = <
      item
        Caption = 'Index'
      end
      item
        Caption = '# of Conditions'
        Width = 100
      end
      item
        Caption = 'Targetnode'
        Width = 159
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
  end
  object Button1: TButton
    Left = 656
    Top = 448
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 328
    Top = 160
    Width = 465
    Height = 281
    Caption = 'Conditions'
    TabOrder = 2
    Visible = False
    object Label11: TLabel
      Left = 224
      Top = 224
      Width = 111
      Height = 13
      Caption = 'Linkage (none/and/or):'
    end
    object Label3: TLabel
      Left = 8
      Top = 176
      Width = 69
      Height = 13
      Caption = 'Value to check'
    end
    object Label4: TLabel
      Left = 8
      Top = 136
      Width = 50
      Height = 13
      Caption = 'Evaluation'
    end
    object Label5: TLabel
      Left = 8
      Top = 24
      Width = 74
      Height = 13
      Caption = 'Resulting code:'
    end
    object Label7: TLabel
      Left = 8
      Top = 96
      Width = 39
      Height = 13
      Caption = 'Selector'
      Visible = False
    end
    object Label10: TLabel
      Left = 224
      Top = 48
      Width = 65
      Height = 13
      Caption = 'Condition list:'
    end
    object Label2: TLabel
      Left = 224
      Top = 8
      Width = 164
      Height = 13
      Caption = 'Condition type (for new condition)'
    end
    object ComboBox5: TComboBox
      Left = 224
      Top = 240
      Width = 233
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'None'
      Items.Strings = (
        'None'
        'And'
        'Or')
    end
    object Edit1: TEdit
      Left = 8
      Top = 192
      Width = 209
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object ComboBox2: TComboBox
      Left = 8
      Top = 152
      Width = 209
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnClick = ComboBox2Click
      Items.Strings = (
        'none (check for true)'
        '== (equal)'
        '!= (not equal)'
        '> (larger than)'
        '< (less than)'
        '>= (larger than or equal)'
        '<= (less than or equal)')
    end
    object ComboBox3: TComboBox
      Left = 8
      Top = 112
      Width = 209
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Visible = False
      OnClick = ComboBox3Click
    end
    object Label6: TMemo
      Left = 8
      Top = 40
      Width = 209
      Height = 57
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = True
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object ListBox1: TListBox
      Left = 224
      Top = 64
      Width = 233
      Height = 153
      ItemHeight = 13
      TabOrder = 5
      OnClick = ListBox1Click
    end
    object Button6: TButton
      Left = 8
      Top = 240
      Width = 65
      Height = 25
      Caption = 'Add'
      TabOrder = 6
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 152
      Top = 240
      Width = 65
      Height = 25
      Caption = 'Delete'
      TabOrder = 7
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 80
      Top = 240
      Width = 65
      Height = 25
      Caption = 'Modify'
      TabOrder = 8
      OnClick = Button8Click
    end
    object ComboBox1: TComboBox
      Left = 224
      Top = 24
      Width = 225
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 9
      OnChange = ComboBox1Change
    end
  end
  object Button2: TButton
    Left = 728
    Top = 448
    Width = 65
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 264
    Top = 448
    Width = 57
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = Button5Click
  end
  object GroupBox2: TGroupBox
    Left = 328
    Top = 8
    Width = 465
    Height = 145
    Caption = 'Start condition global data'
    TabOrder = 5
    object Label9: TLabel
      Left = 8
      Top = 52
      Width = 89
      Height = 13
      Caption = 'Node text preview'
    end
    object Label8: TLabel
      Left = 8
      Top = 12
      Width = 63
      Height = 13
      Caption = 'Target node:'
    end
    object ComboBox4: TComboBox
      Left = 8
      Top = 28
      Width = 337
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox4Change
    end
    object Memo1: TMemo
      Left = 8
      Top = 72
      Width = 337
      Height = 65
      Color = clCream
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object Button3: TButton
      Left = 352
      Top = 80
      Width = 105
      Height = 25
      Caption = 'Add Start node'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 352
      Top = 112
      Width = 105
      Height = 25
      Caption = 'Apply changes'
      Enabled = False
      TabOrder = 3
      OnClick = Button4Click
    end
    object CheckBox1: TCheckBox
      Left = 352
      Top = 24
      Width = 105
      Height = 25
      Hint = 
        'This option filters out all nodes that are not marked as startin' +
        'g nodes.'
      Caption = 'Start node filter'
      TabOrder = 4
      OnClick = CheckBox1Click
    end
  end
end
