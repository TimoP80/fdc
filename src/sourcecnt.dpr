program sourcecnt;

{$APPTYPE CONSOLE}

uses
  Classes,
  JclFileUtils,
  SysUtils;

var
  curfile: TStrings;
  j: integer;

  displayhelp, count_em_lines: boolean;
  update_inc: boolean;
  ext: string;
  version_inc, files: TStrings;
  totalcount: integer;
  totalfloat: extended;
begin
  files := TStringList.Create;
  curfile := TStringList.Create;
  version_inc := TStringList.Create;
  displayhelp := False;
  update_inc := False;
  count_em_lines := False;
  for j := 1 to paramcount do


  begin
    if ParamStr(j) = '--help' then
    begin
      displayhelp := True;
    end;

    if ParamStr(j) = '-ext' then
      ext := ParamStr(j + 1);

    if ParamStr(j) = '-updateinc' then
      update_inc := True;

    if ParamStr(j) = '-emlines' then
      count_em_lines := True;

  end;

  if displayhelp then
  begin
    writeln('-updateinc         Update Elektromania sourcecode INC file');
    writeln('-emlines           count elektromania lines');
    writeln('-ext               Specify an extension to check (recursive)');
    exit;
  end;

  if count_em_lines then
  begin
    AdvBuildFileList(getcurrentdir + '\*.ssl', faAnyFile, files, amAny, [flFullNames]);
    AdvBuildFileList(getcurrentdir + '\*.pas', faAnyFile, files, amAny, [flFullNames]);
    AdvBuildFileList(getcurrentdir + '\*.dpr', faAnyFile, files, amAny, [flFullNames]);
  end else
    AdvBuildFileList(getcurrentdir + '\*.' + ext, faAnyFile, files, amAny, [flFullNames, flrecursive]);

  writeln(files.Count, ' source files found in list.');
  totalcount := 0;
  for j := 0 to files.Count - 1 do
  begin
    Write(extractfilename(files[j]));
    curfile.LoadFromFile(files[j]);
    Inc(totalcount, curfile.Count);
    writeln(' -> ', curfile.Count, ' lines.');
    curfile.Clear;
  end;
  writeln('Total lines of code: ', totalcount);
  totalfloat := totalcount;
(*

const

ELEKTROMANIA_VERSION = '0.90';
ELEKTROMANIA_EDITOR = '0.95';
ELEKTROMANIA_ScriptEngine = '0.15';
LINES_OF_CODE = '56,136';
SAVEGAME_VERSION = '0.90';

*)
  if update_inc then
  begin
    ThousandSeparator := ',';
    version_inc.Add('const');
    version_inc.Add('');
    version_inc.Add('ELEKTROMANIA_VERSION = ''0.92'';');
    version_inc.Add('ELEKTROMANIA_EDITOR = ''0.97'';');
    version_inc.Add('ELEKTROMANIA_ScriptEngine = ''0.15'';');
    version_inc.Add('LINES_OF_CODE = ''' + format('%0.0n', [totalfloat]) + ''';');

    version_inc.Add('LINES_OF_CODE_INT = ' + format('%d', [totalcount]) + ';');
    version_inc.Add('SAVEGAME_VERSION = ''0.92'';');

    version_inc.SaveToFile('version.inc');

  end;

end.
