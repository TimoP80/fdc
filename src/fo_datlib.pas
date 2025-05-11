unit fo_datlib;

interface


 // DATFile v2.0 reader library (for Fallout 2 DAT files)
 // version 1.0



uses Classes, FileCtrl, Forms, JclMath, JclStrings, SysUtils, zlibex;

const
  max_files = 80000;

const
  FILETYPE_DIR = 1024;

const
  FILETYPE_CMP = 2;

const
  FILETYPE_UNCMP = 1;

resourcestring
  Sig = 'FO2DATLib 1.0 - (c) 2001 by DjUnique';

type
  datfilerec = record
    Filenamesize: Integer;
    filename:     String;
    opened:       Boolean;
    compressed:   Boolean;
    realsize:     Integer;
    packedsize:   Integer;
    offset:       Integer;
  end;

type
  datfileheader = record
    dirtreesize:  Integer;
    treepos:      Integer;
    dat_filename: String;
    files:        array [0..MAX_FILES] of ^datfilerec;

    filecount: Integer;
  end;

 //var datrec: datfileheader;
 //const BUF_MAX = 2048;
const
  BUFFERSIZE = 8192;

var
  buf: array [0..BUFFERSIZE - 1] of Char;
  buffer_sizes: array [0..1024] of Word;
  buffer: array [0..BUFFERSIZE - 1] of Byte;
  dlogfile, catchmsg: String;
  dlog: textfile;
  logging_enabled: Boolean;
  chars: array [0..255] of Char;
  numread, numwritten, byteswritten, bytesread: Integer;
  bufcount, lastbuf: Integer;
  src_Stream: TStream;
  dest_stream: TStream;

var
  compressor: TZCompressionStream;

procedure closedathandle(var f: file);
procedure cleanuptempfiles(var datrec: datfileheader; startupdir: String);
procedure openfilefromdat(var f: file; var datrec: datfileheader; filename: String; alt_filename: String);
procedure read_cachefile(var f: file; var cachefiles: datfileheader; path, filename: String);
function gettimestampforfile: Integer;
//procedure opendatfilewithprogressdlg(var f: file; var datrec: datfileheader; filename: string);
procedure opendatfile(var f: file; var datrec: datfileheader; filename: String);
procedure openfilefromdatwithfullpath(var f: file; var datrec: datfileheader; filename: String);
function getfileindex(var datrec: datfileheader; filename: String): Integer;
procedure cleanuprecursedtempfiles(var datrec: datfileheader; startupdir: String);
function file_exists_in_dat(filename: String; datrec: datfileheader): Boolean;
procedure create_dat_file(var f: file; var datrec: datfileheader; filename: String);
procedure add_file_to_dat(var xf: file; var datrec: datfileheader; filename: String);
function dir_exists_in_dat(filename: String; datrec: datfileheader): Boolean;
procedure init_dat_logger(startupdir: String);
procedure extract_with_wildcard(var f: file; filemask: String; var xdatfile: datfileheader);

implementation

//uses progressdlg;

procedure init_dat_logger(startupdir: String);
begin
  //showmessage ('INIT: '+startupdir);
  assignfile(dlog, startupdir + '\datlib.log');
  rewrite(dlog);
  writeln(dlog, 'FO2DATLib event log - Started on ', datetimetostr(now));
  writeln(dlog, '-----------------------------------------------------------');
  writeln(dlog);
  closefile(dlog);
  dlogfile := startupdir + '\datlib.log';
  logging_enabled := True;
end;



procedure dat_log_msg(str: String);
begin
  if logging_enabled = True then
  begin
    assignfile(dlog, dlogfile);
    append(dlog);
    writeln(dlog, datetimetostr(now), ' - ', str);
    closefile(dlog);
  end;

end;



procedure decompress(infile: String);
var
  Count: Integer;
var
  _infile, _outfile: TStream;
var
  zstream: TZDecompressionstream;
