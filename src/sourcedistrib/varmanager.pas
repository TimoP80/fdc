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

unit varmanager;

interface

uses
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  dlged,
  Forms,
  Graphics,
  Messages,
  pluginapi,
  SharedDLGData,
  StdCtrls,
  SysUtils,
  Variants,
  Windows;

type
  TForm21 = class(TForm)
    ListView1 : TListView;
    Label1 :    TLabel;
    Edit1 :     TEdit;
    Label2 :    TLabel;
    ComboBox1 : TComboBox;
    Label3 :    TLabel;
    Edit2 :     TEdit;
    CheckBox1 : TCheckBox;
    Button1 :   TButton;
    Button2 :   TButton;
    Button3 :   TButton;
    Button4 :   TButton;
    Button5 :   TButton;
    Label4 :    TLabel;
    ComboBox2 : TComboBox;
    Label5 :    TLabel;
    Memo1 :     TMemo;
    Button6 :   TButton;
    Button7 :   TButton;
    Button8 :   TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form21:   TForm21;
  temp_var: TVariable;
  temp_dlg: dialog;

procedure updatevars;

implementation

uses
  debugwnd,
  Math;

{$R *.dfm}

procedure updatevars;
var
  t: TListItem;
var
  s: integer;
begin
  ;
  form21.listview1.Clear;
  for s := 0 to currentdlg.varcnt - 1 do
  begin
    ;
    t := Form21.ListView1.items.add;
    if (currentdlg.variables[s].flags <> VAR_FLAGS_NONE) then
    begin
      ;
      case currentdlg.variables[s].flags of
        VAR_FLAGS_IMPORT:
          t.Caption := '[import] ' + currentdlg.variables[s].Name;
        VAR_FLAGS_EXPORT:
          t.Caption := '[export] ' + currentdlg.variables[s].Name;
        VAR_FLAGS_LOCAL:
          t.Caption := '[local] ' + currentdlg.variables[s].Name;
        VAR_FLAGS_GLOBAL:
          t.Caption := '[global] ' + currentdlg.variables[s].Name;
      end;

    end
    else
      t.Caption := currentdlg.variables[s].Name;

    if currentdlg.variables[s].vartype = -1 then
      t.subitems.add('N/A (no default value)')
    else
    begin
      ;
      case currentdlg.variables[s].vartype of
        VAR_TYPE_STRING:
        begin
          ;
          t.subitems.add('string');
          t.subitems.add(currentdlg.variables[s].Value);
        end;
        VAR_TYPE_INT:
        begin
          ;
          t.subitems.add('integer');
          t.subitems.add(IntToStr(currentdlg.variables[s].Value));
        end;
        VAR_TYPE_FLOAT:
        begin
          ;
          t.subitems.add('float');
          t.subitems.add(floattostr(currentdlg.variables[s].Value));
        end;
      end;

    end;

  end;

end;

