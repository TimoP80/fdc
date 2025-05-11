object Form5: TForm5
  Left = 1080
  Top = 463
  Width = 592
  Height = 492
  Caption = 'About Fallout Dialogue Creator'
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
    Width = 576
    Height = 453
    Align = alClient
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 3
    Top = 1
    Width = 558
    Height = 168
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 273
    Height = 161
    AutoSize = False
    Caption = 
      'Fallout Dialogue Creator'#13#10'version %s'#13#10'(build date: %s)'#13#10#13#10'The pr' +
      'ogram formerly known as'#13#10'FMF Dialogue Tool'#13#10#13#10'Number of DelphiWe' +
      'bScript engine functions: %d'#13#10'Number of plugins loaded: %d'#13#10#13#10'(c' +
      ') 2005-2018 T. Pitk'#228'nen'
    Transparent = True
  end
  object JvHTLabel1: TJvHTLabel
    Left = 296
    Top = 8
    Width = 265
    Height = 153
    AutoSize = False
    Caption = 
      'Contact author by e-mail: <a href="mailto:tpitkane@gmail.com">tp' +
      'itkane@gmail.com</a><br>'#13#10'<br>'#13#10'<b>Uses the following components' +
      '/libraries:</b><br>'#13#10'<br>'#13#10'<a href="http://jvcl.sourceforge.net"' +
      '>JVCL</a>, <a href="http://homepages.borland.com/jedi/jcl/">JCL<' +
      '/a>, '#13#10'<a href="http://www.tetzel.com/CocoR">CoCo/R for Delphi</' +
      'a>, <a href="http://www.dwscript.com">DelphiWebScriptII</a>,<br>' +
      #13#10'<a href="http://www.maxcomponents.net/">mxWebUpdate</a>, <a hr' +
      'ef="http://synedit.sourceforge.net/">SynEdit</a><br>'
    Transparent = True
    OnClick = JvHTLabel1Click
    OnMouseMove = JvHTLabel1MouseMove
    OnHyperLinkClick = JvHTLabel1HyperLinkClick
  end
  object Bevel2: TBevel
    Left = 288
    Top = 0
    Width = 17
    Height = 169
    Shape = bsLeftLine
  end
  object Bevel4: TBevel
    Left = 3
    Top = 168
    Width = 558
    Height = 233
    Shape = bsFrame
  end
  object Bevel5: TBevel
    Left = 11
    Top = 0
    Width = 553
    Height = 17
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 176
    Width = 48
    Height = 13
    Caption = 'Plugin list:'
  end
  object Label3: TLabel
    Left = 224
    Top = 176
    Width = 133
    Height = 13
    Caption = 'Selected plugin information:'
  end
  object Label4: TLabel
    Left = 8
    Top = 408
    Width = 385
    Height = 33
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 488
    Top = 408
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 192
    Width = 209
    Height = 201
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object Button2: TButton
    Left = 392
    Top = 408
    Width = 89
    Height = 25
    Caption = 'Configure plugin'
    TabOrder = 2
    Visible = False
    OnClick = Button2Click
  end
  object JvHTListBox1: TJvHTListBox
    Left = 224
    Top = 192
    Width = 329
    Height = 201
    HideSel = False
    OnHyperLinkClick = JvHTListBox1HyperLinkClick
    BorderStyle = bsNone
    Color = clBtnFace
    ColorHighlight = clBtnFace
    ColorHighlightText = clHighlightText
    ColorDisabledText = clGrayText
    ExtendedSelect = False
    TabOrder = 3
  end
end
