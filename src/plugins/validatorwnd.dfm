object Form1: TForm1
  Left = 186
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Dialogue validation tool'
  ClientHeight = 331
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 331
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 63
      Height = 13
      Caption = 'Validation log'
    end
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 545
      Height = 33
      AutoSize = False
      Caption = 
        'This tool will check the current dialogue for errors and list th' +
        'em below. You can '#13#10'double-click on an error line to go to the n' +
        'ode the error was found in and correct it.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 248
      Top = 288
      Width = 81
      Height = 33
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Memo1: TListBox
      Left = 8
      Top = 59
      Width = 545
      Height = 223
      ItemHeight = 13
      TabOrder = 1
    end
  end
end
