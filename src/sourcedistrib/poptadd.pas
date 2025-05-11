(*

FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen

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

unit poptadd;

interface

uses
  Classes, ComCtrls, Controls, debugwnd, Dialogs, Forms,
  Graphics, Messages, SharedDLGData, StdCtrls, SysUtils, Variants, Windows;

type
  TForm4 = class(TForm)
    Memo1:                 TMemo;
    Edit1:                 TMemo;
    nodetextpreview:       TMemo;
    GroupBox1:             TGroupBox;
    Memo2:                 TMemo;
    RadioButton1:          TRadioButton;
    RadioButton2:          TRadioButton;
    RadioButton3:          TRadioButton;
    nodetextfemalepreview: TMemo;
    CheckBox1:             TCheckBox;
    CheckBox2:             TCheckBox;
    CheckBox4:             TCheckBox;
    Button1:               TButton;
    Button2:               TButton;
    Button3:               TButton;
    Button4:               TButton;
    Button5:               TButton;
    Button9:               TButton;
    editbtn:               TButton;
    Label1:                TLabel;
    noteslabel:            TLabel;
    Label4:                TLabel;
    Label6:                TLabel;
    Label7:                TLabel;
    Label8:                TLabel;
    Label2:                TLabel;
    Edit2:                 TEdit;
    ComboBox2:             TComboBox;
    ComboBox1:             TComboBox;
    ComboBox4:             TComboBox;
    ComboBox5:             TComboBox;
    Label5:                TLabel;
    Edit3:                 TEdit;
    CheckBox3:             TCheckBox;
    UpDown1:               TUpDown;
    ComboBox3:             TComboBox;
    Label3:                TLabel;
    Label9:                TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure editbtnClick(Sender: TObject);
    procedure nodetextfemalepreviewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure nodetextpreviewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form4:   TForm4;
  nodeind: Integer;

procedure updateconds;

implementation

uses addnode, condcheck, custom_proc_ed, skillcheck_ed;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.Checked = True then
  begin
    Button3.Visible := True;
    // Memo1.Text      := '';
    Label4.Visible := True;
    Edit2.Visible  := True;
    nodetextpreview.Visible := False;
    nodetextfemalepreview.Visible := False;
    label2.Visible := False;
    label6.Visible := False;
    if RadioButton2.Visible = True then
    begin
      RadioButton2.Visible := False;
    end;
    if RadioButton1.Visible = True then
    begin
      RadioButton1.Visible := False;
    end;
    if RadioButton3.Visible = True then
    begin
      RadioButton3.Visible := False;
    end;

    Button3.Enabled := True;
    combobox1.Visible := False;
    combobox4.Visible := False;
    combobox5.Visible := False;
    editbtn.Visible := False;
    button5.Visible := False;
    checkbox2.Checked := False;
    checkbox4.Checked := False;
  end
  else
  begin
    Button3.Visible := False;
    Label4.Visible := False;
    Edit2.Visible := False;

    if (checkbox2.Checked = False) and (checkbox4.Checked = False) then
    begin
      RadioButton1.Visible := True;
      RadioButton2.Visible := True;
      RadioButton3.Visible := True;
      combobox1.Visible := True;
      combobox4.Visible := True;
      combobox5.Visible := True;
      editbtn.Visible := True;
      button5.Visible := True;
      label6.Visible  := True;
      label2.Visible  := True;

      nodetextfemalepreview.Visible := True;
      nodetextpreview.Visible := True;
    end;

  end;

end;

procedure TForm4.ComboBox1Click(Sender: TObject);
var
  i: Integer;
begin
  i := GetNodeIndex(combobox1.Text);
  if i <> -1 then
  begin
    label6.Visible := True;

    if nodetextpreview.Visible = False then
      nodetextpreview.Visible := True;

    nodetextpreview.Text :=
      currentdlg.nodes[i].npctext;
    nodetextfemalepreview.Text := currentdlg.nodes[i].npctext_female;
    if currentdlg.nodes[i].npctext_female = '' then
      nodetextfemalepreview.Text := currentdlg.nodes[i].npctext;

  end
  else
  begin
    nodetextpreview.Text := '';
    label6.Visible := False;
    label2.Visible := False;

  end;

end;

procedure TForm4.Button3Click(Sender: TObject);
var
  nodetext: String;
begin
  try

    // Verify that the new node name is not null
    if (edit2.Text = '') then
    begin
      MessageDlg('Enter a name for the new node.', mtInformation, [mbOK], 0);
      exit;
    end;
    if (GetNodeIndex(edit2.Text) <> -1) then
    begin
      MessageDlg(format('This node already exists at' + #13 + #10 + 'index [%d]', [GetNodeIndex(edit2.Text)]),
        mtWarning, [mbOK], 0);
      exit;
    end;
    new(currentdlg.nodes[currentdlg.nodecount]);
    debugmsg('Attempting to create node at slot ' + IntToStr(currentdlg.nodecount) + ' - NodeIND (edited node) == ' +
      IntToStr(nodeind));
    nodetext := InputBox('Enter text', 'Enter npc text for new node', '');
    currentdlg.nodes[currentdlg.nodecount].hidden := False;
    currentdlg.nodes[currentdlg.nodecount].optioncnt := 0;
    currentdlg.nodes[currentdlg.nodecount].nodename := Edit2.Text;
    currentdlg.nodes[currentdlg.nodecount].npctext := nodetext;
    currentdlg.nodes[currentdlg.nodecount].skillcheckcnt := 0;
    Inc(currentdlg.nodecount);
    debugmsg('Attempting to refresh node list.');
    form3.refreshnodelist;
    CheckBox1.Checked := False;
    ComboBox1.ItemIndex := combobox1.Items.IndexOf(edit2.Text);
    RadioButton2.Checked := True;
    radiobutton2click(nil);
    if combobox1.ItemIndex <> -1 then
      ComboBox1Click(button3);
    edit2.Text := '';
  except
    on E: Exception do
    begin
      debugmsg('Error occured!');
    end;
  end;

end;

procedure TForm4.CheckBox2Click(Sender: TObject);
begin
  if checkbox2.Checked = True then
  begin
    if CheckBox1.Checked = True then
      checkbox1.Checked := False;
    if checkbox4.Checked = True then
      checkbox4.Checked := False;

    RadioButton1.Visible := False;
    RadioButton2.Visible := False;
    RadioButton3.Visible := False;

    Button3.Enabled := False;
    Edit2.Enabled  := False;
    checkbox1.Checked := False;
    ComboBox1.Visible := False;
    combobox4.Visible := False;
    combobox5.Visible := False;
    editbtn.Visible := False;
    button5.Visible := False;
    label6.Visible := False;
    label2.Visible := False;
    nodetextpreview.Visible := False;
    nodetextfemalepreview.Visible := False;

  end else
  begin
    Button3.Enabled := True;
    Edit2.Enabled := True;

    if (checkbox1.Checked = False) and (checkbox4.Checked = False) then
    begin
      RadioButton1.Visible := True;
      RadioButton2.Visible := True;
      combobox1.Visible := True;
      RadioButton3.Visible := True;
      combobox4.Visible := True;
      combobox5.Visible := True;
      editbtn.Visible := True;
      button5.Visible := True;
      label2.Visible  := True;
      label6.Visible  := True;
      nodetextpreview.Visible := True;
      nodetextfemalepreview.Visible := True;
    end;

  end;

end;

procedure TForm4.CheckBox3Click(Sender: TObject);
begin
  if checkbox3.Checked = True then
    UpDown1.Position := defdumbint
  else
    updown1.position := defsmartint;

end;

procedure TForm4.CheckBox4Click(Sender: TObject);
begin
  if checkbox4.Checked = True then
  begin

    Button3.Enabled := False;
    Memo1.Text := '';
    if RadioButton1.Visible = True then
      RadioButton1.Visible := False;
    if RadioButton2.Visible = True then
      RadioButton2.Visible := False;
    if RadioButton3.Visible = True then
      RadioButton3.Visible := False;


    Label4.Visible := False;
    Edit2.Visible  := False;
    // label2.Visible    := False;
    nodetextpreview.Visible := False;
    nodetextfemalepreview.Visible := False;
    label6.Visible := False;
    label2.Visible := False;
    editbtn.Visible := False;
    button5.Visible := False;
    combobox1.Visible := False;
    ComboBox4.Visible := False;
    ComboBox5.Visible := False;
    checkbox1.Checked := False;
    if CheckBox2.Checked = True then
      checkbox2.Checked := False;
  end else
  begin
    Button3.Visible := False;
    Label4.Visible := False;
    Edit2.Visible := False;

    if (checkbox1.Checked = False) and (checkbox2.Checked = False) then
    begin
      RadioButton1.Visible := True;
      RadioButton2.Visible := True;
      RadioButton3.Visible := True;
      combobox1.Visible := True;
      combobox4.Visible := True;
      combobox5.Visible := True;
      editbtn.Visible := True;
      button5.Visible := True;
      label6.Visible  := True;
      label2.Visible  := True;
      nodetextpreview.Visible := True;
      nodetextfemalepreview.Visible := True;
    end;

  end;

end;

function linktostr(lnk: Integer): String;
begin
  case lnk of
    LINKAGE_NONE:
      Result := '';
    LINKAGE_AND:
      Result := 'AND';
    LINKAGE_OR:
      Result := 'OR';
  end;

end;

procedure updateconds;
var
  t: Integer;
begin
  form4.Memo2.Clear;
  if currentdlg.nodes[nodeind].options[lineind].conditioncnt > 0 then
  begin
    for t := 0 to currentdlg.nodes[nodeind].options[lineind].conditioncnt - 1 do
    begin
      if t < currentdlg.nodes[nodeind].options[lineind].conditioncnt - 1 then
      begin
        form4.memo2.Lines.add(currentdlg.nodes[nodeind].options[lineind].conditions[t].resolved_code +
          ' ' + linktostr(currentdlg.nodes[nodeind].options[lineind].conditions[t].link));
      end else
        form4.memo2.Lines.add(currentdlg.nodes[nodeind].options[lineind].conditions[t].resolved_code);
    end;
  end else
    form4.memo2.Text := 'No conditions set for this option.';

end;

procedure TForm4.Button4Click(Sender: TObject);
var
  i, cnt: Integer;
begin
  form16.checktypelist.Clear;
  cnt := condcfg.readinteger('Main', 'CheckTypeCount', 0);

  for i := 0 to cnt - 1 do
    form16.checktypelist.Items.add(condcfg.readstring('Main', 'CheckType' + IntToStr(i + 1), ''));

  form16.checktypelist.ItemIndex := 0;
  form16.checktypelistClick(form4);
  form16.evaltype.ItemIndex := 0;

  form16.sslcode.Caption := '';
  form16.valuetocheck.Text := '';
  refreshconds;
  form16.showmodal;
  updateconds;

end;

procedure TForm4.Button9Click(Sender: TObject);
begin
  set_current_node := True;
  form23.showmodal;
  Form3.RefreshNodelist;
end;

procedure TForm4.RadioButton2Click(Sender: TObject);
begin
  combobox4.Enabled := False;
  ComboBox5.Enabled := False;
  combobox1.Enabled := True;
end;

procedure TForm4.RadioButton1Click(Sender: TObject);
begin
  combobox1.Enabled := False;
  ComboBox5.Enabled := False;
  combobox4.Enabled := True;

end;


procedure RefreshSkillchecks;
var
  i, u: Integer;
begin
  form4.combobox5.Clear;
  for u := 0 to currentdlg.nodecount - 1 do
  begin

    for i := 0 to currentdlg.nodes[u].skillcheckcnt - 1 do
    begin
      form4.ComboBox5.Items.add(currentdlg.nodes[u].skillchecks[i].check_proc_name);
    end;
  end;

end;

procedure TForm4.Button5Click(Sender: TObject);
var
  check: String;
var
  the_node: Integer;
begin
  form24.Edit1.Text := '';
  form24.Memo1.Clear;
  form24.Memo2.Clear;
  form24.UpDown1.Position := 0;
  updatenodelists;
  form24.ComboBox4.ItemIndex := nodeind;
  form24.showmodal;
  if form24.modalresult = mrOk then
  begin
    the_node := form24.combobox4.ItemIndex;
    new(currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt]);
    currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].check_proc_name :=
      form24.Edit1.Text;
    check := form24.edit1.Text;
    currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].check_what :=
      form24.combobox1.ItemIndex + 1;
    currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].modifier :=
      Form24.UpDown1.position;
    currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].successnode :=
      Form24.ComboBox2.Text;
    currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].failurenode :=
      Form24.ComboBox3.Text;
    Inc(currentdlg.nodes[the_node].skillcheckcnt);
    RefreshSkillchecks;
    form4.combobox5.ItemIndex := form4.combobox5.Items.indexof(check);
    if radiobutton3.Checked = False then
    begin
      radiobutton3.Checked := True;
      radiobutton3click(nil);
    end;

  end;

