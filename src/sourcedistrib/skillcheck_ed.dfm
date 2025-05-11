object Form24: TForm24
  Left = 1286
  Top = 589
  Width = 500
  Height = 421
  Caption = 'Skill check editor'
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
    Width = 484
    Height = 383
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 48
      Width = 149
      Height = 13
      Caption = 'Name for skill check procedure:'
    end
    object Label2: TLabel
      Left = 96
      Top = 80
      Width = 88
      Height = 13
      Caption = 'Skill/Stat to check:'
    end
    object Label3: TLabel
      Left = 104
      Top = 120
      Width = 83
      Height = 13
      Caption = 'Difficulty modifier'
    end
    object Label4: TLabel
      Left = 96
      Top = 144
      Width = 90
      Height = 13
      Caption = 'On success, go to:'
    end
    object Label5: TLabel
      Left = 96
      Top = 232
      Width = 83
      Height = 13
      Caption = 'On failure, go to:'
    end
    object Label6: TLabel
      Left = 8
      Top = 328
      Width = 289
      Height = 39
      Caption = 
        'Note: A negative modifier makes the skill check more difficult'#13#10 +
        'whereas a modifier with a value more than 0 makes it'#13#10'easier. Ev' +
        'en skill checks with a modifier of 0 may fail.'
    end
    object Label7: TLabel
      Left = 80
      Top = 168
      Width = 110
      Height = 13
      Caption = 'Success node preview:'
    end
    object Label8: TLabel
      Left = 80
      Top = 264
      Width = 104
      Height = 13
      Caption = 'Failure node preview:'
    end
    object Label9: TLabel
      Left = 80
      Top = 16
      Width = 106
      Height = 13
      Caption = 'Associated with node:'
    end
    object Edit1: TEdit
      Left = 192
      Top = 40
      Width = 185
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object Button1: TButton
      Left = 384
      Top = 40
      Width = 57
      Height = 25
      Hint = 
        'This button automatically assigns a unique name for the skill ch' +
        'eck.'
      Caption = 'Generate'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 192
      Top = 72
      Width = 193
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'Small Guns'
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
        'Outdoorsman'
        'Strength'
        'Perception'
        'Endurance'
        'Charisma'
        'Intelligence'
        'Agility'
        'Luck')
    end
    object Edit2: TEdit
      Left = 192
      Top = 104
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 273
      Top = 104
      Width = 16
      Height = 21
      Associate = Edit2
      Min = -9999
      Max = 9999
      TabOrder = 4
    end
    object ComboBox2: TComboBox
      Left = 192
      Top = 136
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      OnChange = ComboBox2Change
      OnClick = ComboBox2Click
    end
    object ComboBox3: TComboBox
      Left = 192
      Top = 232
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      OnChange = ComboBox3Change
      OnClick = ComboBox3Click
    end
    object Button2: TButton
      Left = 336
      Top = 344
      Width = 65
      Height = 25
      Caption = 'OK'
      Enabled = False
      TabOrder = 7
      OnClick = Button2Click
    end
    object Memo1: TMemo
      Left = 192
      Top = 168
      Width = 241
      Height = 57
      Color = clCream
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 8
    end
    object Memo2: TMemo
      Left = 192
      Top = 264
      Width = 241
      Height = 57
      Color = clCream
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 9
    end
    object ComboBox4: TComboBox
      Left = 192
      Top = 8
      Width = 193
      Height = 21
      ItemHeight = 13
      TabOrder = 10
    end
    object Button3: TButton
      Left = 408
      Top = 344
      Width = 65
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 11
    end
  end
end
