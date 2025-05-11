
unit ScriptRegister;

interface

uses
  pluginfunc,
  dialogs, Classes,
  SysUtils;

type
  scriptLSTentry = record
    scriptfilename: string;
    scriptdesc:     string;
    localvars:      integer;
    script_id:      string;
  end;

var
  scriptlstentries: array [0..5000] of ^scriptlstentry;
  scriptlstentrycnt: integer;
  headerspath, fo2basepath: string;
  scriptlist: TStrings;

procedure LoadScriptList(filename: string);

implementation


procedure LoadScriptList(filename: string);
var  curline: string;
  temp1, temp2, temp3: string;
  t: integer;
begin
scriptlist        := TStringList.Create;
  scriptlist.loadfromfile(filename);
  scriptlstentrycnt := 0;
  for t := 0 to scriptlist.Count - 1 do
  begin
    curline := scriptlist[t];

    new(scriptlstentries[scriptlstentrycnt]);
    temp1   := copy(curline, 1, pos(';', curline) - 1);
    temp1   := Trim(temp1);
    //senddebugmsg(pchar('Script #'+inttostr(scriptlstentrycnt)+' filename == '+temp1));
    temp2   := copy(curline, pos(';', curline) + 2, pos('#', curline) - 2);
    temp3   := copy(curline, pos('#', curline) + 2, length(curline));
    temp2   := StringReplace(temp2, '# ' + temp3, '', [rfReplaceAll]);
    temp2   := Trim(temp2);
    temp3   := Trim(temp3);
    temp3   := stringreplace(temp3, 'local_vars=', '', [rfReplaceAll]);
    temp3   := stringreplace(temp3, '#', '', [rfReplaceAll]);
    scriptlstentries[scriptlstentrycnt].scriptfilename := temp1;
    scriptlstentries[scriptlstentrycnt].scriptdesc     := temp2;
    try
    scriptlstentries[scriptlstentrycnt].localvars      := StrToInt(temp3);
    except on EConvertError do
    begin
     showmessage('ERROR READING LIST, line '+inttostr(scriptlstentrycnt)+#13#10+'line dump: '+scriptlist[t]);
    end;
    end;

    Inc(scriptlstentrycnt);
  end;

end;

end.