end;

procedure TForm4.RadioButton3Click(Sender: TObject);
begin
  combobox4.Enabled := False;
  ComboBox5.Enabled := True;
  combobox1.Enabled := False;
end;

procedure TForm4.editbtnClick(Sender: TObject);
var
  skcheckind: Integer;
var
  nodeindex, the_node: Integer;
begin
  if form4.combobox5.ItemIndex <> -1 then
  begin
    updatenodelists;
    skcheckind := getskillcheckindex(form4.ComboBox5.Text, nodeindex);
    form24.ComboBox4.ItemIndex := nodeindex;
    form24.Edit1.Text := currentdlg.nodes[nodeindex].skillchecks[skcheckind].check_proc_name;
    form24.ComboBox1.ItemIndex := currentdlg.nodes[nodeindex].skillchecks[skcheckind].check_what - 1;
    Form24.UpDown1.position := currentdlg.nodes[nodeindex].skillchecks[skcheckind].modifier;
    form24.combobox2.ItemIndex := getnodeindex(currentdlg.nodes[nodeindex].skillchecks[skcheckind].successnode);
    form24.combobox3.ItemIndex := getnodeindex(currentdlg.nodes[nodeindex].skillchecks[skcheckind].failurenode);
    form24.ComboBox2Click(nil);
    form24.ComboBox3Click(nil);
    form24.showmodal;
    if form24.modalresult = mrOk then
    begin
      the_node := form24.combobox4.ItemIndex;
      currentdlg.nodes[the_node].skillchecks[skcheckind].check_proc_name :=
        form24.Edit1.Text;
      currentdlg.nodes[the_node].skillchecks[skcheckind].check_what :=
        form24.combobox1.ItemIndex + 1;
      currentdlg.nodes[the_node].skillchecks[skcheckind].modifier :=
        Form24.UpDown1.position;
      currentdlg.nodes[the_node].skillchecks[skcheckind].successnode :=
        Form24.ComboBox2.Text;
      currentdlg.nodes[the_node].skillchecks[skcheckind].failurenode :=
        Form24.ComboBox3.Text;
      RefreshSkillchecks;
      form4.ComboBox5.ItemIndex := form4.combobox5.items.indexof(currentdlg.nodes[the_node].skillchecks[skcheckind].check_proc_name);
    end;
  end else
    MessageDlg('No skill check selected!', mtError, [mbOK], 0);
end;

procedure TForm4.nodetextfemalepreviewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  t: Integer;
begin
  if combobox1.ItemIndex <> -1 then
  begin
    t := getnodeindex(combobox1.Text);
    currentdlg.nodes[t].npctext_female := nodetextfemalepreview.Text;
  end;

end;

procedure TForm4.nodetextpreviewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  t: Integer;
begin
  if combobox1.ItemIndex <> -1 then
  begin
    t := getnodeindex(combobox1.Text);
    currentdlg.nodes[t].npctext := nodetextpreview.Text;
  end;

end;

end.

