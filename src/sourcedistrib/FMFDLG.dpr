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

// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program FMFDLG;
                        
uses
  SysUtils,
  aboutbox in 'aboutbox.pas' {Form5},
  addnode in 'addnode.pas' {Form3},
  condcheck in 'condcheck.pas' {Form16},
  custom_proc_ed in 'custom_proc_ed.pas' {Form23},
  customcodeedit in 'customcodeedit.pas' {Form25},
  debugwnd in 'debugwnd.pas' {Form11},
  devfunced in 'devfunced.pas' {Form12},
  dlged in 'dlged.pas' {Form2},
  dlgterminate in 'dlgterminate.pas' {Form8},
  dlgtrans in 'dlgtrans.pas' {Form13},
  floatnode_ed in 'floatnode_ed.pas' {Form17},
  fmfmain in 'fmfmain.pas' {Form1},
  Forms,
  globalnpc in 'globalnpc.pas' {Form9},
  helpscreen in 'helpscreen.pas' {Form28},
  parseerror in 'parseerror.pas' {Form7},
  PlayerCharSetup in 'PlayerCharSetup.pas' {Form15},
  poptadd in 'poptadd.pas' {Form4},
  prefs in 'prefs.pas' {Form10},
  selectfloatnode in 'selectfloatnode.pas' {Form20},
  SharedDLGData in 'SharedDLGData.pas',
  skillcheck_ed in 'skillcheck_ed.pas' {Form24},
  skillcheck_eval in 'skillcheck_eval.pas' {Form27},
  scriptprogressbar,
  startconds in 'startconds.pas' {Form22},
  TE_DataEd in 'TE_DataEd.pas' {Form19},
  timeevent_editor in 'timeevent_editor.pas' {Form18},
  transclist in 'transclist.pas' {Form14},
  updateprog in 'updateprog.pas' {Form6},
  var_inputpage in 'var_inputpage.pas' {Form26},
  varmanager in 'varmanager.pas' {Form21},
  scrseq in 'scrseq.pas' {scrseqedit},
  debug_exceptiondlg in 'debug_exceptiondlg.pas' {ExceptionDialog};

{$INCLUDE 'version.inc'}


{$IFDEF BETARELEASE}
{$MESSAGE 'Building beta release'}
{$ELSE}
{$MESSAGE 'Building stable release'}
{$ENDIF}


{$R *.res}
var
  i: integer;

begin

  Application.Initialize;
  Application.Title := 'Fallout Dialogue Creator';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tprogressform, progressform);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm15, Form15);
  Application.CreateForm(TForm16, Form16);
  Application.CreateForm(TForm17, Form17);
  Application.CreateForm(TForm18, Form18);
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TForm20, Form20);
  Application.CreateForm(TForm21, Form21);
  Application.CreateForm(TForm22, Form22);
  Application.CreateForm(TForm23, Form23);
  Application.CreateForm(TForm24, Form24);
  Application.CreateForm(TForm25, Form25);
  Application.CreateForm(TForm26, Form26);
  Application.CreateForm(TForm27, Form27);
  Application.CreateForm(TForm28, Form28);
  Application.CreateForm(Tscrseqedit, scrseqedit);
  Application.CreateForm(TForm3, Form3);
  if (ParamStr(1) <> '') and (ParamStr(1) <> '/devmode') then
    form1.executescriptconsole('LoadDialogue(''' + ParamStr(1) + ''')');

  for i := 0 to application.ComponentCount - 1 do
  begin
    if application.Components[i].ClassParent = TForm then
    begin
      GenerateHelpButton(TForm(application.Components[i]));
    end;

  end;

  Application.Run;
end.

