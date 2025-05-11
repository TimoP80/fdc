object Form26: TForm26
  Left = 962
  Top = 369
  Width = 447
  Height = 292
  Caption = 'Parameter Input window'
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
  object CurrentParamCaption: TLabel
    Left = 8
    Top = 8
    Width = 353
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object JvPageList1: TJvPageList
    Left = 10
    Top = 24
    Width = 409
    Height = 185
    ActivePage = StatSelectInputPage
    PropagateEnable = False
    ShowDesignCaption = sdcNone
    object StringInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'String data'
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 113
        Height = 13
        Caption = 'Enter string parameter:'
      end
      object Memo1: TMemo
        Left = 8
        Top = 40
        Width = 393
        Height = 129
        Color = clCream
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
      end
    end
    object NodeInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'Select node'
      object Label1: TLabel
        Left = 8
        Top = 64
        Width = 93
        Height = 13
        Caption = 'Node text preview:'
      end
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 69
        Height = 13
        Caption = 'Select a node:'
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 32
        Width = 241
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnClick = ComboBox1Click
      end
      object Memo2: TMemo
        Left = 8
        Top = 88
        Width = 393
        Height = 81
        Color = clCream
        Ctl3D = False
        ParentCtl3D = False
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object IntegerInput: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'Enter a number:'
      object Label6: TLabel
        Left = 136
        Top = 56
        Width = 86
        Height = 13
        Caption = 'Set integer value:'
      end
      object Edit1: TEdit
        Left = 136
        Top = 72
        Width = 105
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object UpDown1: TUpDown
        Left = 241
        Top = 72
        Width = 17
        Height = 21
        Associate = Edit1
        Min = -9999
        Max = 9999
        TabOrder = 1
      end
    end
    object FloatNodeInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'Select float node:'
      object Label2: TLabel
        Left = 8
        Top = 64
        Width = 146
        Height = 13
        Caption = 'Float node messages preview:'
      end
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 94
        Height = 13
        Caption = 'Select a float node:'
      end
      object Memo3: TMemo
        Left = 8
        Top = 88
        Width = 393
        Height = 81
        Color = clCream
        Ctl3D = False
        ParentCtl3D = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object ComboBox2: TComboBox
        Left = 8
        Top = 32
        Width = 241
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        OnClick = ComboBox2Click
      end
    end
    object BooleanInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'BooleanInputPage'
      object Label7: TLabel
        Left = 112
        Top = 56
        Width = 90
        Height = 13
        Caption = 'Set boolean value:'
      end
      object ComboBox3: TComboBox
        Left = 112
        Top = 72
        Width = 185
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'False'
          'True')
      end
    end
    object SkillSelectInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'SkillSelectInputPage'
      object Label8: TLabel
        Left = 16
        Top = 24
        Width = 52
        Height = 13
        Caption = 'Select skill:'
      end
      object ListBox1: TListBox
        Left = 16
        Top = 40
        Width = 377
        Height = 129
        Style = lbOwnerDrawVariable
        ItemHeight = 16
        TabOrder = 0
      end
    end
    object StatSelectInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'StatSelectInputPage'
      object Label9: TLabel
        Left = 16
        Top = 24
        Width = 55
        Height = 13
        Caption = 'Select stat:'
      end
      object ListBox2: TListBox
        Left = 16
        Top = 40
        Width = 377
        Height = 129
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object VarInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'VarInputPage'
      object Label10: TLabel
        Left = 16
        Top = 24
        Width = 70
        Height = 13
        Caption = 'Select variable'
      end
      object ListBox3: TListBox
        Left = 16
        Top = 40
        Width = 377
        Height = 129
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object GeneralInputPage: TJvStandardPage
      Left = 0
      Top = 0
      Width = 409
      Height = 185
      Caption = 'GeneralInputPage'
      object Label11: TLabel
        Left = 16
        Top = 24
        Width = 58
        Height = 13
        Caption = 'Select data:'
      end
      object ListBox4: TListBox
        Left = 16
        Top = 40
        Width = 377
        Height = 129
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 248
    Top = 216
    Width = 89
    Height = 25
    Caption = 'Next parameter'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 216
    Width = 73
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
