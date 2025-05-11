program fmfcomp;
{$APPTYPE CONSOLE}
{$DEFINE FMFCOMP_BUILD}
uses
  Classes, CocoBaseNew, condcheck, FMF, Inifiles, jclfileutils, SharedDLGData, SysUtils;
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

type strentry = record
    index_offset: integer;
    offset:       integer;
    strind:       integer;
    strdata:      string;
  end;

var
  FMF1:        TFMF;
  DisplayObj:  TDisplayObj;
  x:           integer;
  brute_force_optimize, optimize: boolean;
  filelist:    TStringList;
  total_string_count: integer;
  true_string_count: integer;
  SourceList:  TStringList;
  stringtable: array [0..65535] of ^strentry;
  strofs, saveofs: integer;
  log:         TStrings;
  strcnt:      integer;

  { TDisplayObj }

  function string_index(str: string): integer;
  var t: integer;
  begin;
    Result := -1;
    for t := 0 to strcnt - 1 do
    begin;
      if (stringtable[t].strdata = str) then
      begin;
        Result := t;
        exit;
      end;
    end;
  end;

  function AddToStringTable(str: string; offset: integer): integer;
  begin;
    Inc(total_string_count);
    if (optimize = True) then
    begin;
      // optimize on
      if (string_index(str) = -1) then
      begin;
        new(stringtable[strcnt]);
        stringtable[strcnt].strind := strcnt;
        stringtable[strcnt].strdata := str;
        stringtable[strcnt].index_offset := offset;
        Result := strcnt;
        Inc(true_string_count);
        Inc(strcnt);
      end else
      if (string_index(str) <> -1) then
      begin;
        Result := string_index(str);
        //   if str<>'' then
        //     writeln('String '''+str+''' optimized as index ',result);
      end;
    end else
    begin;
      // optimize off
      new(stringtable[strcnt]);
      stringtable[strcnt].strind := strcnt;
      stringtable[strcnt].strdata := str;
      stringtable[strcnt].index_offset := offset;
      Result := strcnt;
      Inc(strcnt);
      Inc(true_string_count);

    end;

  end;

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

  function TDisplayObj.CustomErrorEvent(Sender: TObject; const ErrorCode: integer; const Data: string): string;
  begin
    Result := 'Error: ' + IntToStr(ErrorCode);
  end;

  procedure TDisplayObj.OnSuccess(Sender: TObject);
  begin
    //    Writeln(FMF1.sourcefilename + ' successfully compiled.');
  end;

  procedure TDisplayObj.OnFailure(Sender: TObject; NumErrors: integer);
  begin
    Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
    if NumErrors <> 1 then
      Writeln('s')
    else Writeln;
  end;

  function makespace(start: integer; stop: integer): string;
  var t: integer;
  begin;
    Result := '';
    for t := start to stop do Result := Result + ' ';
  end;

  procedure writeraw(str: string; var j: file; crypt: boolean = False; xorshift: integer = 0);
  var temp: integer;
  var nj:   integer;
  var i:    char;
  begin;
    log.add('WriteRaw: ' + str + makespace(length('WriteRaw: ' + str), 35) + IntToStr(filepos(j)));
    temp := length(str);
    for nj := 1 to temp do
    begin;
      if crypt = True then
        i := chr(Ord(str[nj]) xor xorshift) else
        i := str[nj];
      blockwrite(j, i, 1);
    end;
  end;

  procedure writeint(s: integer; var j: file; nameinfo: string = '<N/A>');
  begin;
    // writeln('writeInt ',s,' ofs=',filepos(j));
    if s > 1000000 then
    begin;
      writeln('Possible uninitialized value (' + nameinfo + ') ', s);
    end;

    log.add('WriteInt: (' + nameinfo + ') ' + IntToStr(s) + makespace(length('WriteInt: ' + IntToStr(s)), 35) +
      IntToStr(filepos(j)));
    blockwrite(j, s, 4);
  end;


  procedure writebool(s: boolean; var j: file);
  begin;
    blockwrite(j, s, 1);
  end;

  procedure writeword(s: integer; var j: file);
  begin;
    blockwrite(j, s, 2);
  end;

  procedure writeheader(str: string; var j: file);
  var temp: integer;
  var nj:   integer;
  begin;
    temp := length(str);
    for nj := 1 to temp do
    begin;
      blockwrite(j, str[nj], 1);
    end;
  end;


  procedure writestring(str: string; var j: file; nameinfo: string = 'N/A');
  var temp:  integer;
  var nj:    integer;
  var chrd:  char;
  var ur:    char;
  var Count: integer;
  var xstr:  TStringList;
  begin;
    log.add('WriteString: (' + nameinfo + ') ' + makespace(length('WriteString: ' + str), 35) +
      IntToStr(filepos(j)));

    if (brute_force_optimize = True) then
    begin;
      xstr           := TStringList.Create;
      xstr.CommaText := str;
      writeint(xstr.Count, j);
      xstr.Sort;
      for nj := 0 to xstr.Count - 1 do
      begin;
        writeint(length(xstr[nj]), j);
        temp := AddToStringTable(xstr[nj], filepos(j));
        writeint(temp, j);
        writeint(0, j);
      end;

    end else
    begin;
      writeint(length(str), j);
      // temp int for string offset
      temp := AddToStringTable(str, filepos(j));
      writeint(temp, j);
      writeint(0, j);
    end;

  end;



  procedure BinComp(outputfile: string);
  var j, x, i: integer;
  var s, t:    file;
  begin;
    strcnt := 0;
    total_string_count := 0;
    true_string_count := 0;
    log := TStringList.Create;
    log.add('FMF Binary Dialogue file - Build log - ' + datetimetostr(now));
    log.add('------------------------------------------------------------');
    log.add('');

    ResolveNodes;
    assignfile(t, outputfile);
    rewrite(t, 1);
    writeheader('FMF Binary Data ', t);
    writeheader('[Header]', t);
    writeint(currentdlg.start_time_event, t, 'start_time_event');
    writeint(currentdlg.startconditioncnt, t, 'startconditioncnt');
    writeint(currentdlg.default_cond, t);
    writeint(currentdlg.timedeventcnt, t);
    writeint(currentdlg.nodecount, t);
    writeint(currentdlg.floatnodecount, t);
    writeint(currentdlg.varcnt, t);
    writestring(currentdlg.npcname, t);
    writestring(currentdlg.description, t);
    writestring(currentdlg.location, t);
    writestring(currentdlg.unknowndesc, t);
    writestring(currentdlg.knowndesc, t);
    writestring(currentdlg.detaileddesc, t);
    writestring(changefileext(outputfile, '.fmf'), t);
    writestring(datetimetostr(now), t);
    // stringtable offset
    saveofs := filepos(t);
    writeint(0, t);
    writeheader('[Variables]', t);
    for j := 0 to currentdlg.varcnt - 1 do
    begin;
      writestring(currentdlg.variables[j].Name, t, 'VarName');
      writestring(currentdlg.variables[j].notes, t, 'VarNotes');
      writeint(currentdlg.variables[j].Value, t, 'VarValue');
      writeint(currentdlg.variables[j].flags, t, 'VarFlags');
      case currentdlg.variables[j].vartype of
        VAR_TYPE_STRING:
          writestring(currentdlg.variables[j].Value, t);
        VAR_TYPE_INT:
          writeint(currentdlg.variables[j].Value, t);
      end;

    end;

    writeheader('[TimedEvents]', t);
    for j := 0 to currentdlg.timedeventcnt - 1 do
    begin;
      writeint(currentdlg.timedevents[j].FixedParamEnumIndex,
        t, currentdlg.timedevents[j].fixedparamname + '.FixedParamEnumIndex');
      writeint(currentdlg.timedevents[j].actioncnt, t, currentdlg.timedevents[j].fixedparamname + '.actiocnt');
      writeint(currentdlg.timedevents[j].mininterval, t, currentdlg.timedevents[j].fixedparamname + '.mininterval');
      writeint(currentdlg.timedevents[j].maxinterval, t);
      writeint(currentdlg.timedevents[j].interval, t);
      writestring(currentdlg.timedevents[j].FixedParamName, t);
      for x := 0 to currentdlg.timedevents[j].actioncnt - 1 do
      begin;
        writestring(currentdlg.timedevents[j].actionlines[x].linedata, t);
      end;

    end;
    writeheader('[FloatNodes]', t);

    for J := 0 to currentdlg.floatnodecount - 1 do
    begin;
      writestring(currentdlg.floatnodes[j].nodename, t);
      writestring(currentdlg.floatnodes[j].notes, t);
      writeint(currentdlg.floatnodes[j].messagecnt, t, 'floatnodes.messagecnt');
      for x := 0 to currentdlg.floatnodes[j].messagecnt - 1 do
      begin;
        writestring(currentdlg.floatnodes[j].Messages[x], t, 'floatnodes.messages[' + IntToStr(x) + ']');
      end;
    end;


    writeheader('[RegularNodes]', t);
    for j := 0 to currentdlg.nodecount - 1 do
    begin;
      writestring(currentdlg.nodes[j].nodename, t);
    end;

    for j := 0 to currentdlg.nodecount - 1 do
    begin;
      writeint(j, t);
      writestring(currentdlg.nodes[j].npctext, t);
      writestring(currentdlg.nodes[j].npctext_female, t);
      writestring(currentdlg.nodes[j].notes, t);
      writeint(currentdlg.nodes[j].optioncnt, t);
      writeint(currentdlg.nodes[j].skillcheckcnt, t);
      for x := 0 to currentdlg.nodes[j].skillcheckcnt - 1 do
      begin;
        writestring(currentdlg.nodes[j].skillchecks[x].check_proc_name, t);
        writeint(currentdlg.nodes[j].skillchecks[x].check_what, t);
        writeint(currentdlg.nodes[j].skillchecks[x].modifier, t);
        writestring(currentdlg.nodes[j].skillchecks[x].successnode, t);
        writestring(currentdlg.nodes[j].skillchecks[x].failurenode, t);

      end;

      for x := 0 to currentdlg.nodes[j].optioncnt - 1 do
      begin;
        writestring(currentdlg.nodes[j].options[x].optiontext, t, 'optiontext');
        writestring(currentdlg.nodes[j].options[x].nodelink, t, 'nodelink');
        writestring(currentdlg.nodes[j].options[x].notes, t, 'notes');
        writebool(currentdlg.nodes[j].options[x].link_to_proc, t);
        writebool(currentdlg.nodes[j].options[x].link_to_skillcheck, t);
        writeint(currentdlg.nodes[j].options[x].reaction, t, 'reaction');
        writeint(currentdlg.nodes[j].options[x].genderflags, t, 'genderflags');
        writeint(currentdlg.nodes[j].options[x].intcheck, t, 'intcheck');
        writeint(currentdlg.nodes[j].options[x].conditioncnt, t, 'conditioncnt');
        writeint(currentdlg.nodes[j].options[x].noderesolved, t, 'noderesolved');
        if (currentdlg.nodes[j].options[x].conditioncnt > 0) then
        begin;
          for i := 0 to currentdlg.nodes[j].options[x].conditioncnt - 1 do
          begin;
            writeint(currentdlg.nodes[j].options[x].conditions[i].check_type, t);
            writeint(currentdlg.nodes[j].options[x].conditions[i].check_field, t);
            writeint(currentdlg.nodes[j].options[x].conditions[i].check_eval, t);
            writestring(currentdlg.nodes[j].options[x].conditions[i].check_value, t);
            writestring(currentdlg.nodes[j].options[x].conditions[i].resolved_code, t);
          end;

        end;

      end;

    end;

    strofs := filepos(t);
    seek(t, saveofs);
    //  writeln('Stringtable located at position ', strofs);
    writeint(strofs, t);
    seek(t, strofs);
    writeheader('[String Table]', t);
    writeint(strcnt, t);

    //    For j := 0 To strcnt - 1 Do
    //    Begin;
    //      writeint(length(stringtable[j].strdata), t);
    //    End;

    for j := 0 to strcnt - 1 do
    begin;
      saveofs := filepos(t);
      writeraw(stringtable[j].strdata, t);
      writeraw(' ', t);
      strofs  := filepos(t);
      seek(t, stringtable[j].index_offset);
      writeint(saveofs, t, 'STROffset');
      Seek(t, strofs);
    end;
    assignfile(s, FMF1.sourcefilename);
    Reset(s, 1);
    writeln(outputfile, ': ', filesize(s), ' => ', filesize(t), ' bytes.');
    closefile(s);


    closefile(t);
      log.savetofile(changefileext(outputfile, '.log'));
  end;

  procedure ShowVersion;
  begin
    writeln('FMF Dialogue Tool - FMF->Binary Compiler v1.0 (c) 2005 Dj Unique');
    writeln;
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
        newfile := newfile + '.fmf';
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
  FMF1 := TFMF.Create(NIL);
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
      for x := 2 to paramcount do
      begin;
        if ParamStr(x) = '-o' then optimize := True;
        if ParamStr(x) = '-bruteforce' then brute_force_optimize := True;
      end;


      if fileexists('..\conditions.ini') then
      begin;
        condcfg := Tinifile.Create('..\conditions.ini');

      end else
      begin;
        writeln('Condition config not found!');
        halt;
      end;
      filelist := TStringList.Create;
      AdvBuildFileList(ParamStr(1), faAnyFile, filelist, amAny);
      writeln(filelist.Count, ' matching files.');
      for x := 0 to filelist.Count - 1 do
      begin;

        FMF1.SourceFileName := filelist[x];
        FMF1.Execute;

        if fmf1.successful then
        begin;
          BinComp(changefileext(filelist[x], '.fmb'));
          if optimize = True then writeln(total_string_count, ' total strings, optimized to ',
              true_string_count, ' strings.');
        end else
          fmf1.ListStream.SaveToFile('errorlog.log');
      end;

      //writeln('STUFF: VARCNT: ', currentdlg.varcnt);

      //       FMF1.savedata(ChangeFileExt(ParamStr(1),'.ncs'));
      //FMF1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    FMF1.Free;
  end;

end.

