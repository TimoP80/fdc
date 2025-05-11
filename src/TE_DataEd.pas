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

unit TE_DataEd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, SynEditHighlighter, SynHighlighterGeneral,
  SynEdit, SynMemo, Menus, JvExControls, JvComponent, JvArrowButton;

type
  TForm19 = class(TForm)
    SynMemo1: TSynMemo;
    SynGeneralSyn1: TSynGeneralSyn;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    Insertcommand1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

uses fmfmain;

{$R *.dfm}

procedure TForm19.Button1Click(Sender: TObject);
begin
modalresult:=mrOk;
end;

procedure TForm19.Button2Click(Sender: TObject);
begin
modalresult:=mrCancel;

end;

procedure TForm19.FormCreate(Sender: TObject);
begin
Form1.LoadScript(extractfiledir(paramstr(0))+'\helperscripts\TE_Commands.dws');
 Form1.SynCompletionProposal1.AddEditor(Form19.SynMemo1);
  Form1.SynCompletionProposal2.AddEditor(Form19.SynMemo1);

end;

procedure TForm19.FormShow(Sender: TObject);
begin
form1.syncompletionproposal1.Editor := form19.synmemo1;
form1.syncompletionproposal2.Editor := form19.synmemo1;

end;

end.
