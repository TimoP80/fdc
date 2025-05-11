program datlibtest;

{$APPTYPE CONSOLE}

uses
  fo_datlib,SysUtils;

var data: datfileheader;
var s: file;
var t: integer;
begin
writeln('DatLibTest v0.1 (c) 2005 DjUnique');
if paramcount=0 then
exit;

init_dat_logger(getcurrentdir);
  opendatfile(s,data,paramstr(1));
for t:=0 to data.filecount-1 do
begin;
writeln(data.files[t].filename,' ',data.files[t].realsize,' ',data.files[t].packedsize);
openfilefromdatwithfullpath(s,data,data.files[t].filename);
end;
// cleanuprecursedtempfiles(data,getcurrentdir+'\');
  { TODO -oUser -cConsole Main : Insert code here }
end.
