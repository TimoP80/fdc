program cSSLParser;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  CocoBase,
  SSLParser;

const
  ResultStr = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  Private
    function CustomErrorEvent(Sender: TObject; const ErrorCode: Integer; const Data: String): String;
    procedure OnError(Sender: TObject; Error: TCocoError);
    procedure OnSuccess(Sender: TObject);
    procedure OnFailure(Sender: TObject; NumErrors: Integer);
  end; // DisplayObj

var
  SSLParser1: TSSLParser;
  DisplayObj: TDisplayObj;

  { TDisplayObj }

  procedure TDisplayObj.OnError(Sender: TObject; Error: TCocoError);
  begin
    writeln('ERROR EVENT CALLED');

   writeln('error of type ',sslparser1.ErrorStr(Error.ErrorCode, ''),' and code ',Error.ErrorCode,' of data ', error.Data, ' on line ', error.line,' column ', error.col);

  end;

  function TDisplayObj.CustomErrorEvent(Sender: TObject; const ErrorCode: Integer; const Data: String): String;
  begin
    writeln('ERROR EVENT CALLED');
    Result := 'Error: ' + IntToStr(ErrorCode);
  end;

  procedure TDisplayObj.OnSuccess(Sender: TObject);
  begin
    Writeln('Compile sucessful');
    Writeln(ResultStr + ChangeFileExt(ParamStr(1), '.lst'));
  end;

  procedure TDisplayObj.OnFailure(Sender: TObject; NumErrors: Integer);
  begin

    Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
    if NumErrors <> 1 then
      Writeln('s')
    else
      Writeln;
    Writeln(ResultStr + ChangeFileExt(ParamStr(1), '.lst'));
  end;

  procedure ShowVersion;
  begin
    Write('SSLParser');
    Writeln('  - ' + SSLParser1.Version + FormatDateTime(' (ddddd t)', SSLParser1.BuildDate));
    Writeln('    ' + SSLParser1.VersionComment);
    Writeln('    Author: ' + SSLParser1.GrammarAuthor);
    Writeln('    ' + SSLParser1.GrammarCopyright);
    Writeln;
  end;

  procedure ShowHelp;
  begin
    Writeln('Usage: cSSLParser [filename]');
    Writeln('Example: cSSLParser Test.txt');
  end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  SSLParser1 := TSSLParser.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if not FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      SSLParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      SSLParser1.OnSuccess := DisplayObj.OnSuccess;
      SSLParser1.OnFailure := DisplayObj.OnFailure;
      SSLParser1.OnError := DisplayObj.OnError;
      SSLParser1.SourceFileName := ParamStr(1);
      SSLParser1.Execute;
      SSLParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1), '.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    SSLParser1.Free;
  end;

end.
