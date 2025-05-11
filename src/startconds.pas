unit startconds;

interface

uses
  Classes,
  gvarparse, ComCtrls, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Inifiles, Messages, shareddlgdata, StdCtrls, SysUtils, Variants, Windows;

type
  TForm22 = class(TForm)
    Label1:    TLabel;
    ListView1: TListView;
    Button1:   TButton;
    GroupBox1: TGroupBox;
    Button2:   TButton;
    Label3:    TLabel;
    Edit1:     TEdit;
    Label4:    TLabel;
    ComboBox2: TComboBox;
    Label5:    TLabel;
    Label7:    TLabel;
    ComboBox3: TComboBox;
    Bevel1:    TBevel;
    Button5:   TButton;
    Label6:    TMemo;
    Label10:   TLabel;
    ComboBox5: TComboBox;
    Label11:   TLabel;
    ListBox1:  TListBox;
    GroupBox2: TGroupBox;
    Label9:    TLabel;
    Label8:    TLabel;
    ComboBox4: TComboBox;
    Memo1:     TMemo;
    Button3:   TButton;
    Button4:   TButton;
    Button6:   TButton;
    Button7:   TButton;
    Button8:   TButton;
    ComboBox1: TComboBox;
    Label2:    TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form22:         TForm22;
  conds_cfg:      TIniFile;
  set_as_default: boolean;
  Value:          string;
  sel_inisect:    string;
  globalselector, selection: string;
  eval:           integer;

procedure refresh_start_conditions;
procedure update_visibilities;
procedure UpdateTextPreview;

implementation

uses helpscreen;


{$R *.dfm}

procedure TForm22.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
end;

function GetEval(eval_type: integer): string;
begin
  ;
  case eval_type of
    COMPARE_EQUAL:
      Result := '==';
    COMPARE_NOT_EQUAL:
      Result := '!=';
    COMPARE_LARGER_THAN:
      Result := '>';
    COMPARE_LESS_THAN:
      Result := '<';
    COMPARE_LARGER_THAN_OR_EQUAL:
      Result := '>=';
    COMPARE_LESS_THAN_OR_EQUAL:
      Result := '<=';
  end;
end;

procedure update_code;
var
  section: string;
  codestr: string;
begin
  ;
  eval  := form22.ComboBox2.ItemIndex;
  section := form22.combobox1.Text;
  Value := form22.Edit1.Text;
  selection := form22.combobox3.Text;

  if globalselector = 'inisect' then
    selection := conds_cfg.ReadString(sel_inisect, 'item' +
      IntToStr(form22.combobox3.ItemIndex + 1), '');

  form22.label6.Text := conds_cfg.ReadString(section, 'data',
    '<error: no data defined>');
  form22.label6.Text := StringReplace(form22.label6.Text, '%eval%',
    GetEval(eval), [rfReplaceAll]);

  form22.label6.Text := StringReplace(form22.label6.Text, '%value%',
    Value, [rfReplaceAll]);
  form22.label6.Text := StringReplace(form22.label6.Text, '%selection%',
    selection, [rfReplaceAll]);
end;

procedure TForm22.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;

end;

procedure TForm22.FormCreate(Sender: TObject);
begin
  conds_cfg := TInifile.Create(extractfiledir(ParamStr(0)) + '\start_conditions.ini');
end;

procedure TForm22.FormShow(Sender: TObject);
var
  t: integer;
var
  cnt: integer;
begin
  cnt := conds_cfg.ReadInteger('Condition Types', 'count', 0);
  Form22.combobox1.Clear;
  for t := 1 to cnt do
  begin
    ;
    form22.combobox1.Items.add(conds_cfg.readstring('Condition Types',
      'cond' + IntToStr(t), ''));
  end;
  form22.ComboBox4.Clear;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    ;
    form22.ComboBox4.Items.add(currentdlg.nodes[t].nodename);
  end;
  for t := 0 to currentdlg.floatnodecount - 1 do
  begin
    ;
    form22.ComboBox4.Items.add(currentdlg.floatnodes[t].nodename);
  end;

end;

procedure TForm22.ComboBox1Click(Sender: TObject);
var
  section: string;
var
  hide_data_ctrl, haseval, do_selector: boolean;
var
  selector: string;
var
  i: integer;
begin
  section := combobox1.Text;
  do_selector := (conds_cfg.ReadString(section, 'selector', '') <> '');
  haseval := conds_cfg.ReadBool(section, 'haseval', True);
  hide_data_ctrl := conds_cfg.ReadBool(section, 'hide_data_entry', False);
  set_as_default := conds_cfg.ReadBool(section, 'do_setdefault', False);
  if (hide_data_ctrl = True) then
  begin
    ;
    label3.hide;
    edit1.hide;
  end else
  begin
    ;
    Label3.Show;
    edit1.Show;
  end;

  label4.Visible := haseval;
  combobox2.Visible := haseval;

  label6.Text := conds_cfg.ReadString(section, 'data', '<error: no data defined>');
  if do_selector = True then
  begin
    ;
    label7.Show;
    combobox3.Show;
    combobox3.Clear;
    selector := conds_cfg.ReadString(section, 'selector', '');
    label7.Caption := conds_cfg.ReadString(section, 'selectorcaption', '');
    if (selector = 'scriptvars') then
    begin
      ;
      for i := 0 to currentdlg.varcnt - 1 do
      begin
        ;
        combobox3.Items.add(currentdlg.variables[i].Name);
      end;

    end;

  end else
  begin
    ;
    label7.hide;
    combobox3.hide;
  end;
  update_code;
