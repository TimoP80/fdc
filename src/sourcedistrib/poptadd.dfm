object Form4: TForm4
  Left = 962
  Top = 55
  BorderStyle = bsDialog
  Caption = 'Add playeroption'
  ClientHeight = 629
  ClientWidth = 563
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
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Player option text'
    Transparent = False
  end
  object noteslabel: TLabel
    Left = 8
    Top = 408
    Width = 76
    Height = 13
    Caption = 'Designer notes:'
    Transparent = False
  end
  object Label4: TLabel
    Left = 200
    Top = 88
    Width = 94
    Height = 13
    Caption = 'Name for new node'
    Transparent = False
    Visible = False
  end
  object Label6: TLabel
    Left = 8
    Top = 200
    Width = 113
    Height = 41
    AutoSize = False
    Caption = 'NPC Text'#13#10'for the selected'#13#10'node:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Label7: TLabel
    Left = 280
    Top = 64
    Width = 31
    Height = 13
    Caption = 'Label7'
    Transparent = False
  end
  object Label8: TLabel
    Left = 8
    Top = 496
    Width = 65
    Height = 13
    Caption = 'Condition list:'
    Transparent = False
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 113
    Height = 57
    AutoSize = False
    Caption = 'NPC Text'#13#10'(female PC)'#13#10'for the selected'#13#10'node:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 424
    Width = 545
    Height = 65
    Hint = 
      'These are designer notes for the player option,'#13#10'mostly detailin' +
      'g additional things needed such as'#13#10'skill checks etc.'
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Edit1: TMemo
    Left = 16
    Top = 24
    Width = 537
    Height = 57
    Hint = 'This is '
    TabOrder = 0
  end
  object nodetextpreview: TMemo
    Left = 120
    Top = 200
    Width = 433
    Height = 49
    Color = clCream
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
    Visible = False
    OnKeyUp = nodetextpreviewKeyUp
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 320
    Width = 545
    Height = 81
    Caption = 'Player option settings'
    TabOrder = 9
    object Label5: TLabel
      Left = 16
      Top = 20
      Width = 85
      Height = 13
      Caption = 'Intelligence check'
      Transparent = False
    end
    object Label3: TLabel
      Left = 360
      Top = 20
      Width = 42
      Height = 13
      Caption = 'Reaction'
      Transparent = False
    end
    object Label9: TLabel
      Left = 136
      Top = 16
      Width = 65
      Height = 13
      Caption = 'Gender flags:'
    end
    object ComboBox2: TComboBox
      Left = 136
      Top = 32
      Width = 201
      Height = 21
      Hint = 'This sets visibility of the option based'#13#10'on player gender.'
      ItemHeight = 13
      TabOrder = 0
      Text = 'Option is visible for both genders'
      Items.Strings = (
        'Option is visible for both genders'
        'Option is visible for male players only'
        'Option is visible for female players only')
    end
    object Edit3: TEdit
      Left = 16
      Top = 32
      Width = 81
      Height = 21
      Hint = 
        'This sets the int requirement for the option.'#13#10#13#10'Negative values' +
        ' mean int should be less than the value'#13#10'and positive means equa' +
        'l or more than the value'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '4'
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 53
      Width = 118
      Height = 20
      Hint = 
        'This is a simple wrapper for the dumb player. Setting'#13#10'this to c' +
        'hecked changes the value to whatever'#13#10'is defined in the config f' +
        'or the "Default int for dumb player"'#13#10'setting.'
      Caption = 'Dumb player option'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
    object UpDown1: TUpDown
      Left = 97
      Top = 32
      Width = 16
      Height = 21
      Associate = Edit3
      Min = -10
      Max = 10
      Position = 4
      TabOrder = 3
    end
    object ComboBox3: TComboBox
      Left = 360
      Top = 32
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = 'Neutral'
      Items.Strings = (
        'Neutral'
        'Good'
        'Bad')
    end
  end
  object Memo2: TMemo
    Left = 8
    Top = 512
    Width = 545
    Height = 65
    BevelKind = bkSoft
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 127
    Width = 153
    Height = 17
    Caption = 'Link to procedure'
    TabOrder = 17
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 17
    Top = 85
    Width = 137
    Height = 17
    Caption = 'Link to node'
    TabOrder = 18
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 200
    Top = 128
    Width = 113
    Height = 16
    Caption = 'Link to skill check'
    TabOrder = 20
    OnClick = RadioButton3Click
  end
  object nodetextfemalepreview: TMemo
    Left = 120
    Top = 264
    Width = 433
    Height = 49
    Color = clCream
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 22
    Visible = False
    OnKeyUp = nodetextfemalepreviewKeyUp
  end
  object CheckBox1: TCheckBox
    Left = 344
    Top = 88
    Width = 115
    Height = 20
    Caption = 'Link to a new node'
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 344
    Top = 112
    Width = 121
    Height = 20
    Hint = 'This sets the option link to end dialogue'
    Caption = 'Terminates dialogue'
    TabOrder = 10
    OnClick = CheckBox2Click
  end
  object CheckBox4: TCheckBox
    Left = 344
    Top = 136
    Width = 194
    Height = 20
    Hint = 
      'This setting will override '#39'terminates dialogue'#39#13#10'After dialogue' +
      ' terminates, the critter becomes'#13#10'hostile and combat starts.'
    Caption = 'Enter combat (set critter to hostile)'
    TabOrder = 11
    OnClick = CheckBox4Click
  end
  object Button1: TButton
    Left = 400
    Top = 592
    Width = 73
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 592
    Width = 73
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 472
    Top = 88
    Width = 73
    Height = 25
    Hint = 
      'Clicking on this button creates a new empty node '#13#10'with the name' +
      ' specified in "Name for new node"'#13#10#13#10'You can set the npc text or' +
      ' leave it empty and fill it in'#13#10'later. The node will appear in t' +
      'he node combobox in the'#13#10'left side of this window displaying the' +
      ' npc text'#13#10'for the new node.'
    Caption = 'Create node'
    TabOrder = 8
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 592
    Width = 129
    Height = 25
    Caption = 'Set up conditions...'
    TabOrder = 12
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 224
    Top = 169
    Width = 49
    Height = 16
    Hint = 
      'This button opens the skill check editor which allows you to spe' +
      'cify a conditional node link path. This will override the curren' +
      'tly set node link.'
    Caption = 'Create'
    TabOrder = 14
    OnClick = Button5Click
  end
  object Button9: TButton
    Left = 153
    Top = 592
    Width = 105
    Height = 25
    Hint = 
      'This button invokes a code editor to add a new procedure. '#13#10'For ' +
      'example, this can be used when you need a new procedure '#13#10'that p' +
      'erforms some tasks such as sets variable values, '#13#10'transfers ite' +
      'ms, determines where to go'#13#10'based on a condition and many other ' +
      'tasks.'
    Caption = 'Custom procedures'
    TabOrder = 15
    OnClick = Button9Click
  end
  object editbtn: TButton
    Left = 280
    Top = 168
    Width = 57
    Height = 17
    Caption = 'edit'
    TabOrder = 21
    OnClick = editbtnClick
  end
  object Edit2: TEdit
    Left = 200
    Top = 105
    Width = 137
    Height = 21
    Hint = 'This specifies a name for a new node to be created for the link'
    TabOrder = 2
    Visible = False
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 104
    Width = 161
    Height = 21
    Hint = 
      'This is the node to link the option to.'#13#10#13#10'Note that the current' +
      ' node is never visible here'#13#10'to avoid self-linking (which could ' +
      'cause an endless'#13#10'loop)'#13#10
    ItemHeight = 13
    TabOrder = 1
    OnClick = ComboBox1Click
  end
  object ComboBox4: TComboBox
    Left = 16
    Top = 144
    Width = 161
    Height = 21
    ItemHeight = 13
    TabOrder = 16
  end
  object ComboBox5: TComboBox
    Left = 200
    Top = 144
    Width = 137
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 19
  end
end