begin
  try
    //writeln ('Searching at: ',getcurrentdir);
    //writeln ('infile ',infile);
    _InFile := TFileStream.Create(infile + '.zlib', fmOpenRead);
    try

      _OutFile := TFileStream.Create(infile, fmCreate);
      try

        ZStream := TZDecompressionStream.Create(_InFile);
        try
          while True do
          begin
            Count := ZStream.Read(Buffer, BufferSize);
            if Count <> 0 then
              _OutFile.WriteBuffer(Buffer, Count)
            else
              Break;
          end;
        finally
          ZStream.Free;
        end;
        //  writeln (' ',_infile.size,' -> ',_outfile.size);
      finally
        _OutFile.Free;
      end;
    finally
      _InFile.Free;
    end;
    deletefile(infile + '.zlib');

  except
    on e: Exception do
    begin
      //  writeln('Error: ', e.message);
    end;
  end;
end;

procedure decompress_as(infile, newfile: String);
var
  Count: Integer;
var
  _infile, _outfile: TStream;
var
  zstream: TZDecompressionstream;
begin
  _InFile := TFileStream.Create(infile, fmOpenRead);
  try

    _OutFile := TFileStream.Create(newfile, fmCreate);
    try

      ZStream := TZDecompressionStream.Create(_InFile);
      try
        while True do
        begin
          Count := ZStream.Read(Buffer, BufferSize);
          if Count <> 0 then
            _OutFile.WriteBuffer(Buffer, Count)
          else
            Break;
        end;
      finally
        ZStream.Free;
        //writeln (newfile,' : ',_infile.size,' -> ',_outfile.size);

      end;

    finally
      _OutFile.Free;
    end;
  finally
    _InFile.Free;
  end;
  DeleteFile(infile);
end;



procedure read_cachefile(var f: file; var cachefiles: datfileheader; path, filename: String);
var
  t, i: Integer;
var
  ch: Char;
var
  unctotalsize: Integer;
