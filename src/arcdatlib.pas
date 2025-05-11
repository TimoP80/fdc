unit arcdatlib;

interface


 // DATFile v2.1 reader library (For use with Arcanum DAT files)
 // version 1.0

 // This will be used with my tools related to Arcanum
// for direct access to the files without the need for the end-user to extract data (just specify location of dat files and that's it)

 // 30.12.2001:
 // Yay for me! the unknown value in the file record IS a timestamp! :)
 // I'm going to add a create_dat_file procedure here right-fucking-now!

 // 5.9.2002:

 // DAT Creation functions working now and compatible with
 // dbmaker, which means they should be compatible with the game
 // (need to do some testing though)



uses
  Windows,
  Controls,
  SysUtils,
  strutils_,
  jclstrings,
  jclmath,
  FileCtrl,
  Forms,
  Classes,
  Dialogs,
  zlibex;

const
  max_files      = 80000;

const
  FILETYPE_DIR   = 1024;

const
  FILETYPE_CMP   = 2;

const
  FILETYPE_UNCMP = 1;

resourcestring
  Sig            = 'ArcDATLib 1.0 - (c) 2001 by DjUnique';

type
  datfilerec     = record
    Filenamesize: integer;
    deleted:      boolean;
    filename:     string;
    opened:       boolean;
    timestamp:    integer;
    itemtype:     integer;
    realsize:     integer;
    packedsize:   integer;
    offset:       integer;
  end;

type
  datfileheader = record
    dirtreesize:  integer;
    treepos:      integer;
    totalsize:    integer;
    dat_filename: string;
    files:        array [0..MAX_FILES] of ^datfilerec;
    unknown1, unknown2, unknown3, unknown4: integer;
    unknown5, unknown6: integer;

    filecount: integer;
  end;

var
  dat_rec: datfileheader;
//const BUF_MAX = 2048;
const
  BUFFERSIZE = 8192;

var
  buf:             array [0..BUFFERSIZE - 1] of char;
  buffer_sizes:    array [0..1024] of word;
  buffer:          array [0..BUFFERSIZE - 1] of byte;
  dlogfile, catchmsg: string;
  dlog:            textfile;
  logging_enabled: boolean;
  chars:           array [0..255] of char;
  numread, numwritten, byteswritten, bytesread: integer;
  bufcount, lastbuf: integer;
  src_Stream:      TStream;

  dest_stream:     TStream;

  compressor:      TZCompressionstream;

procedure closedathandle(var f: file);
procedure cleanuptempfiles(var datrec: datfileheader; startupdir: string);
procedure openfilefromdat(var f: file; var datrec: datfileheader; filename: string; alt_filename: string);
procedure read_cachefile(var f: file; var cachefiles: datfileheader; path, filename: string);
function gettimestampforfile: integer;
{$IFDEF OPENDATWITHDLG}

procedure opendatfilewithprogressdlg(var f: file; var datrec: datfileheader;
  filename: string);
  {$ENDIF}
procedure opendatfile(var f: file; var datrec: datfileheader; filename: string);
procedure openfilefromdatwithfullpath(var f: file; var datrec: datfileheader; filename: string);
function getfileindex(var datrec: datfileheader; filename: string): integer;
procedure cleanuprecursedtempfiles(var datrec: datfileheader; startupdir: string);
function file_exists_in_dat(filename: string; datrec: datfileheader): boolean;
procedure create_dat_file(var f: file; var datrec: datfileheader; filename: string);
procedure add_file_to_dat(var xf: file; var datrec: datfileheader; filename: string);
procedure write_dat_Header(var xf: file; datrec: datfileheader);
function dir_exists_in_dat(filename: string; datrec: datfileheader): boolean;
procedure init_dat_logger(startupdir: string);
procedure create_dat_file_noreset(var f: file; var datrec: datfileheader; filename: string);
function folderexists(var datrec: datfileheader; folder: string): boolean;
procedure decompress_as(infile, newfile: string);
function compress_(filename: string; compressionratio: TZCompressionlevel): longint;
 // for data save functions

implementation

 //uses progressdlg, mainfrm;

function folderexists(var datrec: datfileheader; folder: string): boolean;
var
  D: integer;
