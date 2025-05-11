object Form3: TForm3
  Left = 811
  Top = 364
  BorderStyle = bsDialog
  Caption = 'Add node'
  ClientHeight = 785
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  ShowHint = True
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 112
    Height = 13
    Caption = 'NPC Text for the node:'
  end
  object Label2: TLabel
    Left = 8
    Top = 373
    Width = 68
    Height = 13
    Caption = 'Player options'
  end
  object Label3: TLabel
    Left = 8
    Top = 236
    Width = 140
    Height = 13
    Caption = 'Designer notes for this node:'
  end
  object Label4: TLabel
    Left = 8
    Top = 24
    Width = 54
    Height = 13
    Caption = 'Node name'
  end
  object Label5: TLabel
    Left = 8
    Top = 141
    Width = 177
    Height = 13
    Caption = 'NPC text for female player (optional)'
  end
  object npctext: TMemo
    Left = 8
    Top = 64
    Width = 665
    Height = 71
    TabOrder = 1
  end
  object designernotes: TMemo
    Left = 8
    Top = 255
    Width = 665
    Height = 105
    Hint = 
      'Here are designer notes for the node.'#13#10'This is where you type so' +
      'me information'#13#10'about the node, its purpose, etc.'
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 8
    Top = 160
    Width = 665
    Height = 70
    Enabled = False
    TabOrder = 7
  end
  object optionsdata: TListView
    Left = 8
    Top = 392
    Width = 663
    Height = 338
    Hint = 'These are the player options'
    Columns = <
      item
        Caption = 'Index'
      end
      item
        Caption = 'Option text'
        Width = 412
      end
      item
        Caption = 'Target node'
        Width = 199
      end>
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnClick = optionsdataClick
    OnDblClick = optionsdataDblClick
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 217
    Height = 21
    Hint = 
      'This is the name for the node. It will become the procedure name' +
      #13#10'in the exported SSL script.'#13#10'Accepted characters: 0-9,A-Z,a-z'#13 +
      #10'No whitespace is allowed. (No check is made here but'#13#10'the scrip' +
      't compiler might complain)'
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 433
    Top = 141
    Width = 232
    Height = 16
    Hint = 'Enables a different response when the player is female.'
    Caption = 'Display different npc text for female player'
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object isstartnode: TCheckBox
    Left = 538
    Top = 366
    Width = 135
    Height = 20
    Hint = 
      'Marks the node as a starting point where dialogue will start fro' +
      'm.'#13#10'This is used for the starting condition editor to filter out' +
      ' non-start nodes.'
    Caption = 'Is dialogue start node?'
    TabOrder = 15
  end
  object Button1: TButton
    Left = 520
    Top = 736
    Width = 73
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 600
    Top = 736
    Width = 73
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 736
    Width = 81
    Height = 25
    Hint = 'This button opens the "add player option" dialog.'
    Caption = 'Add option'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 184
    Top = 736
    Width = 89
    Height = 25
    Hint = 'This button deletes the selected player option.'
    Caption = 'Delete option'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 360
    Top = 736
    Width = 65
    Height = 25
    Caption = 'Move Up'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 432
    Top = 736
    Width = 65
    Height = 25
    Caption = 'Move Down'
    TabOrder = 11
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 96
    Top = 736
    Width = 81
    Height = 25
    Caption = 'Edit option'
    TabOrder = 12
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 584
    Top = 16
    Width = 81
    Height = 25
    Hint = 
      'This button invokes a code editor to insert code to the beginnin' +
      'g of the node. '#13#10'It can be used when you need to perform tasks '#13 +
      #10'specific to the particular node regardless of which player opti' +
      'on '#13#10'was selected. For example, you can cause some items to '#13#10'be' +
      ' transferred from the player to the NPC or something else.'
    Caption = 'Custom code'
    TabOrder = 13
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 304
    Top = 16
    Width = 81
    Height = 25
    Hint = 
      '|This button generates a nodename in the NodeXXX format. The num' +
      'ber is based on the current node count. (for example, if this is' +
      ' the first node, the number becomes Node001 and so on) '
    Caption = 'Generate'
    TabOrder = 14
    OnClick = Button9Click
  end
end
