(*

  ---------------------------------------------------------------
  Fallout Dialogue Creator - dialogue editor for Fallout 2 mods
  Copyright (C) 2005-2025 T. Pitkänen
  ---------------------------------------------------------------
  Description:

  This unit is the player option condition editor.
  ---------------------------------------------------------------


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

unit condcheck;

interface

uses
  addnode,
  GVarparse, Classes,
  Controls,
  debugwnd,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Inifiles,
  Masks,
  Messages,
  ParseInclude,
  poptadd,
  SharedDLGData,
  StdCtrls,
  SysUtils,
  Variants,
  Windows, SynEdit, SynMemo;

type
  TForm16 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    checktypelist: TComboBox;
    fieldlist: TListBOx;
    Label2: TLabel;
    Label3: TLabel;
    evaltype: TComboBox;
    Label4: TLabel;
    sslcode: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label6: TLabel;
    condlist: TListBOx;
    Label7: TLabel;
    valuetocheck: TEdit;
    Label5: TLabel;
    chosenfield: TLabel;
    Button5: TButton;
    Label8: TLabel;
    linkage: TComboBox;
    customcodeeditor: TSynMemo;
    procedure updatevalues;
    procedure checktypelistClick(Sender: TObject);
    procedure fieldlistClick(Sender: TObject);
    procedure evaltypeClick(Sender: TObject);
    procedure valuetocheckChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure condlistClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure condlistMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure valuetocheckKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form16: TForm16;

  Source: String;

function GetEval(eval_type: Integer): String;
procedure refreshconds;

implementation

uses
  fmfmain, Math;

{$R *.dfm}

function GetDefineEnumByValue(Value: String): String;
var
  t: Integer;
begin;
  Result := '';
  for t := 0 to inc_cnt - 1 do
  begin;
    if (Value = incs[t].desc) then
    begin;
      Result := incs[t].Name;
      exit;
    end;

  end;

end;

function GetDefineValueByEnum(Value: String): String;
var
  t: Integer;
begin;
  Result := '';
  for t := 0 to inc_cnt - 1 do
  begin;
    if (Value = incs[t].Name) then
    begin;
      Result := incs[t].desc;
      exit;
    end;

  end;

end;

procedure TForm16.updatevalues;
var
  code: String;
var
  checktype, cmd: String;
var
  sslenum: String;
begin
  if fieldlist.ItemIndex = -1 then
    debugmsg('FIELD LIST IS NOT SELECTED????')
  else
    chosenfield.Caption := fieldlist.Items[fieldlist.ItemIndex];
  checktype := checktypelist.Items[checktypelist.ItemIndex];
  cmd := condcfg.ReadString(checktype, 'SSLCommand', '');
  sslenum := condcfg.ReadString(checktype,
    'Item' + IntToStr(fieldlist.ItemIndex + 1) + 'SSLEnum', '');

  if condcfg.ReadString(checktype, 'source', '') <> '' then
  begin

    if condcfg.ReadString(checktype, 'source', '') = 'defines' then
    begin
      sslenum := GetDefineEnumByValue(fieldlist.Items[fieldlist.ItemIndex]);
    end
    else
    begin
      if fieldlist.ItemIndex <> -1 then
        sslenum := fieldlist.Items[fieldlist.ItemIndex]
      else
        debugmsg('SOMETHINGS FUCKED UP THE FIELDLIST IS -1!');
    end;

  end;

  cmd := stringreplace(cmd, '%eval%', GetEval(evaltype.ItemIndex), []);
  cmd := stringreplace(cmd, '%value%', valuetocheck.Text, []);
  sslcode.Caption := Format(cmd, [sslenum]);
 
end;

procedure TForm16.checktypelistClick(Sender: TObject);
var
  pattern, checktype: String;
var
  h, itemcount: Integer;
begin
  fieldlist.Clear;
  checktype := checktypelist.Items[checktypelist.ItemIndex];
  Source := '';
  if checktypelist.ItemIndex = CHECK_TYPE_CUSTOM_CODE-1 then
  begin
  DebugMSG('Check type is custom code.');
    fieldlist.Visible:=false;
    customcodeeditor.Visible := true;
    Label2.caption:='Custom code:';
  end
  else
    begin
  DebugMSG('Check type is fields, itemindex: '+inttostr(checktypelist.ItemIndex));
    fieldlist.Visible:=true;
    customcodeeditor.Visible := false;
    Label2.caption:='Field names:';

    end;
  if (condcfg.ReadString(checktype, 'source', '') <> '') then
  begin
    Source := condcfg.ReadString(checktype, 'source', '');
    if (Source = 'local_vars') then
    begin
      for h := 0 to currentdlg.varcnt - 1 do
      begin

        if (currentdlg.variables[h].flags = VAR_FLAGS_LOCAL) then
        begin
          fieldlist.Items.Add(currentdlg.variables[h].Name);
        end;

      end;
    end
    else if (Source = 'global_vars') then
    begin
      for h := 0 to gvarcount - 1 do
      begin

        fieldlist.Items.Add(gvars[h].Name);

      end;
    end
    else if (Source = 'defines') then
    begin
      pattern := condcfg.ReadString(checktype, 'pattern', '');
      for h := 0 to inc_cnt - 1 do
      begin
        if matchesmask(incs[h].Name, pattern) then
        begin

          fieldlist.Items.Add(incs[h].desc);
        end;

      end;

    end
    else if (Source = 'script_vars') then
    begin
      for h := 0 to currentdlg.varcnt - 1 do
      begin;
        if (currentdlg.variables[h].flags = VAR_FLAGS_NONE) then
        begin;
          fieldlist.Items.Add(currentdlg.variables[h].Name);
        end;

      end;

    end;

  end
  else
  begin
    itemcount := condcfg.ReadInteger(checktype, 'ItemCount', 0);
    for h := 1 to itemcount do
      fieldlist.Items.Add(condcfg.ReadString(checktype,
        'Item' + IntToStr(h), ''));

    fieldlist.ItemIndex := 0;

  end;

end;

function GetEval(eval_type: Integer): String;
begin

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

procedure TForm16.fieldlistClick(Sender: TObject);
begin;

  updatevalues;
  if (Source = 'local_vars') or (Source = 'script_vars') then
  begin;
    debugmsg('FieldlistHInt:=' + fieldlist.hint);
  end;
  if fieldlist.ItemIndex <> -1 then
  begin;
    fieldlist.hint := getVarDesc(fieldlist.Items[fieldlist.ItemIndex]);
  end;
end;

procedure TForm16.evaltypeClick(Sender: TObject);
begin
  updatevalues;
end;

procedure TForm16.valuetocheckChange(Sender: TObject);
begin
  if condlist.ItemIndex <> -1 then
    updatevalues;
end;

procedure refreshconds;
var
  t: Integer;
begin;

  Form16.condlist.Clear;
  for t := 0 to currentdlg.nodes[nodeind].options[lineind].conditioncnt - 1 do
  begin;
    Form16.condlist.Items.Add(currentdlg.nodes[nodeind].options[lineind]
      .conditions[t].resolved_code);
  end;

end;

procedure TForm16.Button3Click(Sender: TObject);
begin
  if checktypelist.ItemIndex = -1 then
  begin
    MessageDlg('You have not chosen a condition type!', mtWarning, [mbOK], 0);
    exit;
  end;

  if (valuetocheck.Text = '') and (evaltype.ItemIndex > 0) then
  begin
    MessageDlg('The value check field is empty. Please enter a value.',
      mtWarning, [mbOK], 0);
    exit;
  end;

  new(currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt]);
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_type :=
    checktypelist.ItemIndex + 1;
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].var_ptr := '';
  if Source = 'defines' then
  begin
    currentdlg.nodes[nodeind].options[lineind].conditions
      [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_field :=
      fieldlist.ItemIndex;
    currentdlg.nodes[nodeind].options[lineind].conditions
      [currentdlg.nodes[nodeind].options[lineind].conditioncnt].var_ptr :=
      GetDefineEnumByValue(fieldlist.Items[fieldlist.ItemIndex]);
  end
  else if (Source = 'local_vars') or (Source = 'script_vars') or
    (Source = 'global_vars') then
  begin
    currentdlg.nodes[nodeind].options[lineind].conditions
      [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_field :=
      fieldlist.ItemIndex;
    currentdlg.nodes[nodeind].options[lineind].conditions
      [currentdlg.nodes[nodeind].options[lineind].conditioncnt].var_ptr :=
      fieldlist.Items[fieldlist.ItemIndex];
  end
  else

    currentdlg.nodes[nodeind].options[lineind].conditions
      [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_field :=
      condcfg.ReadInteger(checktypelist.Items[checktypelist.ItemIndex],
      'Item' + IntToStr(fieldlist.ItemIndex + 1) + 'Enum', 0);
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_eval :=
    evaltype.ItemIndex;
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_value :=
    valuetocheck.Text;
    if currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].check_type=CHECK_TYPE_CUSTOM_CODE then
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].resolved_code :=
    customcodeeditor.lines.text else

  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].resolved_code :=
    sslcode.Caption;
  currentdlg.nodes[nodeind].options[lineind].conditions
    [currentdlg.nodes[nodeind].options[lineind].conditioncnt].link :=
    linkage.ItemIndex;

  Inc(currentdlg.nodes[nodeind].options[lineind].conditioncnt);
  refreshconds;
