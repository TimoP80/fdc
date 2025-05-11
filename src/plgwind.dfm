object plgwnd: Tplgwnd
  Left = 306
  Top = 152
  Width = 536
  Height = 409
  Caption = 'Plugin helper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Small Fonts'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 11
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 375
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 85
      Height = 11
      Caption = 'Name for new plugin:'
    end
    object Description: TLabel
      Left = 15
      Top = 42
      Width = 119
      Height = 22
      Caption = 'Description'#13#10'(for source code comments)'
    end
    object Label2: TLabel
      Left = 18
      Top = 171
      Width = 65
      Height = 22
      Caption = 'Description'#13#10'(for application)'
    end
    object Label3: TLabel
      Left = 18
      Top = 204
      Width = 29
      Height = 11
      Caption = 'Author'
    end
    object Label4: TLabel
      Left = 16
      Top = 336
      Width = 73
      Height = 11
      Caption = 'Output project file'
    end
    object Label5: TLabel
      Left = 16
      Top = 296
      Width = 36
      Height = 11
      Caption = 'Shortcut'
    end
    object plgName: TEdit
      Left = 144
      Top = 16
      Width = 330
      Height = 19
      TabOrder = 0
    end
    object plgdesc: TMemo
      Left = 144
      Top = 40
      Width = 331
      Height = 129
      TabOrder = 1
    end
    object appdesc: TEdit
      Left = 144
      Top = 176
      Width = 334
      Height = 19
      TabOrder = 2
    end
    object auth: TEdit
      Left = 144
      Top = 200
      Width = 334
      Height = 19
      TabOrder = 3
    end
    object Button1: TButton
      Left = 408
      Top = 344
      Width = 49
      Height = 27
      Caption = 'OK'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 462
      Top = 344
      Width = 53
      Height = 27
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 5
    end
    object CheckBox1: TCheckBox
      Left = 144
      Top = 318
      Width = 270
      Height = 14
      Caption = 'Plugin can be added to the Plugins-menu'
      TabOrder = 6
    end
    object JvHotKey1: TJvHotKey
      Left = 144
      Top = 296
      Width = 153
      Height = 17
      HotKey = 0
      InvalidKeys = [hcShift]
      Modifiers = []
      TabOrder = 7
      ParentColor = False
    end
    object CheckBox2: TCheckBox
      Left = 144
      Top = 224
      Width = 225
      Height = 17
      Caption = 'Allow plugin to refresh data'
      TabOrder = 8
    end
    object CheckBox3: TCheckBox
      Left = 144
      Top = 240
      Width = 257
      Height = 17
      Caption = 'Allow plugin to close its windows'
      TabOrder = 9
    end
    object CheckBox4: TCheckBox
      Left = 144
      Top = 256
      Width = 305
      Height = 17
      Caption = 'Allow plugin to receive debug messages from the host application'
      TabOrder = 11
    end
    object CheckBox5: TCheckBox
      Left = 144
      Top = 272
      Width = 297
      Height = 17
      Caption = 'Allow plugin to be configured'
      TabOrder = 10
    end
    object output: TJvFilenameEdit
      Left = 144
      Top = 336
      Width = 257
      Height = 19
      Filter = 'Delphi project files (*.dpr)|*.dpr'
      TabOrder = 12
    end
  end
end