procedure TForm21.Button1Click(Sender: TObject);
begin
  if edit1.Text = '' then
  begin
    ;
    MessageDlg('Variable name missing!', mtWarning, [mbOK], 0);
    exit;
  end;

  new(currentdlg.variables[currentdlg.varcnt]);
  currentdlg.variables[currentdlg.varcnt].Name := Edit1.Text;
  currentdlg.variables[currentdlg.varcnt].vartype := -1;
  currentdlg.variables[currentdlg.varcnt].notes := Memo1.Text;
  currentdlg.variables[currentdlg.varcnt].notes :=
    StringReplace(currentdlg.variables[currentdlg.varcnt].notes, #13#10, '\n', [rfReplaceAll]);

  if checkbox1.Checked then
  begin
    ;
    currentdlg.variables[currentdlg.varcnt].vartype := ComboBox1.ItemIndex;
    case currentdlg.variables[currentdlg.varcnt].vartype of
      VAR_TYPE_STRING:
        currentdlg.variables[currentdlg.varcnt].Value := Edit2.Text;
      VAR_TYPE_INT:
        currentdlg.variables[currentdlg.varcnt].Value := StrToInt(edit2.Text);
      VAR_TYPE_FLOAT:
        currentdlg.variables[currentdlg.varcnt].Value := StrToFloat(edit2.Text);
    end;
  end;
  currentdlg.variables[currentdlg.varcnt].flags := ComboBox2.ItemIndex;
  Inc(currentdlg.varcnt);
  edit2.Text          := '';
  edit1.Text          := '';
  memo1.Text          := '';
  combobox2.ItemIndex := -1;
  checkbox1.Checked   := False;
  combobox1.ItemIndex := -1;
  updatevars;
end;

procedure TForm21.Button2Click(Sender: TObject);
begin
  if ListView1.Selected <> NIL then
  begin
    ;
    DeleteVar(ListView1.Selected.index);
    updatevars;
  end;

end;

procedure TForm21.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> NIL then
  begin
    ;
    button3.Enabled := True;
    edit1.Text      := currentdlg.variables[listview1.selected.index].Name;
    case currentdlg.variables[listview1.selected.index].vartype of
      VAR_TYPE_INT:
        combobox1.ItemIndex := 1;
      VAR_TYPE_STRING:
        combobox1.ItemIndex := 0;

      VAR_TYPE_FLOAT:
        combobox1.ItemIndex := 2;
    end;

    combobox2.ItemIndex := currentdlg.variables[listview1.selected.index].flags;
    // combobox1.Text      := combobox1.items[combobox1.ItemIndex];
    if combobox1.ItemIndex <> currentdlg.variables[listview1.selected.index].vartype then
      debugmsg('VAR TYPES DIFFER!!!! ' + IntToStr(currentdlg.variables[listview1.selected.index].vartype) +
        ' AND ' + IntToStr(combobox1.ItemIndex));
    debugmsg('varTYPE:=' + IntToStr(currentdlg.variables[listview1.selected.index].vartype));
    Memo1.Text          := currentdlg.variables[listview1.selected.index].notes;

    memo1.Text :=
      StringReplace(currentdlg.variables[listview1.selected.index].notes, '\n', #13#10, [rfReplaceAll]);

    CheckBox1.Checked := (combobox1.ItemIndex <> -1);
    case currentdlg.variables[listview1.selected.index].vartype of
      VAR_TYPE_INT:
      begin
        ;
        edit2.Text := IntToStr(currentdlg.variables[listview1.selected.index].Value);
      end;
      VAR_TYPE_STRING:
      begin
        ;
        edit2.Text := currentdlg.variables[listview1.selected.index].Value;
      end;
      VAR_TYPE_FLOAT:
      begin
        ;
        edit2.Text := floattostr(currentdlg.variables[listview1.selected.index].Value);

      end;
    end;

  end
  else
  begin
    ;
    edit2.Text          := '';
    edit1.Text          := '';
    checkbox1.Checked   := False;
    combobox1.ItemIndex := -1;
    memo1.Text          := '';
    ComboBox2.ItemIndex := 0;
    button3.Enabled     := False;
  end;

end;

procedure TForm21.Button3Click(Sender: TObject);
var
  t:    integer;
var
  item: TListItem;
begin
  if ListView1.selected <> NIL then
  begin
    ;
    if listview1.selcount = 1 then
    begin
      ;
      currentdlg.variables[ListView1.Selected.index].Name := Edit1.Text;
      currentdlg.variables[ListView1.Selected.index].notes := Memo1.Text;
      currentdlg.variables[ListView1.Selected.index].notes :=
        StringReplace(currentdlg.variables[ListView1.Selected.index].notes, #13#10, '\n', [rfReplaceAll]);
      currentdlg.variables[ListView1.Selected.index].vartype := ComboBox1.ItemIndex;
      currentdlg.variables[ListView1.Selected.index].flags := ComboBox2.ItemIndex;

      if combobox1.ItemIndex <> -1 then
      begin
        ;
        currentdlg.variables[ListView1.Selected.index].vartype := ComboBox1.ItemIndex;
        case currentdlg.variables[ListView1.Selected.index].vartype of
          VAR_TYPE_STRING:
            currentdlg.variables[ListView1.Selected.index].Value := Edit2.Text;
          VAR_TYPE_INT:
            currentdlg.variables[ListView1.Selected.index].Value := StrToInt(edit2.Text);
          VAR_TYPE_FLOAT:
            currentdlg.variables[ListView1.Selected.index].Value := StrToFloat(edit2.Text);
        end;
      end;
    end
    else
    begin
      ;
      debugmsg('Selected ' + IntToStr(listview1.selcount) + ' items.');
      item := listview1.Selected;
      while item <> NIL do
      begin
        ;
        currentdlg.variables[item.index].vartype := ComboBox1.ItemIndex;

        if combobox1.ItemIndex <> -1 then
        begin
          ;
          currentdlg.variables[item.index].vartype := ComboBox1.ItemIndex;
          case currentdlg.variables[item.index].vartype of
            VAR_TYPE_STRING:
              currentdlg.variables[item.index].Value := Edit2.Text;
            VAR_TYPE_INT:
              currentdlg.variables[item.index].Value := StrToInt(edit2.Text);
            VAR_TYPE_FLOAT:
              currentdlg.variables[item.index].Value := StrToFloat(edit2.Text);
          end;

        end;
        currentdlg.variables[item.index].flags := ComboBox2.ItemIndex;
        item := ListView1.GetNextItem(item, sdBelow, [isselected]);
      end;
    end;

    edit2.Text          := '';
    edit1.Text          := '';
    checkbox1.Checked   := False;
    combobox1.ItemIndex := -1;
    updatevars;
  end;

end;

procedure TForm21.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.Checked = False then
  begin
    ;
    ComboBox1.ItemIndex := -1;
    combobox1.Text      := '<none>';
  end
  else
  begin
    ;
    // combobox1.ItemIndex := 0;
  end;

end;

procedure TForm21.Button6Click(Sender: TObject);
var
  prev_index:    integer;
var
  movenodeind:   integer;
var
  movetonodeind: integer;
var
  j:             integer;
begin
  if listview1.ItemIndex = 0 then
  begin
    ;
    listview1.SetFocus;
    exit;
  end;
  prev_index    := listview1.selected.Index;
  movenodeind   := listview1.Selected.index;
  movetonodeind := listview1.items[listview1.selected.index - 1].index;

  temp_var            := currentdlg.variables[movenodeind]^;
  currentdlg.variables[movenodeind]^ :=
    currentdlg.variables[movetonodeind]^;
  currentdlg.variables[movetonodeind]^ := temp_var;
  updatevars;
  listview1.ItemIndex := movetonodeind;
  listview1.selected  := listview1.items[listview1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  listview1.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure DoVarSort;

var
  t:        integer;
var
  newind:   integer;
var
  varnames: TStringList;
begin
  ;



  temp_dlg := currentdlg;
  varnames := TStringList.Create;
  for t := 0 to temp_dlg.varcnt - 1 do
  begin
    ;
    varnames.add(temp_dlg.variables[t].Name);
  end;

  varnames.Sort;


  currentdlg.varcnt := 0;
  for t := 0 to varnames.Count - 1 do
  begin
    ;
    new(currentdlg.variables[currentdlg.varcnt]);
    newind := GetVarindexFromDLG(varnames[t], temp_dlg);
    currentdlg.variables[currentdlg.varcnt]^ := temp_dlg.variables[newind]^;
    Inc(currentdlg.varcnt);
  end;

  updatevars;
  requestpluginrefresh;
end;



procedure TForm21.Button7Click(Sender: TObject);
var
  prev_index:    integer;
var
  movenodeind:   integer;
var
  movetonodeind: integer;
begin
  if listview1.ItemIndex = listview1.items.Count - 1 then
  begin
    ;
    listview1.SetFocus;
    exit;
  end;

  prev_index          := listview1.selected.Index;
  movenodeind         := listview1.Selected.index;
  movetonodeind       := listview1.items[listview1.selected.index + 1].index;
  temp_var            := currentdlg.variables[movenodeind]^;
  currentdlg.variables[movenodeind]^ :=
    currentdlg.variables[movetonodeind]^;
  currentdlg.variables[movetonodeind]^ := temp_var;
  updatevars;
  listview1.ItemIndex := movetonodeind;
  listview1.selected  := listview1.items[listview1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  listview1.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm21.Button8Click(Sender: TObject);
begin
  DoVarSort;
end;

end.