begin
  ;
  Result := False;
  for d := 0 to datrec.filecount - 1 do
  begin
    ;
    if (datrec.files[d].filename = folder) and (datrec.files[d].itemtype = FILETYPE_DIR) then
    begin
      ;
      //showmessage('Folder '+folder+' exists!');
      Result := True;
      exit;
    end;

  end;

end;

procedure init_dat_logger(startupdir: string);
begin
  ;
  //showmessage ('INIT: '+startupdir);
  assignfile(dlog, startupdir + '\datlib.log');
  rewrite(dlog);
  writeln(dlog, 'ArcDATLib event log - Started on ', datetimetostr(now));
  writeln(dlog, '-----------------------------------------------------------');
  writeln(dlog);
  closefile(dlog);
  dlogfile        := startupdir + '\datlib.log';
  logging_enabled := True;
end;



procedure dat_log_msg(str: string);
begin
  ;
  if logging_enabled = True then
  begin
    ;
    assignfile(dlog, dlogfile);
    append(dlog);
    writeln(dlog, datetimetostr(now), ' - ', str);
    closefile(dlog);
  end;

end;



procedure decompress(infile: string);
var
  Count:             integer;
var
  _infile, _outfile: TStream;
var
  zstream:           TZDecompressionstream;
begin
  ;
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
    on e : Exception do
    begin
      ;
      writeln('Error: ', e.message);
    end;
  end;
end;

procedure decompress_as(infile, newfile: string);
var
  Count:             integer;
  _infile, _outfile: TStream;
  zstream:           TZDecompressionstream;
begin
  ;
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



procedure read_cachefile(var f: file; var cachefiles: datfileheader; path, filename: string);
var
  t, i:         integer;
var
  ch:           char;
var
  unctotalsize: integer;
begin
  ;

  assignfile(f, changefileext(filename, '.inf'));
  reset(f, 1);
  cachefiles.dat_filename := path + '\' + extractfilename(filename);



  //cachefiles.files[i].Filename  := '';
  blockread(f, cachefiles.filecount, 4);
  for i := 0 to cachefiles.filecount - 1 do
  begin
    ;
    new(cachefiles.files[i]);
    blockread(f, cachefiles.files[i].Filenamesize, 4);
    blockread(f, chars, cachefiles.files[i].Filenamesize);
    cachefiles.files[i].Filename := chars;
    blockread(f, cachefiles.files[i].timestamp, 4);
    blockread(f, cachefiles.files[i].itemtype, 4);
    blockread(f, cachefiles.files[i].realsize, 4);
    blockread(f, cachefiles.files[i].packedsize, 4);
    blockread(f, cachefiles.files[i].offset, 4);
    Inc(unctotalsize, cachefiles.files[i].realsize);
  end;
  closefile(f);
  dat_log_msg('Cache_Load: ' + changefileext(filename, '.inf') + ' ' + cachefiles.dat_filename +
    #13#10 + IntToStr(cachefiles.filecount) + ' files cached.'#13#10 + IntToStr(unctotalsize) +
    ' bytes uncompressed.');
  //showmessage(
end;

procedure write_dat_Header(var xf: file; datrec: datfileheader);
var
  j, i:         integer;
var
  bytearray:    array of byte;
var
  dirtreesize2: integer;
var
  CRC:          longword;
var
  chr:          char;
var
  ch2:          char;
