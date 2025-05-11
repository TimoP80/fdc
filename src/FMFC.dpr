(*


Fallout Dialogue Ceeato rCommandline compiler - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2006 T. Pitkänen

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.



*)

program FMFC;

{$APPTYPE CONSOLE}
{$DEFINE FMFCBuild}

uses
  Classes,
  CocoBase, //condcheck,
  ddf_output in 'ddf_output.pas',
  DLGDef in 'DLGDef.pas',
  FMF in 'FMF.pas',
  Inifiles,
  Registry,
  ScriptCompilerIntf in 'ScriptCompilerIntf.pas',
  shareddlgdata,
  Windows,
  SysUtils;

const
  ResultStr   = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender: TObject; const ErrorCode: integer; const Data: ansistring): ansistring;
    procedure onError(Sender: TObject; Error: TCocoError);
    procedure OnSuccess(Sender: TObject);
    procedure OnFailure(Sender: TObject; NumErrors: integer);
  end; // DisplayObj

var
  DLGDef1:    TDLGDef;
  FMFParser:  TFMF;

  Data:       string;
  reg:        TRegistry;
  DisplayObj: TDisplayObj;
  x:          integer;
  inputfile:  string;
  SourceList: TStringList;

  { TDisplayObj }

  procedure TDisplayObj.onError(Sender: TObject; Error: TCocoError);
  var
    str:  ansistring;
  var
    test: integer;
    line: integer;
    EOF:  boolean;
  begin
    line := 0;
    test := error.line;
    while not EOF do
    begin
      DLGDef1.GetLine(test, str, EOF);
      Inc(line);
      if line = error.line then
        writeln(str);

    end;

    if error.Data <> '' then
      writeln(DLGDef1.errorstr(error.errorcode, error.Data),
        ' (', error.Data, ') at line ', error.Line, ' column ', error.col)
    else
      writeln(DLGDef1.errorstr(error.errorcode, error.Data),
        ' at line ', error.Line, ' column ', error.col);
  end;

  function TDisplayObj.CustomErrorEvent(Sender: TObject; const ErrorCode: integer; const Data: ansistring): ansistring;
  begin
    Result := 'Error: ' + IntToStr(ErrorCode);
  end;

  procedure TDisplayObj.OnSuccess(Sender: TObject);
  begin
    Writeln(DLGDef1.sourcefilename + ': no errors.');
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
    writeln('Fallout Dialogue Creator Commandline Compiler');
    writeln('(c) 2003-2025 Dj Unique');
    writeln('---------------------------------------------------------');
  end;

  procedure preprocess(filename: string);
  var
    t:       Text;
    i, x:    integer;
    newfile: string;
    str:     string;
  begin
    assignfile(t, filename);
    reset(t);
    while not EOF(t) do
    begin
      readln(t, str);
      if pos('#include', str) <> 0 then
      begin
        x       := pos('"', str) + 1;
        newfile := '';
        while str[x] <> '"' do
        begin
          newfile := newfile + str[x];
          Inc(x);
        end;
        newfile := newfile + '.ddf';
        sourcelist.add(newfile);
      end;

    end;

  end;

  procedure ShowHelp;
  begin
    writeln('Usage: FMFC.exe <filename> [switches]');
    writeln;
    writeln('Valid compiler switches:');
    writeln;
    writeln('-writeref              Write MSG text entries to the SSL script');
    writeln('-debug_nodes           Insert debug message containing node name to');
    writeln('                       the beginning of each node');
    writeln('-debug_local_vars      Debug dump local variable values in talk_p_proc');
    writeln('-debug_skillchecks     Insert debug information to skillchecks');
    writeln('-int                   Compiles output file to INT');
    writeln('-msgstep <num>         Set step to increase MSG ID on each node');
    writeln('                       default=',msg_step);
    writeln('-template <name>       Use the specified script template.');
    writeln('-writevardesc          Write variable description above each variable entry.');
  end;

var
  i: integer;
begin
      msg_step    := 30;
  ShowVersion;
  direct_compile := False;

  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  try
    DLGDef1 := TDLGDef.Create(NIL);
    try
      DisplayObj := TDisplayObj.Create;
      if not FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      reg         := TRegistry.Create;
      reg.RootKey := HKEY_CURRENT_USER;
      for i := 2 to paramcount do
      begin
        ;
        if ParamStr(i) = '-int' then
        begin
          direct_compile := True;
        end;

        if ParamStr(i) = '-writevardesc' then
        begin
          include_variablenotes := True;
        end;
        if ParamStr(i) = '-writeref' then
        begin
          writeln('Inserting msg references to script.');
          write_text_data := True;
        end;
        if ParamStr(i) = '-msgstep' then
        begin
          writeln('Setting ID step to ' + ParamStr(i + 1));
          msg_step := StrToInt(ParamStr(i + 1));
        end;
        if ParamStr(i) = '-debug_nodes' then
        begin
          writeln('Inserting node name on each node.');
          debug_nodes := True;
        end;
        if ParamStr(i) = '-template' then
        begin
          template_name := ParamStr(i + 1);
          writeln('Using script template "' + template_name + '"');

        end;

        if ParamStr(i) = '-debug_skillchecks' then
        begin
          writeln('Generating debug messages for skill checks.');
          debug_skillchecks := True;
        end;
        if ParamStr(i) = '-debug_local_vars' then
        begin
          writeln('Inserting local var debug info on dialogue start.');
          debug_local_vars := True;
        end;

      end;

      if reg.OpenKey('Software\Fallout Dialogue Creator', False) then
      begin
      writeln('Opened registry');
        Data        := reg.ReadString('installpath');
        //writeln('data := ',data);
        config      := TInifile.Create(Data + '\fdc.ini');
        condcfg     := Tinifile.Create(Data + '\conditions.ini');
        headerspath := config.readstring('Global Config', 'HeadersPath', '');

        script_output := config.readstring('Global Config', 'FO2Basepath', '') + '\data\scripts';
        initDDFDumper(Data);
        if direct_compile = True then
        begin
          writeln('Compiling script after conversion.');
          InitCompiler(Data + '\plugins');
          headerspath := config.readstring('Global Config', 'HeadersPath', '');
          if headerspath <> '' then
            writeln('Headers configured at ', headerspath)
          else
          begin
            writeln('Header configuration invalid!');
            exit;
          end;

        end;

      end else
      begin
        writeln('Unable to open registry');

      end;
      if extractfileext(ParamStr(1)) = '.fmf' then
      begin
        FMFParser := TFMF.Create(NIL);
        fmfparser.SourceFileName := ParamStr(1);
        fmfparser.Execute;
        if fmfparser.successful then
        begin
          currentdlg.filename := ParamStr(1);
          inputfile := SaveFMF2DDF(currentdlg);
        end
        else
        begin
          writeln('ERROR?');
        end;
      end
      else
        inputfile := ParamStr(1);



      DLGDef1.OnError        := DisplayObj.onError;
      DLGDef1.OnCustomError  := DisplayObj.CustomErrorEvent;
      DLGDef1.OnSuccess      := DisplayObj.OnSuccess;
      DLGDef1.OnFailure      := DisplayObj.OnFailure;
      writeln('processing ''', ParamStr(1), '''');
      DLGDef1.SourceFileName := inputfile;
      DLGDef1.Execute;
      //if direct_compile´= true then DoCompile(paramstr(1),false);
      //       DLGDef1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      DLGDef1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1), '.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    DLGDef1.Free;
  end;

end.

