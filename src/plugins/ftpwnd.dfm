object form1: Tform1
  Left = 426
  Top = 142
  Width = 384
  Height = 435
  Caption = 'Upload current dialogue'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object JvMarkupLabel1: TJvMarkupLabel
    Left = 8
    Top = 16
    Width = 361
    Height = 161
    Text = 
      '<u>Information</u><br>Dialogue filename: <b>%s</b><br> NPC Name:' +
      ' <b>%s</b><br> Location: <b>%s</b><br> Description:<b>%s</b><br>' +
      ' Number of nodes: <b>%d</b>'
  end
  object Label2: TLabel
    Left = 8
    Top = 264
    Width = 151
    Height = 13
    Caption = 'Folder to upload the file to:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 192
    Width = 361
    Height = 41
    AutoSize = False
  end
  object Label3: TLabel
    Left = 8
    Top = 304
    Width = 25
    Height = 13
    Caption = 'URL:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 312
    Top = 368
    Width = 57
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 368
    Width = 89
    Height = 25
    Caption = 'Upload'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 280
    Width = 361
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnClick = ComboBox1Click
    Items.Strings = (
      '')
  end
  object Button3: TButton
    Left = 104
    Top = 368
    Width = 81
    Height = 25
    Caption = 'Remove File'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 240
    Width = 361
    Height = 17
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 8
    Top = 320
    Width = 361
    Height = 41
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
  end
  object Button4: TButton
    Left = 192
    Top = 368
    Width = 81
    Height = 25
    Caption = 'Get folders'
    TabOrder = 6
    OnClick = Button4Click
  end
  object FtpClient1: TFtpClient
    Timeout = 15
    MultiThreaded = False
    HostName = 'www.fanmadefallout.com'
    Port = '21'
    DataPortRangeStart = 0
    DataPortRangeEnd = 0
    LocalAddr = '0.0.0.0'
    UserName = 'fmfteam@fanmadefallout.com '
    PassWord = 'f23mer4'
    DisplayFileFlag = False
    Binary = False
    ShareMode = ftpShareExclusive
    Options = []
    ConnectionType = ftpDirect
    OnDisplay = FtpClient1Display
    OnError = FtpClient1Error
    OnResponse = FtpClient1Response
    OnProgress = FtpClient1Progress
    OnSessionConnected = FtpClient1SessionConnected
    OnReadyToTransmit = FtpClient1ReadyToTransmit
    IcsLogger = IcsLogger1
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Left = 8
    Top = 216
  end
  object IcsLogger1: TIcsLogger
    LogFileOption = lfoAppend
    LogFileName = 'ftp.log'
    LogOptions = [loDestEvent, loDestFile, loDestOutDebug, loAddStamp, loWsockErr, loWsockInfo, loWsockDump, loSslErr, loSslInfo, loSslDump, loProtSpecErr, loProtSpecInfo, loProtSpecDump]
    Left = 168
    Top = 192
  end
end