end;

procedure TForm16.condlistClick(Sender: TObject);
var
  curcond: condition;
begin

  if condlist.ItemIndex <> -1 then
  begin
    curcond := currentdlg.nodes[nodeind].options[lineind].conditions
      [condlist.ItemIndex]^;
    checktypelist.ItemIndex := curcond.check_type - 1;
    checktypelistClick(nil);
    if (Source = 'defines') then
    begin
      debugmsg('DEFINES! VARPTR=' + curcond.var_ptr);
      fieldlist.ItemIndex := fieldlist.Items.indexof
        (GetDefineValueByEnum(curcond.var_ptr));

      if fieldlist.ItemIndex <> -1 then
        chosenfield.Caption := fieldlist.Items[fieldlist.ItemIndex];
    end
    else if (Source = 'local_vars') or (Source = 'script_vars') or
      (Source = 'global_vars') then
    begin
      debugmsg('var PTR:=' + curcond.var_ptr);
      fieldlist.ItemIndex := fieldlist.Items.indexof(curcond.var_ptr);
      if fieldlist.ItemIndex = -1 then
      begin
        fieldlist.ItemIndex := 0;
        MessageDlg
          (Format('Warning: The variable "%s" contained in the condition does not resolve'
          + #13 + #10 + 'to a valid script variable.' + #13 + #10 + '' + #13 +
          #10 + 'It has been reset to the first variable in the list to prevent crashing.',
          [curcond.var_ptr]), mtWarning, [mbOK], 0);
      end;

    end
    else
      fieldlist.ItemIndex := curcond.check_field - 1;

    evaltype.ItemIndex := curcond.check_eval;
    valuetocheck.Text := curcond.check_value;
    sslcode.Caption := curcond.resolved_code;
    linkage.ItemIndex := curcond.link;
    if curcond.check_type = CHECK_TYPE_CUSTOM_CODE then
    begin
      fieldlist.Visible := false;
      customcodeeditor.Visible := true;
      customcodeeditor.lines.Text := curcond.resolved_code
    end
    else
    begin
      customcodeeditor.lines.Text := '';
      customcodeeditor.Visible := false;
      fieldlist.Visible := true;
    end;
    Button5.Enabled := true;
  end
  else
  begin
    sslcode.Caption := '';
    valuetocheck.Text := '';
    Button5.Enabled := false;
    customcodeeditor.clear;
  end;

