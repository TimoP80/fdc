object Form15: TForm15
  Left = 782
  Top = 279
  BorderStyle = bsDialog
  Caption = 'Player character Setup'
  ClientHeight = 419
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 398
    Height = 419
    Align = alClient
    ParentShowHint = False
    Shape = bsFrame
    ShowHint = True
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 61
    Height = 13
    Caption = 'Player name:'
  end
  object Label2: TLabel
    Left = 224
    Top = 16
    Width = 35
    Height = 13
    Caption = 'Gender'
  end
  object Label3: TLabel
    Left = 304
    Top = 16
    Width = 19
    Height = 13
    Caption = 'Age'
  end
  object Label4: TLabel
    Left = 104
    Top = 80
    Width = 24
    Height = 13
    Caption = 'Skills'
  end
  object Label5: TLabel
    Left = 16
    Top = 80
    Width = 40
    Height = 13
    Caption = 'Strength'
  end
  object Label6: TLabel
    Left = 16
    Top = 120
    Width = 51
    Height = 13
    Caption = 'Perception'
  end
  object Label7: TLabel
    Left = 16
    Top = 160
    Width = 52
    Height = 13
    Caption = 'Endurance'
  end
  object Label8: TLabel
    Left = 16
    Top = 200
    Width = 43
    Height = 13
    Caption = 'Charisma'
  end
  object Label9: TLabel
    Left = 16
    Top = 240
    Width = 54
    Height = 13
    Caption = 'Intelligence'
  end
  object Label10: TLabel
    Left = 16
    Top = 280
    Width = 27
    Height = 13
    Caption = 'Agility'
  end
  object Label11: TLabel
    Left = 16
    Top = 320
    Width = 24
    Height = 13
    Caption = 'Luck'
  end
  object Label12: TLabel
    Left = 16
    Top = 360
    Width = 73
    Height = 13
    Caption = 'Money amount:'
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 193
    Height = 21
    Hint = 
      'This is the name for the player character to use in dialogue tes' +
      'ting.'
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 224
    Top = 32
    Width = 65
    Height = 21
    Hint = 
      'This is the test player character'#39's gender.'#13#10'It affects the npc'#39 +
      's response if both male and female npc'#13#10'text is specified in a n' +
      'ode.'
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Male'
    Items.Strings = (
      'Male'
      'Female')
  end
  object Edit2: TEdit
    Left = 304
    Top = 32
    Width = 57
    Height = 21
    Hint = 
      'This is the age for the character. A minor attribute but still c' +
      'heckable.'
    TabOrder = 2
    Text = '16'
  end
  object UpDown1: TUpDown
    Left = 361
    Top = 32
    Width = 16
    Height = 21
    Associate = Edit2
    Min = 16
    Max = 36
    Position = 16
    TabOrder = 3
  end
  object ValueListEditor1: TValueListEditor
    Left = 104
    Top = 96
    Width = 273
    Height = 233
    Hint = 'These are the skill values for the player.'
    Strings.Strings = (
      'Small Guns=0'
      'Big Guns=0'
      'Energy Weapons=0'
      'Unarmed Combat=0'
      'Melee=0'
      'Throwing=0'
      'First Aid=0'
      'Doctor=0'
      'Sneak=0'
      'Lockpick=0'
      'Steal=0'
      'Traps=0'
      'Science=0'
      'Repair=0'
      'Speech=0'
      'Barter=0'
      'Gambling=0'
      'Outdoorsman=0')
    TabOrder = 4
    TitleCaptions.Strings = (
      'Skill'
      'Value')
    ColWidths = (
      178
      72)
  end
  object JvSpinEdit1: TJvSpinEdit
    Left = 16
    Top = 96
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Strength'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 5
  end
  object JvSpinEdit2: TJvSpinEdit
    Left = 16
    Top = 136
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Perception'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 6
  end
  object JvSpinEdit3: TJvSpinEdit
    Left = 16
    Top = 176
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Endurance'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 7
  end
  object JvSpinEdit4: TJvSpinEdit
    Left = 16
    Top = 216
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Charisma'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 8
  end
  object JvSpinEdit5: TJvSpinEdit
    Left = 16
    Top = 256
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Intelligence'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 9
  end
  object JvSpinEdit6: TJvSpinEdit
    Left = 16
    Top = 296
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Agility'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 10
  end
  object JvSpinEdit7: TJvSpinEdit
    Left = 16
    Top = 336
    Width = 41
    Height = 21
    Hint = 'SPECIAL attributes: Luck'
    MaxValue = 10.000000000000000000
    MinValue = 1.000000000000000000
    Value = 5.000000000000000000
    TabOrder = 11
  end
  object Button1: TButton
    Left = 312
    Top = 376
    Width = 65
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 12
  end
  object JvSpinEdit8: TJvSpinEdit
    Left = 16
    Top = 376
    Width = 81
    Height = 21
    Hint = 'Amount of money carried by the player.'
    MaxValue = 99999.000000000000000000
    TabOrder = 13
  end
end
