object Form2: TForm2
  Left = 503
  Top = 325
  BorderStyle = bsDialog
  Caption = 'About this plugin'
  ClientHeight = 144
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 347
    Height = 144
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 15
      Width = 343
      Height = 127
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'FMF Dialogue Tool Script Exporter'#13#10'version 1.2'#13#10'(c) 2005 Dj Uniq' +
        'ue'#13#10#13#10'Exports dialogue into SSL && MSG'#13#10'files for further editin' +
        'g (or directly to INT)'
    end
    object Button1: TButton
      Left = 144
      Top = 112
      Width = 73
      Height = 25
      BiDiMode = bdLeftToRight
      Caption = 'OK'
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
