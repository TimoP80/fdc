unit txtparser;

interface

uses
  Classes,
  Dialogs,
  jclstrings,
  pluginfunc,
  SysUtils;

var
  line:           string;

var
  playerlinetemp: string;

var
  propstringtemp, playerlinktemp: string;

var
  genderlinetemp, npctemp: string;

var
  itemlist:       TStrings;

procedure ParseTXT(filename: string; var storage: dialog);

implementation

procedure ParseTXT(filename: string; var storage: dialog);
var
  t:        textfile;
var
  nodename: string;
begin
  ;
  assignfile(t, filename);
  reset(t);
  //new(storage);
  storage.nodecount := -1;
  while not EOF(t) do
  begin
    ;

    readln(t, line);
    // senddebugmsg(pchar('Read: '+line));
    line := stringreplace(line, '''', '''''', [rfReplaceAll]);
    if (pos('//', line) = 0) then
    begin
      ;
      if (pos('NPCPROPS', line) <> 0) then
      begin
        ;
        itemlist             := TStringList.Create;
        propstringtemp       := copy(line, pos('NPCPROPS', line) + length('NPCPROPS') + 1, length(line));
        itemlist.commatext   := propstringtemp;
        storage.npcname      := itemlist[0];
        storage.location     := itemlist[1];
        storage.description  := itemlist[2];
        storage.unknowndesc  := itemlist[3];
        storage.knowndesc    := itemlist[4];
        storage.detaileddesc := itemlist[5];
      end
      else
      if (pos('FEMALE', line) = 1) and (pos('-', line) <> 1) then
      begin
        ;
        npctemp := copy(line, pos('FEMALE', line) + 7, length(line));
        storage.nodes[storage.nodecount].npctext_female := PChar(npctemp);

      end
      else

      if ((pos(':', line) <> 0) or (pos('(', line) <> 0)) and (pos('-', line) <> 1) and
        (pos('FEMALE', line) = 0) then
      begin
        ;
        Inc(storage.nodecount);
        new(storage.nodes[storage.nodecount]);
        if pos(':', line) <> 0 then
        begin
          npctemp  := copy(line, pos(':', line) + 2, length(line));
          nodename := copy(line, 1, pos(':', line) - 1);

        end
        else
        if pos('(', line) <> 0 then
        begin
          ;
          npctemp  := copy(line, pos(')', line) + 2, length(line));
          nodename := copy(line, pos('(', line) + 1, pos(')', line) - 2);
        end;

        //senddebugmsg(pchar('NPC Line '+npctemp+', nodecount: '+inttostr(storage.nodecount)+'! NODENAME: '+nodename));
        //storage.nodes[storage.nodecount].nodename := copy(line,1,pos(':',line)-1);
        //showmessage('Node='+nodename);
        storage.nodes[storage.nodecount].nodename := format('%s', [nodename]);
        storage.nodes[storage.nodecount].npctext  := PChar(npctemp);
        storage.nodes[storage.nodecount].optioncnt := 0;
        //showmessage('NPCLIne: '+line);
      end
      else if (pos('-', line) = 1) then
      begin
        ;
        // showmessage('Playerlinktemp: '+playerlinktemp);
        if pos('gender=', line) <> 0 then
        begin
          ;

        end;

        playerlinetemp := copy(line, pos('-', line) + 2, pos('(', line) - 3);
        playerlinktemp := copy(line, pos('(', line) + 1, pos(')', line) - 1);
        playerlinktemp := stringreplace(playerlinktemp, '(', '', [rfReplaceAll]);
        playerlinktemp := stringreplace(playerlinktemp, ')', '', [rfReplaceAll]);
        //      senddebugmsg(pchar('playerline: '+playerlinetemp));
        //      senddebugmsg(pchar('source: '+line));
        new(storage.nodes[storage.nodecount].options[storage.nodes[storage.nodecount].optioncnt]);
        storage.nodes[storage.nodecount].options[
          storage.nodes[storage.nodecount].optioncnt].optiontext := PChar(playerlinetemp);
        if playerlinktemp = 'done' then
          storage.nodes[storage.nodecount].options[
            storage.nodes[storage.nodecount].optioncnt].nodelink := playerlinktemp
        else

          storage.nodes[storage.nodecount].options[
            storage.nodes[storage.nodecount].optioncnt].nodelink := playerlinktemp;
        //storage.nodes[storage.nodecount].options[storage.nodes[storage.nodecount].optioncnt].nodelink := 'playerlinktemp;
        Inc(storage.nodes[storage.nodecount].optioncnt);
      end;
    end;

  end;
  Inc(storage.nodecount);
  //showmessage('Total nodes: '+inttostr(storage.nodecount));
  closefile(t);

end;

end.

