object conv_view: Tconv_view
  Left = 1066
  Top = 259
  Width = 726
  Height = 597
  Caption = 'Dialogue Output'
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 87
    Height = 13
    Caption = 'Script location:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 125
    Height = 13
    Caption = 'Message file location:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object msgloc: TLabel
    Left = 152
    Top = 24
    Width = 529
    Height = 13
    AutoSize = False
  end
  object scrloc: TLabel
    Left = 152
    Top = 8
    Width = 529
    Height = 13
    AutoSize = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 48
    Width = 689
    Height = 457
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Message file'
      object SynMemo1: TSynMemo
        Left = 0
        Top = 0
        Width = 681
        Height = 429
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = msghighlight
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Script File'
      ImageIndex = 1
      object SynMemo2: TSynMemo
        Left = 0
        Top = 0
        Width = 681
        Height = 429
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = sslHighlight
      end
    end
  end
  object Button1: TButton
    Left = 608
    Top = 512
    Width = 81
    Height = 33
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object sslHighlight: TSynGeneralSyn
    CommentAttri.Foreground = clGreen
    Comments = [csAnsiStyle, csPasStyle, csCStyle, csCPPStyle]
    DetectPreprocessor = True
    IdentifierAttri.Foreground = clBlack
    IdentifierChars = 
      '!"#$%&'#39'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`' +
      'abcdefghijklmnopqrstuvwxyz{|}~'#8364#129#8218#402#8222#8230#8224#8225#710#8240#352#8249#338#141#381#143#144#8216#8217#8220#8221#8226#8211#8212#732#8482#353#8250#339#157#382#376#160 +
      #161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224 +
      #225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255
    KeyAttri.Foreground = clNavy
    KeyWords.Strings = (
      'AND'
      'BEGIN'
      'BWAND'
      'BWOR'
      'CALL'
      'CRITICAL'
      'DO'
      'ELSE'
      'END'
      'EXPORT'
      'IF'
      'IMPORT'
      'OR'
      'PROCEDURE'
      'THEN'
      'VARIABLE'
      'WHILE')
    NumberAttri.Foreground = clNavy
    PreprocessorAttri.Foreground = clBackground
    StringAttri.Foreground = clBlue
    StringDelim = sdDoubleQuote
    Left = 204
    Top = 144
  end
  object msghighlight: TSynGeneralSyn
    CommentAttri.Foreground = clGreen
    Comments = [csAnsiStyle, csAsmStyle]
    DetectPreprocessor = False
    IdentifierChars = 
      '!"#$%&'#39'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`' +
      'abcdefghijklmnopqrstuvwxyz{|}~'#8364#129#8218#402#8222#8230#8224#8225#710#8240#352#8249#338#141#381#143#144#8216#8217#8220#8221#8226#8211#8212#732#8482#353#8250#339#157#382#376#160 +
      #161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224 +
      #225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255
    KeyWords.Strings = (
      '{'
      '}')
    NumberAttri.Foreground = clBlue
    StringDelim = sdDoubleQuote
    Left = 148
    Top = 72
  end
end