begin
  ;
  //writeln ('Writing dat header');
  Assign(xf, datrec.dat_filename);
  reset(xf, 1);
  datrec.treepos   := filesize(xf);
  seek(xf, filesize(xf));
  datrec.totalsize := filesize(xf) + 4;
  blockwrite(xf, datrec.totalsize, 4);

  blockwrite(xf, datrec.filecount, 4);
  //debugmsg('Total: ' + IntToStr(datrec.filecount) + ' files.');
  for i := 0 to datrec.filecount - 1 do
  begin
    ;
    //debugmsg (inttostr(i)+': '+datrec.files[i].filename);
    blockwrite(xf, datrec.files[i].Filenamesize, 4);
    for j := 1 to datrec.files[i].filenamesize do
    begin
      ;
      chr := datrec.files[i].filename[j];
      blockwrite(xf, chr, 1);
    end;

    blockwrite(xf, datrec.files[i].timestamp, 4);
    blockwrite(xf, datrec.files[i].itemtype, 4);
    blockwrite(xf, datrec.files[i].realsize, 4);
    blockwrite(xf, datrec.files[i].packedsize, 4);
    blockwrite(xf, datrec.files[i].offset, 4);
  end;



  //new(datrec.files[y]);
  //blockread(f, datrec.files[y].Filenamesize, 4);
  //blockread(f, chars, datrec.files[y].Filenamesize);
  //datrec.files[y].filename := chars;
  //blockread(f, datrec.files[y].timestamp, 4);
  //blockread(f, datrec.files[y].itemtype, 4);
  //blockread(f, datrec.files[y].realsize, 4);
  //blockread(f, datrec.files[y].packedsize, 4);
  //blockread(f, datrec.files[y].offset, 4);


  datrec.unknown4 := 1145132081;
  //SetLength(bytearray, length(datrec.dat_filename));
  //for j := 1 to length(datrec.dat_filename) do
  //bytearray [j-1] := ord(datrec.dat_filename[j]);
  //CRC := crc32(bytearray, length(datrec.dat_filename));
  datrec.unknown1 := 0;
  randomize;
  datrec.unknown2 := crc;

  //crc32(
  blockwrite(xf, datrec.unknown1, 4);
  blockwrite(xf, datrec.unknown2, 4);
  blockwrite(xf, datrec.unknown3, 4);
  blockwrite(xf, datrec.unknown3, 4);
  blockwrite(xf, datrec.unknown4, 4);

  datrec.dirtreesize := datrec.dirtreesize + 4 + 24 + 4 + 4;
  dirtreesize2       := datrec.dirtreesize - datrec.filecount * 24 - 36;
  datrec.dirtreesize := datrec.dirtreesize - 4;


  blockwrite(xf, dirtreesize2, 4);
  blockwrite(xf, datrec.dirtreesize, 4);
  //MessageDlg(format('Dat Header written.'+#13+#10+'Total size: %d bytes'+#13+#10+'Total number of files: %d',[filesize(xf),datrec.filecount]), mtInformation, [mbOK], 0);
  Close(xf);

end;


function compress_(filename: string; compressionratio: TZCompressionlevel): longint;
  // for data save functions
begin
  ;
  //writeln ('Compressing "',filename,'" at ',getcurrentdir);
  catchmsg   := 'Opening source stream: ' + getcurrentdir + '\' + filename;
  src_Stream := TFilestream.Create(filename, fmopenread);

  catchmsg    := 'Opening dest stream: ' + getcurrentdir + '\' + extractfilename(filename);
  dest_stream := TFilestream.Create(extractfilename(filename) + '.zlib', fmCreate);
  compressor  := TZCompressionStream.Create(dest_stream, compressionratio);
  try
    compressor.copyfrom(src_stream, 0);
  finally
    begin
      ;
      if fileexists(filename) then
      begin
        ;
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

procedure add_folder_to_dat(var xf: file; var datrec: datfileheader; filename: string);
begin
  ;
  new(datrec.files[datrec.filecount]);
  datrec.files[datrec.filecount].filename     := extractfiledir(filename);
  datrec.files[datrec.filecount].filenamesize := length(filename);
  datrec.files[datrec.filecount].deleted      := False;
  datrec.files[datrec.filecount].realsize     := 0;
  datrec.files[datrec.filecount].packedsize   := 0;
  datrec.files[datrec.filecount].timestamp    := 0;
  datrec.files[datrec.filecount].itemtype     := FILETYPE_DIR;
  datrec.files[datrec.filecount].offset       := 0;
  Inc(datrec.dirtreesize, 4 + datrec.files[datrec.filecount].Filenamesize + 4 + 4 + 4 + 4 + 4);
  Inc(datrec.filecount);

end;

procedure add_file_to_dat(var xf: file; var datrec: datfileheader; filename: string);
var
  f:            file;
var
  fnametemp:    string;
var
  dirnode, dirnodemain, tempstring: string;
var
  temp_pchar:   PChar;
var
  dirnodecount: integer;
var
  n:            integer;
