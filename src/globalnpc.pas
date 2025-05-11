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

unit globalnpc;

interface

uses
  Classes, Controls, Dialogs, Forms,
  Graphics, helpscreen,Messages, StdCtrls, SysUtils, Variants, Windows;
type
  TForm9 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    npcname: TEdit;
    Label2: TLabel;
    npcloc: TEdit;
    Label3: TLabel;
    npcnotes: TMemo;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    npcunknowndesc: TMemo;
    Label5: TLabel;
    npcknowndesc: TMemo;
    Label6: TLabel;
    npcdetailed: TMemo;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

end.
