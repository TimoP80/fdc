unit define_main;

interface

uses
  CKSLIb, Classes, ComCtrls, Controls, Dialogs, DynamicSkinForm, ExtCtrls, Forms,
  Graphics, IniFiles, Mask, Menus, Messages, ParseInclude, SkinBoxCtrls, SkinCtrls, SkinData,
  SkinHint,
  spCategoryButtons, spDialogs, spSkinShellCtrls, StdCtrls, SysUtils, Variants, Windows, XPMan;
type
  TForm1 = class(TForm)
    ListBox1:     TspSkinListBox;
    TeOpenDialog1: TspSkinOpenDialog;
    TeSaveDialog1: TspSkinSaveDialog;
    spDynamicSkinForm1: TspDynamicSkinForm;
    spSkinData1:  TspSkinData;
    spCompressedStoredSkin1: TspCompressedStoredSkin;
    spResourceStrData1: TspResourceStrData;
    spSkinMainMenuBar1: TspSkinMainMenuBar;
    spSkinMainMenu1: TspSkinMainMenu;
    File1:        TMenuItem;
    Open1:        TMenuItem;
    Save1:        TMenuItem;
    N1:           TMenuItem;
    Quit1:        TMenuItem;
    Help1:        TMenuItem;
    About1:       TMenuItem;
    GroupBox1:    TspSkinGroupBox;
    Panel1:       TspSkinPanel;
    Button3:      TspSkinButton;
    TeButton1:    TspSkinButton;
    Edit1:        TspSkinEdit;
    Edit3:        TspSkinComboBox;
    Edit2:        TspSkinEdit;
    Edit4:        TspSkinEdit;
    TeListView1:  TspSkinListView;
    Label2:       TspSkinLabel;
    Label3:       TspSkinLabel;
    Label4:       TspSkinLabel;
    Label5:       TspSkinLabel;
    spOpenSkinDialog1: TspOpenSkinDialog;
    GUI1:         TMenuItem;
    Changeskin1:  TMenuItem;
    spSkinHint1:  TspSkinHint;
    spSelectSkinDialog1: TspSelectSkinDialog;
    spSkinStatusBar1: TspSkinStatusBar;
    spSkinStatusPanel1: TspSkinStatusPanel;
    spSkinScrollBar1: TspSkinScrollBar;
    spSkinScrollBar2: TspSkinScrollBar;
    spSkinGauge1: TspSkinGauge;
    spSkinProgressDialog1: TspSkinProgressDialog;
    spSkinData2:  TspSkinData;
    spCompressedStoredSkin2: TspCompressedStoredSkin;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CustomItem2Click(Sender: TObject);
    procedure CustomItem3Click(Sender: TObject);
    procedure CustomItem4Click(Sender: TObject);
    procedure TeButton1Click(Sender: TObject);
    procedure CustomItem6Click(Sender: TObject);
    procedure Changeskin1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1:    TForm1;
  prev_ind: integer;

  parser:   TParseInclude;

implementation

uses defedit_about, Math;

{$R *.dfm}
function getincparams(index: integer): string;
var i:    integer;
var temp: string;
begin;
  Result := '';
  for i := 0 to incs[index].paramcnt - 1 do
  begin;
    Result := Result + incs[index].params[i];
    if i < incs[index].paramcnt - 1 then
      Result := Result + ', ';
  end;

end;

procedure SaveDefines(filename: string);
var t: integer;
var x: TStrings;
begin;
  x := TStringList.Create;
  x.add('/* FMF Dialogue Tool code completion defines file */');
  x.add('');
  for t := 0 to inc_cnt - 1 do
  begin;
    if (incs[t].category <> '') and (incs[t].desc <> '') then
      x.add(format('AddDefine %s = %s ' + #13#10 + '  description="%s" category=%s;',
        [incs[t].Name, incs[t].Value, incs[t].desc, incs[t].category])) else
    if (incs[t].category = '') and (incs[t].desc = '') and (incs[t].Value <> '') then
    begin;
      x.add(format('AddDefine %s = %s;', [incs[t].Name, incs[t].Value]));
    end else
    if (incs[t].category = '') and (incs[t].desc = '') and (incs[t].Value = '') and (incs[t].paramcnt > 0) then
    begin;
      x.add(format('AddDefine %s (%s);', [incs[t].Name, getincparams(t)]));
    end;

  end;
  x.savetofile(filename);
end;

function getparams(x: integer): string;
var z: integer;
begin;
  Result := '';
  for z := 0 to incs[x].paramcnt - 1 do
  begin;
    Result := Result + incs[x].params[z];
    if z < incs[x].paramcnt - 1 then
      Result := Result + ', ';
  end;
end;

procedure updatelist;
var t: integer;
begin;
  form1.listbox1.Clear;
  form1.spSkinGauge1.MaxValue := inc_cnt;

  for t := 0 to inc_cnt - 1 do
  begin;
    application.ProcessMessages;

    form1.spSkinGauge1.Value := t;
    if incs[t].paramcnt = 0 then
    begin;
      if incs[t].Value <> '' then

        form1.listbox1.items.add(incs[t].Name + ' (' + incs[t].Value + ')') else
        form1.listbox1.items.add(incs[t].Name);

    end else
    begin;
      form1.listbox1.items.add(incs[t].Name + ' (' + getparams(t) + ')');

    end;

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);

