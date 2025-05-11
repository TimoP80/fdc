(*

Fallout Dialogue Creator  - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2025 T. Pitkänen

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

*)

unit addnode;

interface

uses
  Classes,
  VCL.ComCtrls,
  VCL.Controls,
  debugwnd,
  VCL.Dialogs,
  VCL.Forms,
  VCL.Graphics,
  Messages,
  pluginapi,
  SharedDLGData,
  VCL.StdCtrls,
  strutils_,
  SysUtils,
  Variants,
  Windows;

type
  TForm3 = class(TForm)
    Label1:        TLabel;
    npctext:       TMemo;
    Label2:        TLabel;
    Label3:        TLabel;
    designernotes: TMemo;
    Label4:        TLabel;
    Label5:        TLabel;
    Memo1:         TMemo;
    optionsdata:   TListView;
    Edit1:         TEdit;
    CheckBox1:     TCheckBox;
    isstartnode:   TCheckBox;
    Button1:       TButton;
    Button2:       TButton;
    Button3:       TButton;
    Button4:       TButton;
    Button5:       TButton;
    Button6:       TButton;
    Button7:       TButton;
    Button8:       TButton;
    Button9:       TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure optionsdataDblClick(Sender: TObject);
    procedure RefreshNodelist;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure optionsdataClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form3:          TForm3;
  globalnodename: String;

var
  lineind:  Integer;
  temp_opt: option;

procedure RefreshPlayerOptions;
procedure EditOption(node: String; option: Integer);

implementation

uses
  custom_proc_ed,
  fmfmain,
  customcodeedit,
  dlged,
  poptadd;

var
  tx: TListItem;

{$R *.dfm}

procedure RefreshPlayerOptions;

var
  y: Integer;
begin
  form3.optionsdata.Clear;
  for y := 0 to currentdlg.nodes[nodeind].optioncnt - 1 do
  begin
    tx := form3.optionsdata.items.add;

    tx.Caption := IntToStr(y + 1);
    tx.subitems.add(currentdlg.nodes[nodeind].options[y].optiontext);
    tx.subitems.add(currentdlg.nodes[nodeind].options[y].nodelink);

  end;

end;

procedure TForm3.Button1Click(Sender: TObject);
var
  get_it: Integer;
  validnode: Boolean;
  errormsgs: String;
  x, t: Integer;
