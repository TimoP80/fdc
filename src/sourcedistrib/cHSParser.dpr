program cHSParser;
{$APPTYPE CONSOLE}

uses
  Classes, arcmsg, parseholodisk, holofrmmain,CocoBase, HSParser, SysUtils;
const
  ResultStr   = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender: TObject; const ErrorCode: integer; const Data: string): string;
    procedure onError(Sender: TObject; Error: TCocoError);
    procedure OnSuccess(Sender: TObject);
    procedure OnFailure(Sender: TObject; NumErrors: integer);
  end; // DisplayObj

var
  HSParser1:  THSParser;
  DisplayObj: TDisplayObj;
  x:          integer;
  SourceList: TStringList;
  { TDisplayObj }

  procedure TDisplayObj.onError(Sender: TObject; Error: TCocoError);
  var str:  string;
  var test: integer;
  var line: integer;
  var EOF:  boolean;
  begin;
    line := 0;
    test := error.line;
    while not EOF do
    begin;
      HSParser1.GetLine(test, str, EOF);
      Inc(line);
      if line = error.line then
        writeln(str);
      //writeln ('LINE: ',line);

    end;


    if error.Data <> '' then
      writeln(HSParser1.errorstr(error.errorcode, error.Data), ' (', error.Data, ') at line ', error.Line
        , ' column ', error.col) else
      writeln(HSParser1.errorstr(error.errorcode, error.Data), ' at line ', error.Line, ' column ', error.col);
  end;

  function TDisplayObj.CustomErrorEvent(Sender: TObject; const ErrorCode: integer; const Data: string): string;
  begin
    Result := 'Error: ' + IntToStr(ErrorCode);
  end;

  procedure TDisplayObj.OnSuccess(Sender: TObject);
  begin
    Writeln(HSParser1.sourcefilename + ' successfully parsed.');
  end;

  procedure TDisplayObj.OnFailure(Sender: TObject; NumErrors: integer);
  begin
    Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
    if NumErrors <> 1 then
      Writeln('s')
    else
      Writeln;
  end;

  procedure ShowVersion;
  begin
    Write('HSParser');
    Writeln('  - ' + HSParser1.Version + FormatDateTime(' (ddddd t)', HSParser1.BuildDate));
    Writeln('    ' + HSParser1.VersionComment);
    Writeln('    Author: ' + HSParser1.GrammarAuthor);
    Writeln('    ' + HSParser1.GrammarCopyright);
    Writeln;
  end;

  procedure preprocess(filename: string);
  var t:       Text;
  var x:       integer;
  var newfile: string;
  var str:     string;
  begin;
    assignfile(t, filename);
    reset(t);
    while not EOF(t) do
    begin;
      readln(t, str);
      if pos('#include', str) <> 0 then
      begin;
        x       := pos('"', str) + 1;
        newfile := '';
        while str[x] <> '"' do
        begin;
          newfile := newfile + str[x];
          Inc(x);
        end;
        newfile := newfile + '.nss';
        sourcelist.add(newfile);
      end;

    end;

  end;

  procedure ShowHelp;
  begin
    Writeln('Usage: cHSParser [filename]');
    Writeln('Example: cHSParser Test.txt');
  end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  HSParser1 := THSParser.Create(NIL);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if not FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      //   sourcelist := TStringList.create;
      //  PreProcess(paramstr(1));

      HSParser1.OnError := DisplayObj.onError;

      HSParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      HSParser1.OnSuccess     := DisplayObj.OnSuccess;
      HSParser1.OnFailure     := DisplayObj.OnFailure;
      holocnt:=0;
     parse_mes('pipboy_empty.msg',pipboydata);
      writeln('compiling main file ''', ParamStr(1), '''');
      HSParser1.SourceFileName := ParamStr(1);
try
      HSParser1.Execute;
      //       HSParser1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      HSParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1), '.lst'));
except on e:exception do
begin;
end;
end;

    finally
      DisplayObj.Free;
    end;
  finally
    HSParser1.Free;
  end;

end.

