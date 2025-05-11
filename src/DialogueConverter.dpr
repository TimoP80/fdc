(*

---------------------------------------------------------------
Fallout Dialogue Creator
Dialogue Converter - Converts .FMF files to SSL/INT+MSG
Copyright (C) 2005-2025 T. Pitkänen
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


program DialogueConverter;

uses
  Forms,   Windows,
  dlgconv_ in 'dlgconv_.pas' {dlg_form},
  viewscript in 'viewscript.pas' {conv_view},
  parseerror in 'parseerror.pas' {Form7},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;

  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.Title := 'Fallout Dialogue Creator - Dialogue Converter';
  Application.CreateForm(Tdlg_form, dlg_form);
  Application.CreateForm(Tconv_view, conv_view);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
