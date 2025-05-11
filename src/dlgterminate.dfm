object Form8: TForm8
  Left = 557
  Top = 646
  ActiveControl = Button1
  BorderStyle = bsDialog
  Caption = 'Dialogue termination query'
  ClientHeight = 196
  ClientWidth = 511
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
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 511
    Height = 196
    Align = alClient
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 32
    Height = 26
    Caption = 'Target'#13#10'node:'
  end
  object NodeLabel: TLabel
    Left = 72
    Top = 56
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 80
    Width = 32
    Height = 13
    Caption = 'Notes:'
  end
  object Label4: TLabel
    Left = 120
    Top = 8
    Width = 319
    Height = 26
    Alignment = taCenter
    Caption = 
      'The player option you selected terminates the dialogue. '#13#10'Do you' +
      ' wish to edit the node or exit?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NotesMemo: TMemo
    Left = 72
    Top = 80
    Width = 409
    Height = 57
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvSpace
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 192
    Top = 160
    Width = 89
    Height = 25
    Caption = 'Edit node'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 296
    Top = 160
    Width = 73
    Height = 25
    Caption = 'Exit'
    ModalResult = 2
    TabOrder = 2
  end
end