begin
  ;
  if extractfiledir(filename) <> '' then
  begin
    ;
    dirnodecount := WordCount(filename, ['\']);
    dirnode      := extractfiledir(filename);
    if dirnodecount > 1 then
    begin
      ;

      for n := 1 to dirnodecount do
      begin
        ;
        dirnodemain := ExtractWord(n, dirnode, ['\']);
        if folderexists(datrec, dirnodemain) = False then
        begin
          ;
          add_folder_to_dat(xf, datrec, dirnode);
        end;
      end;

    end
    else
    begin
      ;
      dirnodemain := extractfiledir(filename);
      if folderexists(datrec, dirnodemain) = False then
      begin
        ;
        add_folder_to_dat(xf, datrec, dirnodemain);
      end;

    end;
  end;

  new(datrec.files[datrec.filecount]);
  datrec.files[datrec.filecount].deleted := False;
  try
    Assign(f, filename);
    reset(f, 1);
  except
    on e : Exception do
    begin
      ;
      //showmessage('Error adding file: '+filename+#13#10#13#10+'Exception: '+#13#10+e.message);
      //MessageDlg('Error adding file: '+filename+#13#10+'Current directory: '+getcurrentdir+#13#10+'Exception: '+#13+#10+e.message, mtError, [mbOK], 0);
      writeln('Error adding file: ' + filename + #13#10 + 'Current directory: ' +
        getcurrentdir + #13#10 + 'Exception: ' + #13 + #10 + e.message);
      exit;
    end;
  end;

  datrec.files[datrec.filecount].realsize := filesize(f);
  Close(f);
  Compress_(filename, zcMax);
  Assign(f, extractfilename(filename) + '.zlib');
  reset(f, 1);
  datrec.files[datrec.filecount].packedsize := filesize(f);
  Close(f);
  fnametemp := filename;
  if pos(':', fnametemp) <> 0 then
    Delete(fnametemp, 1, 3);
  datrec.files[datrec.filecount].Filenamesize := length(fnametemp) + 1;
  datrec.files[datrec.filecount].Filename := fnametemp;
  datrec.files[datrec.filecount].itemtype := FILETYPE_CMP;
  //datrec.files[datrec.filecount].timestamp := gettimestampforfile;
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

  //  debugmsg(filename + ': ' + IntToStr(datrec.files[datrec.filecount].realsize) +
  //   ' -> ' + IntToStr(datrec.files[datrec.filecount].packedsize) + ' (' +
  //   floattostr(100 - (datrec.files[datrec.filecount].packedsize /
  //   datrec.files[datrec.filecount].realsize * 100)) + '%)');
  Close(f);

  Close(xf);
  tempstring := changefileext(extractfilename(filename), '');
  temp_pchar := PChar(tempstring);
  datrec.files[datrec.filecount].timestamp := 0;

  if Deletefile(extractfilename(filename) + '.zlib') = True then
  begin
    ;

  end
  else
  begin
    ;
    ShowMessage('Delete of ' + getcurrentdir + '\' + extractfilename(filename) + '.zlib failed!');
  end;

  if datrec.files[datrec.filecount].deleted = True then
    ShowMessage('DATFILE_DELETED := TRUE!');

  Inc(datrec.filecount);
end;




procedure create_dat_file_noreset(var f: file; var datrec: datfileheader; filename: string);
begin
  ;
  //writeln ('Creating DAT File "',filename,'"');
  Assign(f, filename);
  rewrite(f, 1);
  datrec.dat_filename := filename;
  Close(f);
end;


procedure create_dat_file(var f: file; var datrec: datfileheader; filename: string);
begin
  ;
  //writeln ('Creating DAT File "',filename,'"');
  datrec.filecount    := 0;
  Assign(f, filename);
  rewrite(f, 1);
  datrec.dat_filename := filename;
  Close(f);
end;

procedure cleanuptempfiles(var datrec: datfileheader; startupdir: string);
var
  j:            integer;
var
  str:          string;
var
  filescleaned: integer;
begin
  ;
  str          := 'Cleaning temp files in ' + startupdir + ' extracted from ' + datrec.dat_filename + '... ' + #13#10;
  filescleaned := 0;
  for j := 0 to datrec.filecount - 1 do
  begin
    ;
    if datrec.files[j].opened = True then
    begin
      ;
      //riteln ('Clean up: ',datrec.files[j].filename);
      if not fileexists(startupdir + extractfilename(datrec.files[j].filename)) then
      begin
        ;
        //messagedlg('Unable to locate '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mterror,[mbok],0);
        str := str + 'File_Not_Found: ' + startupdir + '\' + extractfilename(
          datrec.files[j].filename) + #13#10;
      end
      else
      begin
        ;
        //messagedlg('Trying to delete '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mtinformation,[mbok],0);
        if deletefile(startupdir + extractfilename(datrec.files[j].filename)) = False then
        begin
          ;
          //writeln ('Uh... couldn''t do it!!??');
        end
        else
        begin
          ;
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


procedure cleanuprecursedtempfiles(var datrec: datfileheader; startupdir: string);
var
  j: integer;
begin
  ;

  for j := 0 to datrec.filecount - 1 do
  begin
    ;
    if datrec.files[j].opened = True then
    begin
      ;
      //showmessage ('Clean up: '+datrec.files[j].filename);
      if not fileexists(startupdir + datrec.files[j].filename) then
      begin
        ;
        //messagedlg('Unable to locate '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mterror,[mbok],0);
      end
      else
      begin
        ;
        //messagedlg('Trying to delete '+startupdir+extractfilename(datrec.files[j].filename)+' which was extracted from a DAT file.',mtinformation,[mbok],0);
        if deletefile(startupdir + datrec.files[j].filename) = False then
        begin
          ;
          //showmessage ('Uh... couldn''t do it!!??');
        end
        else
        begin
          ;
          //showmessage ('Successs?');
        end;

      end;
      if directoryexists(startupdir + extractfiledir(datrec.files[j].filename)) then
        RemoveDir(startupdir + extractfiledir(datrec.files[j].filename));
      datrec.files[j].opened := False;

    end;
  end;

end;


function dir_exists_in_dat(filename: string; datrec: datfileheader): boolean;
var
  T: integer;
begin
  ;
  Result := False;
  for t := 0 to datrec.filecount - 1 do
  begin
    ;
    //writeln (datrec.files[t].filename);
    if extractfiledir(lowercase(datrec.files[t].filename)) = lowercase(filename) then
    begin
      ;
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := True;
      exit;
    end;

  end;
end;


function file_exists_in_dat(filename: string; datrec: datfileheader): boolean;
var
  T: integer;
begin
  ;
  Result := False;
  for t := 0 to datrec.filecount - 1 do
  begin
    ;
    //writeln (datrec.files[t].filename);
    if lowercase(datrec.files[t].filename) = lowercase(filename) then
    begin
      ;
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := True;
      exit;
    end;

  end;
end;

function getfileindex(var datrec: datfileheader; filename: string): integer;
var
  t: integer;
begin
  ;
  Result := 0;
  for t := 0 to datrec.filecount - 1 do
  begin
    ;
    //writeln (datrec.files[t].filename);
    if lowercase(datrec.files[t].filename) = lowercase(filename) then
    begin
      ;
      //showmessage('GetFileIndex('+filename+') = '+inttostr(t));
      Result := t;
      exit;
    end;

  end;

end;


procedure openfilefromdat(var f: file; var datrec: datfileheader; filename: string; alt_filename: string);
var
  iz, ind: integer;
var
  outf:    file;
var
  savepos: integer;
begin

  ind     := getfileindex(datrec, filename);
  //showmessage('Trying to open '+filename+' from '+datrec.dat_filename+#13#10+' File index is '+inttostr(ind)+' and current directory '+getcurrentdir);
  assignfile(f, datrec.dat_filename);
  reset(f, 1);
  savepos := filepos(f);
  seek(f, datrec.files[ind].offset);
  datrec.files[ind].opened := True;
  if datrec.files[ind].itemtype = FILETYPE_CMP then
  begin
    ;
    Assign(outf, extractfilename(filename) + '.zlib');
    bufcount := datrec.files[ind].packedsize div 8192;
    lastbuf  := datrec.files[ind].packedsize mod 8192;
  end
  else
  if datrec.files[ind].itemtype = FILETYPE_UNCMP then
  begin
    ;
    Assign(outf, extractfilename(filename));
    bufcount := datrec.files[ind].realsize div 8192;
    lastbuf  := datrec.files[ind].realsize mod 8192;
  end;

  rewrite(outf, 1);

  if bufcount > 0 then
  begin
    ;
    for iz := 0 to bufcount - 1 do
    begin
      ;
      blockread(f, buf, sizeof(buf), numread);
      blockwrite(outf, buf, numread, numwritten);

    end;
  end;
  if lastbuf > 0 then
  begin
    ;

    blockread(f, buf, lastbuf, numread);
    blockwrite(outf, buf, numread, numwritten);

  end;
  seek(f, savepos);
  Close(outf);

  if datrec.files[ind].itemtype = FILETYPE_CMP then
  begin
    ;
    if alt_filename = '' then
      decompress_as(extractfilename(filename) + '.zlib', extractfilename(filename))
    else
    begin
      ;
      //writeln ('FILENAME_OVERRIDE: '+alt_filename);
      decompress_as(extractfilename(filename) + '.zlib', extractfilename(alt_filename));
    end;
    DeleteFile(extractfilename(filename) + '.zlib');
  end;
  closefile(f);
end;


procedure openfilefromdatwithfullpath(var f: file; var datrec: datfileheader; filename: string);
var
  iz, ind: integer;
var
  outf:    file;
var
  savepos: integer;
begin
  ;

  try
    ind := getfileindex(datrec, filename);
    if datrec.files[ind] = NIL then
    begin
      ;
      ShowMessage('DAT File entry ' + IntToStr(ind) + ' is null.' + #13#10 +
        'Contact the author. This should NEVER happen.');  // this won''t happen
    end;
    //showmessage('Trying to open '+filename+' from '+datrec.dat_filename+#13#10+' File index is '+inttostr(ind)+' and current directory '+getcurrentdir+' to path '+extractfiledir(datrec.files[ind].filename));

    dat_log_msg('GetIndex ' + filename + ' :: ' + IntToStr(ind) + ' from ' + datrec.dat_filename);

    ForceDirectories(getcurrentdir + '\' + extractfiledir(datrec.files[ind].filename));
    assignfile(f, datrec.dat_filename);
    reset(f, 1);
    savepos := filepos(f);
    seek(f, datrec.files[ind].offset);
    datrec.files[ind].opened := True;


    if datrec.files[ind].itemtype = FILETYPE_CMP then
    begin
      ;
      Assign(outf, filename + '.zlib');
      bufcount := datrec.files[ind].packedsize div 8192;
      lastbuf  := datrec.files[ind].packedsize mod 8192;
    end
    else
    if datrec.files[ind].itemtype = FILETYPE_UNCMP then
    begin
      ;
      Assign(outf, filename);
      bufcount := datrec.files[ind].realsize div 8192;
      lastbuf  := datrec.files[ind].realsize mod 8192;
    end;

    rewrite(outf, 1);


    if bufcount > 0 then
    begin
      ;
      for iz := 0 to bufcount - 1 do
      begin
        ;
        blockread(f, buf, sizeof(buf), numread);
        blockwrite(outf, buf, numread, numwritten);

      end;
    end;
    if lastbuf > 0 then
    begin
      ;

      blockread(f, buf, lastbuf, numread);
      blockwrite(outf, buf, numread, numwritten);

    end;
    seek(f, savepos);
    Close(outf);

    if datrec.files[ind].itemtype = FILETYPE_CMP then
    begin
      ;
      decompress_as(filename + '.zlib', filename);
      DeleteFile(filename + '.zlib');
    end;

    dat_log_msg('Extracted ' + filename + ' from ' + datrec.dat_filename);
    closefile(f);
  except
    on e : Exception do
    begin
      ;
      ShowMessage('DATLib Exception:' + #13#10 + e.message + #13#10 +
        'While trying to extract a file with full path.');
    end;
  end;

end;


function gettimestampforfile: integer;
var
  tstamp: TTimestamp;
begin
  ;
  tstamp      := DateTimeToTimeStamp(now);
  tstamp.Date := 0;
  //writeln (tstamp.time);

  Result := tstamp.time;

end;

procedure closedathandle(var f: file);
begin
  ;
  //closefile(f);
end;



{$IFDEF OPENDATWITHDLG}
procedure opendatfilewithprogressdlg(var f: file; var datrec: datfileheader;
  filename: string);
var
  treesubs: integer;
var
  y: integer;
var
  whatsthere: integer;
begin
  ;
  dat_log_msg('DAT_LOAD: Opening database "' + filename + '".. ' + #13#10);

  with TForm3.Create(nil) do
    try
      begin
        ;
        FormStyle := fsStayOnTop;
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
          ;

          application.ProcessMessages;
          buprogressbar1.position := y;
          new(datrec.files[y]);
          blockread(f, datrec.files[y].Filenamesize, 4);
          blockread(f, chars, datrec.files[y].Filenamesize);
          datrec.files[y].filename := chars;


          blockread(f, datrec.files[y].timestamp, 4);
          blockread(f, datrec.files[y].itemtype, 4);

          label2.Caption := datrec.files[y].filename;
          blockread(f, datrec.files[y].realsize, 4);
          blockread(f, datrec.files[y].packedsize, 4);
          blockread(f, datrec.files[y].offset, 4);
          datrec.files[y].opened := False;

          //writeln (datrec.files[y].filename);

        end;
      end;
    finally
      Free;
    end;
  Close(f);

end;
{$ENDIF}

procedure opendatfile(var f: file; var datrec: datfileheader; filename: string);
var
  treesubs:   integer;
var
  y:          integer;
var
  test:       integer;
var
  whatsthere: integer;
begin
  ;
  //showmessage ('AT TEMP TING TO O PEN!! '+filename);
  dat_log_msg('DAT_LOAD: Opening database "' + filename + '".. ' + #13#10);
  datrec.filecount    := 0;
  Assign(f, filename);
  datrec.dat_filename := filename;
  reset(f, 1);

  seek(f, filesize(f) - 4);
  blockread(f, treesubs, 4);
  seek(f, filesize(f) - 8);
  blockread(f, test, 4);

  seek(f, filesize(f) - 24);

  blockread(f, datrec.unknown1, 4);

  blockread(f, datrec.unknown2, 4);

  blockread(f, datrec.unknown3, 4);

  blockread(f, datrec.unknown4, 4);
  //blockread(f, datrec.unknown5, 4);
  //blockread(f, datrec.unknown6, 4);
  //writeln ('DAT.unknown5 = ',datrec.unknown5);
  //writeln ('DAT.unknown6 = ',datrec.unknown6);
  seek(f, filesize(f) - treesubs);
  blockread(f, whatsthere, 4);
  if whatsthere > 1000000 then
  begin
    ;
    case MessageDlg('Warning! DAT File count is weird.' + #13 + #10 +
        'Do you wish to manually enter the filecount?', mtWarning, [mbYes, mbNo], 0) of
      mrYes:
        whatsthere := StrToInt(InputBox('ARCDATLib Request', 'Enter the manual file count', ''));
    end;
  end;

  datrec.filecount := whatsthere;

  dat_log_msg('DAT_LOAD: Got ' + IntToStr(datrec.filecount) + ' files.' + #13#10 + 'Size: ' +
    IntToStr(filesize(f)) + ' bytes.');

  for y := 0 to datrec.filecount - 1 do
  begin
    ;
    application.ProcessMessages;
    new(datrec.files[y]);
    datrec.files[y].deleted      := False;
    datrec.files[y].Filenamesize := 0;
    blockread(f, datrec.files[y].Filenamesize, 4);
    blockread(f, chars, datrec.files[y].Filenamesize);
    datrec.files[y].filename     := chars;
    blockread(f, datrec.files[y].timestamp, 4);
    blockread(f, datrec.files[y].itemtype, 4);
    blockread(f, datrec.files[y].realsize, 4);
    blockread(f, datrec.files[y].packedsize, 4);
    blockread(f, datrec.files[y].offset, 4);
    datrec.files[y].opened := False;
    //writeln (datrec.files[y].filename);
  end;


  Close(f);
end;


begin
  ;
  ThousandSeparator := ',';
end.

