object Form10: TForm10
  Left = 667
  Top = 247
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 456
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JvPageControl1: TJvPageControl
    Left = 3
    Top = 5
    Width = 449
    Height = 401
    ActivePage = TabSheet3
    HotTrack = True
    MultiLine = True
    RaggedRight = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General Preferences'
      object JvLabel1: TJvLabel
        Left = 8
        Top = 80
        Width = 138
        Height = 13
        Caption = 'Default SSL output directory'
        Transparent = True
      end
      object JvLabel2: TJvLabel
        Left = 8
        Top = 120
        Width = 142
        Height = 13
        Caption = 'Default MSG output directory'
        Transparent = True
      end
      object Label4: TLabel
        Left = 8
        Top = 160
        Width = 147
        Height = 13
        Caption = 'Location of FO2 script headers'
      end
      object Label5: TLabel
        Left = 8
        Top = 200
        Width = 113
        Height = 13
        Caption = 'Base Fallout 2 directory'
      end
      object Label6: TLabel
        Left = 160
        Top = 320
        Width = 141
        Height = 13
        Caption = 'Auto-save interval (minutes):'
        Visible = False
      end
      object Label13: TLabel
        Left = 8
        Top = 240
        Width = 97
        Height = 13
        Caption = 'Fallout 2 data folder'
      end
      object JvDirectoryEdit1: TJvDirectoryEdit
        Left = 8
        Top = 96
        Width = 353
        Height = 19
        Hint = 'This is the default folder where SSL files are placed'
        DialogKind = dkWin32
        Flat = True
        ParentFlat = False
        ButtonFlat = True
        TabOrder = 3
      end
      object JvDirectoryEdit2: TJvDirectoryEdit
        Left = 8
        Top = 136
        Width = 353
        Height = 19
        Hint = 'This is the default folder where MSG files are placed'
        DialogKind = dkWin32
        Flat = True
        ParentFlat = False
        ButtonFlat = True
        TabOrder = 4
      end
      object JvDirectoryEdit3: TJvDirectoryEdit
        Left = 8
        Top = 176
        Width = 353
        Height = 19
        Hint = 
          'This specifies the folder where the script headers are located. ' +
          'Required for direct script compiling.'
        DialogKind = dkWin32
        Flat = True
        ParentFlat = False
        ButtonFlat = True
        TabOrder = 5
      end
      object JvDirectoryEdit4: TJvDirectoryEdit
        Left = 8
        Top = 216
        Width = 353
        Height = 19
        Hint = 
          'This is the folder where your Fallout 2 installation is located ' +
          'at.'
        DialogKind = dkWin32
        Flat = True
        ParentFlat = False
        ButtonFlat = True
        TabOrder = 6
      end
      object JvSpinEdit1: TJvSpinEdit
        Left = 304
        Top = 312
        Width = 57
        Height = 21
        Value = 5.000000000000000000
        TabOrder = 8
        Visible = False
      end
      object Button3: TButton
        Left = 368
        Top = 216
        Width = 65
        Height = 25
        Caption = 'Auto-config'
        TabOrder = 9
        OnClick = Button3Click
      end
      object debug: TCheckBox
        Left = 8
        Top = 8
        Width = 85
        Height = 20
        Hint = 'Show debug window and log output to file'
        HelpContext = 101
        Caption = 'Debug mode'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
      end
      object checkupdates: TCheckBox
        Left = 8
        Top = 56
        Width = 187
        Height = 20
        Hint = 'Enable autoupdate checking on startup'
        HelpContext = 100
        Caption = 'Check for tool updates on startup'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 1
        Visible = False
      end
      object compwarn: TCheckBox
        Left = 8
        Top = 32
        Width = 290
        Height = 20
        Hint = 
          'This option makes the tool issue warnings during startup if'#13#10'it ' +
          'encounters a plugin that does not return an interface version'#13#10'n' +
          'umber'#13#10'(Interface version means the version of the tool'#13#10'the plu' +
          'gin is compatible with)'
        HelpContext = 103
        Caption = 'Warn about plugins containing no interface version info'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 320
        Width = 118
        Height = 20
        Caption = 'Auto-save dialogue'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 7
        OnClick = CheckBox3Click
      end
      object fo2datapath: TJvDirectoryEdit
        Left = 8
        Top = 256
        Width = 353
        Height = 19
        Hint = 
          'This is the folder where your Fallout 2 installation is located ' +
          'at.'
        DialogKind = dkWin32
        Flat = True
        ParentFlat = False
        ButtonFlat = True
        TabOrder = 10
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dialogue Editing'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 240
        Height = 39
        Caption = 
          'Format string for cloned nodes:'#13#10'Example: '#39'Copy of %s'#39', where %s' +
          ' will be replaced'#13#10'by the name of the node'
        Transparent = True
      end
      object Label2: TLabel
        Left = 8
        Top = 88
        Width = 130
        Height = 13
        Caption = 'Default int for smart player'
      end
      object Label3: TLabel
        Left = 8
        Top = 128
        Width = 129
        Height = 13
        Caption = 'Default int for dumb player'
      end
      object Edit1: TEdit
        Left = 8
        Top = 64
        Width = 297
        Height = 21
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 8
        Top = 104
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '4'
      end
      object UpDown1: TUpDown
        Left = 49
        Top = 104
        Width = 16
        Height = 21
        Associate = Edit2
        Min = -10
        Max = 10
        Position = 4
        TabOrder = 2
      end
      object Edit3: TEdit
        Left = 8
        Top = 144
        Width = 41
        Height = 21
        TabOrder = 3
        Text = '-3'
      end
      object UpDown2: TUpDown
        Left = 49
        Top = 144
        Width = 16
        Height = 21
        Associate = Edit3
        Min = -10
        Max = 10
        Position = -3
        TabOrder = 4
      end
      object autonodemap: TCheckBox
        Left = 8
        Top = 176
        Width = 346
        Height = 20
        Caption = 'Auto remap node names in designer notes if node name is changed'
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Dialogue engine options'
      ImageIndex = 2
      object Label12: TLabel
        Left = 8
        Top = 176
        Width = 286
        Height = 13
        Caption = 'Number of skill checks to perform to determine probabilities:'
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 200
        Width = 425
        Height = 169
        Caption = 'Player option text colors'
        TabOrder = 6
        object Label10: TLabel
          Left = 8
          Top = 88
          Width = 87
          Height = 13
          Caption = 'Bad reaction text:'
        end
        object Label9: TLabel
          Left = 8
          Top = 56
          Width = 94
          Height = 13
          Caption = 'Good reaction text:'
        end
        object Label8: TLabel
          Left = 8
          Top = 24
          Width = 104
          Height = 13
          Caption = 'Neutral reaction text:'
        end
        object Label11: TLabel
          Left = 8
          Top = 120
          Width = 120
          Height = 13
          Caption = 'Dumb player option text:'
        end
        object badColor: TJvColorComboBox
          Left = 136
          Top = 80
          Width = 281
          Height = 22
          ColorValue = clRed
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 281
          NewColorText = 'Custom'
          Options = [coText, coSysColors]
          TabOrder = 0
        end
        object goodColor: TJvColorComboBox
          Left = 136
          Top = 48
          Width = 281
          Height = 22
          ColorValue = clGreen
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 281
          NewColorText = 'Custom'
          Options = [coText, coSysColors]
          TabOrder = 1
        end
        object neutralColor: TJvColorComboBox
          Left = 136
          Top = 16
          Width = 281
          Height = 22
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 281
          NewColorText = 'Custom'
          Options = [coText, coSysColors]
          TabOrder = 2
        end
        object dumbcolor: TJvColorComboBox
          Left = 136
          Top = 112
          Width = 281
          Height = 22
          ColorValue = clPurple
          ColorDialogText = 'Custom...'
          DroppedDownWidth = 281
          NewColorText = 'Custom'
          Options = [coText, coSysColors]
          TabOrder = 3
        end
        object dumboptcolormode: TCheckBox
          Left = 8
          Top = 144
          Width = 409
          Height = 17
          Hint = 
            'In this mode, all dumb player options will be displayed with the' +
            ' color you specified. Reaction types for dumb player options are' +
            ' ignored.'
          Caption = 'Colorize dumb player options'
          TabOrder = 4
        end
      end
      object runtimedlgedit: TCheckBox
        Left = 8
        Top = 64
        Width = 178
        Height = 20
        Hint = 
          'This option enables run-time dialogue editing,'#13#10'which basically ' +
          'means that you can edit the'#13#10'dialogue while you'#39're testing it.'
        HelpContext = 103
        Caption = 'Enable run-time dialogue editing'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
      end
      object evalcond: TCheckBox
        Left = 8
        Top = 16
        Width = 161
        Height = 20
        Hint = 
          'Enables dialogue condition checking in dialogue test mode (defau' +
          'lt=ON)'
        HelpContext = 100
        Caption = 'Evaluate dialogue conditions'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 1
      end
      object last_trans: TCheckBox
        Left = 8
        Top = 88
        Width = 274
        Height = 20
        Hint = 
          'This enables displaying a transcript of the last dialogue run af' +
          'ter pressing stop'
        HelpContext = 103
        Caption = 'Show dialogue transcript at the end of dialogue test'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
      end
      object savenodehist: TCheckBox
        Left = 8
        Top = 40
        Width = 182
        Height = 20
        Hint = 
          'This options enables saving of dialogue transcripts'#13#10'that are re' +
          'sult of the test process.'
        HelpContext = 102
        Caption = 'Auto-save dialog test transcripts'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 136
        Width = 294
        Height = 20
        Caption = 'Use dialogue starting conditions to determine start node'
        TabOrder = 4
        Visible = False
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 112
        Width = 117
        Height = 20
        Hint = 
          'Enables dialogue condition checking in dialogue test mode (defau' +
          'lt=ON)'
        HelpContext = 100
        Caption = 'Perform skill checks'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 5
      end
      object skillsimulations: TJvSpinEdit
        Left = 312
        Top = 168
        Width = 49
        Height = 21
        Hint = 
          'When '#39'Evaluate skill checks'#39' is turned off, the popup window'#13#10'wi' +
          'll display probabilities on which this skill check may succeed'#13#10 +
          'or fail. This option determines how many times the checks are'#13#10'p' +
          'erformed to calculate success/failure percentages.'
        TabOrder = 7
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Helper scripts'
      ImageIndex = 3
      TabVisible = False
      object Label7: TLabel
        Left = 8
        Top = 8
        Width = 43
        Height = 13
        Caption = 'Script list'
      end
      object ListBox1: TListBox
        Left = 8
        Top = 24
        Width = 329
        Height = 337
        ItemHeight = 13
        TabOrder = 0
      end
      object Button4: TButton
        Left = 344
        Top = 24
        Width = 73
        Height = 25
        Caption = 'Add script'
        TabOrder = 1
      end
      object Button5: TButton
        Left = 344
        Top = 88
        Width = 73
        Height = 25
        Caption = 'Delete script'
        TabOrder = 2
      end
      object Button6: TButton
        Left = 344
        Top = 56
        Width = 73
        Height = 25
        Caption = 'Modify script'
        TabOrder = 3
      end
    end
  end
  object Button1: TButton
    Left = 296
    Top = 416
    Width = 73
    Height = 33
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 416
    Width = 73
    Height = 33
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
