object Form2: TForm2
  Left = 178
  Top = 152
  Width = 720
  Height = 492
  Caption = 'Output Preview'
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
  object SynEdit1: TSynEdit
    Left = 8
    Top = 16
    Width = 697
    Height = 393
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = ANSI_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -12
    Gutter.Font.Name = 'Verdana'
    Gutter.Font.Style = []
    Gutter.LeadingZeros = True
    Gutter.ShowLineNumbers = True
    Gutter.Gradient = True
    Gutter.GradientStartColor = clInactiveCaptionText
    Gutter.GradientEndColor = clSkyBlue
    Highlighter = SynGeneralSyn1
    WordWrap = True
  end
  object Button1: TButton
    Left = 328
    Top = 416
    Width = 89
    Height = 33
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object SynGeneralSyn1: TSynGeneralSyn
    Comments = []
    DetectPreprocessor = False
    IdentifierChars = 
      '!"#$%&'#39'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`' +
      'abcdefghijklmnopqrstuvwxyz{|}~'#8364#129#8218#402#8222#8230#8224#8225#710#8240#352#8249#338#141#381#143#144#8216#8217#8220#8221#8226#8211#8212#732#8482#353#8250#339#157#382#376#160 +
      #161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224 +
      #225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255
    KeyAttri.Foreground = clNavy
    KeyAttri.Style = []
    NumberAttri.Foreground = clBlack
    SymbolAttri.Style = [fsBold]
    Left = 160
    Top = 56
  end
end
