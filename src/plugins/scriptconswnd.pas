unit scriptconswnd;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Inifiles, JvAppIniStorage, JvAppStorage, JvAppXMLStorage, JvComponent, JvExStdCtrls, JvFormPlacement,
  JvRichEdit, Messages, pluginfunc,  StdCtrls, SysUtils, Variants, Windows;
type
  TForm1 = class(TForm)
    Button1:      TButton;
    Edit1:        TEdit;
    Button2:      TButton;
    Label1:       TLabel;
    Memo2:        TMemo;
    Button3:      TButton;
    Button4:      TButton;
    Memo1:        TMemo;
    Bevel1:       TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1:       TForm1;
  cmdhist:     array of string;
  cmdhistsize: integer;
  historypos:  integer;
  config:      TInifile;

implementation

uses consconf;

{$R *.dfm}

procedure AddCommandToHistory(str: string);
begin;
  setlength(cmdhist, cmdhistsize + 1);
  cmdhist[cmdhistsize] := str;
  historypos           := cmdhistsize;
  Inc(cmdhistsize);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  form1.hide;
  
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
  if button2.Caption = '>> Script' then
  begin;
    edit1.Visible   := False;
    form1.Height    := 500;
    button2.Caption := '<< Command';
    button3.Visible := True;
    Memo2.Visible   := True;
  end else
  begin;
    button2.Caption := '>> Script';
    button3.Visible := False;
    form1.Height    := 359;
    memo2.Visible   := False;
    edit1.Visible   := True;
  end;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
var cmd:  string;
var line: string;
begin
  if key = #13 then
  begin;

    // A few predefined commands which need no script
    // syntax, just <command> [<parameter>]

    if pos('cd', lowercase(edit1.Text)) = 1 then
    begin

      line := '>>> ' + edit1.Text;
      form1.memo1.Lines.add(line);
      if pos(' ', edit1.Text) <> 0 then
      begin;
        senddebugmsg('CONTAINS SPACE!');
        cmd := copy(edit1.Text, pos(' ', edit1.Text) + 1, length(edit1.Text));
        ExecuteScriptLines(PChar('cd(''' + cmd + ''');'));
      end else
        form1.memo1.Lines.add('Current dir is: ' + getcurrentdir);

    end else

    if pos('help', lowercase(edit1.Text)) = 1 then
    begin;
      line := '>>> ' + edit1.Text;
      form1.memo1.Lines.add(line);
      if pos(' ', edit1.Text) <> 0 then
      begin;
        cmd := copy(edit1.Text, pos(' ', edit1.Text) + 1, length(edit1.Text));
        ExecuteScriptLines(PChar('GetHelp(''' + cmd + ''');'));
      end else

        ExecuteScriptLines('Help;');
    end else
    begin;
      line := '>>> ' + edit1.Text;
      form1.memo1.Lines.add(line);
      ExecuteScriptLines(PChar(Edit1.Text));
    end;
    AddCommandToHistory(edit1.Text);
    edit1.Text := '';

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  memo1.Lines.add('FMF Dialogue tool Script command console v1.0 initialized.');
  memo1.Lines.add('Type "Help" to list commands.');

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  form1.Memo1.Lines.add('>>> [Sent script, ' + IntToStr(memo2.Lines.Count) + ' lines.]');
  executescriptlines(PChar(Memo2.Text));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  form1.Height := 359;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  memo2.Clear;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin;

end;



procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin

  case key of
    VK_UP:

    begin;
      edit1.Clear;
      if cmdhistsize = 0 then exit;
      edit1.Text := cmdhist[historypos];
      if historypos = 0 then
        historypos := 0 else
        Dec(historypos);
    end;
    VK_DOWN:
    begin;
      edit1.Clear;
      if cmdhistsize = 0 then exit;
      edit1.Text := cmdhist[historypos];
      if historypos = cmdhistsize - 1 then
      begin;
        historypos := cmdhistsize - 1;
      end else
        Inc(historypos);

    end;
  end;
end;

end.

