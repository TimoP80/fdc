(*

---------------------------------------------------------------
FMF Dialogue Converter - Converts .FMF files to SSL/INT+MSG
Copyright (C) 2005-2008 T. Pitkänen
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

unit viewscript;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  SynEditHighlighter,
  SynHighlighterGeneral,
  SynEdit,
  SynMemo,
  ComCtrls, StdCtrls;

type
  Tconv_view = class(TForm)
    PageControl1 : TPageControl;
    TabSheet1 :    TTabSheet;
    TabSheet2 :    TTabSheet;
    SynMemo1 :     TSynMemo;
    SynMemo2 :     TSynMemo;
    sslHighlight : TSynGeneralSyn;
    msghighlight : TSynGeneralSyn;
    Button1 :      TButton;
    Label1: TLabel;
    Label2: TLabel;
    msgloc: TLabel;
    scrloc: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conv_view: Tconv_view;

implementation

{$R *.dfm}

procedure Tconv_view.Button1Click(Sender: TObject);
begin
  conv_view.Close;
end;

end.

