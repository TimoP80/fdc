(*

---------------------------------------------------------------
Fallout Dialogue Creator - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2025 T. Pitkänen
---------------------------------------------------------------
Description:

  This unit is the skill check editor.
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

unit skillcheck_ed;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Messages, SharedDLGData, StdCtrls, SysUtils, Variants, Windows;
type
  TForm24 = class(TForm)
    Panel1:    TPanel;
    Label1:    TLabel;
    Edit1:     TEdit;
    Button1:   TButton;
    Label2:    TLabel;
    ComboBox1: TComboBox;
    Label3:    TLabel;
    Edit2:     TEdit;
    UpDown1:   TUpDown;
    Label4:    TLabel;
    Label5:    TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button2:   TButton;
    Label6:    TLabel;
    Label7:    TLabel;
    Memo1:     TMemo;
    Memo2:     TMemo;
    Label8:    TLabel;
    Label9:    TLabel;
    ComboBox4: TComboBox;
    Button3:   TButton;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24:           TForm24;
  globalcheckcount: integer;

procedure updatenodelists;
implementation
uses fmfmain;

{$R *.dfm}
procedure updatenodelists;
var u: integer;
begin
  form24.ComboBox2.Clear;
  form24.ComboBox3.Clear;
  form24.ComboBox4.Clear;
  for u := 0 to currentdlg.nodecount - 1 do
  begin
    form24.combobox2.Items.add(currentdlg.nodes[u].nodename);
    form24.combobox3.Items.add(currentdlg.nodes[u].nodename);
    form24.combobox4.Items.add(currentdlg.nodes[u].nodename);
  end;

end;

procedure TForm24.Button1Click(Sender: TObject);
var u, i: integer;
begin
  globalcheckcount := 0;
  for u := 0 to currentdlg.nodecount - 1 do
  begin
    for i := 0 to currentdlg.nodes[u].skillcheckcnt - 1 do
    begin
      Inc(globalcheckcount);
    end;

  end;
  Edit1.Text := format('Skill_Check_%0.3d_%s', [globalcheckcount, ComboBox1.Text]);
  edit1.Text := stringreplace(edit1.Text, ' ', '_', [rfReplaceAll]);

end;

procedure TForm24.ComboBox2Click(Sender: TObject);
begin
  Form24.Memo1.Text := currentdlg.nodes[form24.ComboBox2.ItemIndex].npctext;

end;

procedure TForm24.ComboBox3Click(Sender: TObject);
begin
  Form24.Memo2.Text := currentdlg.nodes[form24.ComboBox3.ItemIndex].npctext;
end;

procedure TForm24.ComboBox2Change(Sender: TObject);
begin
  if form24.ComboBox2.ItemIndex <> -1 then
    Form24.Memo1.Text := currentdlg.nodes[form24.ComboBox2.ItemIndex].npctext;

end;

procedure TForm24.ComboBox3Change(Sender: TObject);
begin
  if form24.ComboBox3.ItemIndex <> -1 then
    Form24.Memo2.Text := currentdlg.nodes[form24.ComboBox3.ItemIndex].npctext;

end;

procedure TForm24.Button2Click(Sender: TObject);
var errorstr: string;
begin

  errorstr := '';
  if edit1.Text = '' then
  begin
    errorstr := errorstr + 'The skill check name is empty.' + #13#10;
  end;
    if (combobox4.ItemIndex = -1) then
  begin
    errorstr := errorstr + 'Node association not specified.' + #13#10;
  end;
  if (combobox2.ItemIndex = -1) then
  begin
    errorstr := errorstr + 'Success node not specified.' + #13#10;
  end;
  if (combobox3.ItemIndex = -1) then
  begin
    errorstr := errorstr + 'Failure node not specified.' + #13#10;
  end;

  if errorstr <> '' then
  begin
    MessageDlg(format('Can''t create skill check. The following errors' + #13 + #10 + 'were detected:' +
      #13 + #10 + '' + #13 + #10 + '%s' + '' + #13 + #10 + 'Correct them and try again.', [errorstr]), mtWarning, [mbOK], 0);
    exit;
  end;

  modalresult := mrOk;
  DialogueChangeNotify;

end;

procedure TForm24.Edit1Change(Sender: TObject);
begin
  if edit1.Text <> '' then
    button2.Enabled := True else
    button2.Enabled := False;

end;

end.

