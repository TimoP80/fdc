object Form1: TForm1
  Tag = 5
  Left = 153
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Dialogue tool debug console'
  ClientHeight = 460
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 51
    Height = 16
    Caption = 'Messages:'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 32
    Width = 657
    Height = 257
    Shape = bsFrame
  end
  object Memo1: TMemo
    Left = 16
    Top = 40
    Width = 641
    Height = 241
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = Memo1Change
  end
  object Memo2: TMemo
    Left = 16
    Top = 296
    Width = 473
    Height = 153
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    WantTabs = True
  end
  object Button1: TButton
    Left = 592
    Top = 296
    Width = 73
    Height = 25
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 296
    Width = 473
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
  end
  object Button2: TButton
    Left = 496
    Top = 296
    Width = 89
    Height = 25
    Caption = '>> Script'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 496
    Top = 328
    Width = 89
    Height = 25
    Caption = 'Run script'
    TabOrder = 5
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 496
    Top = 392
    Width = 89
    Height = 25
    Caption = 'Clear'
    TabOrder = 6
    OnClick = Button4Click
  end
end
