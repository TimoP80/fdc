object Form16: TForm16
  Left = 548
  Top = 276
  Width = 761
  Height = 356
  Caption = 'Additional player option conditions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 745
    Height = 317
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 360
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Check type'
    end
    object Label2: TLabel
      Left = 528
      Top = 8
      Width = 60
      Height = 13
      Caption = 'Field names:'
    end
    object Label3: TLabel
      Left = 360
      Top = 56
      Width = 75
      Height = 13
      Caption = 'Evaluation type'
    end
    object Label4: TLabel
      Left = 360
      Top = 128
      Width = 90
      Height = 13
      Caption = 'Resolved SSL code'
    end
    object sslcode: TLabel
      Left = 360
      Top = 144
      Width = 161
      Height = 41
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label6: TLabel
      Left = 8
      Top = 8
      Width = 61
      Height = 13
      Caption = 'Condition list'
    end
    object Label7: TLabel
      Left = 360
      Top = 192
      Width = 69
      Height = 13
      Caption = 'Value to check'
    end
    object Label5: TLabel
      Left = 360
      Top = 96
      Width = 59
      Height = 13
      Caption = 'Chosen field'
    end
    object chosenfield: TLabel
      Left = 360
      Top = 112
      Width = 161
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 360
      Top = 232
      Width = 36
      Height = 13
      Caption = 'Linkage'
    end
    object Button1: TButton
      Left = 592
      Top = 280
      Width = 65
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 664
      Top = 280
      Width = 65
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object checktypelist: TComboBox
      Left = 360
      Top = 24
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnClick = checktypelistClick
    end
    object fieldlist: TListBox
      Left = 528
      Top = 24
      Width = 201
      Height = 249
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = fieldlistClick
    end
    object evaltype: TComboBox
      Left = 360
      Top = 72
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnClick = evaltypeClick
      Items.Strings = (
        'none (check for true)'
        '== (equal)'
        '!= (not equal)'
        '> (larger than)'
        '< (less than)'
        '>= (larger than or equal)'
        '<= (less than or equal)')
    end
    object Button3: TButton
      Left = 216
      Top = 280
      Width = 57
      Height = 25
      Caption = 'Add'
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 280
      Top = 280
      Width = 65
      Height = 25
      Caption = 'Delete'
      TabOrder = 6
      OnClick = Button4Click
    end
    object condlist: TListBox
      Left = 8
      Top = 24
      Width = 345
      Height = 249
      ItemHeight = 13
      TabOrder = 7
      OnClick = condlistClick
      OnMouseDown = condlistMouseDown
    end
    object valuetocheck: TEdit
      Left = 360
      Top = 208
      Width = 161
      Height = 21
      TabOrder = 8
      OnChange = valuetocheckChange
      OnKeyUp = valuetocheckKeyUp
    end
    object Button5: TButton
      Left = 360
      Top = 280
      Width = 81
      Height = 25
      Caption = 'Apply changes'
      TabOrder = 9
      OnClick = Button5Click
    end
    object linkage: TComboBox
      Left = 360
      Top = 248
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 10
      Items.Strings = (
        'None'
        'And'
        'Or')
    end
  end
end
