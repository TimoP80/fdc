unit SSLPreprocessingPass;

interface

uses System.SysUtils, System.RegularExpressions, system.classes;

type
  NodeInfo = record
    nodename: string;
    is_dialogue_node: boolean;
  end;

var
  NodeInfoData: array of NodeInfo;
  nodeinfocnt: integer;

procedure Preprocess(filename: string);

function GetProcInfoIndex(procname: string): integer;
function is_dialogue_node(procname: string): boolean;
procedure DumpDialogueNodes;

implementation
procedure DumpDialogueNodes;
var i: integer;
begin
 for i := 0 to nodeinfocnt-1 do
  begin
    if nodeinfodata[i].is_dialogue_node=true then
    writeln(nodeinfodata[i].nodename);
  end;
end;
function GetProcInfoIndex(procname: string): integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to nodeinfocnt - 1 do
  begin
    if NodeInfoData[i].nodename = procname then
    begin
      result := i;
      exit;

    end;
  end;
end;

procedure AddProcInfo(procname: string);
begin
  setlength(NodeInfoData, nodeinfocnt + 1);
  NodeInfoData[nodeinfocnt].nodename := procname;
  NodeInfoData[nodeinfocnt].is_dialogue_node := false;
  inc(nodeinfocnt);
end;

function is_dialogue_node(procname: string): boolean;
var
  nodeinfoindex: integer;
begin
  result := false;
  nodeinfoindex := GetProcInfoIndex(procname);
  if nodeinfoindex <> -1 then
  begin
    result := NodeInfoData[nodeinfoindex].is_dialogue_node;
  end;

end;

procedure SetProcInfo(procname: string; is_node: boolean);
var
  nodeinfoindex: integer;
begin
  nodeinfoindex := GetProcInfoIndex(procname);
  if nodeinfoindex <> -1 then
  begin
    NodeInfoData[nodeinfoindex].is_dialogue_node := is_node;
  end;

end;

procedure Preprocess(filename: string);
var
  scriptdata: tstrings;
  line: string;
  i: integer;
  Match: TMatch;
  procedurename: string;
  currentproc: string;
begin

  scriptdata := TStringlist.create;

  scriptdata.LoadFromFile(filename);

  for i := 0 to scriptdata.count - 1 do
  begin
    line := scriptdata[i];
    if (pos('procedure', scriptdata[i]) <> 0)  then
    begin
    //  writeln('Procedure found!');

    if pos('begin', Line) = 0 then
      begin
        Match := TRegEx.Match(Line, 'procedure\s+(\w+)', [roIgnoreCase]);

        if Match.Success then
        begin
          procedurename := Match.Groups[1].Value;
    //      CurrentProcedure.Name := procname;
       end;

      end else

     procedurename := Copy(line, 11, pos(' ', line, 11) - 11);
    //  writeln(' name: ', procedurename);
      currentproc := procedurename;
      AddProcInfo(procedurename);
    end
    else if pos('Reply', scriptdata[i]) <> 0 then
    begin
    //  writeln('found Reply command inside ', procedurename);
      SetProcInfo(currentproc, true);
    end;

  end;
end;

end.
