unit SDataLoad;

interface

uses
  Forms,
  Classes,
  arcdatlib,
  JclStrings,
  zlibex,
  SysUtils;

type
  ftp_site = record
    da_length:     integer;
    dn_lenght:     integer;
    ss_length:     integer;
    domainaddress: string;
    displayname:   string;
    site_script:   string;
  end;

type
  name_group = record
    lookup_length: integer;
    lookup:        string;
    name_length:   array of integer;
    names:         array of string;
    namecnt:       integer;
  end;


const
  GENDER_FEMALE = 1;

const
  GENDER_MALE   = 2;

var
  Group_Name_Length: array [0..500] of integer;
  Group_Names: array [0..500] of string;
  grpnamecnt:  integer;
  ftp_sites:   array [0..500] of ftp_site;
  ftpsitecnt:  integer;
  namedata:    array [0..50] of ^name_group;
  namedatacnt: integer;
  AppTypes_Length: array [0..10] of integer;

  AppTypes:    array [0..10] of string;
  fhandle:           file;
  apptypecnt:  integer;

  Aliases_Length: array [0..500] of integer;
  Aliases_Gender: array [0..500] of integer;

  Aliases:     array [0..500] of string;
  aliascnt:    integer;

  genericdata: array [0..160] of ^name_group;

  genericdatacnt: integer;
  tempgenericcnt: integer;
  tempnamecnt: integer;

function LoadStaticData(filename: string; var f: file): boolean;
procedure SaveBinData(filename: string; usecompression: boolean);
procedure SaveScript(Name: string);
function GetNameGroupIndex(lookup: string): integer;
procedure writeraw(Data: string; var f: file);
function GetRandomData(var grpind: integer; lookup: string): integer;
function AddNewData(sectname: string): integer;
function GetGenericDataGroupIndex(lookup: string): integer;
procedure readdata(var Data: string; len: integer; var f: file);
function readraw(Data: string; var f: file): boolean;
procedure readdatashort(var Data: shortstring; len: integer; var f: file);

function ReplaceData(Data: string): string;
function GetRandomDataSTR(lookup: string): string;
procedure savegeneric(Name: string);
procedure AddNewEntry(ind: integer; Data: string);

implementation

uses
  Updating,
  DebugMSG,
  Dialogs;

function GetGenericDataGroupIndex(lookup: string): integer;
var
  i: integer;
begin
  ;
  Result := -1;
  for I := 0 to genericdatacnt - 1 do
  begin
    ;
    if lookup = genericdata[i].lookup then
    begin
      ;
      Result := i;
      exit;
    end;

  end;

  //DebugMSG('Warning :: GetGenericDataIndex("'+lookup+'") == -1 !!!');
end;


function GetNameGroupIndex(lookup: string): integer;
var
  i: integer;
begin
  ;
  Result := -1;
  for I := 0 to namedatacnt - 1 do
  begin
    ;
    if lookup = namedata[i].lookup then
    begin
      ;
      Result := i;
      exit;
    end;

  end;

end;


function GetRandomDataSTR(lookup: string): string;
var
  rand, t: integer;
begin
  ;
  //DebugMSG('RandomData - '+lookup);
  if t <> -1 then
  begin
    ;
    t      := GetGenericDataGroupIndex(lookup);
    rand   := random(genericdata[t].namecnt);
    Result := genericdata[t].names[rand];
  end
  else
    Result := 'Error';

end;

function GetRandomData(var grpind: integer; lookup: string): integer;
var
  t: integer;
begin
  ;
  t      := GetGenericDataGroupIndex(lookup);
  grpind := t;
  Result := random(genericdata[t].namecnt);
end;



function ReplaceData(Data: string): string;
var
  temp: string;