begin

  parser := TParseinclude.Create(Form1);
  updatelist;
  tesavedialog1.InitialDir := extractfiledir(ParamStr(0)) + '\def';
  teopendialog1.InitialDir := extractfiledir(ParamStr(0)) + '\def';
end;
function getParamType(z: integer): string;
begin;
  case z of
    PTYPE_OBJECTPTR:
      Result := 'object';
    PTYPE_STRING:
      Result := 'string';
    PTYPE_INTEGER:
      Result := 'int';
    PTYPE_PROCPTR:
      Result := 'proc_ptr';
  end;

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var x:   integer;
var str: string;
var z:   TListItem;
begin

  if button3.Enabled = True then button3click(NIL);

  prev_ind := listbox1.ItemIndex;


  TeListView1.Clear;
  edit1.Text      := incs[listbox1.ItemIndex].Name;
  edit4.Text      := incs[listbox1.ItemIndex].desc;
  edit3.ItemIndex := edit3.items.indexof(incs[listbox1.ItemIndex].category);
  edit2.Text      := incs[listbox1.ItemIndex].Value;


  if incs[listbox1.ItemIndex].paramcnt > 0 then
  begin;
    for x := 0 to incs[listbox1.ItemIndex].paramcnt - 1 do
    begin;
      z         := telistview1.items.add;
      z.Caption := getParamType(incs[listbox1.ItemIndex].paramtype[x]);
      z.subitems.add(incs[listbox1.ItemIndex].params[x]);
    end;

  end;

  if (pos('PID_', edit1.Text) <> 0) and (incs[listbox1.ItemIndex].desc = '') then
  begin;

    str        := edit1.Text;
    str        := StringReplace(str, 'PID_', '', [rfReplaceAll]);
    str        := StringReplace(str, '_', ' ', [rfReplaceAll]);
    str        := NameCase(str);
    edit4.Text := str;
  end;

  button3.Enabled := True;

end;

procedure TForm1.Button3Click(Sender: TObject);
var t: integer;
begin
  if listbox1.selcount > 1 then
  begin;
    for t := 0 to listbox1.Items.Count - 1 do
    begin;
      if listbox1.selected[t] = True then
      begin;
        incs[t].category := edit3.Text;
      end;

    end;

  end else
  begin;

    if prev_ind <> -1 then
    begin;
      incs[prev_ind].Name     := edit1.Text;
      incs[prev_ind].desc     := edit4.Text;
      incs[prev_ind].category := edit3.Text;
      incs[prev_ind].Value    := edit2.Text;
      if incs[prev_ind].paramcnt > 0 then
        listbox1.items[prev_ind] := edit1.Text + ' (' + getparams(prev_ind) + ')' else

        listbox1.items[prev_ind] := edit1.Text + ' (' + edit2.Text + ')';
    end;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var the_str, str: string;
var i:            integer;
var cnt:          integer;
begin
  cnt := 0;
  for i := 0 to inc_cnt - 1 do
  begin;
    the_str := incs[i].Name;
    if (pos('PID_', the_str) <> 0) and (incs[i].desc = '') then
    begin;

      str          := the_str;
      str          := StringReplace(str, 'PID_', '', [rfReplaceAll]);
      str          := StringReplace(str, '_', ' ', [rfReplaceAll]);
      str          := NameCase(str);
      incs[i].category := 'unsorted';
      incs[i].desc := str;
      Inc(cnt);
    end;
  end;
  ShowMessage('Generate process completed. ' + #13#10 + #13#10 + IntToStr(cnt) + ' entries processed.');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  halt;

end;

procedure TForm1.CustomItem2Click(Sender: TObject);
begin
  if TeOpenDialog1.Execute then
  begin;
    inc_cnt := 0;
    parser.sourcefilename := teopendialog1.filename;
    parser.Execute;
    updatelist;
    spSkinStatusPanel1.Caption := IntToStr(inc_cnt) + ' define entries loaded from ' + teopendialog1.filename;
  end;

end;

procedure TForm1.CustomItem3Click(Sender: TObject);
begin

  halt;

end;

procedure TForm1.CustomItem4Click(Sender: TObject);
begin
  if tesavedialog1.Execute then
  begin;
    SaveDefines(tesavedialog1.filename);
  end;

end;

procedure TForm1.TeButton1Click(Sender: TObject);
begin

  incs[inc_cnt].Name     := edit1.Text;
  incs[inc_cnt].desc     := edit4.Text;
  incs[inc_cnt].category := edit3.Text;
  incs[inc_cnt].Value    := edit2.Text;
  Inc(inc_cnt);
  updatelist;
end;

procedure TForm1.CustomItem6Click(Sender: TObject);
begin
  form2.Show;

end;

procedure TForm1.Changeskin1Click(Sender: TObject);
begin
  if spSelectSkinDialog1.Execute(Form1.spSkinData1.CompressedStoredSkin) then
  begin;

    Form1.spSkinData1.CompressedStoredSkin := spSelectSkinDialog1.SelectedSkin;

  end;

end;

end.

