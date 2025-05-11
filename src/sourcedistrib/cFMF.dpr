program cFMF;
{$APPTYPE CONSOLE}

uses
  CocoBase, classes,SysUtils,
  FMF;

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
  FMF1 : TFMF;
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
FMF1.GetLine(test,str, eof);
inc(line);
if line=error.line then
writeln(str);
//writeln ('LINE: ',line);

end;


if error.data<>'' then
writeln (FMF1.errorstr(error.errorcode,error.data), ' (',error.data,') at line ',error.Line ,' column ',error.col) else
writeln (FMF1.errorstr(error.errorcode,error.data), ' at line ',error.Line ,' column ',error.col);
    end;

function TDisplayObj.CustomErrorEvent(Sender: TObject;
  const ErrorCode: integer; const Data : string): string;
begin
  Result := 'Error: ' + IntToStr(ErrorCode);
end;

procedure TDisplayObj.OnSuccess(Sender : TObject);
begin
  Writeln(FMF1.sourcefilename+' successfully parsed.');
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
  Write('FMF');
  Writeln('  - ' + FMF1.Version
    + FormatDateTime(' (ddddd t)',FMF1.BuildDate));
  Writeln('    ' + FMF1.VersionComment);
  Writeln('    Author: ' + FMF1.GrammarAuthor);
  Writeln('    ' + FMF1.GrammarCopyright);
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
  Writeln('Usage: cFMF [filename]');
  Writeln('Example: cFMF Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  FMF1 := TFMF.Create(nil);
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

        FMF1.OnError := DisplayObj.onError;

        FMF1.OnCustomError := DisplayObj.CustomErrorEvent;
      FMF1.OnSuccess := DisplayObj.OnSuccess;
      FMF1.OnFailure := DisplayObj.OnFailure;

      writeln ('compiling main file ''',paramstr(1),'''');
      FMF1.SourceFileName := ParamStr(1);

      FMF1.Execute;
//       FMF1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      FMF1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    FMF1.Free;
  end;

end.    
