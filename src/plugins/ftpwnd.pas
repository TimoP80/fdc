unit ftpwnd;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, Forms,
  Graphics, JclFileUtils, JvComponent, JvExControls, JvMarkupLabel, Messages, pluginfunc,
  StdCtrls,
  SysUtils, Variants, Windows, OverbyteIcsWndControl, OverbyteIcsFtpCli,
  OverbyteIcsLogger;

type
  Tform1 = class(TForm)
    JvMarkupLabel1: TJvMarkupLabel;
    Button1:        TButton;
    FtpClient1:     TFtpClient;
    Button2:        TButton;
    ComboBox1:      TComboBox;
    Label2:         TLabel;
    Button3:        TButton;
    ProgressBar1:   TProgressBar;
    Label1:         TLabel;
    Label3:         TLabel;
    Memo1:          TMemo;
    Button4:        TButton;
    IcsLogger1:     TIcsLogger;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FtpClient1Display(Sender: TObject; var Msg: string);
    procedure FtpClient1SessionConnected(Sender: TObject; Error: word);
    procedure ComboBox1Click(Sender: TObject);
    procedure FtpClient1Progress(Sender: TObject; Count: integer; var Abort: boolean);
    procedure Button3Click(Sender: TObject);
    procedure FtpClient1ReadyToTransmit(Sender: TObject; var bCancel: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FtpClient1Error(Sender: TObject; var Msg: string);
    procedure FtpClient1Response(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form1:         Tform1;
  the_dlg:       pnewdialogue;
  url:           string;
  labeltemplate: string;

procedure InitData;

implementation

uses Math;

{$R *.dfm}

procedure InitData;
begin
  ;
  new(the_dlg);

  the_dlg := GetDLGNew;
  labeltemplate := form1.jvmarkuplabel1.Text;
  form1.ftpclient1.HostFileName := extractfilename(the_dlg.filename);
  form1.FtpClient1.HostDirName := '/dialogue/' + form1.ComboBox1.Text;
  url := 'http://www.fanmadefallout.com/project/dialogue/' +
    form1.ComboBox1.Text + '/' + form1.ftpclient1.HostFileName;

  Form1.JvMarkupLabel1.Text :=
    format(labeltemplate, [the_dlg.filename, the_dlg.npcname,
    the_dlg.location, the_dlg.description, the_dlg.nodecount]);
  form1.Memo1.Text := url;

end;

procedure Tform1.Button2Click(Sender: TObject);
begin

  FtpClient1.OnError := ftpclient1.OnDisplay;

  ftpclient1.Connect;
  if ftpclient1.connected = True then
  begin

    ftpclient1.Pwd;
    ftpclient1.TypeSet;

    ftpclient1.LocalFileName := the_dlg.filename;
    ftpclient1.Size;
    ftpclient1.Cwd;
    ftpclient1.Put;
    ftpclient1.Quit;
    // ftpclient1.;

  end;

end;

procedure Tform1.Button1Click(Sender: TObject);
begin
  form1.Close;
end;

procedure Tform1.FtpClient1Display(Sender: TObject; var Msg: string);
begin
  senddebugmsg(PChar(msg));
  Label1.Caption := msg;
end;

procedure Tform1.FtpClient1SessionConnected(Sender: TObject; Error: word);
begin
  senddebugmsg(PChar('Successfully connected to ' + ftpclient1.HostName));

end;

procedure Tform1.ComboBox1Click(Sender: TObject);
begin
  ftpclient1.HostDirName := 'dialogue/' + combobox1.Text;
  url := 'http://www.fanmadefallout.com/project/dialogue/' +
    form1.ComboBox1.Text + '/' + form1.ftpclient1.HostFileName;
  form1.JvMarkupLabel1.Text :=
    format(labeltemplate, [the_dlg.filename, the_dlg.npcname,
    the_dlg.location, the_dlg.description, the_dlg.nodecount]);
  memo1.Text := url;

end;

procedure Tform1.FtpClient1Progress(Sender: TObject; Count: integer; var Abort: boolean);
begin
  ProgressBar1.Position := Count;

end;

procedure Tform1.Button3Click(Sender: TObject);
begin
  ftpclient1.Connect;
  if ftpclient1.connected = True then
  begin
    ;
    ftpclient1.Pwd;
    ftpclient1.TypeSet;
    ftpclient1.LocalFileName := the_dlg.filename;
    ftpclient1.Cwd;
    ftpclient1.Dele;
    ftpclient1.Quit;
  end;

end;

procedure Tform1.FtpClient1ReadyToTransmit(Sender: TObject; var bCancel: boolean);
begin
  ProgressBar1.Max := filegetsize(ftpclient1.LocalFileName);
  ProgressBar1.Position := 0;
end;

procedure Tform1.FormDestroy(Sender: TObject);
begin
  senddebugmsg('Form destroys!');

end;
function ParseFTPDirData (str: string; whattoreturn: integer): ;
begin
end;

procedure Tform1.Button4Click(Sender: TObject);
var
  res: boolean;
begin
  IcsLogger1.OpenLogFile;
  FtpClient1.OnError := ftpclient1.OnDisplay;
  senddebugmsg('Connecting ... ');

  res := FtpClient1.Open;
  if res = False then
  begin
    senddebugmsg('error, something went wrong!');
    senddebugmsg(PChar('host=' + ftpclient1.HostName));
    senddebugmsg(PChar('dnsresult=' + ftpclient1.DnsResult));

    senddebugmsg(PChar(FtpClient1.errormessage));
  end else if res = True then
    senddebugmsg('connect ok!');

  if ftpclient1.connected = True then
  begin
    senddebugmsg('Connected!');
    ftpclient1.User;
    ftpclient1.Pass;
    ftpclient1.Pwd;
    ftpclient1.HostDirName := 'dialogue';
    ftpclient1.Cwd;

    ftpclient1.LocalFileName := 'filedata.txt';
    ftpclient1.dir;
  //  combobox1.Items.LoadFromFile('filedata.txt');
  //  combobox1.items.Delete(ComboBox1.Items.IndexOf('.'));
  //  combobox1.items.Delete(ComboBox1.Items.IndexOf('..'));

    ftpclient1.Quit;
    // ftpclient1.;

  end;
  IcsLogger1.closeLogFile;
end;

procedure Tform1.FtpClient1Error(Sender: TObject; var Msg: string);
begin
  senddebugmsg(PChar('Error: ' + msg));
end;

procedure Tform1.FtpClient1Response(Sender: TObject);
begin
  //  senddebugmsg(PChar(FtpClient1.LastResponse));
end;

end.