end;

procedure TForm16.Button5Click(Sender: TObject);
var
  Data: Integer;
begin
  try
    if condlist.ItemIndex <> -1 then
    begin
      currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex]
        .check_type := checktypelist.ItemIndex + 1;
      Data := condcfg.ReadInteger(checktypelist.Items[checktypelist.ItemIndex],
        'Item' + IntToStr(fieldlist.ItemIndex + 1) + 'Enum', 0);
      currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex]
        .check_field := Data;
      currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex]
        .check_eval := evaltype.ItemIndex;
      currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex]
        .check_value := valuetocheck.Text;
      debugmsg('Source: ' + Source);
      if Source = 'defines' then
      begin;
        // currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex].check_field := Data;
        currentdlg.nodes[nodeind].options[lineind].conditions
          [condlist.ItemIndex].var_ptr :=
          GetDefineEnumByValue(fieldlist.Items[fieldlist.ItemIndex]);
      end
      else if (Source = 'local_vars') or (Source = 'script_vars') or
        (Source = 'global_vars') then
      begin
        // currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex].check_field := Data;
        currentdlg.nodes[nodeind].options[lineind].conditions
          [condlist.ItemIndex].var_ptr := fieldlist.Items[fieldlist.ItemIndex];
      end;
      debugmsg('VarPTR := ' + currentdlg.nodes[nodeind].options[lineind]
        .conditions[condlist.ItemIndex].var_ptr);
      if currentdlg.nodes[nodeind].options[lineind].conditions
        [condlist.ItemIndex].check_type = CHECK_TYPE_CUSTOM_CODE then
      begin

        currentdlg.nodes[nodeind].options[lineind].conditions
          [condlist.ItemIndex].resolved_code := customcodeeditor.Text;
      end
      else
        currentdlg.nodes[nodeind].options[lineind].conditions
          [condlist.ItemIndex].resolved_code := sslcode.Caption;

      currentdlg.nodes[nodeind].options[lineind].conditions[condlist.ItemIndex]
        .link := linkage.ItemIndex;

      refreshconds;
    end;
  except
    on e: Exception do
    begin
      MessageDlg('SHIT GOD DAMN CRAP FUCK IT!' + #13 + #10 + '' + #13 + #10 +
        'Okay.. Some shit went wrong.', mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TForm16.Button4Click(Sender: TObject);
begin
  if condlist.ItemIndex <> -1 then
  begin
    deleteoptioncondition(nodeind, lineind, condlist.ItemIndex);
    refreshconds;
  end;
end;

procedure TForm16.condlistMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if condlist.ItemAtPos(Point(X, Y), true) = -1 then
  begin
    condlist.ItemIndex := -1;
    checktypelist.ItemIndex := -1;
    evaltype.ItemIndex := -1;
    valuetocheck.Text := '';
    chosenfield.Caption := '';
    sslcode.Caption := '';
    linkage.ItemIndex := -1;
    fieldlist.Clear;
  end;

end;

procedure TForm16.valuetocheckKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  updatevalues;
end;

end.
