object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 604
  Top = 235
  Height = 150
  Width = 215
  object mxWebUpdate1: TmxWebUpdate
    TagInfo.Author = 'mxAuthor'
    TagInfo.Email = 'mxEmail'
    TagInfo.ClientFileName = 'mxClientSideName'
    TagInfo.Download = 'mxDownload'
    TagInfo.ProductName = 'mxProduct'
    TagInfo.Redirection = 'mxRedirection'
    TagInfo.RunParameters = 'mxRunParameters'
    TagInfo.Version = 'mxVersion'
    ProductInfo.URL = 'http://www.djunique.org/fmfdlgtool/betaupdate.htm'
    ProductInfo.Version = '0.24-beta1'
    ProductInfo.VersionFormat = vfString
    InfoCaption.OkButton = '&OK'
    InfoCaption.CancelButton = '&Cancel'
    InfoCaption.CheckForUpdate = 'C&heck for updates in the future'
    Options = [uoOverwrite]
    Version = '1.2'
    OnBeforeDownload = mxWebUpdate1BeforeDownload
    OnAfterDownload = mxWebUpdate1AfterDownload
    OnUpdateAvailable = mxWebUpdate1UpdateAvailable
    OnGetClientFileName = mxWebUpdate1GetClientFileName
    OnClientFileExists = mxWebUpdate1ClientFileExists
    OnBeforeShowInfo = mxWebUpdate1BeforeShowInfo
    OnNoUpdateFound = mxWebUpdate1NoUpdateFound
    OnDownload = mxWebUpdate1Download
    OnDownloadError = mxWebUpdate1DownloadError
    Left = 56
    Top = 48
  end
end
