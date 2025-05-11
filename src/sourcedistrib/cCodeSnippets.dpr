program cCodeSnippets;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  CodeSnippets;

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
  CodeSnippets1 : TCodeSnippets;
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
  Write('CodeSnippets');
  Writeln('  - ' + CodeSnippets1.Version
    + FormatDateTime(' (ddddd t)',CodeSnippets1.BuildDate));
  Writeln('    ' + CodeSnippets1.VersionComment);
  Writeln('    Author: ' + CodeSnippets1.GrammarAuthor);
  Writeln('    ' + CodeSnippets1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cCodeSnippets [filename]');
  Writeln('Example: cCodeSnippets Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  CodeSnippets1 := TCodeSnippets.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      CodeSnippets1.OnCustomError := DisplayObj.CustomErrorEvent;
      CodeSnippets1.OnSuccess := DisplayObj.OnSuccess;
      CodeSnippets1.OnFailure := DisplayObj.OnFailure;

      CodeSnippets1.SourceFileName := ParamStr(1);
      CodeSnippets1.Execute;
      CodeSnippets1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    CodeSnippets1.Free;
  end;

end.    