begin

  assignfile(f, changefileext(filename, '.inf'));
  reset(f, 1);
  cachefiles.dat_filename := path + '\' + extractfilename(filename);



  //cachefiles.files[i].Filename  := '';
  blockread(f, cachefiles.filecount, 4);
  for i := 0 to cachefiles.filecount - 1 do
  begin
    new(cachefiles.files[i]);
    blockread(f, cachefiles.files[i].Filenamesize, 4);
    blockread(f, chars, cachefiles.files[i].Filenamesize);
    cachefiles.files[i].Filename := chars;
    blockread(f, cachefiles.files[i].compressed, 1);
    blockread(f, cachefiles.files[i].realsize, 4);
    blockread(f, cachefiles.files[i].packedsize, 4);
    blockread(f, cachefiles.files[i].offset, 4);
    Inc(unctotalsize, cachefiles.files[i].realsize);
  end;
  closefile(f);
  dat_log_msg('Cache_Load: ' + changefileext(filename, '.inf') + ' ' + cachefiles.dat_filename + #13#10 +
    IntToStr(cachefiles.filecount) + ' files cached.'#13#10 + IntToStr(unctotalsize) + ' bytes uncompressed.');
  //showmessage(
end;


function compress_(filename: String; compressionratio: TZCompressionlevel): Longint; // for data save functions
begin
  //writeln ('Compressing "',filename,'" at ',getcurrentdir);
  catchmsg := 'Opening source stream: ' + getcurrentdir + '\' + filename;
  src_Stream := TFilestream.Create(filename, fmopenread);

  catchmsg := 'Opening dest stream: ' + getcurrentdir + '\' + extractfilename(filename);
  dest_stream := TFilestream.Create(extractfilename(filename) + '.zlib', fmCreate);
  compressor := TZCompressionStream.Create(dest_stream, compressionratio);
  try
    compressor.copyfrom(src_stream, 0);
  finally
    begin
      if fileexists(filename) then
      begin
        //writeln ('File exists at the moment!');
      end;

      compressor.Free;
      //writeln ('Compressed to ',dest_stream.size,' byte(s) from ',src_Stream.size,' byte(s)');
      //writeln ('Deleting temp\',filename);
      Result := dest_stream.Size;
      src_stream.Free;
      dest_stream.Free;

    end;
  end;
end;



procedure add_file_to_dat(var xf: file; var datrec: datfileheader; filename: String);
var
  f: file;
var
  fnametemp: String;
begin
  new(datrec.files[datrec.filecount]);
  Assign(f, filename);
  reset(f, 1);
  datrec.files[datrec.filecount].realsize := filesize(f);
  Close(f);
  Compress_(filename, zcMax);
  Assign(f, extractfilename(filename) + '.zlib');
  reset(f, 1);
  datrec.files[datrec.filecount].packedsize := filesize(f);
  Close(f);
  fnametemp := filename;
  Delete(fnametemp, 1, 3);
  datrec.files[datrec.filecount].Filenamesize := length(fnametemp) + 1;
  datrec.files[datrec.filecount].Filename := fnametemp;
  datrec.files[datrec.filecount].compressed := True;
  Inc(datrec.dirtreesize, 4 + datrec.files[datrec.filecount].Filenamesize + 4 + 4 + 4 + 4 + 4);
  Assign(xf, datrec.dat_filename);
  reset(xf, 1);
  datrec.files[datrec.filecount].offset := filesize(xf);
  seek(xf, filesize(xf));
  Assign(f, extractfilename(filename) + '.zlib');
  reset(f, 1);

  repeat
    blockread(f, buf, sizeof(buf), numread);
    blockwrite(xf, buf, numread, numwritten);
  until (NumRead = 0) or (NumWritten <> NumRead);

  //writeln (filename,': ',datrec.files[datrec.filecount].realsize,' -> ',datrec.files[datrec.filecount].packedsize,' (',100-(datrec.files[datrec.filecount].packedsize / datrec.files[datrec.filecount].realsize * 100):3:1,'%)');
  Close(f);

  Close(xf);
  if Deletefile(extractfilename(filename) + '.zlib') = True then
  begin

  end else
  begin
    //  writeln('Delete of ' + getcurrentdir + '\' + extractfilename(filename) + '.zlib failed!');
  end;


  Inc(datrec.filecount);
end;

procedure create_dat_file(var f: file; var datrec: datfileheader; filename: String);
begin
  //writeln ('Creating DAT File "',filename,'"');
  datrec.filecount := 0;
  Assign(f, filename);
  rewrite(f, 1);
  datrec.dat_filename := filename;
  Close(f);
end;

procedure cleanuptempfiles(var datrec: datfileheader; startupdir: String);
var
  j: Integer;
var
  str: String;
var
  filescleaned: Integer;
begin
  str := 'Cleaning temp files in ' + startupdir + ' extracted from ' + datrec.dat_filename + '... ' + #13#10;
  filescleaned := 0;
  for j := 0 to datrec.filecount - 1 do
  begin
    if datrec.files[j].opened = True then
    begin
      //riteln ('Clean up: ',datrec.files[j].filename);
      if not fileexists(startupdir + extractfilename(datrec.files[j].filename)) then
      begin
        //messagedlg('Unable to locate '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mterror,[mbok],0);
        str := str + 'File_Not_Found: ' + extractfilename(datrec.files[j].filename) + #13#10;
      end else
      begin
        //messagedlg('Trying to delete '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mtinformation,[mbok],0);
        if deletefile(startupdir + extractfilename(datrec.files[j].filename)) = False then
        begin
          //writeln ('Uh... couldn''t do it!!??');
        end else
        begin
          str := str + datrec.files[j].filename + #13#10;
          //showmessage ('Cleaned up: '+startupdir+extractfilename(datrec.files[j].filename));
          //writeln ('Successs?');
          Inc(filescleaned);
        end;

      end;
      datrec.files[j].opened := False;

    end;
  end;

  if filescleaned = 0 then
    str := str + 'No files cleaned.'
  else
    str := str + 'Clean up complete: ' + IntToStr(filescleaned) + ' temp files removed.';

  dat_log_msg(str);

end;


procedure cleanuprecursedtempfiles(var datrec: datfileheader; startupdir: String);
var
  j: Integer;
begin

  for j := 0 to datrec.filecount - 1 do
  begin
    if datrec.files[j].opened = True then
    begin
      // writeln ('Clean up: ',datrec.files[j].filename);
      if not fileexists(startupdir + datrec.files[j].filename) then
      begin
        //   writeln('Unable to locate '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.');
      end else
      begin
        //messagedlg('Trying to delete '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mtinformation,[mbok],0);
        if deletefile(startupdir + datrec.files[j].filename) = False then
        begin
          //writeln ('Uh... couldn''t do it!!??');
        end else
        begin
          //writeln ('Successs?');
        end;

      end;
      if directoryexists(startupdir + extractfiledir(datrec.files[j].filename)) then
        RemoveDir(startupdir + extractfiledir(datrec.files[j].filename));
      datrec.files[j].opened := False;

    end;
  end;

end;


function dir_exists_in_dat(filename: String; datrec: datfileheader): Boolean;
var
  T: Integer;
begin
  Result := False;
  for t := 0 to datrec.filecount - 1 do
  begin
    //writeln (datrec.files[t].filename);
    if extractfiledir(lowercase(datrec.files[t].filename)) = lowercase(filename) then
    begin
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := True;
      exit;
    end;

  end;
end;


function file_exists_in_dat(filename: String; datrec: datfileheader): Boolean;
var
  T: Integer;
begin
  Result := False;
  for t := 0 to datrec.filecount - 1 do
  begin
    //writeln (datrec.files[t].filename);
    if lowercase(datrec.files[t].filename) = lowercase(filename) then
    begin
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := True;
      exit;
    end;

  end;
end;

function getfileindex(var datrec: datfileheader; filename: String): Integer;
var
  t: Integer;
begin
  Result := 0;
  for t := 0 to datrec.filecount - 1 do
  begin
    //writeln (datrec.files[t].filename);
    if lowercase(datrec.files[t].filename) = lowercase(filename) then
    begin
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := t;
      exit;
    end;

  end;

end;


procedure openfilefromdat(var f: file; var datrec: datfileheader; filename: String; alt_filename: String);
var
  iz, ind: Integer;
var
  outf: file;
var
  savepos: Integer;
begin
  if not file_exists_in_dat(filename, datrec) then
  begin
    dat_log_msg('File ' + filename + ' was not found in ' + datrec.dat_filename + ', operation aborted.');
    exit;
  end;

  ind := getfileindex(datrec, filename);
  //showmessage('Trying to open '+filename+' from '+datrec.dat_filename+#13#10+' File index is '+inttostr(ind)+' and current directory '+getcurrentdir);
  assignfile(f, datrec.dat_filename);
  reset(f, 1);
  savepos := filepos(f);
  seek(f, datrec.files[ind].offset);
  datrec.files[ind].opened := True;
  if datrec.files[ind].compressed = True then
  begin
    Assign(outf, extractfilename(filename) + '.zlib');
    bufcount := datrec.files[ind].packedsize div 8192;
    lastbuf  := datrec.files[ind].packedsize mod 8192;
  end else
  if datrec.files[ind].compressed = False then
  begin
    Assign(outf, extractfilename(filename));
    bufcount := datrec.files[ind].realsize div 8192;
    lastbuf  := datrec.files[ind].realsize mod 8192;
  end;

  rewrite(outf, 1);

  if bufcount > 0 then
  begin
    for iz := 0 to bufcount - 1 do
    begin
      blockread(f, buf, sizeof(buf), numread);
      blockwrite(outf, buf, numread, numwritten);

    end;
  end;
  if lastbuf > 0 then
  begin

    blockread(f, buf, lastbuf, numread);
    blockwrite(outf, buf, numread, numwritten);

  end;
  seek(f, savepos);
  Close(outf);

  if datrec.files[ind].compressed = True then
  begin
    if alt_filename = '' then
      decompress_as(extractfilename(filename) + '.zlib', extractfilename(filename))
    else
    begin
      //writeln ('FILENAME_OVERRIDE: '+alt_filename);
      decompress_as(extractfilename(filename) + '.zlib', extractfilename(alt_filename));
    end;
    DeleteFile(extractfilename(filename) + '.zlib');
  end;
  closefile(f);

end;


procedure openfilefromdatwithfullpath(var f: file; var datrec: datfileheader; filename: String);
var
  iz, ind: Integer;
var
  outf: file;
var
  savepos: Integer;
begin
  try
    ind := getfileindex(datrec, filename);
    writeln('Fileindex = ', ind);
    if datrec.files[ind] = nil then
    begin
      // ShowMessage('DAT File entry ' + IntToStr(ind) + ' is null.' + #13#10 + 'Contact the author. This should NEVER happen.');
      // this won''t happen
    end;
    //showmessage('Trying to open '+filename+' from '+datrec.dat_filename+#13#10+' File index is '+inttostr(ind)+' and current directory '+getcurrentdir);
    assignfile(f, datrec.dat_filename);
    reset(f, 1);
    savepos := filepos(f);
    seek(f, datrec.files[ind].offset);
    datrec.files[ind].opened := True;

    //   writeln('Attempting to create ... '+extractfiledir(datrec.files[ind].filename));
    if ForceDirectories(getcurrentdir + '\' + extractfiledir(datrec.files[ind].filename)) = False then
    begin
      //   writeln('Cannot create dir ?!?!?');
      halt;
    end;

    if datrec.files[ind].compressed = True then
    begin
      //    writeln('outputfile=',filename + '.zlib');
      Assign(outf, filename + '.zlib');
      bufcount := datrec.files[ind].packedsize div 8192;
      lastbuf  := datrec.files[ind].packedsize mod 8192;
    end else
    if datrec.files[ind].compressed = False then
    begin
      //     writeln('outputfile=',filename);
      Assign(outf, filename);
      bufcount := datrec.files[ind].realsize div 8192;
      lastbuf  := datrec.files[ind].realsize mod 8192;
    end;

    rewrite(outf, 1);


    if bufcount > 0 then
    begin
      for iz := 0 to bufcount - 1 do
      begin
        blockread(f, buf, sizeof(buf), numread);
        blockwrite(outf, buf, numread, numwritten);

      end;
    end;
    if lastbuf > 0 then
    begin

      blockread(f, buf, lastbuf, numread);
      blockwrite(outf, buf, numread, numwritten);

    end;
    seek(f, savepos);
    Close(outf);
    if datrec.files[ind].compressed = True then
    begin
      decompress_as(filename + '.zlib', filename);
      DeleteFile(filename + '.zlib');
    end;
    closefile(f);
  except
    on e: Exception do
    begin
      //   ShowMessage('DATLib Exception:' + #13#10 + e.message + #13#10 + 'While trying to extract a file ('+filename+') with full path. currentdir='+getcurrentdir);
      halt;
    end;
  end;

end;

procedure extract_with_wildcard(var f: file; filemask: String; var xdatfile: datfileheader);
var
  t: Integer;
begin
  for t := 0 to xdatfile.filecount - 1 do
  begin

    if StrMatches(filemask, xdatfile.files[t].filename) then
    begin
      application.ProcessMessages;
      forcedirectories(getcurrentdir + '\' + extractfiledir(xdatfile.files[t].filename));
      openfilefromdatwithfullpath(f, xdatfile, xdatfile.files[t].filename);
    end;

  end;

end;

function gettimestampforfile: Integer;
var
  tstamp: TTimestamp;
begin
  tstamp := DateTimeToTimeStamp(now);
  tstamp.Date := 0;
  //writeln (tstamp.time);

  Result := tstamp.time;

end;

procedure closedathandle(var f: file);
begin
  //closefile(f);
end;

(*
procedure opendatfilewithprogressdlg(var f: file; var datrec: datfileheader; filename: string);
var treesubs:   integer;
var y:          integer;
var whatsthere: integer;
begin 
  dat_log_msg('DAT_LOAD: Opening database "' + filename + '".. ' + #13#10);

  with TForm3.Create(NIL) do try
      begin 
        FormStyle        := fsStayOnTop;
        Show;
        datrec.filecount := 0;
        label1.Caption   := 'Opening ' + extractfilename(filename);
        label2.Caption   := 'Reading header..';
        assignfile(f, filename);
        reset(f, 1);
        seek(f, filesize(f) - 4);
        blockread(f, treesubs, 4);
        seek(f, filesize(f) - treesubs);
        blockread(f, whatsthere, 4);

        datrec.filecount   := whatsthere;
        buprogressbar1.max := datrec.filecount;
        label2.Caption     := 'Reading dirtree..';

        for y := 0 to datrec.filecount - 1 do
        begin 

          application.ProcessMessages;
          buprogressbar1.position  := y;
          new(datrec.files[y]);
          blockread(f, datrec.files[y].Filenamesize, 4);
          blockread(f, chars, datrec.files[y].Filenamesize);
          datrec.files[y].filename := chars;


          blockread(f, datrec.files[y].compressed, 1);

          label2.Caption         := datrec.files[y].filename;
          blockread(f, datrec.files[y].realsize, 4);
          blockread(f, datrec.files[y].packedsize, 4);
          blockread(f, datrec.files[y].offset, 4);
          datrec.files[y].opened := False;

          //writeln (datrec.files[y].filename);

        end;
      end;
    finally Free;
    end;
  Close(f);

end;

*)

procedure opendatfile(var f: file; var datrec: datfileheader; filename: String);
var
  treesubs: Integer;
  y: Integer;
  test: Integer;
  whatsthere: Integer;
  listoffset, ofs1, ofs2: Integer;
begin
  //showmessage ('AT TEMP TING TO O PEN!! '+filename);
  dat_log_msg('DAT_LOAD: Opening database "' + filename + '".. ' + #13#10);
  //writeln ('OpenDatFile: ',filename);
  datrec.filecount := 0;

  Assign(f, filename);
  datrec.dat_filename := filename;
  if not fileexists(filename) then
  begin
    // MessageDlg(format('Error! Cannot open DAT file ''%s'' !', [filename]), mtError, [mbOK], 0);

  end;

  reset(f, 1);

  seek(f, filesize(f) - 8);
  blockread(f, ofs1, 4);
  blockread(f, ofs2, 4);
  Dec(ofs1, 4);
  //blockread(f, datrec.unknown5, 4);
  //blockread(f, datrec.unknown6, 4);
  //writeln ('DAT.unknown1 = ',datrec.unknown1);
  //writeln ('DAT.unknown2 = ',datrec.unknown2);
  //writeln ('DAT.unknown3 = ',datrec.unknown3);
  //writeln ('DAT.unknown4 = ',datrec.unknown4);
  listoffset := (ofs2 - ofs1) - 8;
  seek(f, listoffset - 4);
  blockread(f, datrec.filecount, 4);
  //datrec.filecount := whatsthere;

  dat_log_msg('DAT_LOAD: Got ' + IntToStr(datrec.filecount) + ' files.' + #13#10 + 'Size: ' + IntToStr(filesize(f)) + ' bytes.');
  seek(f, listoffset);
  for y := 0 to datrec.filecount - 1 do
  begin
    application.ProcessMessages;
    new(datrec.files[y]);
    chars := '';
    datrec.files[y].Filenamesize := 0;
    blockread(f, datrec.files[y].Filenamesize, 4);
    blockread(f, chars, datrec.files[y].Filenamesize);
    datrec.files[y].filename := chars;
    blockread(f, datrec.files[y].compressed, 1);
    blockread(f, datrec.files[y].realsize, 4);
    blockread(f, datrec.files[y].packedsize, 4);
    blockread(f, datrec.files[y].offset, 4);
    datrec.files[y].opened := False;
    //writeln (datrec.files[y].filename);
  end;
  Close(f);
end;


begin
  init_dat_logger(getcurrentdir);
  ThousandSeparator := ',';
end.