begin
  ;
  temp   := Data;
  temp   := StringReplace(temp, #13#10, '\n', [rfReplaceAll]);
  temp   := StringReplace(temp, #9, '\t', [rfReplaceAll]);
  temp   := StringReplace(temp, '"', '\"', [rfReplaceAll]);
  Result := temp;
end;

function GetAliasGender(gend: integer): string;
begin
  ;
  Result := 'unknown';
  case gend of
    GENDER_MALE:
      Result := 'male';
    GENDER_FEMALE:
      Result := 'female';
  end;
end;

procedure savegeneric(Name: string);
var
  strdata:     string;
var
  added, i, t: integer;
var
  strs:        TStrings;
begin
  ;
  strs := TStringList.Create;
  strs.add('/*');
  strs.add('');
  strs.add(' String data');
  strs.add('');
  strs.add('*/');
  strs.add('');

  for I := 0 to genericdatacnt - 1 do
  begin
    ;
    strdata := 'data ' + genericdata[i].lookup;
    strs.add(' ' + strdata);
    strs.add('   begin');
    added   := 0;
    strdata := '';
    for t := 0 to genericdata[i].namecnt - 1 do
    begin
      ;
      strdata := '"' + ReplaceData(genericdata[i].names[t]) + '"';
      if t < genericdata[i].namecnt - 1 then
        strdata := strdata + ', ';
      strs.add('    ' + strdata);

      strdata := '';

    end;


    strs.add('    end');

  end;
  strs.SaveToFile(Name);

end;

procedure SaveScript(Name: string);
var
  added, i, t: integer;
var
  strs:        TStrings;
var
  strdata:     string;
begin
  ;
  strs := TStringList.Create;
  strs.add('/*');
  strs.add('');
  strs.add('  WareLord Static Data script');
  strs.add('    For manual compiling with SDataCMP.EXE');
  strs.add('');
  strs.add('  Otherwise, use the Visual Static Data Editor (SDataWin.EXE in the \Devtools folder)');
  strs.add('');
  strs.add('*/');
  strs.add('');

  strs.add('group_names');
  strs.add('begin');
  for t := 0 to grpnamecnt - 1 do
  begin
    ;
    strdata := ReplaceData(group_names[t]);
    if t < grpnamecnt - 1 then
      strs.add('"' + strdata + '",')
    else
      strs.add('"' + strdata + '"');
  end;
  strs.add('end;');
  strs.add('');
  strs.add('ftp_sites');
  strs.add('begin');
  for t := 0 to ftpsitecnt - 1 do
  begin
    ;
    if ftp_sites[t].site_script <> '' then
      strdata := '("' + ReplaceData(ftp_sites[t].domainaddress) + '","' +
        ReplaceData(ftp_sites[t].displayname) + '", script="' + ftp_sites[t].site_script + '")'
    else

      strdata := '("' + ReplaceData(ftp_sites[t].domainaddress) + '","' +
        ReplaceData(ftp_sites[t].displayname) + '")';

    if t < ftpsitecnt - 1 then
      strdata := strdata + ',';
    strs.add(strdata);
  end;

  strs.add('end;');
  strs.add('');

  strs.add('app_types');
  strs.add('begin');

  for t := 0 to apptypecnt - 1 do
  begin
    ;
    strdata := ReplaceData(apptypes[t]);
    if t < apptypecnt - 1 then
      strs.add('"' + strdata + '",')
    else
      strs.add('"' + strdata + '"');
  end;

  strs.add('end;');
  strs.add('');
  strs.add('aliases');
  strs.add('begin');
  for t := 0 to aliascnt - 1 do
  begin
    ;
    strdata := ReplaceData(aliases[t]);
    if t < aliascnt - 1 then
      strs.add('"' + strdata + '"=' + GetAliasGender(aliases_gender[t]) + ',')
    else
      strs.add('"' + strdata + '"=' + GetAliasGender(aliases_gender[t]));
  end;

  strs.add('end;');

  strs.SaveToFile('..\data\static\masterstatic.wls');
  strs.Clear;
  strs.add('/*');
  strs.add('');
  strs.add(' Name Generator data');
  strs.add(' Script auto-saved from SDataWIN.EXE');
  strs.add('');
  strs.add('*/');
  strs.add('');

  strs.add('name_data');
  strs.add(' begin');
  for I := 0 to namedatacnt - 1 do
  begin
    ;
    strdata := 'namegroup ' + namedata[i].lookup;
    strs.add('    ' + strdata);
    strs.add('   (');
    added   := 0;
    strdata := '';
    for t := 0 to namedata[i].namecnt - 1 do
    begin
      ;

      strdata := '"' + ReplaceData(namedata[i].names[t]) + '"';
      if t < namedata[i].namecnt - 1 then
        strdata := strdata + ', ';
      strs.add('    ' + strdata);

      strdata := '';

    end;



    if i < namedatacnt - 1 then
      strs.add('   );')
    else
      strs.add('   )');
  end;
  strs.add(' end;');
  strs.SaveToFile('..\data\static\namedata.wls');


  strs.Clear;
  strs.add('/*');
  strs.add('');
  strs.add(' String data');
  strs.add(' Script auto-saved from SDataWIN.EXE');
  strs.add('');
  strs.add('*/');
  strs.add('');

  for I := 0 to genericdatacnt - 1 do
  begin
    ;
    strdata := 'data ' + genericdata[i].lookup;
    strs.add(' ' + strdata);
    strs.add('   begin');
    added   := 0;
    strdata := '';
    for t := 0 to genericdata[i].namecnt - 1 do
    begin
      ;

      strdata := '"' + ReplaceData(genericdata[i].names[t]) + '"';
      if t < genericdata[i].namecnt - 1 then
        strdata := strdata + ', ';
      strs.add('    ' + strdata);

      strdata := '';

    end;


    strs.add('    end');

  end;
  strs.SaveToFile('..\data\static\stringdata.wls');

  strs.Clear;
  strs.Add('/*');
  strs.add('');
  strs.add('    WareLord WorldGen master data script.');
  strs.add('');
  strs.Add('*/');
  strs.add('');
  strs.add('#include "namedata" // Includes the namedata.wls file, made separate just for clarity');
  strs.add('#include "stringdata" // Includes the stringdata.wls file, containin generic data strings');
  strs.add('#include "masterstatic" // Includes the masterstatic.wls file, main static data script');
  strs.savetofile(Name);

end;

procedure writeraw(Data: string; var f: file);
var
  s:        integer;
var
  dastr:    array [1..600000] of char;
var
  dalength: integer;
begin
  ;
  dalength := length(Data);
  for s := 1 to length(Data) do
  begin
    ;
    dastr[s] := Data[s];
    //blockwrite(f, data[s], 1);
  end;
  //writeln('DaLength := ',dalength,' String: ',data);
  blockwrite(f, dastr, dalength);
end;


procedure SaveBinData(filename: string; usecompression: boolean);
var
  f:            file;
var
  iscompressed: boolean;
var
  destsize, origsize: integer;
var
  cmpfile:      string;
var
  len, z, s:    integer;
begin
  ;
  assignfile(f, changefileext(filename, '.dat'));
  rewrite(f, 1);
  writeraw('WLSDATA', f);
  iscompressed := False;
  blockwrite(f, iscompressed, 1);
  blockwrite(f, grpnamecnt, 4);
  blockwrite(f, ftpsitecnt, 4);
  blockwrite(f, namedatacnt, 4);
  blockwrite(f, apptypecnt, 4);
  blockwrite(f, aliascnt, 4);
  blockwrite(f, genericdatacnt, 4);
  for s := 0 to apptypecnt - 1 do
  begin
    ;
    len := length(AppTypes[s]);
    blockwrite(f, len, 4);

  end;
  for s := 0 to apptypecnt - 1 do
  begin
    ;
    //writeln('APPTYPE OFFSET: ',filepos(f));
    writeraw(AppTypes[s], f);
    writeraw(' ', f);
  end;


  for s := 0 to grpnamecnt - 1 do
  begin
    ;
    len := length(group_Names[s]);
    blockwrite(f, len, 4);
  end;

  for s := 0 to grpnamecnt - 1 do
  begin
    ;
    //writeln('GRPNAME OFFSET: ',filepos(f));
    writeraw(group_Names[s], f);
    writeraw(' ', f);
  end;



  for s := 0 to ftpsitecnt - 1 do
  begin
    ;
    //writeln('Domain OFFSET: ',filepos(f));
    len := length(ftp_sites[s].domainaddress);
    blockwrite(f, len, 4);
    len := length(ftp_sites[s].displayname);
    blockwrite(f, len, 4);
    len := length(ftp_sites[s].site_script);
    blockwrite(f, len, 4);
  end;

  for s := 0 to ftpsitecnt - 1 do
  begin
    ;
    //writeln('FTPSite OFFSET: ',filepos(f));
    writeraw(ftp_sites[s].domainaddress, f);
    writeraw(' ', f);
    writeraw(ftp_sites[s].displayname, f);
    writeraw(' ', f);
    writeraw(ftp_sites[s].site_script, f);
    writeraw(' ', f);
  end;

  for s := 0 to namedatacnt - 1 do
  begin
    ;
    len := length(namedata[s].lookup);
    blockwrite(f, len, 4);
  end;


  for s := 0 to namedatacnt - 1 do
  begin
    ;
    //writeln('NameData OFFSET: ',filepos(f));
    writeraw(namedata[s].lookup, f);
    writeraw(' ', f);
  end;

  for s := 0 to namedatacnt - 1 do
  begin
    ;
    blockwrite(f, namedata[s].namecnt, 4);
  end;

  for s := 0 to namedatacnt - 1 do
  begin
    ;
    for z := 0 to namedata[s].namecnt - 1 do
    begin
      ;
      len := length(namedata[s].names[z]);
      blockwrite(f, len, 1);
    end;
    for z := 0 to namedata[s].namecnt - 1 do
    begin
      ;
      //writeln('Names ',namedata[s].lookup,' OFFSET: ',filepos(f));

      writeraw(namedata[s].names[z], f);
      writeraw(' ', f);

    end;

  end;


  for s := 0 to aliascnt - 1 do
  begin
    ;
    len := length(aliases[s]);
    blockwrite(f, len, 1);

  end;
  for s := 0 to aliascnt - 1 do
  begin
    ;
    //writeln('APPTYPE OFFSET: ',filepos(f));
    writeraw(aliases[s], f);
    writeraw(' ', f);
    blockwrite(f, aliases_gender[s], 1);
  end;


  for s := 0 to genericdatacnt - 1 do
  begin
    ;
    len := length(genericdata[s].lookup);
    blockwrite(f, len, 4);
  end;

  for s := 0 to genericdatacnt - 1 do
  begin
    ;
    //writeln('NameData OFFSET: ',filepos(f));
    writeraw(genericdata[s].lookup, f);
    writeraw(' ', f);
  end;

  for s := 0 to genericdatacnt - 1 do
  begin
    ;
    blockwrite(f, genericdata[s].namecnt, 4);
  end;

  for s := 0 to genericdatacnt - 1 do
  begin
    ;
    for z := 0 to genericdata[s].namecnt - 1 do
    begin
      ;
      len := length(genericdata[s].names[z]);
      blockwrite(f, len, 4);
    end;
    for z := 0 to genericdata[s].namecnt - 1 do
    begin
      ;
      //writeln('Names ',namedata[s].lookup,' OFFSET: ',filepos(f));

      writeraw(genericdata[s].names[z], f);
      writeraw(' ', f);

    end;

  end;


  origsize := filesize(f);
  closefile(f);
  if usecompression = True then
  begin

    compress_(changefileext(filename, '.dat'), zcmax);
    assignfile(f, changefileext(filename, '.dat') + '.zlib');
    reset(f, 1);
    destsize := filesize(f);
    Close(f);

    assignfile(f, changefileext(filename, '.dat'));
    rewrite(f, 1);
    writeraw('WLSDATA', f);
    iscompressed := True;
    blockwrite(f, iscompressed, 1);
    blockwrite(f, origsize, 4);
    blockwrite(f, destsize, 4);
    cmpfile      := FileToString(changefileext(filename, '.dat') + '.zlib');
    writeraw(cmpfile, f);
    Close(f);
    deletefile(changefileext(filename, '.dat') + '.zlib');
  end;

end;



procedure readdatashort(var Data: shortstring; len: integer; var f: file);
var
  str: string;
var
  ch:  char;
var
  s:   integer;
begin
  ;
  try
    Data := '';
    for s := 1 to len do
    begin
      ;
      blockread(f, ch, 1);
      Data := Data + ch;
    end;
  except
    on e : Exception do
    begin
      ;

    end;
  end;

end;

procedure readdata(var Data: string; len: integer; var f: file);
var
  str: string;
var
  ch:  char;
var
  s:   integer;
begin
  try
    Data := '';
 //   globaldebug('reading data of length ' + IntToStr(len) + ' at ' + IntToStr(filepos(f)));
    for s := 1 to len do
    begin

      blockread(f, ch, 1);
      Data := Data + ch;
    end;
  except
    on e : Exception do
    begin
      MessageDlg('ERROR!', mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure AddNewEntry(ind: integer; Data: string);
begin
  setlength(genericdata[ind].names, genericdata[ind].namecnt + 1);
  genericdata[ind].names[genericdata[ind].namecnt] := Data;
  Inc(genericdata[ind].namecnt);

end;


function AddNewData(sectname: string): integer;
begin
  new(genericdata[genericdatacnt]);
  genericdata[genericdatacnt].lookup := sectname;
  genericdata[genericdatacnt].namecnt := 0;
  Result := genericdatacnt;
  Inc(genericdatacnt);
end;

function readraw(Data: string; var f: file): boolean;
var
  str: string;
  ch:  char;
  s:   integer;
begin
  ;
  str := '';
  //DebugMSg('Read_DATA: '+data);
  for s := 1 to length(Data) do
  begin
    ;
    blockread(f, ch, 1);
    str    := str + ch;
  end;
  if Data = str then
    Result := True
  else
    Result := False;
end;
// Auto detects compression
function LoadStaticData(filename: string; var f: file): boolean;
var
  len, z, s:            integer;
  destfsize, origfsize: integer;
  iscompressed:         boolean;
  uncmpfile:            string;
begin
  if not fileexists(filename) then
  begin
    exit;
  end;

  application.ProcessMessages;
  assignfile(f, filename);
  reset(f, 1);
  readraw('WLSDATA', f);
  iscompressed := False;
  blockread(f, iscompressed, 1);
  if iscompressed = True then
  begin
    globaldebug('Compressed data.');
    blockread(f, origfsize, 4);
    blockread(f, destfsize, 4);
    readdata(uncmpfile, destfsize, f);
    StringToFile(filename + '.tmp.zlib', uncmpfile);
    Closefile(f);
    decompress_as(filename + '.tmp.zlib', filename + '.tmp');

    assignfile(f, filename + '.tmp');
  end
  else
  begin
  //  assignfile(f, filename);

  end;

  reset(f, 1);
  if readraw('WLSDATA', f) = False then
  begin

    closefile(f);
    Result := False;
    exit;
  end;

  seek(f, filepos(f) + 1);
  globaldebug('counts..');
  blockread(f, grpnamecnt, 4);
  blockread(f, ftpsitecnt, 4);
  blockread(f, tempnamecnt, 4);
  blockread(f, apptypecnt, 4);
  blockread(f, aliascnt, 4);
  blockread(f, tempgenericcnt, 4);

  globaldebug('apptypes');
  //DebugMSG('Groupnamecnt: '+inttostr(grpnamecnt));
  //DebugMSG('ftpsitecnt: '+inttostr(ftpsitecnt));
  //DebugMSG('namedatacnt: '+inttostr(namedatacnt));
  //DebugMSG('apptypecnt: '+inttostr(apptypecnt));
  if apptypecnt > 0 then
  begin
    for s := 0 to apptypecnt - 1 do
    begin
      application.ProcessMessages;
      //len := length(AppTypes[s]);
      blockread(f, len, 4);
      AppTypes_Length[s] := len;
    end;

    for s := 0 to apptypecnt - 1 do
    begin
      application.ProcessMessages;
      readdata(AppTypes[s], apptypes_length[s], f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);
    end;
  end;

  Form8.spSkinListBox1.Items.add('GRPNameLoad');

  if grpnamecnt > 0 then
  begin
    for s := 0 to grpnamecnt - 1 do
    begin
      application.ProcessMessages;
      //len := length(group_Names[s]);
      blockread(f, len, 4);
      Group_Name_Length[s] := len;
    end;

    for s := 0 to grpnamecnt - 1 do
    begin
      application.ProcessMessages;
      readdata(group_Names[s], group_name_length[s], f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);
    end;
  end;

  if ftpsitecnt > 0 then
  begin
    Form8.spSkinListBox1.Items.add('FTPSiteLoad');
    for s := 0 to ftpsitecnt - 1 do
    begin
      application.ProcessMessages;
      //len := length(ftp_sites[s].domainaddress);
      blockread(f, len, 4);
      ftp_sites[s].da_length := len;
      //len := length(ftp_sites[s].displayname);
      blockread(f, len, 4);
      ftp_sites[s].dn_lenght := len;
      blockread(f, len, 4);
      ftp_sites[s].ss_length := len;

    end;

    for s := 0 to ftpsitecnt - 1 do
    begin
      application.ProcessMessages;
      readdata(ftp_sites[s].domainaddress, ftp_sites[s].da_length, f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);
      readdata(ftp_sites[s].displayname, ftp_sites[s].dn_lenght, f);
      seek(f, filepos(f) + 1);
      readdata(ftp_sites[s].site_script, ftp_sites[s].ss_length, f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);
    end;
  end;


  for s := namedatacnt to namedatacnt + tempnamecnt - 1 do
  begin
    application.ProcessMessages;
    new(namedata[s]);
    //len := length(namedata[s].lookup);
    blockread(f, len, 4);
    namedata[s].lookup_length := len;
  end;

  for s := namedatacnt to namedatacnt + tempnamecnt - 1 do
  begin
    application.ProcessMessages;
    readdata(namedata[s].lookup, namedata[s].lookup_length, f);
    seek(f, filepos(f) + 1);
    //readraw(' ',f);
  end;

  for s := namedatacnt to namedatacnt + tempnamecnt - 1 do
  begin
    ;
    blockread(f, namedata[s].namecnt, 4);
  end;

  for s := namedatacnt to namedatacnt + tempnamecnt - 1 do
  begin
    application.ProcessMessages;
    setlength(namedata[s].name_length, namedata[s].namecnt + 1);
    setlength(namedata[s].names, namedata[s].namecnt + 1);


    for z := 0 to namedata[s].namecnt - 1 do
    begin
      ;
      //len := length(namedata[s].names[z]);
      blockread(f, len, 1);
      namedata[s].name_length[z] := len;
    end;
    for z := 0 to namedata[s].namecnt - 1 do
    begin
      ;
      readdata(namedata[s].names[z], namedata[s].name_length[z], f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);

    end;

  end;

  for s := 0 to aliascnt - 1 do
  begin

    application.ProcessMessages;
      //len := length(aliases[s]);
    blockread(f,  aliases_length[s], 1);
//    := len;
//    globaldebug('aliaslength: '+inttostr(len));
  end;
  for s := 0 to aliascnt - 1 do
  begin
     application.ProcessMessages;  //writeln('APPTYPE OFFSET: ',filepos(f));
//  globaldebug('vitun paska on : '+inttostr(filepos(f)));

    readdata(aliases[s], aliases_length[s], f);
    seek(f, filepos(f) + 1);
    blockread(f, aliases_gender[s], 1);
  end;


  for s := genericdatacnt to genericdatacnt + tempgenericcnt - 1 do
  begin
    application.ProcessMessages;
    //len := length(genericdata[s].lookup);
    blockread(f, len, 4);
    new(genericdata[s]);

    genericdata[s].lookup_length := len;
  end;

  for s := genericdatacnt to genericdatacnt + tempgenericcnt - 1 do
  begin
    readdata(genericdata[s].lookup, genericdata[s].lookup_length, f);
    seek(f, filepos(f) + 1);
    //readraw(' ',f);
  end;

  for s := genericdatacnt to genericdatacnt + tempgenericcnt - 1 do
  begin

    blockread(f, genericdata[s].namecnt, 4);
  end;

  for s := genericdatacnt to genericdatacnt + tempgenericcnt - 1 do
  begin

    setlength(genericdata[s].name_length, genericdata[s].namecnt + 1);
    setlength(genericdata[s].names, genericdata[s].namecnt + 1);
    for z := 0 to genericdata[s].namecnt - 1 do
    begin

      //len := length(genericdata[s].names[z]);
      blockread(f, len, 4);
      genericdata[s].name_length[z] := len;
    end;
    for z := 0 to genericdata[s].namecnt - 1 do
    begin

      readdata(genericdata[s].names[z], genericdata[s].name_length[z], f);
      seek(f, filepos(f) + 1);
      //readraw(' ',f);

    end;

  end;


  genericdatacnt := genericdatacnt + tempgenericcnt;
  namedatacnt    := namedatacnt + tempnamecnt;
  closefile(f);
  if iscompressed = True then
    deletefile(filename + '.tmp');
  Result         := True;

end;



end.

