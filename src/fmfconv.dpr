program fmfconv;
{$APPTYPE CONSOLE}

uses
   ExceptionLog,
  CocoBaseNew, SharedDLGDAta,Classes, SysUtils, FMF;
const
  ResultStr = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender: TObject; const ErrorCode: integer;
      const Data: string): string;
    procedure onError(Sender: TObject; Error: TCocoError);
    procedure OnSuccess(Sender: TObject);
    procedure OnFailure(Sender: TObject; NumErrors: integer);
  end; // DisplayObj

var
  FMF1: TFMF;
  DisplayObj: TDisplayObj;
  x:    integer;
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
      FMF1.GetLine(test, str, EOF);
      Inc(line);
      if line = error.line then
        writeln(str);
      //writeln ('LINE: ',line);

    end;


    if error.Data <> '' then
      writeln(FMF1.errorstr(error.errorcode, error.Data),
        ' (', error.Data, ') at line ', error.Line, ' column ', error.col)
    else writeln(FMF1.errorstr(error.errorcode, error.Data),
        ' at line ', error.Line, ' column ', error.col);
  end;

  function TDisplayObj.CustomErrorEvent(Sender: TObject; const ErrorCode: integer;
  const Data: string): string;
  begin
    Result := 'Error: ' + IntToStr(ErrorCode);
  end;

  procedure TDisplayObj.OnSuccess(Sender: TObject);
  begin
    Writeln(FMF1.sourcefilename + ' successfully parsed.');
  end;

  procedure TDisplayObj.OnFailure(Sender: TObject; NumErrors: integer);
  begin
    Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
    if NumErrors <> 1 then
      Writeln('s')
    else Writeln;
  end;

  procedure ShowVersion;
  begin
    writeln('FMF Dialogue Tool - Format converter v1.0 (c) 2005 Dj Unique');
    writeln;
  end;

  procedure preprocess(filename: string);
  var t:   Text;
  var x:   integer;
  var newfile: string;
  var str: string;
  begin;
    assignfile(t, filename);
    reset(t);
    while not EOF(t) do
    begin;
      readln(t, str);
      if pos('#include', str) <> 0 then
      begin;
        x := pos('"', str) + 1;
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
    Writeln('Usage: ', changefileext(extractfilename(ParamStr(0)), ''), ' [filename]');
    Writeln('Example: ', changefileext(extractfilename(ParamStr(0)), ''), ' test.fmf');
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
      if not FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      //   sourcelist := TStringList.create;
      //  PreProcess(paramstr(1));

      FMF1.OnError := DisplayObj.onError;

      FMF1.OnCustomError := DisplayObj.CustomErrorEvent;
      FMF1.OnSuccess     := DisplayObj.OnSuccess;
      FMF1.OnFailure     := DisplayObj.OnFailure;

      writeln('parsing file ''', ParamStr(1), '''');
      FMF1.SourceFileName := ParamStr(1);

      FMF1.Execute;
      writeln('STUFF: VARCNT: ',currentdlg.varcnt);
      //       FMF1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      //FMF1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    FMF1.Free;
  end;

end.
