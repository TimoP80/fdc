program cGVARParser;
{$APPTYPE CONSOLE}

uses
  CocoBase, classes,SysUtils,
  GVARParser;

const
  ResultStr = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender : TObject; const ErrorCode : integer;
      const Data : string) : string;
    procedure onError (Sender : TObject; Error : TCocoError);
    procedure OnSuccess(Sender : TObject);
    procedure OnFailure(Sender : TObject; NumErrors : integer);
  end; // DisplayObj

var
  GVARParser1 : TGVARParser;
  DisplayObj : TDisplayObj;
  x: integer;
  SourceList: TStringList;
{ TDisplayObj }

procedure TDisplayObj.onError (Sender : TObject; Error : TCocoError);
var str: string;
var test: integer;
var line: integer;
var eof: boolean;
begin;
line := 0;
test := error.line;
while not eof do
begin;
GVARParser1.GetLine(test,str, eof);
inc(line);
if line=error.line then
writeln(str);
//writeln ('LINE: ',line);

end;


if error.data<>'' then
writeln (GVARParser1.errorstr(error.errorcode,error.data), ' (',error.data,') at line ',error.Line ,' column ',error.col) else
writeln (GVARParser1.errorstr(error.errorcode,error.data), ' at line ',error.Line ,' column ',error.col);
    end;

function TDisplayObj.CustomErrorEvent(Sender: TObject;
  const ErrorCode: integer; const Data : string): string;
begin
  Result := 'Error: ' + IntToStr(ErrorCode);
end;

procedure TDisplayObj.OnSuccess(Sender : TObject);
begin
  Writeln(GVARParser1.sourcefilename+' successfully parsed.');
end;

procedure TDisplayObj.OnFailure(Sender : TObject; NumErrors : integer);
begin
  Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
  if NumErrors <> 1 then
    Writeln('s')
  else
    Writeln;
end;

procedure ShowVersion;
begin
  Write('GVARParser');
  Writeln('  - ' + GVARParser1.Version
    + FormatDateTime(' (ddddd t)',GVARParser1.BuildDate));
  Writeln('    ' + GVARParser1.VersionComment);
  Writeln('    Author: ' + GVARParser1.GrammarAuthor);
  Writeln('    ' + GVARParser1.GrammarCopyright);
  Writeln;
end;

procedure preprocess(filename: string);
var t: text;
var x: integer;
var newfile: string;
var str: string;
begin;
assignfile(t, filename);
reset(t);
while not eof(t) do
begin;
readln(t, str);
if pos('#include',str)<>0 then
begin;
x:=pos('"',str)+1;
newfile := '';
while str[x]<>'"' do
begin;
newfile := newfile + str[x];
inc(x);
end;
newfile:=newfile + '.nss';
sourcelist.add(newfile);
end;

end;

end;

procedure ShowHelp;
begin
  Writeln('Usage: cGVARParser [filename]');
  Writeln('Example: cGVARParser Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  GVARParser1 := TGVARParser.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
     //   sourcelist := TStringList.create;
     //  PreProcess(paramstr(1));

        GVARParser1.OnError := DisplayObj.onError;

        GVARParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      GVARParser1.OnSuccess := DisplayObj.OnSuccess;
      GVARParser1.OnFailure := DisplayObj.OnFailure;

      writeln ('compiling main file ''',paramstr(1),'''');
      GVARParser1.SourceFileName := ParamStr(1);

      GVARParser1.Execute;
//       GVARParser1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      GVARParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    GVARParser1.Free;
  end;

end.    
