unit ParseSSLTest;

interface

uses
  Windows, Messages,SimpleSSLParser, SysUtils, Variants, Classes, Graphics, Controls, Forms,
msgparser,inifiles, Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    log_output: TMemo;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    OpenDialog2: TOpenDialog;
    Label2: TLabel;
    ListView1: TListView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
 config: TInifile;

procedure debug(str: string);


implementation

procedure debug(str: string);
begin
  form1.log_output.Lines.add(str);
end;

{$R *.dfm}
procedure updatenodes;
var y: TListItem;
x: integer;
begin
  form1.ListView1.Clear;
  for x:=0 to sslcount-1 do
  begin
    y := form1.ListView1.Items.add;
    y.Caption := ssldata[x].nodename;
    y.SubItems.add(ssldata[x].reply_params);
    y.SubItems.add(inttostr(ssldata[x].optioncnt));

  end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
begin



  parsesslfile(OpenDialog1.filename);
  updatenodes;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if opendialog2.execute then
begin
  themsg := tmsgparser.create(nil);
  themsg.sourcefilename := opendialog2.FileName;
  themsg.Execute;
  if themsg.Successful then
  begin
    debug('Parsed msg file, '+inttostr(CurrentMessageFile.entrycnt)+' entries found.');
  end;
end;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 config:=Tinifile.Create('./ssltester.cfg');
 Opendialog1.InitialDir := config.readstring('Main','SSLPath','');
 Opendialog2.InitialDir := config.readstring('Main','MSGPath','');

end;

end.
