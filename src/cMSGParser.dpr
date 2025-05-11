program cMSGParser;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  MSGParser;

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
  MSGParser1 : TMSGParser;
  DisplayObj : TDisplayObj;

{ TDisplayObj }

function TDisplayObj.CustomErrorEvent(Sender: TObject;
  const ErrorCode: integer; const Data : string): string;
begin
  Result := 'Error: ' + IntToStr(ErrorCode);
end;

procedure TDisplayObj.OnSuccess(Sender : TObject);
begin
  Writeln('Compile sucessful');
  Writeln(ResultStr + ChangeFileExt(ParamStr(1),'.lst'));
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
  Write('MSGParser');
  Writeln('  - ' + MSGParser1.Version
    + FormatDateTime(' (ddddd t)',MSGParser1.BuildDate));
  Writeln('    ' + MSGParser1.VersionComment);
  Writeln('    Author: ' + MSGParser1.GrammarAuthor);
  Writeln('    ' + MSGParser1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cMSGParser [filename]');
  Writeln('Example: cMSGParser Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  MSGParser1 := TMSGParser.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      MSGParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      MSGParser1.OnSuccess := DisplayObj.OnSuccess;
      MSGParser1.OnFailure := DisplayObj.OnFailure;

      MSGParser1.SourceFileName := ParamStr(1);
      MSGParser1.Execute;
      MSGParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    MSGParser1.Free;
  end;

end.    