end;

procedure TForm22.ComboBox3Click(Sender: TObject);
begin
  update_code;

end;

procedure TForm22.ComboBox2Click(Sender: TObject);
begin
  update_code;

end;

procedure TForm22.Edit1Change(Sender: TObject);
begin
  update_code;

end;

procedure refresh_start_conditions;
var
  t: integer;
var
  x: TListItem;
begin
  ;
  Form22.ListView1.Clear;
  for t := 0 to currentdlg.startconditioncnt - 1 do
  begin
    ;
    x := form22.ListView1.Items.add;
    x.Caption := IntToStr(t + 1);
    x.SubItems.add(IntToStr(currentdlg.startconditions[t].condcnt));
    x.SubItems.add(currentdlg.startconditions[t].goto_node);

  end;
end;

procedure TForm22.Button3Click(Sender: TObject);
var
  t: integer;
begin

  AddStartCondition(combobox4.Text, set_as_default);
  refresh_start_conditions;
  t := currentdlg.startconditioncnt - 1;
  listview1.selected := ListView1.Items.Item[t];
  listview1click(nil);
  listview1.SetFocus;
end;

procedure TForm22.Button5Click(Sender: TObject);
begin
  if ListView1.selected <> nil then
  begin
    ;
    DeleteStartCond(listview1.Selected.index);
    refresh_start_conditions;
  end;

end;

procedure updatecondlist;
var
  t: integer;
begin
  ;
  form22.ListBox1.Clear;
  for t := 0 to currentdlg.startconditions[form22.listview1.selected.index].condcnt
    - 1 do
  begin
    ;
    form22.listbox1.Items.add(
      currentdlg.startconditions[form22.listview1.selected.index].conditions[t].resultcode);
  end;

end;

procedure TForm22.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    ;
    updatecondlist;
    combobox4.ItemIndex := combobox4.Items.IndexOf(
      currentdlg.startconditions[listview1.selected.index].goto_node);

    button4.Enabled := True;
    updatetextpreview;
  end else
  begin
    ;
    button4.Enabled := False;
    //  ComboBox1.ItemIndex := -1;
    combobox3.ItemIndex := -1;
    edit1.Text  := '';
    label6.Text := '';
    combobox5.ItemIndex := -1;
    listbox1.Clear;
    memo1.Clear;
    combobox4.ItemIndex := -1;
  end;
  groupbox1.Visible := (ListView1.selected <> nil);
end;


procedure update_visibilities;
var
  section: string;
var
  hide_data_ctrl, haseval, do_selector: boolean;
var
  selector: string;
var
  i: integer;
begin
  if form22.combobox1.Text = '' then
    exit;

  section := form22.combobox1.Text;
  do_selector := (conds_cfg.ReadString(section, 'selector', '') <> '');
  haseval := conds_cfg.ReadBool(section, 'haseval', True);
  hide_data_ctrl := conds_cfg.ReadBool(section, 'hide_data_entry', False);
  set_as_default := conds_cfg.ReadBool(section, 'do_setdefault', False);
  if (hide_data_ctrl = True) then
  begin
    ;
    form22.label3.hide;
    form22.edit1.hide;
  end else
  begin
    ;
    form22.Label3.Show;
    form22.edit1.Show;
  end;

  form22.label4.Visible := haseval;
  form22.combobox2.Visible := haseval;

  form22.label6.Text := conds_cfg.ReadString(section, 'data',
    '<error: no data defined>');
  if do_selector = True then
  begin
    ;
    form22.label7.Show;
    form22.combobox3.Show;
    form22.combobox3.Clear;
    selector := conds_cfg.ReadString(section, 'selector', '');
    globalselector := selector;
    form22.label7.Caption := conds_cfg.ReadString(section, 'selectorcaption', '');
    if (selector = 'inisect') then
    begin
      ;
      sel_inisect := conds_cfg.ReadString(section, 'inisect', '');

      for i := 0 to conds_cfg.ReadInteger(sel_inisect, 'count', 0) - 1 do
      begin
        ;
        form22.combobox3.Items.add(conds_cfg.ReadString(sel_inisect,
          'itemdisplay' + IntToStr(i + 1), ''));
      end;
    end else
    if (selector = 'globalvars') then
    begin
      ;
      for i := 0 to gvarcount - 1 do
      begin
        ;
        form22.combobox3.Items.add(gvars[i].Name);
      end;

    end else

    if (selector = 'scriptvars') then
    begin
      ;
      for i := 0 to currentdlg.varcnt - 1 do
      begin
        ;
        if (currentdlg.variables[i].flags = VAR_FLAGS_NONE) then
          form22.combobox3.Items.add(currentdlg.variables[i].Name);
      end;

    end else
    if (selector = 'localvars') then
    begin
      ;
      for i := 0 to currentdlg.varcnt - 1 do
      begin
        ;
        if (currentdlg.variables[i].flags = VAR_FLAGS_LOCAL) then
          form22.combobox3.Items.add(currentdlg.variables[i].Name);
      end;

    end;
  end else
  begin
    ;
    form22.label7.hide;
    form22.combobox3.hide;
  end;
  update_code;
