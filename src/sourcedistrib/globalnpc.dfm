object Form9: TForm9
  Left = 1176
  Top = 266
  BorderStyle = bsDialog
  Caption = 'NPC Properties'
  ClientHeight = 555
  ClientWidth = 532
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 185
    Caption = 'Descriptions for script header comments'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 49
      Height = 13
      Caption = 'NPC name'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 40
      Height = 13
      Caption = 'Location'
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 28
      Height = 13
      Caption = 'Notes'
    end
    object npcname: TEdit
      Left = 72
      Top = 24
      Width = 257
      Height = 21
      TabOrder = 0
    end
    object npcloc: TEdit
      Left = 72
      Top = 56
      Width = 169
      Height = 21
      TabOrder = 1
    end
    object npcnotes: TMemo
      Left = 72
      Top = 88
      Width = 425
      Height = 89
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 200
    Width = 513
    Height = 313
    Caption = 'NPC look descriptions'
    TabOrder = 1
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 144
      Height = 13
      Caption = 'Unknown (not spoken to NPC)'
    end
    object Label5: TLabel
      Left = 8
      Top = 120
      Width = 148
      Height = 13
      Caption = 'Known (spoken to NPC before)'
    end
    object Label6: TLabel
      Left = 8
      Top = 208
      Width = 116
      Height = 13
      Caption = 'Detailed look description'
    end
    object npcunknowndesc: TMemo
      Left = 8
      Top = 40
      Width = 497
      Height = 73
      TabOrder = 0
    end
    object npcknowndesc: TMemo
      Left = 8
      Top = 136
      Width = 497
      Height = 65
      TabOrder = 1
    end
    object npcdetailed: TMemo
      Left = 8
      Top = 224
      Width = 497
      Height = 73
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 368
    Top = 520
    Width = 73
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 448
    Top = 520
    Width = 73
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
