unit updunit;

interface

uses
 dialogs, controls,Inifiles,SysUtils, Classes, mxWebUpdate;

type
  TDataModule1 = class(TDataModule)
    mxWebUpdate1: TmxWebUpdate;
    procedure mxWebUpdate1UpdateAvailable(Sender: TObject; ActualVersion,
      NewVersion: String; var CanUpdate: Boolean);
    procedure mxWebUpdate1NoUpdateFound(Sender: TObject);
    procedure mxWebUpdate1DownloadError(Sender: TObject);
    procedure mxWebUpdate1BeforeDownload(Sender: TObject;
      FileName: String);
    procedure mxWebUpdate1Download(Sender: TObject; Total,
      Downloaded: Integer);
    procedure mxWebUpdate1GetClientFileName(Sender: TObject;
      var FileName: String);
    procedure mxWebUpdate1BeforeShowInfo(Sender: TObject; var ShowInfo,
      CheckForUpdate: Boolean);
    procedure mxWebUpdate1AfterDownload(Sender: TObject; FileName: String);
    procedure mxWebUpdate1ClientFileExists(Sender: TObject;
      var FileName: String; var Overwrite: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  cfg: TInifile;
implementation

uses updform;

{$R *.dfm}

procedure TDataModule1.mxWebUpdate1UpdateAvailable(Sender: TObject;
  ActualVersion, NewVersion: String; var CanUpdate: Boolean);
begin
form1.curver.caption := actualversion;
form1.availver.caption := newversion;
canupdate := (MessageDlg('New update found!'+#13+#10+''+#13+#10+'Do you wish to download it?', mtInformation, [mbYes, mbNo], 0) = mrYes);

if canupdate=true then
begin;
if MessageDlg('Do you wish to run the update after it has been downloaded?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
mxWebUpdate1.Options := [uoRunUpdate, uoOverwrite];
end else
mxWebUpdate1.Options := [uoOverwrite];

end;

procedure TDataModule1.mxWebUpdate1NoUpdateFound(Sender: TObject);
begin
form1.curver.caption := mxwebupdate1.productinfo.version;
form1.availver.caption := 'N/A';
Form1.status.Caption := 'No updates available.';
end;

procedure TDataModule1.mxWebUpdate1DownloadError(Sender: TObject);
begin
form1.curver.caption := mxwebupdate1.productinfo.version;
form1.availver.caption := 'N/A';
Form1.status.Caption := 'Error while retrieving update info.';
end;

procedure TDataModule1.mxWebUpdate1BeforeDownload(Sender: TObject;
  FileName: String);
begin

Form1.status.Caption := 'Getting '+extractfilename(filename);

end;

procedure TDataModule1.mxWebUpdate1Download(Sender: TObject; Total,
  Downloaded: Integer);
begin

Form1.progress.Caption := format('%d bytes / %d bytes',[downloaded, total]);
form1.JvGradientProgressBar1.Max := total;
form1.JvGradientProgressBar1.Position := downloaded;
end;

procedure TDataModule1.mxWebUpdate1GetClientFileName(Sender: TObject;
  var FileName: String);
begin
filename := thepath+'\downloads\'+extractfilename(filename);

end;

procedure TDataModule1.mxWebUpdate1BeforeShowInfo(Sender: TObject;
  var ShowInfo, CheckForUpdate: Boolean);
begin
showinfo := (MessageDlg('Do you wish to view release notes?', mtWarning, [mbYes, mbNo], 0) = mrYes);
end;

procedure TDataModule1.mxWebUpdate1AfterDownload(Sender: TObject;
  FileName: String);
begin
form1.status.caption := 'Done.';
form1.progress.caption := '';
form1.JvGradientProgressBar1.Position := 0;
//showmessage('Updated to version: '+mxWebUpdate1.ProductVersion);
cfg.writestring('Beta Version Information','CurrentVersion',mxwebupdate1.ProductVersion);
end;

procedure TDataModule1.mxWebUpdate1ClientFileExists(Sender: TObject;
  var FileName: String; var Overwrite: Boolean);
begin
overwrite := true;
end;

end.
