(*

FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen

Commandline script compiler tool

This tool performs the preprocessing pass to remove the need
for using a batch file. It also supports wildcards so you
can compile all scripts in one go if you wish.

-----------------------------------------------------------

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

program FMFSSLC;{$APPTYPE CONSOLE}

uses
  Windows,
  Classes,
  ScriptCompilerIntf,
  JclFileUtils,
  Registry,
  Inifiles,
  SysUtils;

var
  reg: TRegistry;
  suppress_errors: boolean;
  recurse: boolean;
  localcompile: boolean;
  scriptlist: TStrings;
  t: integer;
  inputfile, headerspath, Data: string;
  config, condcfg: TInifile;
begin
  writeln('FMF Preprocessing SSL Script Compiler (c) 2006-2018 Dj Unique');
  writeln('---------------------------------------------------------------');
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.access := KEY_READ;
  if reg.OpenKey('Software\FMF Dialogue Tool', False) then
  begin
    Data := reg.ReadString('installpath');
    writeln('data: '+data);
    config := TInifile.Create(Data + '\fdc.ini');
    headerspath := config.readstring('Global Config', 'HeadersPath', '');
    script_output := config.readstring('Global Config', 'DirectCompilePath', '');
    InitCompiler(Data + '\plugins');
    headerspath := config.readstring('Global Config', 'HeadersPath', '');
  end else
  begin
    writeln('Header configuration invalid (null string)!');
    exit;
  end;


  if paramcount = 0 then
  begin
    writeln('Usage: FMFSSLC.EXE <scriptname/wildcard> [-r] [-s] [-l]');
    writeln;
    writeln('     -r            recursive file searching');
    writeln;
    writeln('     -s            suppress errors - continue going through the ');
    writeln('                   script list until the end regardless of errors');
    writeln;
    writeln('     -l            local compile, output script to the same path');
    writeln('                   as the source file. If not specified the script ');
    writeln('                   goes to ' + script_output);
    reg.Free;
    exit;
  end;

  inputfile := ParamStr(1);
  suppress_errors := false;
  recurse := false;
  localcompile := false;
  writeln('Options:');
  for t := 2 to paramcount do
  begin
    if ParamStr(t) = '-r' then
    begin
      recurse := True;
    end;
    if ParamStr(t) = '-s' then
    begin
      suppress_errors := True;
    end;
    if ParamStr(t) = '-l' then
      localcompile := True;

  end;
  writeln('# Input filename / mask: ' + inputfile);
  if recurse = True then
    writeln('# Recursive compiling');
  if suppress_errors = True then
    writeln('# Suppressing errors');
  if localcompile=true then
  writeln('# Local compile');

  // The filename parameter is a wildcard
  if pos('*', inputfile) <> 0 then
  begin
    scriptlist := TStringList.Create;
    if recurse = True then
      advbuildfilelist(getcurrentdir + '\' + inputfile, faAnyFile, scriptlist,
        amAny, [flFullNames, flRecursive])
    else

      advbuildfilelist(getcurrentdir + '\' + inputfile, faAnyFile, scriptlist,
        amAny, [flFullNames]);
    if scriptlist.Count = 0 then
    begin
      writeln('No files found matching mask ' + inputfile);
    end else
    begin
     writeln(scriptlist.count,' files.');

      for t := 0 to scriptlist.Count - 1 do
      begin
        Write('Compiling ', extractfilename(scriptlist[t]), '...');
        if DoCompile(scriptlist[t], localcompile) = True then
        begin
          writeln('OK!');
        end else
        begin
          writeln('ERROR!');
          if suppress_errors = False then
            halt;
        end;
     
      end;
    end;

  end else
    // The filename parameter is a specific file
  begin
    if extractfileext(ParamStr(1)) = '' then
    begin
      inputfile := ParamStr(1) + '.ssl';
    end;
    if fileexists(inputfile) = False then
    begin
      writeln('File "', inputfile, '" not found!');
      exit;
    end;

    if DoCompile(inputfile, localcompile) = True then
    begin
      writeln('Compile successful!');
    end;

  end;

end.

