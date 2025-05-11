object Form1: TForm1
  Left = 350
  Top = 180
  Caption = 'Fallout Dialogue Creator'
  ClientHeight = 876
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    929
    876)
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 42
    Height = 13
    Caption = 'NPC Line'
  end
  object Label2: TLabel
    Left = 8
    Top = 333
    Width = 68
    Height = 13
    Caption = 'Player options'
  end
  object Label3: TLabel
    Left = 8
    Top = 753
    Width = 135
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Notes for the current option'
    ExplicitTop = 727
  end
  object Label4: TLabel
    Left = 607
    Top = 8
    Width = 43
    Height = 11
    Anchors = [akTop, akRight]
    Caption = 'Start node'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 519
  end
  object Label5: TLabel
    Left = 178
    Top = 16
    Width = 68
    Height = 13
    Caption = 'Current node:'
    Visible = False
  end
  object Label6: TLabel
    Left = 8
    Top = 197
    Width = 136
    Height = 13
    Caption = 'Designer notes for this node'
  end
  object hiddenopts: TLabel
    Left = 443
    Top = 248
    Width = 312
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 355
  end
  object Memo1: TMemo
    Left = 8
    Top = 72
    Width = 908
    Height = 119
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    ExplicitWidth = 860
  end
  object Memo2: TMemo
    Left = 9
    Top = 772
    Width = 906
    Height = 74
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 2
    ExplicitTop = 746
    ExplicitWidth = 858
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 852
    Width = 929
    Height = 24
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object ListBox1: TListView
    Left = 8
    Top = 352
    Width = 908
    Height = 395
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Index'
      end
      item
        AutoSize = True
        Caption = 'Option text'
      end
      item
        Caption = 'Target node'
        Width = 90
      end
      item
        Caption = 'Reaction'
        Width = 68
      end>
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = ListBox1Click
    OnCustomDrawSubItem = ListBox1CustomDrawSubItem
    OnDblClick = ListBox1DblClick
  end
  object Memo3: TMemo
    Left = 8
    Top = 216
    Width = 908
    Height = 111
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 11
    ExplicitWidth = 860
  end
  object nodelabel: TEdit
    Left = 178
    Top = 35
    Width = 169
    Height = 19
    Color = clBtnFace
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
    Visible = False
  end
  object Button1: TButton
    Left = 747
    Top = 22
    Width = 88
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Run dialogue'
    TabOrder = 3
    OnClick = Button1Click
    ExplicitLeft = 699
  end
  object Button2: TButton
    Left = 841
    Top = 22
    Width = 88
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Stop'
    Enabled = False
    TabOrder = 4
    OnClick = Button2Click
    ExplicitLeft = 793
  end
  object Button3: TButton
    Left = 448
    Top = 20
    Width = 105
    Height = 29
    Caption = 'Edit dialogue'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 22
    Width = 73
    Height = 27
    Caption = 'Go back'
    Enabled = False
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 89
    Top = 22
    Width = 83
    Height = 25
    Caption = 'Go forward'
    Enabled = False
    TabOrder = 9
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 353
    Top = 20
    Width = 89
    Height = 29
    Caption = 'Edit this node'
    TabOrder = 10
    Visible = False
    OnClick = Button6Click
  end
  object ComboBox1: TComboBox
    Left = 607
    Top = 24
    Width = 134
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 7
    ExplicitLeft = 559
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New dialogue'
        ShortCut = 16462
        OnClick = New1Click
      end
      object Loaddialogue1: TMenuItem
        Caption = 'Load dialogue'
        ImageIndex = 1
        ShortCut = 16460
        OnClick = Loaddialogue1Click
      end
      object Savedialogue2: TMenuItem
        Caption = 'Save dialogue'
        ShortCut = 16467
        OnClick = Savedialogue2Click
      end
      object Savedialogue1: TMenuItem
        Caption = 'Save dialogue as...'
        OnClick = Savedialogue1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Import1: TMenuItem
        Caption = 'Import'
        Visible = False
      end
      object ExportHTML1: TMenuItem
        Caption = 'Export'
        Visible = False
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Preferences1: TMenuItem
        Caption = 'Preferences...'
        ImageIndex = 0
        OnClick = Preferences1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        OnClick = Quit1Click
      end
    end
    object Global1: TMenuItem
      Caption = 'Global'
      object NPCproperties1: TMenuItem
        Caption = 'NPC properties'
        OnClick = NPCproperties1Click
      end
      object Playercharactersetup1: TMenuItem
        Caption = 'Setup Player Character'
        OnClick = Playercharactersetup1Click
      end
    end
    object Dialog1: TMenuItem
      Caption = 'Dialogue'
      object Showtranscriptlist1: TMenuItem
        Caption = 'Dialogue transcripts...'
        OnClick = Showtranscriptlist1Click
      end
      object Saveall1: TMenuItem
        Caption = 'Save all transcripts'
        OnClick = Saveall1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Opendialogueeditor1: TMenuItem
        Caption = 'Dialogue editor...'
        ShortCut = 16453
        OnClick = Opendialogueeditor1Click
      end
      object Customprocedures1: TMenuItem
        Caption = 'Custom procedures...'
        ShortCut = 16464
        OnClick = Customprocedures1Click
      end
    end
    object Plugins1: TMenuItem
      Caption = 'Plugins'
    end
    object Dev1: TMenuItem
      Caption = 'Developer stuff'
      Visible = False
      object Dumpscriptcommands1: TMenuItem
        Caption = 'Dump script commands'
        OnClick = Dumpscriptcommands1Click
      end
      object Editfunctiondescriptions1: TMenuItem
        Caption = 'Edit function descriptions'
        OnClick = Editfunctiondescriptions1Click
      end
    end
    object HelperScripts1: TMenuItem
      Caption = 'Helper Scripts'
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object DialogueToolHelp1: TMenuItem
        Caption = 'Dialogue Tool Help'
        ShortCut = 112
        OnClick = DialogueToolHelp1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'fmf'
    Filter = 'FMF Dialogue File format (*.fmf)|*.fmf'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 136
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'fmf'
    Filter = 'FMF Dialogue File format (*.fmf)|*.fmf'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 160
    Top = 64
  end
  object DelphiWebScriptII1: TDelphiWebScript
    Config.CompilerOptions = []
    Left = 232
    Top = 208
  end
  object func_unit: TdwsUnit
    Script = DelphiWebScriptII1
    Constants = <
      item
        Name = 'FIELD_NPC_NAME'
        DataType = 'Integer'
        Value = 0
      end
      item
        Name = 'FIELD_NPC_LOCATION'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'FIELD_NPC_DESCRIPTION'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'FIELD_NPC_UNKNOWN_LOOK'
        DataType = 'Integer'
        Value = 3
      end
      item
        Name = 'FIELD_NPC_KNOWN_LOOK'
        DataType = 'Integer'
        Value = 4
      end
      item
        Name = 'FIELD_NPC_DETAILED_LOOK'
        DataType = 'Integer'
        Value = 5
      end
      item
        Name = 'FIELD_NODE_NPCTEXT'
        DataType = 'Integer'
        Value = 6
      end
      item
        Name = 'FIELD_NODE_NPCFEMALETEXT'
        DataType = 'Integer'
        Value = 7
      end
      item
        Name = 'FIELD_NODE_NOTES'
        DataType = 'Integer'
        Value = 8
      end
      item
        Name = 'FIELD_NODE_OPTIONCOUNT'
        DataType = 'Integer'
        Value = 9
      end
      item
        Name = 'FIELD_NODE_NAME'
        DataType = 'Integer'
        Value = 16
      end
      item
        Name = 'FIELD_PLAYEROPTION_OPTIONTEXT'
        DataType = 'Integer'
        Value = 10
      end
      item
        Name = 'FIELD_PLAYEROPTION_REACTION'
        DataType = 'Integer'
        Value = 11
      end
      item
        Name = 'FIELD_PLAYEROPTION_GENDERFLAGS'
        DataType = 'Integer'
        Value = 12
      end
      item
        Name = 'FIELD_PLAYEROPTION_NODELINK'
        DataType = 'Integer'
        Value = 13
      end
      item
        Name = 'FIELD_PLAYEROPTION_INTCHECK'
        DataType = 'Integer'
        Value = 14
      end
      item
        Name = 'FIELD_PLAYEROPTION_NOTES'
        DataType = 'Integer'
        Value = 15
      end
      item
        Name = 'REACTION_NEUTRAL'
        DataType = 'Integer'
        Value = 0
      end
      item
        Name = 'REACTION_GOOD'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'REACTION_BAD'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'GENDER_NONE'
        DataType = 'Integer'
        Value = 0
      end
      item
        Name = 'GENDER_MALE'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'GENDER_FEMALE'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'SW_SHOW'
        DataType = 'Integer'
        Value = 5
      end
      item
        Name = 'VAR_FLAGS_NONE'
        DataType = 'Integer'
        Value = 0
      end
      item
        Name = 'VAR_FLAGS_IMPORT'
        DataType = 'Integer'
        Value = 1
      end
      item
        Name = 'VAR_FLAGS_EXPORT'
        DataType = 'Integer'
        Value = 2
      end
      item
        Name = 'VAR_FLAGS_LOCAL'
        DataType = 'Integer'
        Value = 3
      end>
    Functions = <
      item
        Name = 'AddNode'
        Parameters = <
          item
            Name = 'nodename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'npctext'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'notes'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'npctext_female'
            DataType = 'String'
            IsWritable = False
            HasDefaultValue = True
            DefaultValue = ''
          end>
        OnEval = func_unitFunctionsAddNodeEval
      end
      item
        Name = 'AddPlayerOption'
        Parameters = <
          item
            Name = 'destnodename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'opttext'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'nodelink'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'notes'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddPlayerOptionEval
      end
      item
        Name = 'SetNodeName'
        Parameters = <
          item
            Name = 'Oldname'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'NewName'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetNodeNameEval
      end
      item
        Name = 'RefreshAll'
        OnEval = func_unitFunctionsRefreshAllEval
      end
      item
        Name = 'SetPlayerOptionLink'
        Parameters = <
          item
            Name = 'Nodeindex'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'OptionIndex'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Newdata'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetPlayerOptionLinkEval
      end
      item
        Name = 'MoveNodelinkToNotes'
        Parameters = <
          item
            Name = 'Nodeindex'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Optionindex'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Replacedata'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsMoveNodelinkToNotesEval
      end
      item
        Name = 'GetCurrentNode'
        ResultType = 'String'
        OnEval = func_unitFunctionsGetCurrentNodeEval
      end
      item
        Name = 'SetCurrentNode'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetCurrentNodeEval
      end
      item
        Name = 'GetSSLPath'
        ResultType = 'String'
        OnEval = func_unitFunctionsGetSSLPathEval
      end
      item
        Name = 'GetMSGPath'
        ResultType = 'String'
        OnEval = func_unitFunctionsGetMSGPathEval
      end
      item
        Name = 'DebugMsg'
        Parameters = <
          item
            Name = 'message'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsDebugMsgEval
      end
      item
        Name = 'EditNode'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsEditNodeEval
      end
      item
        Name = 'SaveConfirm'
        ResultType = 'Boolean'
        OnEval = func_unitFunctionsSaveConfirmEval
      end
      item
        Name = 'Help'
        OnEval = func_unitFunctionsHelpEval
      end
      item
        Name = 'Print'
        Parameters = <
          item
            Name = 'text'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsPrintEval
      end
      item
        Name = 'GetHelp'
        Parameters = <
          item
            Name = 'cmd'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsGetHelpEval
      end
      item
        Name = 'ListNodes'
        OnEval = func_unitFunctionsListNodesEval
      end
      item
        Name = 'ShowNode'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsShowNodeEval
      end
      item
        Name = 'ShowDialogGlobals'
        OnEval = func_unitFunctionsShowDialogGlobalsEval
      end
      item
        Name = 'SetDialogGlobals'
        Parameters = <
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'data'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetDialogGlobalsEval
      end
      item
        Name = 'ShowConstants'
        OnEval = func_unitFunctionsShowConstantsEval
      end
      item
        Name = 'ListPlugins'
        OnEval = func_unitFunctionsListPluginsEval
      end
      item
        Name = 'StartPlugin'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsStartPluginEval
      end
      item
        Name = 'GetProgramVersion'
        OnEval = func_unitFunctionsGetProgramVersionEval
      end
      item
        Name = 'LoadDialogue'
        Parameters = <
          item
            Name = 'filename'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsLoadDialogueEval
      end
      item
        Name = 'SaveDialogue'
        Parameters = <
          item
            Name = 'filename'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSaveDialogueEval
      end
      item
        Name = 'RunDialogue'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsRunDialogueEval
      end
      item
        Name = 'StopDialogue'
        OnEval = func_unitFunctionsStopDialogueEval
      end
      item
        Name = 'ShowNodeHistory'
        OnEval = func_unitFunctionsShowNodeHistoryEval
      end
      item
        Name = 'ShowCurrentDir'
        OnEval = func_unitFunctionsShowCurrentDirEval
      end
      item
        Name = 'IsDialogueRunning'
        ResultType = 'Boolean'
        OnEval = func_unitFunctionsIsDialogueRunningEval
      end
      item
        Name = 'ListTranscripts'
        OnEval = func_unitFunctionsListTranscriptsEval
      end
      item
        Name = 'ShowTranscript'
        Parameters = <
          item
            Name = 'num'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsShowTranscriptEval
      end
      item
        Name = 'Cls'
        OnEval = func_unitFunctionsClsEval
      end
      item
        Name = 'FlushDialogue'
        OnEval = func_unitFunctionsFlushDialogueEval
      end
      item
        Name = 'Dir'
        OnEval = func_unitFunctionsDirEval
      end
      item
        Name = 'cd'
        Parameters = <
          item
            Name = 'path'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionscdEval
      end
      item
        Name = 'SaveDialogTranscripts'
        OnEval = func_unitFunctionsSaveDialogTranscriptsEval
      end
      item
        Name = 'DoNodeSort'
        OnEval = SortNodes
      end
      item
        Name = 'DumpHelpToHTML'
        OnEval = func_unitFunctionsDumpHelpToHTMLEval
      end
      item
        Name = 'SetNodeData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Newdata'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetNodeDataEval
      end
      item
        Name = 'GetNodeData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsGetNodeDataEval
      end
      item
        Name = 'GetPlayerOptionStringData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Option'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsGetPlayerOptionStringDataEval
      end
      item
        Name = 'GetPlayerOptionIntegerData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Option'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end>
        ResultType = 'Integer'
        OnEval = func_unitFunctionsGetPlayerOptionIntegerDataEval
      end
      item
        Name = 'SetPlayerOptionStringData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Option'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'newdata'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetPlayerOptionStringDataEval
      end
      item
        Name = 'SetPlayerOptionIntegerData'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Option'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'Field'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'newdata'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetPlayerOptionIntegerDataEval
      end
      item
        Name = 'AddHelperScript'
        Parameters = <
          item
            Name = 'Filename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Description'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Category'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddHelperScriptEval
      end
      item
        Name = 'GetNodeName'
        Parameters = <
          item
            Name = 'nodeIndex'
            DataType = 'Integer'
            IsWritable = False
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsGetNodeNameEval
      end
      item
        Name = 'EditPlayerOption'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'OptionNum'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsEditPlayerOptionEval
      end
      item
        Name = 'GetNodeCount'
        ResultType = 'Integer'
        OnEval = func_unitFunctionsGetNodeCountEval
      end
      item
        Name = 'DeleteNode'
        Parameters = <
          item
            Name = 'Name'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsDeleteNodeEval
      end
      item
        Name = 'DeletePlayerOption'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'OptionIndex'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsDeletePlayerOptionEval
      end
      item
        Name = 'Confirm'
        Parameters = <
          item
            Name = 'Message'
            DataType = 'String'
            IsWritable = False
          end>
        ResultType = 'Boolean'
        OnEval = func_unitFunctionsConfirmEval
      end
      item
        Name = 'StringReplace'
        Parameters = <
          item
            Name = 'srcString'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'oldString'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'newString'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'ReplaceAll'
            DataType = 'Boolean'
            IsWritable = False
            HasDefaultValue = True
            DefaultValue = True
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsStringReplaceEval
      end
      item
        Name = 'AddTimeEventCode'
        Parameters = <
          item
            Name = 'line'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddTimeEventCodeEval
      end
      item
        Name = 'AddTimeEventCommand'
        Parameters = <
          item
            Name = 'Name'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'script'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'Shortcut'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddTimeEventCommandEval
      end
      item
        Name = 'SelectFloatNode'
        ResultType = 'String'
        OnEval = func_unitFunctionsSelectFloatNodeEval
      end
      item
        Name = 'SelectTimedEvent'
        ResultType = 'String'
        OnEval = func_unitFunctionsSelectTimedEventEval
      end
      item
        Name = 'AddNodeNoRefresh'
        Parameters = <
          item
            Name = 'nodename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'npctext'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'notes'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'npctext_female'
            DataType = 'String'
            IsWritable = False
            HasDefaultValue = True
            DefaultValue = ''
          end>
        OnEval = func_unitFunctionsAddNodeNoRefreshEval
      end
      item
        Name = 'AddTimedEvent'
        Parameters = <
          item
            Name = 'name'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'interval1'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'interval2'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddTimedEventEval
      end
      item
        Name = 'AddCodeToEvent'
        Parameters = <
          item
            Name = 'eventname'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'codeline'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddCodeToEventEval
      end
      item
        Name = 'AddFloatNode'
        Parameters = <
          item
            Name = 'nodename'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'desc'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddFloatNodeEval
      end
      item
        Name = 'AddMSGToFloatNode'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'msg'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddMSGToFloatNodeEval
      end
      item
        Name = 'EditFloatNode'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsEditFloatNodeEval
      end
      item
        Name = 'Dialoguechangenotify'
        OnEval = func_unitFunctionsDialoguechangenotifyEval
      end
      item
        Name = 'GetTimedEventData'
        Parameters = <
          item
            Name = 'event'
            DataType = 'String'
            IsWritable = False
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsGetTimedEventDataEval
      end
      item
        Name = 'DoLink_ShowExports'
        Parameters = <
          item
            Name = 'plugin'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsDoLink_ShowExportsEval
      end
      item
        Name = 'ExecuteFile'
        Parameters = <
          item
            Name = 'app'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'params'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'defaultdir'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'displaycmd'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsExecuteFileEval
      end
      item
        Name = 'LoadDef'
        Parameters = <
          item
            Name = 'fname'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsLoadDefEval
      end
      item
        Name = 'AddSkillCheck'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'name'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'skill'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'modifier'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'onsuccess'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'onfailure'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsAddSkillCheckEval
      end
      item
        Name = 'SetOptionToSkillCheck'
        Parameters = <
          item
            Name = 'node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'opt_ind'
            DataType = 'Integer'
            IsWritable = False
          end
          item
            Name = 'skillcheck'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetOptionToSkillCheckEval
      end
      item
        Name = 'RequestPluginRefresh'
        OnEval = func_unitFunctionsRequestPluginRefreshEval
      end
      item
        Name = 'SetNodeCustomCode'
        Parameters = <
          item
            Name = 'Node'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'code'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetNodeCustomCodeEval
      end
      item
        Name = 'OpenProgressBar'
        OnEval = func_unitFunctionsOpenProgressBarEval
      end
      item
        Name = 'setProgressMax'
        Parameters = <
          item
            Name = 'count'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionssetProgressMaxEval
      end
      item
        Name = 'updateProgress'
        Parameters = <
          item
            Name = 'pos'
            DataType = 'Integer'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsupdateProgressEval
      end
      item
        Name = 'closeprogressbar'
        OnEval = func_unitFunctionscloseprogressbarEval
      end
      item
        Name = 'Setprogressbarcaption'
        Parameters = <
          item
            Name = 'text'
            DataType = 'String'
            IsWritable = False
          end>
        OnEval = func_unitFunctionsSetprogressbarcaptionEval
      end
      item
        Name = 'AddVariable'
        Parameters = <
          item
            Name = 'varname'
            DataType = 'String'
            IsWritable = False
          end
          item
            Name = 'varflags'
            DataType = 'Integer'
            IsWritable = False
          end>
      end
      item
        Name = 'IsNodeHidden'
        Parameters = <
          item
            Name = 'index'
            DataType = 'Integer'
          end>
        ResultType = 'Boolean'
        OnEval = func_unitFunctionsIsNodeHiddenEval
      end
      item
        Name = 'CopyConditions'
        Parameters = <
          item
            Name = 'SourceNodeIndex'
            DataType = 'Integer'
          end
          item
            Name = 'DestinationNodeIndex'
            DataType = 'Integer'
          end
          item
            Name = 'SourceConditionPlayerOption'
            DataType = 'Integer'
          end
          item
            Name = 'TargetConditionPlayerOption'
            DataType = 'Integer'
          end>
        OnEval = func_unitFunctionsCopyConditionsEval
      end
      item
        Name = 'FormattedInt'
        Parameters = <
          item
            Name = 'formattedindex'
            DataType = 'Integer'
          end
          item
            Name = 'FormatString'
            DataType = 'String'
          end>
        ResultType = 'String'
        OnEval = func_unitFunctionsFormattedIntEval
      end>
    UnitName = 'FMFFuncs'
    Variables = <
      item
        Name = 'basepath'
        DataType = 'String'
        OnReadVar = func_unitVariablesbasepathReadVar
      end>
    StaticSymbols = False
    Left = 192
    Top = 152
  end
  object dws2GUIFunctions1: TdwsGUIFunctions
    Left = 432
    Top = 208
  end
  object SynCompletionProposal1: TSynCompletionProposal
    DefaultType = ctParams
    Options = [scoLimitToMatchedText, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    ClBackground = 16773876
    EndOfTokenChr = '()[]. '
    TriggerChars = '(,'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    OnExecute = SynCompletionProposal1Execute
    ShortCut = 16416
    TimerInterval = 700
    Left = 472
    Top = 200
  end
  object SynCompletionProposal2: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUseInsertList, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    ClTitleBackground = 16706008
    EndOfTokenChr = '()[]. '
    TriggerChars = '.,'
    Title = 'Code completion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    ShortCut = 16416
    Left = 416
    Top = 184
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 176
    Top = 128
  end
  object ReplaceDialog1: TReplaceDialog
    Options = [frDown, frReplaceAll]
    OnReplace = ReplaceDialog1Replace
    Left = 328
    Top = 104
  end
end
