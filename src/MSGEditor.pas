unit MSGEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  strutils_,
  Dialogs, JvComponentBase, JvExControls, JvGradient,
  MSGParser,
  ComCtrls, JvExComCtrls, JvListView, Menus, JvMenus,
  XPMan, jvDialogs, StdCtrls;

type
  TForm1 = class(TForm)
    JvListView1: TJvListView;
    JvGradient1: TJvGradient;
    JvMainMenu1: TJvMainMenu;
    File1:     TMenuItem;
    Quit1:     TMenuItem;
    Help1:     TMenuItem;
    About1:    TMenuItem;
    XPManifest1: TXPManifest;
    Newmessagefile1: TMenuItem;
    LoadMSG1:  TMenuItem;
    SaveMSG1:  TMenuItem;
    N1:        TMenuItem;
    JvOfficeMenuItemPainter1: TJvOfficeMenuItemPainter;
    JvOpenDialog1: TJvOpenDialog;
    ools1:     TMenuItem;
    Outputpreview1: TMenuItem;
    Button1:   TButton;
    Button2:   TButton;
    Button3:   TButton;
    Label1:    TLabel;
    Edit1:     TEdit;
    Label2:    TLabel;
    Edit2:     TEdit;
    Label3:    TLabel;
    Memo1:     TMemo;
    CheckBox1: TCheckBox;
    Memo2:     TMemo;
    procedure Quit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoadMSG1Click(Sender: TObject);
    procedure JvListView1InfoTip(Sender: TObject; Item: TListItem; var InfoTip: String);
    procedure Outputpreview1Click(Sender: TObject);
    procedure Newmessagefile1Click(Sender: TObject);
    procedure JvListView1Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form1:     TForm1;
  msgparser: TMSGParser;

implementation

uses MSGPreview;



{$R *.dfm}

procedure UpdateEntries;
var
  t: Integer;
  listitem: TListItem;
begin
  form1.JvListView1.Items.Clear;

  for t := 0 to CurrentMessageFile.entrycnt - 1 do
  begin
    listitem := Form1.JvListView1.Items.Add;
    listitem.Caption := IntToStr(CurrentMessageFile.entries[t].index);
    listitem.SubItems.Add(currentmessagefile.entries[t].voicefile);
    listitem.SubItems.Add(currentmessagefile.entries[t].messagestr);
  end;

end;

procedure TForm1.Quit1Click(Sender: TObject);
begin

  form1.Close;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  msgparser := TMSGParser.Create(form1);

end;

procedure TForm1.LoadMSG1Click(Sender: TObject);
begin
  if JvOpenDialog1.Execute then
  begin
    msgparser.SourceFileName := jvopendialog1.FileName;
    msgparser.Execute;
    if msgparser.successful then
    begin
      UpdateEntries;
    end;

  end;

end;

procedure TForm1.JvListView1InfoTip(Sender: TObject; Item: TListItem; var InfoTip: String);
begin
  infotip := WrapText(item.SubItems[1], #13#10, [], 40);
end;

procedure TForm1.Outputpreview1Click(Sender: TObject);
var
  x, t: Integer;
  cnt:  Integer;
  Data, curstr: String;
  comments: String;
  split: TStrings;
begin
  form2.SynEdit1.Clear;
  split := TStringList.Create;
  for t := 0 to CurrentMessageFile.entrycnt - 1 do
  begin
    // empty line after each section

    if CurrentMessageFile.entries[t].beforeline_comments.Count > 0 then
    begin
      //  if (t > 0) then
      //    form2.SynEdit1.Lines.Add('');
      //   comments := stringreplace(comments, #13, #13#10, [rfReplaceAll]);
      for x := 0 to CurrentMessageFile.entries[t].beforeline_comments.Count - 1 do
      begin
        synaddline(CurrentMessageFile.entries[t].beforeline_comments.Comments[x]);
      end;

    end;

    if pos(#13, CurrentMessageFile.entries[t].messagestr) <> 0 then
    begin
      Data := CurrentMessageFile.entries[t].messagestr;
      Data := StringReplace(Data, #13#10, '|', [rfReplaceAll]);
      if extractword(1, Data, ['|']) = '' then
      begin
        Delete(Data, 1, 1);
      end;

      //  ShowMessage('data == ' + Data);
      cnt := wordcount(Data, ['|']);

    //  ShowMessage(IntToStr(cnt) + ' splits.');
      if cnt > 1 then
      begin

        for x := 1 to cnt do
        begin
          curstr := extractword(x, Data, ['|']);
          if curstr <> '' then
          begin
            if x = 1 then
            begin
              synaddline(format('{%d}{%s}{%s', [CurrentMessageFile.entries[t].index,
                CurrentMessageFile.entries[t].voicefile, curstr]));
            end else
            if x = cnt then
            begin
              curstr := curstr + '}';
              synaddline(curstr);
            end else
              synaddline(curstr);
          end;
        end;

      end else
      begin
          curstr := extractword(1, Data, ['|']);
          synaddline(format('{%d}{%s}{%s}', [CurrentMessageFile.entries[t].index,
                CurrentMessageFile.entries[t].voicefile, curstr]));

      end;


    end
    else
    begin
      curstr := CurrentMessageFile.entries[t].messagestr;
      synaddline(format('{%d}{%s}{%s}', [CurrentMessageFile.entries[t].index, CurrentMessageFile.entries[t].voicefile, curstr]));
    end;

    if CurrentMessageFile.entries[t].add_linebreak = True then
      form2.SynEdit1.Lines.Add('');

  end;

  form2.showmodal;

end;

procedure TForm1.Newmessagefile1Click(Sender: TObject);
begin
  CurrentMessageFile.entrycnt := 0;
  UpdateEntries;
end;

procedure TForm1.JvListView1Click(Sender: TObject);
var
  msgind: Integer;
begin
  if jvlistview1.selected <> nil then
  begin
    msgind := JvListView1.selected.Index;
    Edit1.Text := IntToStr(CurrentMessageFile.entries[msgind].index);
    Edit2.Text := CurrentMessageFile.entries[msgind].voicefile;
    Memo1.Text := CurrentMessageFile.entries[msgind].messagestr;
    memo2.Text := CurrentMessageFile.entries[msgind].beforeline_comments.Text;
  end;

end;

end.