begin
  get_it := GetNodeIndex(form3.edit1.Text);
  if form3.Edit1.Text = '' then
  begin
    MessageDlg('Please specify a name for this node!' + #13 + #10 + 'Empty node names will cause trouble.',
      mtWarning, [mbOK], 0);
    exit;
  end
  else

  if (get_it <> -1) and (nodeind <> get_it) then
  begin
    MessageDlg(format('The specified node ''%s'' already exists.' + #13 + #10 + 'Please pick a unique node name.', [form3.edit1.Text]),
      mtWarning, [mbOK], 0);
    exit;
  end;

  validnode := IsValidNodeName(form3.edit1.Text, errormsgs);
  if validnode = False then
  begin
    MessageDlg(format('Warning: Node name does not seem to be valid.' + #13 + #10 + '(ie scripting compatible)' +
      #13 + #10 + '' + #13 + #10 + '%s', [errormsgs]), mtWarning, [mbOK], 0);
    exit;

  end;

  debugmsg('CurrentNodeName: ' + form3.edit1.Text + ' Previous: ' + currentdlg.nodes[nodeind].nodename);
  globalnodename := form3.edit1.Text;
  if (form3.edit1.Text <> currentdlg.nodes[nodeind].nodename) and (currentdlg.nodes[nodeind].nodename <> '') then
  begin
    // IMPORTANT NOTE!

    // Add code here to remap any other places as well,
    // such as starting conditions

    debugmsg('Node names differ... Remapping player options.');

    (*for x := 0 to currentdlg.startconditioncnt - 1 do
    begin
    end;*)


    for x := 0 to currentdlg.nodecount - 1 do
    begin
      if autonodemap = True then
        currentdlg.nodes[x].notes :=
          StringReplace(currentdlg.nodes[x].notes, currentdlg.nodes[nodeind].nodename, globalnodename, [rfReplaceAll]);
      //debugmsg('Going through node '+currentdlg.nodes[x].nodename);

      for t := 0 to currentdlg.nodes[x].skillcheckcnt - 1 do
      begin

        if (currentdlg.nodes[x].skillchecks[t].successnode = currentdlg.nodes[nodeind].nodename) then
        begin
          debugmsg('Remapped success node of ' + currentdlg.nodes[x].skillchecks[t].check_proc_name);
          currentdlg.nodes[x].skillchecks[t].successnode := globalnodename;
        end;

        if (currentdlg.nodes[x].skillchecks[t].failurenode = currentdlg.nodes[nodeind].nodename) then
        begin
          debugmsg('Remapped failure node of ' + currentdlg.nodes[x].skillchecks[t].check_proc_name);
          currentdlg.nodes[x].skillchecks[t].failurenode := globalnodename;
        end;

      end;


      for t := 0 to currentdlg.nodes[x].optioncnt - 1 do
      begin
        //debugmsg('Player option '+inttostr(t)+' points to: '+currentdlg.nodes[x].options[t].nodelink);
        if (currentdlg.nodes[x].options[t].nodelink = currentdlg.nodes[nodeind].nodename) then
        begin
          debugmsg('Remapped option ' + IntToStr(t) + ' of node ' + currentdlg.nodes[x].nodename);
          if autonodemap = True then
            currentdlg.nodes[x].options[t].notes :=
              StringReplace(currentdlg.nodes[x].options[t].notes, currentdlg.nodes[nodeind].nodename,
              globalnodename, [rfReplaceAll]);

          currentdlg.nodes[x].options[t].nodelink := globalnodename;
        end;
      end;

    end;

  end;
  modalresult := mrOk;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TForm3.RefreshNodelist;
var
  i, U: Integer;
var
  nodeind: Integer;
begin
  if form2.listview1.Selected <> nil then
    nodeind := form2.listview1.Selected.index
  else
    nodeind := currentdlg.nodecount;


  form4.ComboBox1.Clear;
  form4.ComboBox4.Clear;
  form4.ComboBox5.Clear;
  for u := 0 to currentdlg.nodecount - 1 do
  begin
    // list only allocated, non-null nodenames excluding the currently edited node
    if (u <> nodeind) and (currentdlg.nodes[u].nodename <> '') and (currentdlg.nodes[u] <> nil) then
      form4.combobox1.Items.Add(currentdlg.nodes[u].nodename);
    if currentdlg.nodes[u].skillcheckcnt > 0 then
    begin
      for i := 0 to currentdlg.nodes[u].skillcheckcnt - 1 do
      begin
        form4.ComboBox5.Items.add(currentdlg.nodes[u].skillchecks[i].check_proc_name);
      end;
    end;

  end;
  for u := 0 to currentdlg.customproccnt - 1 do
  begin
    form4.ComboBox4.items.add(currentdlg.customprocs[u].Name);
  end;

  form4.combobox1.ItemIndex := 0;
end;


procedure EditOption(node: String; option: Integer);
var
  nodeind: Integer;
var
  lineind: Integer;
begin
  nodeind := GetNodeIndex(node);
  if nodeind = -1 then
  begin
    MessageDlg(format('Error!' + #13 + #10 + '' + #13 + #10 + 'Requested node %s for player' + #13 +
      #10 + 'option editing does not exist.', [node]), mtError, [mbOK], 0);
    exit;
  end;

  form3.RefreshNodeList;
  form4.Caption := 'Edit playeroption';
  lineind := option;
  form4.Edit1.Text := currentdlg.nodes[nodeind].options[lineind].optiontext;

  form4.ComboBox1.ItemIndex :=
    form4.combobox1.items.indexof(currentdlg.nodes[nodeind].options[lineind].nodelink);
  form4.ComboBox2.ItemIndex := currentdlg.nodes[nodeind].options[lineind].genderflags;
  form4.ComboBox3.ItemIndex := currentdlg.nodes[nodeind].options[lineind].reaction;
  form4.ComboBox1click(nil);
  form4.UpDown1.Position := currentdlg.nodes[nodeind].options[lineind].intcheck;
  form4.Memo1.Text := currentdlg.nodes[nodeind].options[lineind].notes;
  if (form4.ComboBox1.ItemIndex = -1) and (currentdlg.nodes[nodeind].options[lineind].nodelink <> 'done') and
    (currentdlg.nodes[nodeind].options[lineind].nodelink <> 'combat') then
  begin
    form4.CheckBox1.Checked := True;
    form4.Edit2.Text := currentdlg.nodes[nodeind].options[lineind].nodelink;

  end;

  if currentdlg.nodes[nodeind].options[lineind].nodelink = 'done' then
    form4.CheckBox2.Checked := True
  else
    form4.CheckBox2.Checked := False;
  if currentdlg.nodes[nodeind].options[lineind].nodelink = 'combat' then
    form4.checkbox4.Checked := True
  else
    form4.checkbox4.Checked := False;
  if form4.nodetextpreview.Visible = False then
    form4.nodetextpreview.Visible := True;

  form4.Memo1.Text := stringreplace(form4.memo1.Text, '\n', #13#10, [rfReplaceAll]);
  //form4.ComboBox1.text := extractword(1, line,['|']);
  Form4.ShowModal;
  if form4.ModalResult = mrOk then
  begin
    currentdlg.nodes[nodeind].options[lineind].optiontext := Form4.edit1.Text;
    if form4.checkbox2.Checked = True then
      currentdlg.nodes[nodeind].options[lineind].nodelink := 'done'
    else
    if form4.checkbox4.Checked = True then
      currentdlg.nodes[nodeind].options[lineind].nodelink := 'combat'
    else

      currentdlg.nodes[nodeind].options[lineind].nodelink := form4.combobox1.Text;

    currentdlg.nodes[nodeind].options[lineind].notes := Form4.Memo1.Text;
    currentdlg.nodes[nodeind].options[lineind].intcheck := Form4.UpDown1.Position;
    currentdlg.nodes[nodeind].options[lineind].reaction := form4.ComboBox3.ItemIndex;
    currentdlg.nodes[nodeind].options[lineind].genderflags :=
      form4.ComboBox2.ItemIndex;


    //      RefreshPlayerOptions;
  end;

  //MessageDlg('Accept!', mtWarning, [mbOK], 0);
  // optionsdata.Lines[lineind] := format('%s|%s|%s', [form4.Edit1.Text, temp2, temp]);

  RequestPluginRefresh;
  form4.Memo1.Clear;
  form4.ComboBox1.Clear;
  form4.edit2.Text := '';
  form4.edit1.Text := '';
  form4.CheckBox1.Checked := False;

end;

procedure TForm3.Button3Click(Sender: TObject);
var
  temp2, temp: String;
begin
  form4.Caption := 'Add player option';
  refreshnodelist;
  form4.checkbox1.Checked := True;
  new(currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]);
  lineind := currentdlg.nodes[nodeind].optioncnt;
  currentdlg.nodes[nodeind].options[lineind].conditioncnt := 0;
  currentdlg.nodes[nodeind].options[lineind].link_to_proc := False;
  currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck := False;
  updateconds;
  form4.combobox3.ItemIndex := 0;
  form4.combobox2.ItemIndex := 0;
  form4.UpDown1.Position := defsmartint;

  form4.showmodal;

  form4.ComboBox1Click(button3);
  if form4.modalresult = mrOk then
  begin
    dlgchanged := True;
    form1.Caption := 'FMF Dialogue Tool - [' + currentfile + '*]';
    debugmsg('Adding player option to NODE: ' + IntToStr(nodeind));

    currentdlg.nodes[nodeind].options[lineind].optiontext :=
      Form4.edit1.Text;
    if (form4.RadioButton1.Checked = True) then
    begin
      currentdlg.nodes[nodeind].options[lineind].nodelink :=
        form4.combobox4.Text;
      currentdlg.nodes[nodeind].options[lineind].link_to_proc :=
        True;
    end
    else
    if (form4.RadioButton2.Checked = True) then
    begin
      currentdlg.nodes[nodeind].options[lineind].nodelink :=
        form4.combobox1.Text;
      currentdlg.nodes[nodeind].options[lineind].link_to_proc :=
        False;

    end;

    if (form4.CheckBox2.Checked = True) then
      currentdlg.nodes[nodeind].options[lineind].nodelink :=
        'done';
    if form4.CheckBox4.Checked = True then
      currentdlg.nodes[nodeind].options[lineind].nodelink :=
        'combat';

    currentdlg.nodes[nodeind].options[lineind].notes :=
      Form4.Memo1.Text;
    currentdlg.nodes[nodeind].options[lineind].intcheck :=
      Form4.UpDown1.Position;
    currentdlg.nodes[nodeind].options[lineind].reaction :=
      form4.ComboBox3.ItemIndex;
    currentdlg.nodes[nodeind].options[lineind].genderflags :=
      form4.ComboBox2.ItemIndex;
    Inc(currentdlg.nodes[nodeind].optioncnt);


    RefreshPlayerOptions;
  end;
  form4.Memo1.Clear;
  form4.ComboBox1.Clear;
  form4.edit2.Text := '';
  form4.edit1.Text := '';
  form4.CheckBox1.Checked := False;
  form4.CheckBox3.Checked := False;

end;

procedure TForm3.optionsdataDblClick(Sender: TObject);
var
  line: String;
var
  temp, temp2: String;
begin
  //showmessage(format('Caret x=%d y=%d',[optionsdata.CaretPos.x,optionsdata.caretpos.y]));
  if optionsdata.selected = nil then
  begin
    Button3Click(nil);
  end
  else
  begin
    RefreshNodeList;
    form4.Caption := 'Edit player option';
    lineind := optionsdata.selected.index;
    form4.Edit1.Text := currentdlg.nodes[nodeind].options[lineind].optiontext;

    case currentdlg.nodes[nodeind].options[lineind].genderflags of
      GENDER_NONE:
        Form4.ComboBox2.ItemIndex := GENDER_NONE;
      GENDER_FEMALE:
        Form4.ComboBox2.ItemIndex := GENDER_FEMALE;
      GENDER_MALE:
        Form4.ComboBox2.ItemIndex := GENDER_MALE;
    end;
    form4.ComboBox3.ItemIndex := currentdlg.nodes[nodeind].options[lineind].reaction;
    form4.UpDown1.Position := currentdlg.nodes[nodeind].options[lineind].intcheck;
    form4.Memo1.Text := currentdlg.nodes[nodeind].options[lineind].notes;
    if (currentdlg.nodes[nodeind].options[lineind].link_to_proc = True) and
      (currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck = False) then
    begin
      Form4.RadioButton1.Checked := True;
      form4.RadioButton1Click(nil);
      Form4.ComboBox4.ItemIndex := Form4.ComboBox4.Items.IndexOf(currentdlg.nodes[nodeind].options[lineind].nodelink);

    end
    else
    if (currentdlg.nodes[nodeind].options[lineind].link_to_proc = False) and
      (currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck = True) then
    begin
      Form4.RadioButton3.Checked := True;
      form4.RadioButton3Click(nil);
      Form4.ComboBox5.ItemIndex := Form4.ComboBox5.Items.IndexOf(currentdlg.nodes[nodeind].options[lineind].nodelink);

    end
    else
    if (currentdlg.nodes[nodeind].options[lineind].link_to_proc = False) and
      (currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck = False) then
    begin
      Form4.RadioButton2.Checked := True;
      form4.RadioButton2Click(nil);
      form4.ComboBox1.ItemIndex := form4.ComboBox1.items.IndexOf(currentdlg.nodes[nodeind].options[lineind].nodelink);
      form4.ComboBox1click(nil);
    end;


    if (form4.ComboBox1.ItemIndex = -1) and (currentdlg.nodes[nodeind].options[lineind].nodelink <> 'done') and
      (currentdlg.nodes[nodeind].options[lineind].nodelink <> 'combat') then
    begin
      form4.CheckBox1.Checked := True;
      form4.Edit2.Text := currentdlg.nodes[nodeind].options[lineind].nodelink;
    end;

    if currentdlg.nodes[nodeind].options[lineind].nodelink = 'done' then
      form4.CheckBox2.Checked := True
    else
      form4.CheckBox2.Checked := False;
    if currentdlg.nodes[nodeind].options[lineind].nodelink = 'combat' then
      form4.checkbox4.Checked := True
    else
      form4.checkbox4.Checked := False;

    form4.Label2.Visible := (form4.checkbox1.Checked = False) and (form4.checkbox2.Checked = False) and
      (form4.checkbox4.Checked = False);

    form4.Label6.Visible := (form4.checkbox1.Checked = False) and (form4.checkbox2.Checked = False) and
      (form4.checkbox4.Checked = False);

    form4.nodetextpreview.Visible := (form4.checkbox1.Checked = False) and (form4.checkbox2.Checked = False) and
      (form4.checkbox4.Checked = False);
    form4.nodetextfemalepreview.Visible :=
      (form4.checkbox1.Checked = False) and (form4.checkbox2.Checked = False) and (form4.checkbox4.Checked = False);

    form4.checkbox3.Checked := (currentdlg.nodes[nodeind].options[lineind].intcheck = defdumbint);

    form4.Memo1.Text := stringreplace(form4.memo1.Text, '\n', #13#10, [rfReplaceAll]);
    //form4.ComboBox1.text := extractword(1, line,['|']);
    updateconds;

    Form4.ShowModal;
    if form4.ModalResult = mrOk then
    begin
      currentdlg.nodes[nodeind].options[lineind].optiontext := Form4.edit1.Text;

      if form4.checkbox2.Checked = True then
        currentdlg.nodes[nodeind].options[lineind].nodelink := 'done'
      else
      if form4.checkbox4.Checked = True then
        currentdlg.nodes[nodeind].options[lineind].nodelink := 'combat'
      else

      //      currentdlg.nodes[nodeind].options[lineind].nodelink := form4.combobox1.Text;

      if (form4.RadioButton1.Checked = True) then
      begin
        currentdlg.nodes[nodeind].options[lineind].nodelink :=
          form4.combobox4.Text;
        currentdlg.nodes[nodeind].options[lineind].link_to_proc :=
          True;
        currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck :=
          False;

      end
      else

      if (form4.RadioButton3.Checked = True) then
      begin
        currentdlg.nodes[nodeind].options[lineind].nodelink :=
          form4.combobox5.Text;
        currentdlg.nodes[nodeind].options[lineind].link_to_proc :=
          False;
        currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck :=
          True;

      end
      else


      if (form4.RadioButton2.Checked = True) then
      begin
        currentdlg.nodes[nodeind].options[lineind].nodelink :=
          form4.combobox1.Text;
        currentdlg.nodes[nodeind].options[lineind].link_to_proc :=
          False;
        currentdlg.nodes[nodeind].options[lineind].link_to_skillcheck :=
          False;
      end;



      currentdlg.nodes[nodeind].options[lineind].notes := Form4.Memo1.Text;
      currentdlg.nodes[nodeind].options[lineind].intcheck := Form4.UpDown1.Position;

      currentdlg.nodes[nodeind].options[lineind].reaction := form4.ComboBox3.ItemIndex;
      currentdlg.nodes[nodeind].options[lineind].genderflags :=
        form4.ComboBox2.ItemIndex;


      RefreshPlayerOptions;
    end;

    //MessageDlg('Accept!', mtWarning, [mbOK], 0);
    // optionsdata.Lines[lineind] := format('%s|%s|%s', [form4.Edit1.Text, temp2, temp]);

  end;
  form4.ComboBox1.Clear;
  form4.edit2.Text := '';
  form4.edit1.Text := '';
  form4.CheckBox1.Checked := False;
  form4.Memo1.Clear;

end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.Checked = True then
    Memo1.Enabled := True
  else
    memo1.Enabled := False;

end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  if optionsdata.selected <> nil then
  begin
    Deleteplayeroption(nodeind, optionsdata.selected.index);
    RefreshPlayerOptions;
  end;

end;

procedure TForm3.Button5Click(Sender: TObject);
var
  prev_index: Integer;
  movenodeind: Integer;
  movetonodeind: Integer;
  j: Integer;
begin
  if optionsdata.ItemIndex = 0 then
  begin
    optionsdata.SetFocus;
    exit;
  end;
  prev_index  := optionsdata.selected.Index;
  movenodeind := optionsdata.Selected.index;
  movetonodeind := optionsdata.items[optionsdata.selected.index - 1].index;

  temp_opt := currentdlg.nodes[nodeind].options[movenodeind]^;
  currentdlg.nodes[nodeind].options[movenodeind]^ :=
    currentdlg.nodes[nodeind].options[movetonodeind]^;
  currentdlg.nodes[nodeind].options[movetonodeind]^ := temp_opt;
  RefreshPlayerOptions;
  optionsdata.ItemIndex := movetonodeind;
  optionsdata.selected  := optionsdata.items[optionsdata.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  optionsdata.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm3.Button6Click(Sender: TObject);
var
  prev_index:  Integer;
  movenodeind: Integer;
  movetonodeind: Integer;
begin
  if optionsdata.ItemIndex = optionsdata.items.Count - 1 then
  begin
    optionsdata.SetFocus;
    exit;
  end;

  prev_index := optionsdata.selected.Index;
  movenodeind := optionsdata.Selected.index;
  movetonodeind := optionsdata.items[optionsdata.selected.index + 1].index;
  temp_opt := currentdlg.nodes[nodeind].options[movenodeind]^;
  currentdlg.nodes[nodeind].options[movenodeind]^ :=
    currentdlg.nodes[nodeind].options[movetonodeind]^;
  currentdlg.nodes[nodeind].options[movetonodeind]^ := temp_opt;
  RefreshPlayerOptions;
  optionsdata.ItemIndex := movetonodeind;
  optionsdata.selected  := optionsdata.items[optionsdata.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  optionsdata.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm3.optionsdataClick(Sender: TObject);
begin
  if optionsdata.selected = nil then
  begin
    Button5.Enabled := False;
    Button6.Enabled := False;
  end
  else
  begin
    button5.Enabled := True;
    Button6.Enabled := True;
  end;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  if optionsdata.selected <> nil then
    optionsdataDblClick(form3);
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  form25.SynMemo1.Text := currentdlg.nodes[nodeind].customcode;
  form25.showmodal;
  if form25.modalresult = mrOk then
  begin
    currentdlg.nodes[nodeind].customcode := Form25.SynMemo1.Text;
  end;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  edit1.Text := format('Node%0.3d', [currentdlg.nodecount]);
end;

end.

