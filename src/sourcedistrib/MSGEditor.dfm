object Form1: TForm1
  Left = 220
  Top = -11
  Width = 696
  Height = 735
  Caption = 'Fallout 2 MSG Editor'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Courier New'
  Font.Style = []
  Menu = JvMainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object JvGradient1: TJvGradient
    Left = 0
    Top = 0
    Width = 688
    Height = 681
    Style = grVertical
    StartColor = clSilver
    EndColor = clGray
  end
  object Label1: TLabel
    Left = 16
    Top = 432
    Width = 82
    Height = 14
    Caption = 'Message ID:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 464
    Width = 100
    Height = 14
    Caption = 'Soundfile field:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 16
    Top = 496
    Width = 34
    Height = 14
    Caption = 'Text:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object JvListView1: TJvListView
    Left = 8
    Top = 8
    Width = 673
    Height = 369
    Columns = <
      item
        Caption = 'id'
      end
      item
        Caption = 'sound file'
        Width = 90
      end
      item
        Caption = 'text'
        Width = 529
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLines = True
    RowSelect = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = JvListView1Click
    OnInfoTip = JvListView1InfoTip
    ColumnsOrder = '0=50,1=90,2=529'
    Groups = <
      item
        GroupId = 1
        Header = 'Group'
      end
      item
        GroupId = 2
        Header = 'Gag'
      end>
    ExtendedColumns = <
      item
      end
      item
      end
      item
      end>
  end
  object Button1: TButton
    Left = 16
    Top = 392
    Width = 81
    Height = 25
    Caption = 'Add'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 104
    Top = 392
    Width = 81
    Height = 25
    Caption = 'Insert'
    TabOrder = 2
  end
  object Button3: TButton
    Left = 192
    Top = 392
    Width = 81
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 152
    Top = 424
    Width = 137
    Height = 23
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 152
    Top = 456
    Width = 137
    Height = 23
    TabOrder = 5
  end
  object Memo1: TMemo
    Left = 152
    Top = 488
    Width = 513
    Height = 81
    TabOrder = 6
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 584
    Width = 129
    Height = 17
    Caption = 'Add comments:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object Memo2: TMemo
    Left = 152
    Top = 582
    Width = 513
    Height = 81
    TabOrder = 8
  end
  object JvMainMenu1: TJvMainMenu
    Style = msItemPainter
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    ItemPainter = JvOfficeMenuItemPainter1
    TextMargin = 6
    Left = 96
    Top = 16
    object File1: TMenuItem
      Caption = 'File'
      object Newmessagefile1: TMenuItem
        Caption = 'New'
        OnClick = Newmessagefile1Click
      end
      object LoadMSG1: TMenuItem
        Caption = 'Load'
        OnClick = LoadMSG1Click
      end
      object SaveMSG1: TMenuItem
        Caption = 'Save'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        OnClick = Quit1Click
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
      object Outputpreview1: TMenuItem
        Caption = 'Saved output preview'
        OnClick = Outputpreview1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 248
    Top = 88
  end
  object JvOfficeMenuItemPainter1: TJvOfficeMenuItemPainter
    Left = 88
    Top = 72
  end
  object JvOpenDialog1: TJvOpenDialog
    DefaultExt = 'msg'
    Filter = 'Fallout MSG files (*.msg)|*.msg|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Height = 0
    Width = 0
    Left = 192
    Top = 56
  end
end
