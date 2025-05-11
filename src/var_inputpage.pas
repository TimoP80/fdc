(*

Fallout Dialogue Creator - dialogue editor for Fallout 2 mods
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

unit var_inputpage;

interface

uses
  Classes, CodeSnippets, ComCtrls, condcheck, Controls, debugwnd, Dialogs, Forms,
  Graphics, JvComponent, JvExComCtrls,
  GVarParse, JvExControls, JvPageList, JvPageListTreeView, Masks, Messages, ParseInclude, SharedDLGData,
  StdCtrls, SysUtils, Variants, Windows;
type
  TForm26 = class(TForm)
    JvPageList1:      TJvPageList;
    StringInputPage:  TJvStandardPage;
    CurrentParamCaption: TLabel;
    Memo1:            TMemo;
    NodeInputPage:    TJvStandardPage;
    ComboBox1:        TComboBox;
    Label1:           TLabel;
    Memo2:            TMemo;
    Button1:          TButton;
    Button2:          TButton;
    IntegerInput:     TJvStandardPage;
    Edit1:            TEdit;
    UpDown1:          TUpDown;
    FloatNodeInputPage: TJvStandardPage;
    Memo3:            TMemo;
    Label2:           TLabel;
    ComboBox2:        TComboBox;
    Label3:           TLabel;
    Label4:           TLabel;
    Label5:           TLabel;
    Label6:           TLabel;
    BooleanInputPage: TJvStandardPage;
    Label7:           TLabel;
    ComboBox3:        TComboBox;
    SkillSelectInputPage: TJvStandardPage;
    Label8:           TLabel;
    ListBox1:         TListBox;
    StatSelectInputPage: TJvStandardPage;
    Label9:           TLabel;
    ListBox2:         TListBox;
    VarInputPage:     TJvStandardPage;
    Label10:          TLabel;
    ListBox3:         TListBox;
    GeneralInputPage: TJvStandardPage;
    Label11:          TLabel;
    ListBox4:         TListBox;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form26:        TForm26;
  current_param: integer;
  current_code:  integer;
  code_string:   string;
procedure updateparams;

implementation

uses Math;

{$R *.dfm}
procedure updateparams;
var t: integer;
begin
  if current_param < codesnippetdata[current_code].ParamCount - 1 then

    form26.button1.Caption := 'Next parameter' else
  begin
    form26.button1.Caption := 'OK';

  end;
  if current_param > codesnippetdata[current_code].ParamCount - 1 then
  begin
    exit;

  end;

  try
    form26.CurrentParamCaption.Caption := codesnippetdata[current_code].params[current_param].paramdesc;
    debugmsg('PARAM TYPE: ' + getparamtype(CodeSnippetData[current_code].Params[current_param].ParamType));
    case CodeSnippetData[current_code].Params[current_param].ParamType of
      PARAM_TYPE_SKILL:
      begin
        form26.JvPageList1.ActivePage := form26.SkillSelectInputPage;
        form26.ListBox1.Clear;
        for t := 1 to condcfg.ReadInteger('Skill', 'ItemCount', 0) do
        begin
          form26.ListBox1.Items.Add(condcfg.ReadString('Skill', 'Item' + IntToStr(t), ''));
        end;
      end;
      PARAM_TYPE_PID:
      begin
        form26.JvPageList1.ActivePage := form26.GeneralInputPage;
        form26.ListBox4.Clear;
        for t := 0 to inc_cnt - 1 do
        begin
          if matchesmask(incs[t].Name, 'PID_*') then
            form26.ListBox4.Items.Add(incs[t].Name);
        end;
      end;
      PARAM_TYPE_STAT:
      begin
        form26.JvPageList1.ActivePage := form26.StatSelectInputPage;
        form26.ListBox2.Clear;
        for t := 1 to condcfg.ReadInteger('Stat', 'ItemCount', 0) do
        begin
          form26.ListBox2.Items.Add(condcfg.ReadString('Stat', 'Item' + IntToStr(t), ''));
        end;

      end;

      PARAM_TYPE_INT:
      begin
        form26.JvPageList1.ActivePage := form26.IntegerInput;

      end;
      PARAM_TYPE_BOOL:
      begin
        form26.JvPageList1.ActivePage := form26.BooleanInputPage;
      end;

      PARAM_TYPE_NODE:
      begin
        form26.ComboBox1.Clear;
        for t := 0 to currentdlg.nodecount - 1 do
        begin
          form26.ComboBox1.Items.add(currentdlg.nodes[t].nodename);
        end;

        form26.JvPageList1.ActivePage := Form26.NodeInputPage;
      end;

      PARAM_TYPE_LVAR:
      begin
        form26.JvPageList1.ActivePage := Form26.VarInputPage;
        form26.ListBox3.Clear;
        for t := 0 to currentdlg.varcnt - 1 do
        begin
          if (currentdlg.variables[t].flags = VAR_FLAGS_LOCAL) then
            form26.ListBox3.Items.Add('LVAR_' + currentdlg.variables[t].Name);

        end;

      end;
      PARAM_TYPE_GVAR:
      begin
        form26.JvPageList1.ActivePage := Form26.VarInputPage;
        form26.ListBox3.Clear;
        for t := 0 to gvarcount - 1 do
        begin
           form26.ListBox3.Items.Add(gvars[t].Name);
         end;
     end;
      PARAM_TYPE_SVAR:
      begin
        form26.JvPageList1.ActivePage := Form26.VarInputPage;
        form26.ListBox3.Clear;
        for t := 0 to currentdlg.varcnt - 1 do
        begin
          if (currentdlg.variables[t].flags = VAR_FLAGS_NONE) then
           form26.ListBox3.Items.Add(currentdlg.variables[t].Name);
         end;

      end;

      PARAM_TYPE_STRING:
      begin
        form26.JvPageList1.ActivePage := Form26.StringInputPage;
      end;

      PARAM_TYPE_FLOATNODE:
      begin
        form26.ComboBox2.Clear;
        for t := 0 to currentdlg.floatnodecount - 1 do
        begin
          form26.ComboBox2.Items.add(currentdlg.floatnodes[t].nodename);
        end;

        form26.JvPageList1.ActivePage := Form26.FloatNodeInputPage;
      end;

    end;
  except on e: Exception do
    begin
      MessageDlg(format('ERROR!' + #13 + #10 + '' + #13 + #10 + 'Current_param=%d', [current_param]),
        mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TForm26.Button1Click(Sender: TObject);
var applyvalue: string;
begin

  case codesnippetdata[current_code].params[current_param].ParamType of
    PARAM_TYPE_INT:
    begin
      applyvalue := IntToStr(updown1.Position);
    end;

    PARAM_TYPE_NODE:
    begin
      applyvalue := ComboBox1.Text;
    end;
    PARAM_TYPE_BOOL:
    begin
      applyvalue := ComboBox3.Text;
    end;
    PARAM_TYPE_FLOATNODE:
    begin
      applyvalue := combobox2.Text;
    end;
    PARAM_TYPE_STRING:
    begin
      applyvalue := memo1.Text;
      applyvalue := stringreplace(applyvalue, #13#10, '\n', [rfReplaceAll]);
    end;
    PARAM_TYPE_SKILL:
    begin
      if listbox1.ItemIndex = -1 then
      begin
        MessageDlg('No skill selected!', mtWarning, [mbOK], 0);
        exit;
      end;

      applyvalue := condcfg.ReadString('Skill', 'Item' + IntToStr(listbox1.ItemIndex + 1) + 'SSLEnum', '');
    end;
    PARAM_TYPE_STAT:
    begin
      if listbox2.ItemIndex = -1 then
      begin
        MessageDlg('No stat selected!', mtWarning, [mbOK], 0);
        exit;
      end;

      applyvalue := condcfg.ReadString('Stat', 'Item' + IntToStr(listbox2.ItemIndex + 1) + 'SSLEnum', '');
    end;
    PARAM_TYPE_GVAR:
    begin
    applyvalue :=  listbox3.Items[listbox3.ItemIndex];
    end;
    PARAM_TYPE_PID:
    begin
      if listbox4.ItemIndex = -1 then
      begin
        MessageDlg('No PID selected!', mtWarning, [mbOK], 0);
        exit;
      end;

      applyvalue := listbox4.Items[listbox4.ItemIndex];
    end;
    PARAM_TYPE_LVAR:
    begin
      if listbox3.ItemIndex = -1 then
      begin
        MessageDlg('No variable selected!', mtWarning, [mbOK], 0);
        exit;
      end;


      applyvalue := listbox3.Items[listbox3.ItemIndex];

    end;
    PARAM_TYPE_SVAR:
    begin
      if listbox3.ItemIndex = -1 then
      begin
        MessageDlg('No variable selected!', mtWarning, [mbOK], 0);
        exit;
      end;


      applyvalue := listbox3.Items[listbox3.ItemIndex];

    end;
    PARAM_TYPE_MVAR:
    begin
    end;

  end;
  code_string := StringReplace(code_string, '%' + codesnippetdata[current_code].params[current_param].paramname +
    '%', applyvalue, [rfReplaceAll]);

  if current_param <= codesnippetdata[current_code].ParamCount - 1 then
  begin
    Inc(current_param);
  end;

  updateparams;


  form26.Memo1.Text := '';

  form26.UpDown1.Position := 0;

  if (button1.Caption = 'OK') and (current_param = codesnippetdata[current_code].ParamCount) then
  begin
    modalresult := mrOk;
  end;

end;

procedure TForm26.ComboBox1Click(Sender: TObject);
var node_ind: integer;
begin

  node_ind   := Getnodeindex(combobox1.Text);
  memo2.Text := currentdlg.nodes[node_ind].npctext;

end;

procedure TForm26.ComboBox2Click(Sender: TObject);
var node_ind: integer;
var t:        integer;
begin

  node_ind := GetFloatNodeIndex(combobox2.Text);
  for t := 0 to currentdlg.floatnodes[node_ind].messagecnt - 1 do
  begin
    memo1.Lines.add(currentdlg.floatnodes[node_ind].Messages[t]);
  end;

end;

procedure TForm26.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;
end;

end.

