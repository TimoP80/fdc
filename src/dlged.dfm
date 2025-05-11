object Form2: TForm2
  Left = 914
  Top = 383
  Caption = 'Dialogue Editor'
  ClientHeight = 779
  ClientWidth = 1078
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    1078
    779)
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1078
    Height = 732
    ActivePage = TabSheet1
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Regular nodes'
      DesignSize = (
        1070
        704)
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 50
        Height = 13
        Caption = 'Node filter'
      end
      object lblSearch: TLabel
        Left = 176
        Top = 3
        Width = 67
        Height = 13
        Caption = 'Search string:'
        Visible = False
      end
      object ListView1: TListView
        Left = 8
        Top = 44
        Width = 966
        Height = 650
        AllocBy = 255
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'NodeName'
            Width = 70
          end
          item
            AutoSize = True
            Caption = 'NPC text'
          end>
        FlatScrollBars = True
        GridLines = True
        MultiSelect = True
        RowSelect = True
        TabOrder = 5
        ViewStyle = vsReport
        OnClick = ListView1Click
        OnDblClick = ListView1DblClick
        OnEdited = ListView1Edited
      end
      object Button1: TButton
        AlignWithMargins = True
        Left = 980
        Top = 45
        Width = 87
        Height = 36
        Hint = 'With this button you can add a node'
        Anchors = [akTop, akRight]
        Caption = 'Add'
        TabOrder = 6
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 980
        Top = 87
        Width = 87
        Height = 34
        Hint = 
          'This opens the current node in the node editor. Also accessible ' +
          'by double-clicking on a node.'
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Edit'
        TabOrder = 7
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 980
        Top = 127
        Width = 87
        Height = 34
        Hint = 'This deletes the node from the dialogue tree'
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Delete'
        TabOrder = 8
        OnClick = Button3Click
      end
      object Button5: TButton
        Left = 980
        Top = 181
        Width = 87
        Height = 25
        Hint = 
          'This button makes a copy of the selected node and places it in t' +
          'he last slot in the dialogue tree. (e.g. number of nodes + 1)'
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Clone'
        TabOrder = 9
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 980
        Top = 301
        Width = 87
        Height = 25
        Hint = 
          'Swaps the selected player option with the one above it in the li' +
          'st.'#13#10#13#10'= Moves it up.'
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Move Up'
        TabOrder = 12
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 980
        Top = 332
        Width = 87
        Height = 25
        Hint = 
          'Swaps the selected player option with the one below it in the li' +
          'st.'#13#10#13#10'= Moves it down.'
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Move Down'
        TabOrder = 13
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 980
        Top = 244
        Width = 87
        Height = 25
        Hint = 
          'Sorts the nodes in alphabetical order. Note that '#13#10'with numeric ' +
          'nodes the sequence is:'#13#10#13#10'1'#13#10'10'#13#10'11'#13#10'12'#13#10'13'#13#10'14'#13#10#13#10'... etc.'#13#10
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Rearrange'
        TabOrder = 11
        OnClick = Button8Click
      end
      object startcondsbtn: TButton
        Left = 559
        Top = 13
        Width = 97
        Height = 25
        Hint = 
          'This opens the dialogue start conditions editor which allows you' +
          ' to define the starting node depending on various conditions and' +
          ' variable values.'
        Caption = 'Start conditions'
        TabOrder = 2
        OnClick = startcondsbtnClick
      end
      object variablesbtn: TButton
        Left = 464
        Top = 13
        Width = 89
        Height = 25
        Hint = 
          'This allows you to declare some variables that will be added to ' +
          'the output script'
        Caption = 'Script variables'
        TabOrder = 1
        OnClick = variablesbtnClick
      end
      object Button15: TButton
        Left = 980
        Top = 400
        Width = 87
        Height = 30
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Hide sel.'
        TabOrder = 14
        OnClick = Button15Click
      end
      object Button16: TButton
        Left = 980
        Top = 436
        Width = 87
        Height = 29
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Unhide All'
        Enabled = False
        TabOrder = 15
        OnClick = Button16Click
      end
      object srchEdit: TEdit
        Left = 176
        Top = 17
        Width = 217
        Height = 21
        TabOrder = 3
        Visible = False
      end
      object ComboBox1: TComboBox
        Left = 3
        Top = 17
        Width = 161
        Height = 21
        TabOrder = 4
        Text = 'Show All Nodes'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Show all nodes'
          'Show start nodes'
          'Show non-start nodes'
          'Show nodes with no text'
          'Show nodes with no player options'
          'Show nodes by name')
      end
      object srchBtn: TButton
        Left = 399
        Top = 13
        Width = 57
        Height = 25
        Caption = 'Search'
        TabOrder = 0
        Visible = False
        OnClick = srchBtnClick
      end
      object Button23: TButton
        Left = 980
        Top = 212
        Width = 87
        Height = 26
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Replace'
        TabOrder = 10
        OnClick = Button23Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Floater nodes'
      ImageIndex = 1
      DesignSize = (
        1070
        704)
      object ListView2: TListView
        Left = 8
        Top = 39
        Width = 985
        Height = 533
        Anchors = [akLeft, akTop, akRight]
        Columns = <
          item
            Caption = 'Node name'
            Width = 120
          end
          item
            Caption = 'Number of random lines'
            Width = 140
          end
          item
            Caption = 'Description'
            Width = 380
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = ListView2DblClick
      end
      object Button9: TButton
        Left = 999
        Top = 39
        Width = 68
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Add'
        TabOrder = 2
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 999
        Top = 75
        Width = 68
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Edit'
        TabOrder = 3
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 999
        Top = 106
        Width = 68
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Delete'
        TabOrder = 4
        OnClick = Button11Click
      end
      object Button12: TButton
        Left = 8
        Top = 8
        Width = 121
        Height = 25
        Caption = 'Timed events editor...'
        TabOrder = 0
        OnClick = Button12Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Custom Messages'
      ImageIndex = 2
      TabVisible = False
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 32
        Height = 13
        Caption = 'Index:'
      end
      object Label3: TLabel
        Left = 160
        Top = 16
        Width = 26
        Height = 13
        Caption = 'Text:'
      end
      object ListView3: TListView
        Left = 8
        Top = 48
        Width = 657
        Height = 377
        Columns = <
          item
            Caption = 'Index'
            Width = 90
          end
          item
            AutoSize = True
            Caption = 'Text'
          end>
        GridLines = True
        TabOrder = 3
        ViewStyle = vsReport
      end
      object Edit1: TEdit
        Left = 56
        Top = 16
        Width = 73
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object UpDown1: TUpDown
        Left = 129
        Top = 16
        Width = 16
        Height = 21
        Associate = Edit1
        TabOrder = 1
      end
      object Edit2: TEdit
        Left = 192
        Top = 16
        Width = 473
        Height = 21
        TabOrder = 2
      end
      object Button17: TButton
        Left = 672
        Top = 48
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 4
      end
      object Button18: TButton
        Left = 672
        Top = 80
        Width = 57
        Height = 25
        Caption = 'Delete'
        TabOrder = 5
      end
      object Button22: TButton
        Left = 8
        Top = 432
        Width = 113
        Height = 25
        Hint = 'This button generates the string table from the dialogue'
        Caption = 'Generate Stringtable'
        TabOrder = 6
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Skill Checks'
      ImageIndex = 3
      DesignSize = (
        1070
        704)
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 67
        Height = 13
        Caption = 'Skill check list:'
      end
      object ListView4: TListView
        Left = 9
        Top = 44
        Width = 980
        Height = 641
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Check name'
            Width = 130
          end
          item
            Caption = 'Skill'
            Width = 173
          end
          item
            Caption = 'Modifier'
            Width = 100
          end
          item
            Caption = 'OnSuccess'
            Width = 110
          end
          item
            Caption = 'OnFailure'
            Width = 130
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ListView4DblClick
      end
      object Button19: TButton
        Left = 995
        Top = 44
        Width = 72
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'Add'
        TabOrder = 1
        OnClick = Button19Click
      end
      object Button20: TButton
        Left = 995
        Top = 77
        Width = 72
        Height = 28
        Anchors = [akTop, akRight]
        Caption = 'Edit'
        TabOrder = 2
        OnClick = Button20Click
      end
      object Button21: TButton
        Left = 995
        Top = 111
        Width = 72
        Height = 34
        Anchors = [akTop, akRight]
        Caption = 'Delete'
        TabOrder = 3
        OnClick = Button21Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Scripted Dialogue'
      ImageIndex = 4
      TabVisible = False
      object ListView5: TListView
        Left = 8
        Top = 48
        Width = 641
        Height = 401
        Columns = <
          item
            Caption = 'Dialogue ID'
            Width = 130
          end
          item
            Caption = 'Number of actions'
            Width = 100
          end
          item
            Caption = 'Type'
            Width = 250
          end
          item
            Caption = 'Number of actors'
            Width = 155
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
      object Button24: TButton
        Left = 656
        Top = 48
        Width = 73
        Height = 25
        Caption = 'Add'
        TabOrder = 1
      end
      object Button25: TButton
        Left = 656
        Top = 80
        Width = 73
        Height = 25
        Caption = 'Edit'
        TabOrder = 2
      end
      object Button26: TButton
        Left = 656
        Top = 112
        Width = 73
        Height = 25
        Caption = 'Delete'
        TabOrder = 3
      end
    end
  end
  object Button4: TButton
    Left = 984
    Top = 741
    Width = 80
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Exit'
    TabOrder = 1
    OnClick = Button4Click
  end
end
