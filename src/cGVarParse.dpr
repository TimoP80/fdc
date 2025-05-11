program cGVarParse;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  GVarParse;

const
  ResultStr = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender : TObject; const ErrorCode : integer;
      const Data : string) : string;
    procedure OnSuccess(Sender : TObject);
    procedure OnFailure(Sender : TObject; NumErrors : integer);
  end; // DisplayObj

var
  GVarParse1 : TGVarParse;
  DisplayObj : TDisplayObj;

{ TDisplayObj }

function TDisplayObj.CustomErrorEvent(Sender: TObject;
  const ErrorCode: integer; const Data : string): string;
begin
  Result := 'Error: ' + IntToStr(ErrorCode);
end;

procedure TDisplayObj.OnSuccess(Sender : TObject);
begin

end;

procedure TDisplayObj.OnFailure(Sender : TObject; NumErrors : integer);
begin
  Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
  if NumErrors <> 1 then
    Writeln('s')
  else
    Writeln;
  Writeln(ResultStr + ChangeFileExt(ParamStr(1),'.lst'));
end;

procedure ShowVersion;
begin
  Write('GVarParse');
  Writeln('  - ' + GVarParse1.Version
    + FormatDateTime(' (ddddd t)',GVarParse1.BuildDate));
  Writeln('    ' + GVarParse1.VersionComment);
  Writeln('    Author: ' + GVarParse1.GrammarAuthor);
  Writeln('    ' + GVarParse1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cGVarParse [filename]');
  Writeln('Example: cGVarParse Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  GVarParse1 := TGVarParse.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      GVarParse1.OnCustomError := DisplayObj.CustomErrorEvent;
      GVarParse1.OnSuccess := DisplayObj.OnSuccess;
      GVarParse1.OnFailure := DisplayObj.OnFailure;

      GVarParse1.SourceFileName := ParamStr(1);
      GVarParse1.Execute;
      writeln('Parsed ',gvarcount,' variables');
    finally
      DisplayObj.Free;
    end;
  finally
    GVarParse1.Free;
  end;

end.    
