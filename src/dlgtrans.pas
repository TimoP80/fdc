unit dlgtrans;

interface

uses
  debugwnd,shareddlgdata,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvRichEdit;

type
  TForm13 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    JvRichEdit1: TJvRichEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;
  trans_index: integer;

implementation

{$R *.dfm}
uses fmfmain;

procedure SaveTranscript (ind: integer);
var s: textfile;
var z: integer;
begin


 if dlgtranscriptcnt > 0 then
  begin
    if directoryexists(extractfiledir(ParamStr(0)) + '\dialogue\history') = False then
    begin
      debugmsg('History folder "' + extractfiledir(ParamStr(0)) +
        '\dialogue\history' + '" did not exist, creating.');
      MkDir(extractfiledir(ParamStr(0)) + '\dialogue\history');

    end;

      debugmsg('Saving history ' + dlgtranscripts[ind].histname);
      try
        assignfile(s, dlgtranscripts[ind].histname);
        rewrite(s);
        for z := 0 to dlgtranscripts[ind].linecnt - 1 do
        begin
          dlgtranscripts[ind].Lines[z] :=
            StringReplace(dlgtranscripts[ind].Lines[z], 'Player',
            player.Name, [rfReplaceAll]);

          dlgtranscripts[ind].Lines[z] :=
            StringReplace(dlgtranscripts[ind].Lines[z], 'NPC',
            currentdlg.npcname, [rfReplaceAll]);
          writeln(s, dlgtranscripts[ind].Lines[z]);

        end;
        closefile(s);
      showmessage('Dialogue transcript saved to:'+#13#10+dlgtranscripts[ind].histname);
      except on e: Exception do
        begin
          MessageDlg(format('Error while saving dialog transcript #%d:' +
            #13 + #10 + '' + #13 + #10 + '%s' + #13 + #10 + '' + #13 +
            #10 + 'Filename: %s', [ind + 1, e.message, dlgtranscripts[ind].histname]),
            mtWarning, [mbOK], 0);
        end;
      end;

    end;



end;



procedure TForm13.Button1Click(Sender: TObject);
begin
form13.hide;
end;

procedure TForm13.Button2Click(Sender: TObject);
begin
SaveTranscript(trans_index);

end;

end.
