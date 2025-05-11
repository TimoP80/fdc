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

unit ScriptCompilerIntf;

interface

{$IFDEF BUILD_ScriptExporter}
{$MESSAGE 'CompilerInterface: Script Exporter build.'}
{$ELSE}
{$MESSAGE 'CompilerInterface: DDFC Build.'}
{$ENDIF}
uses
  VCL.Dialogs,
  Windows,
  fmxutils,
  SysUtils{$IFDEF BUILD_ScriptExporter} , pluginfunc{$ENDIF}  ;

type
  TCompileProc = function(filename: PChar): integer; stdcall;
  TErrorProc = function: PChar; stdcall;

var
  libhandle:     THandle;
  CompileScript: TCompileproc;
  GetLastCompilerError: TErrorProc;
  cmppath:       string;
  script_output: string;

function InitCompiler(DLLpath: string): boolean;
function DoCompile(filename: string; localcompile: boolean = False): boolean;
procedure DeInitCompiler;

implementation

uses Math;

procedure PreProcess(filename: string);
var
  str_info, str_params: string;
var
  res: integer;
begin
  try
    //riteln ('Preprocessing: ',filename);
    str_info := cmppath + '\WCC.EXE';
    str_params := '/P ' + filename + ' /pc /fo=temp.ssl';
{$IFDEF BUILD_ScriptExporter}
    senddebugmsg(PChar('PreProcessing pass: ' + str_info + ' ' + str_params));
 {$ENDIF}
    res := ShellExec('Open', PChar(str_info), PChar(str_params), '', SW_HIDE, True);
    //writeln('Attempt to copy --> ',extractfiledir(paramstr(0))+'\temp.ssl');
    //CopyFile(extractfiledir(paramstr(0))+'\temp.i','temp.ssl');
  except
    on e: Exception do
    begin
   {$IFDEF BUILD_ScriptExporter}
      MessageDlg(format('[COMPILER]' + #13 + #10 + 'Exception occured:' + #13 + #10 +
        '' + #13 + #10 + '%s', [e.message]), mtError, [mbOK], 0);
    {$ENDIF}
      exit;
    end;
  end;

end;


function DoCompile(filename: string; localcompile: boolean = False): boolean;
var
  s: integer;
  themsg: string;
begin

  PreProcess(filename);
{$IFDEF BUILD_ScriptExporter}
  senddebugmsg(PChar('FILE EXISTS: temp.ssl=' + booltostr(fileexists('temp.ssl'), True)));
{$ENDIF}
  if fileexists('temp.ssl') then
  begin
{$IFDEF BUILD_ScriptExporter}
    senddebugmsg('Attempting to compile script');
{$ENDIF}
 {$IFDEF CONSOLE}
 //  writeln ('Compiling script..');
 {$ENDIF}
    s := CompileScript('temp.ssl');
//  writeln('s: ',s);
    if s = 0 then
    begin
{$IFDEF BUILD_ScriptExporter}
      senddebugmsg('Returned from compiler.');
{$ENDIF}
      if fileexists(changefileext(filename, '.int')) then
        DeleteFile(changefileext(filename, '.int'));

      if renamefile('temp.int', changefileext(filename, '.int')) = True then
      begin
          {$IFDEF BUILD_ScriptExporter}
          senddebugmsg(PChar('Successful rename of temp.int to ' +
          changefileext(filename, '.int')));
          {$ENDIF}
         {$IFDEF CONSOLE}
        // writeln('Successfully renamed temp.int to '+changefileext(filename, '.int'));

         {$ENDIF}
        if localcompile = False then
        begin
          // attempt to copy the script to where it's supposed to be
           try
            copyfile(changefileext(filename, '.int'), script_output + '\');
            deletefile(changefileext(filename, '.int'));
          except
            on e: Exception do
            begin
              writeln('FATAL: ', e.message);
            //  halt;
            end
          end;

        end;

      end
      else
      begin
        {$IFDEF CONSOLE}writeln
       {$ELSE}
        ShowMessage
{$ENDIF}
        ('Error while renaming file!');
      end;

      deletefile('temp.ssl');
      Result := True;
    end
    else

    if s <> 0 then
    begin
      writeln('error detected');
      if @GetLastCompilerError <> nil then
      begin
{$IFDEF BUILD_ScriptExporter}
        senddebugmsg('Compiler returned error, last error was:');
{$ENDIF}
        themsg := GetLastCompilerError;
{$IFDEF BUILD_ScriptExporter}
        senddebugmsg(PChar(themsg));
        {$ELSE}
        // remove extra crap from string returned by the DLL
         themsg := StringReplace(themsg,#10,'',[rfReplaceAll]);
        {$IFDEF CONSOLE}writeln{$ELSE}showmessage{$ENDIF}('Error while compiling: ' + themsg);
        {$ENDIF}
        Result := False;
      end else
      begin

      end;

    end;
  end;
end;

procedure DeInitCompiler;
var
  free_res: boolean;
begin
  if libhandle <> 0 then
  begin
    free_res := FreeLibrary(libhandle);
   {$IFDEF BUILD_ScriptExporter}
    if free_res = true then
    senddebugmsg('Compiler DeInit successful!') else
    senddebugmsg('Compiler DeInit failed!');
   {$ENDIF}
  end;

end;

function InitCompiler(DLLpath: string): boolean;
begin
  //writeln('Compiler INIT: '+dllpath);
  cmppath := dllpath;
  libhandle := LoadLibrary(PChar(cmppath + '\ScriptCompiler.dll'));
  if libhandle = 0 then
  begin
  {$IFDEF BUILD_ScriptExporter}senddebugmsg
  {$ELSE}
    writeln
{$ENDIF}
    ('Compiler load failed, possibly looking from wrong directory.');

  end
  else
  if libhandle <> 0 then
  begin
    @CompileScript := GetProcAddress(libhandle, 'CompileFile');
    @GetLastCompilerError :=
      GetProcAddress(libhandle, 'GetLastErrorMessage');
    if (@CompileScript <> nil) and (@GetLastCompilerError <> nil) then
    begin
   {$IFDEF BUILD_ScriptExporter}
   senddebugmsg
  ('Compiler successfully initialized.');
    {$ENDIF}
  //writeln('Compiler successfully initialized.');
      Result := True;
    end
    else
    begin
  {$IFDEF BUILD_ScriptExporter}
      senddebugmsg('Compiler initialization failed.');
  {$ENDIF}
  //  writeln('Compiler initialization failed.');
      Result := False;
    end;
  end;
end;

end.