end;

procedure TForm22.ComboBox1Change(Sender: TObject);
begin
  update_visibilities;
end;

procedure TForm22.Button4Click(Sender: TObject);
begin
  currentdlg.startconditions[ListView1.ItemIndex].goto_node := combobox4.Text;
  refresh_start_conditions;
end;

procedure UpdateTextPreview;
var
  gh, i: integer;
begin
  gh := GetNodeIndex(form22.combobox4.Text);
  if (gh = -1) then
  begin
    ;
    gh := GetFloatNodeIndex(form22.combobox4.Text);
    if gh <> -1 then
    begin
      ;

      form22.Memo1.Text :=
        '[Displays one of the following random messages from float node "' +
        currentdlg.floatnodes[gh].nodename + '"]';
      for i := 0 to currentdlg.floatnodes[gh].messagecnt - 1 do
      begin
        ;
        form22.Memo1.Text := form22.memo1.Text + #13#10 +
          currentdlg.floatnodes[gh].Messages[i];
      end;

    end;

  end else
  begin
    ;
    form22.memo1.Text := currentdlg.nodes[gh].npctext;
  end;

end;


procedure TForm22.ComboBox4Change(Sender: TObject);
begin
  ;
  UpdateTextPreview;
end;

procedure TForm22.ListBox1Click(Sender: TObject);
begin
  if listview1.selected = nil then
    exit;

  if listbox1.ItemIndex <> -1 then
  begin
    ;
    combobox1.ItemIndex := currentdlg.startconditions[
      listview1.selected.index].conditions[listbox1.ItemIndex].index_of_selection;
    edit1.Text := currentdlg.startconditions[
      listview1.selected.index].conditions[listbox1.ItemIndex].compareto;
    combobox2.ItemIndex := currentdlg.startconditions[
      listview1.selected.index].conditions[listbox1.ItemIndex].evaluator;
    update_visibilities;
    combobox3.ItemIndex := ComboBox3.Items.IndexOf(
      currentdlg.startconditions[listview1.selected.index].conditions[
      listbox1.ItemIndex].parameter);
    combobox5.ItemIndex := currentdlg.startconditions[
      listview1.selected.index].conditions[listbox1.ItemIndex].linkage;

    update_code;
  end;

end;

procedure TForm22.Button6Click(Sender: TObject);
var
  saveind: integer;
begin
  AddCondsToSC(form22.label6.Text, ListView1.Selected.Index,
    ComboBox1.ItemIndex, combobox3.Text,
    combobox2.ItemIndex, edit1.Text, combobox5.ItemIndex);
  saveind := Listview1.Selected.index;
  updatecondlist;
  refresh_start_conditions;
  //  listview1.Selected := saveind;
  listview1.ItemIndex := saveind;
end;

procedure TForm22.Button8Click(Sender: TObject);
begin
  if (listview1.selected <> nil) and (listbox1.ItemIndex <> -1) then
  begin
    ;

    setcondtosc(listbox1.ItemIndex, Label6.Text, ListView1.selected.Index,
      ComboBox1.ItemIndex, combobox3.Text,
      combobox2.ItemIndex, edit1.Text, combobox5.ItemIndex);
    updatecondlist;
  end;
end;

procedure TForm22.Button7Click(Sender: TObject);
begin
  if (listview1.selected <> nil) and (listbox1.ItemIndex <> -1) then
  begin
    ;
    DeleteCondFromSCStartCond(ListView1.selected.index, listbox1.ItemIndex);
    updatecondlist;
  end;

end;



procedure TForm22.CheckBox1Click(Sender: TObject);
var
  show_wtg: boolean;
var
  t: integer;
begin
  form22.ComboBox4.Clear;
  show_wtg := checkbox1.Checked;

  if show_wtg = True then
  begin
    ;
    for t := 0 to currentdlg.nodecount - 1 do
    begin
      ;
      if currentdlg.nodes[t].is_wtg = True then
        form22.ComboBox4.Items.add(currentdlg.nodes[t].nodename);
    end;
  end else
  begin
    ;
    for t := 0 to currentdlg.nodecount - 1 do
    begin
      ;
      form22.ComboBox4.Items.add(currentdlg.nodes[t].nodename);
    end;
  end;



  for t := 0 to currentdlg.floatnodecount - 1 do
  begin
    ;
    form22.ComboBox4.Items.add(currentdlg.floatnodes[t].nodename);
  end;

end;

end.

