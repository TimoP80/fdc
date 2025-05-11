object Form14: TForm14
  Left = 857
  Top = 534
  BorderStyle = bsDialog
  Caption = 'List of dialogue transcripts'
  ClientHeight = 305
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 305
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 673
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Double-click on the list view to show the selected dialogue tran' +
        'script'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListView1: TListView
      Left = 8
      Top = 24
      Width = 673
      Height = 225
      Columns = <
        item
          Caption = '#'
          Width = 35
        end
        item
          Caption = 'NPC'
          Width = 150
        end
        item
          Caption = 'Record date'
          Width = 211
        end
        item
          Caption = 'Filename'
          Width = 265
        end>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = ListView1DblClick
    end
    object Button1: TButton
      Left = 312
      Top = 264
      Width = 81
      Height = 33
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
