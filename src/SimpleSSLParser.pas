unit SimpleSSLParser;

interface

uses Sysutils, Strutils_, pluginfunc, msgparser, classes;

type

  option = record
    optiontext: string;
    gender: string;
    iq: integer;
    reaction: integer;
    link: string;
  end;

  sslrec = record
    nodename: string;
    reply_params: string;
    reply_params_female: string;
    options: array of option;
    optioncnt: integer;
  end;

var
  ssldata: array of sslrec;
  sslcount: integer;
  themsg: TMSGParser;

procedure ParseSSLFile(filename: string);

implementation
uses ParseSSLTest;

function GetMsgString(id: integer): string;
var
  u: integer;
begin
  for u := 0 to CurrentMessageFile.entrycnt - 1 do
  begin
    if id = currentmessagefile.entries[u].index then
    begin
      result := currentmessagefile.entries[u].messagestr;
      exit;
    end;
  end;
end;

function getsslfuncindex(sslname: string): integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to sslcount - 1 do
  begin
    if ssldata[i].nodename = sslname then
    begin
      result := i;
      exit;
    end;
  end;
end;

function ParseMSTR(input: string): string;
var
  msgtemp: string;
  mstrcount, id, y: integer;
  currentparam, params: string;
begin
  params := input;
  mstrcount := WordCount(params, ['+', ' ']);
  msgtemp := '';
  for y := 1 to mstrcount do
  begin
    currentparam := trim(extractword(y, params, ['+', ' ']));
   // debug('MSTR: ' + inttostr(y) + ' = ' + currentparam);
    if pos('mstr', currentparam) <> 0 then
    begin
      currentparam := StringReplace(currentparam, 'mstr(', '', [rfreplaceall]);
      currentparam := StringReplace(currentparam, ')', '', [rfreplaceall]);

      id := strtoint(currentparam);

      msgtemp := msgtemp + getmsgstring(id);
    end
    else
    begin
      if currentparam = 'dude_name' then
      begin
        msgtemp := msgtemp + '<PC>';
      end
      else
      begin
        ;
        msgtemp := msgtemp + '${' + currentparam + '}';
      end;
    end;
  end;
  result := msgtemp;

end;

procedure ParseSSLFile(filename: string);
var
  parencount, i: integer;
  z, x, j, y: integer;
var
  input: TStrings;
  beginfound: boolean;
  begindepth: integer;
  commentmode: boolean;
  walkpos: integer;
  procindex: integer;
  msgtemp: string;
  mstrparams: tstrings;
  mstrcount: integer;
  id: integer;
  malemode, femalemode: boolean;
  currentparam, temp, procname: string;
  idstr, params: string;
begin
  input := TStringlist.create;
  input.LoadFromFile(filename);
  begindepth := 0;
  sslcount := 0;

  for j := 0 to input.count - 1 do
  begin
    if pos('//', input[j]) <> 0 then
    begin
      //  debug('ignore comment: '+input[j]);
    end;
    if pos('/*', input[j]) <> 0 then
    begin
      commentmode := true;
    end;
    if commentmode = true then
    begin
      // debug('comment: ' + input[j]);
    end;
    if pos('*/', input[j]) <> 0 then
    begin
      commentmode := false;
    end;

    if pos('begin', input[j]) <> 0 then
    begin
      inc(begindepth);
      // debug('begin depth: ' + inttostr(begindepth));
      beginfound := true;
    end;

    if pos('end', input[j]) <> 0 then
    begin
      beginfound := false;
      if begindepth >= 0 then
        dec(begindepth);
    end;
    if (pos('procedure', input[j]) <> 0) and (commentmode = false) and
      (pos('//', input[j]) = 0) then
    begin
     // debug('procedure found, depth = ' + inttostr(begindepth));

      i := getsslfuncindex(extractword(2, input[j], [' ', '(', ')', ';', ',']));
      if i = -1 then
      begin
      //  debug('Procedure: ' + extractword(2, input[j], [' ', '(', ')', ';',
      //    ',']));
        setlength(ssldata, sslcount + 1);
        ssldata[sslcount].nodename := extractword(2, input[j], [' ', ';', '(',
          ')',
            ',']);
        ssldata[sslcount].optioncnt := 0;
        inc(sslcount);
      end
      else
      begin
      //  debug('Already exists: ' + extractword(2, input[j], [' ', '(', ';', ')',
      //    ',']));
        procname := ssldata[i].nodename;
        procindex := i;

      end;

    end;
    if (pos('if', input[j]) <> 0) and (pos('dude_is_female', input[j]) <> 0)
      then
    begin
      femalemode := true;
    end;
    if (pos('if', input[j]) <> 0) and (pos('dude_is_male', input[j]) <> 0) then
    begin
      malemode := true;
    end;
    if pos('NOption', input[j]) <> 0 then
    begin
      walkpos := pos('(', input[j]) + 1;
      temp := input[j];
      parencount := 1;
      params := '';
      while parencount > 0 do
      begin
        if (temp[walkpos] = '(') then
        begin
          inc(parencount);
        //  debug('inc parencount');
        end;
        if (temp[walkpos] = ')') then
        begin
          dec(parencount);
        //  debug('dec parencount');
          if parencount = 0 then
            break;
        end;
        params := params + temp[walkpos];
        inc(walkpos);
      end;
      idstr := trim(extractword(1, params, [',']));
      if pos('mstr', idstr) <> 0 then
        msgtemp := parsemstr(idstr)
      else
        msgtemp := GetMsgString(strtoint(idstr));
      setlength(ssldata[procindex].options, ssldata[procindex].optioncnt + 1);
      ssldata[procindex].options[ssldata[procindex].optioncnt].optiontext :=
        msgtemp;
      ssldata[procindex].options[ssldata[procindex].optioncnt].link :=
        trim(extractword(2, params, [',']));
      if ssldata[procindex].options[ssldata[procindex].optioncnt].link='Node999' then
      ssldata[procindex].options[ssldata[procindex].optioncnt].link := 'done' else
      if ssldata[procindex].options[ssldata[procindex].optioncnt].link='Node998' then
      ssldata[procindex].options[ssldata[procindex].optioncnt].link  :='combat';

      ssldata[procindex].options[ssldata[procindex].optioncnt].iq :=
        strtoint(trim(extractword(3, params, [','])));
      ssldata[procindex].options[ssldata[procindex].optioncnt].reaction :=
        REACTION_NEUTRAL;
      if (malemode = false) and (femalemode = false) then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'both';

      end;
      if malemode = true then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'male';
        malemode := false;
      end;
      if femalemode = true then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'female';
        femalemode := false;
      end;
      //debug('message: ' + msgtemp);
      inc(ssldata[procindex].optioncnt);
    end;
    if pos('BOption', input[j]) <> 0 then
    begin
      walkpos := pos('(', input[j]) + 1;
      temp := input[j];
      parencount := 1;
      params := '';
      while parencount > 0 do
      begin
        if (temp[walkpos] = '(') then
        begin
          inc(parencount);
         // debug('inc parencount');
        end;
        if (temp[walkpos] = ')') then
        begin
          dec(parencount);
         // debug('dec parencount');
          if parencount = 0 then
            break;
        end;
        params := params + temp[walkpos];
        inc(walkpos);
      end;
      idstr := trim(extractword(1, params, [',']));
      if pos('mstr', idstr) <> 0 then
        msgtemp := parsemstr(idstr)
      else
        msgtemp := GetMsgString(strtoint(idstr));
      setlength(ssldata[procindex].options, ssldata[procindex].optioncnt + 1);
      ssldata[procindex].options[ssldata[procindex].optioncnt].optiontext :=
        msgtemp;
      ssldata[procindex].options[ssldata[procindex].optioncnt].link :=
        trim(extractword(2, params, [',']));
      ssldata[procindex].options[ssldata[procindex].optioncnt].iq :=
        strtoint(trim(extractword(3, params, [','])));
      ssldata[procindex].options[ssldata[procindex].optioncnt].reaction :=
        REACTION_BAD;
      if (malemode = false) and (femalemode = false) then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'both';

      end;
      if malemode = true then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'male';
        malemode := false;
      end;
      if femalemode = true then
      begin
        ssldata[procindex].options[ssldata[procindex].optioncnt].gender :=
          'female';
        femalemode := false;
      end;
     // debug('message: ' + msgtemp);
      inc(ssldata[procindex].optioncnt);

    end;
    if pos('GOption', input[j]) <> 0 then
    begin
      walkpos := pos('(', input[j]) + 1;
      temp := input[j];
      parencount := 1;
      params := '';
      while parencount > 0 do
      begin
        if (temp[walkpos] = '(') then
        begin
          inc(parencount);
       //   debug('inc parencount');
        end;
        if (temp[walkpos] = ')') then
        begin
          dec(parencount);
        //  debug('dec parencount');
          if parencount = 0 then
            break;
        end;
        params := params + temp[walkpos];
        inc(walkpos);
      end;
      idstr := trim(extractword(1, params, [',']));
      if pos('mstr', idstr) <> 0 then
        msgtemp := parsemstr(idstr)
      else
        msgtemp := GetMsgString(strtoint(idstr));
      setlength(ssldata[procindex].options, ssldata[procindex].optioncnt + 1);
      ssldata[procindex].options[ssldata[procindex].optioncnt].optiontext :=
        msgtemp;
      ssldata[procindex].options[ssldata[procindex].optioncnt].link :=
        trim(extractword(2, params, [',']));
      ssldata[procindex].options[ssldata[procindex].optioncnt].iq :=
        strtoint(trim(extractword(3, params, [','])));
      ssldata[procindex].options[ssldata[procindex].optioncnt].reaction :=
        REACTION_GOOD;
        if (malemode=false) and (femalemode=false)
     then
      begin
              ssldata[procindex].options[ ssldata[procindex].optioncnt].gender := 'both';

      end;
     if malemode=true then
      begin
         ssldata[procindex].options[ ssldata[procindex].optioncnt].gender := 'male';
 malemode:=false;
      end;
      if femalemode=true then
      begin
         ssldata[procindex].options[ ssldata[procindex].optioncnt].gender := 'female';
 femalemode:=false;
      end;
     // debug('message: ' + msgtemp);
      inc(ssldata[procindex].optioncnt);

    end;
    if pos('Reply(', input[j]) <> 0 then
    begin
      //params:=copy(input[j], pos('Reply',input[j])+7, pos(')',input[j])-3);
      walkpos := pos('(', input[j]) + 1;
      temp := input[j];
      z := 0;
      parencount := 1;
      params := '';
      while (parencount > 0) do
      begin
        params := params + temp[walkpos];
        inc(walkpos);
        if (temp[walkpos] = '(') then
        begin
          inc(parencount);
        end;
        if (temp[walkpos] = ')') then
        begin
          dec(parencount);

        end;

      end;
      if pos('mstr', params) = 0 then
      begin
        msgtemp := GetMsgString(strtoint(params));
       // debug('message = ' + msgtemp);
        if malemode = true then
          malemode := false;
        if femalemode = true then
        begin
          ssldata[procindex].reply_params_female := msgtemp;
          femalemode := false;
        //  debug('Female reply!');
        end
        else
        begin
          ssldata[procindex].reply_params := msgtemp;
        end
      end
      else if pos('mstr', params) <> 0 then
      begin
      //  debug('MSTR found, parsing params.');
        mstrparams := tstringlist.create;
        mstrcount := WordCount(params, ['+', ' ']);
        msgtemp := '';
        for y := 1 to mstrcount do
        begin
          currentparam := trim(extractword(y, params, ['+', ' ']));
        //  debug('MSTR: ' + inttostr(y) + ' = ' + currentparam);
          if pos('mstr', currentparam) <> 0 then
          begin
            currentparam := StringReplace(currentparam, 'mstr(', '',
              [rfreplaceall]);
            currentparam := StringReplace(currentparam, ')', '',
              [rfreplaceall]);

            id := strtoint(currentparam);

            msgtemp := msgtemp + getmsgstring(id);
          end
          else
          begin
            if currentparam = 'dude_name' then
            begin
              msgtemp := msgtemp + '<PC>';
            end
            else
            begin
              ;
              msgtemp := msgtemp + '${' + currentparam + '}';
            end;
          end;
        end;
       // debug('msg joined part: ' + msgtemp);
        if femalemode = true then
        begin
          ssldata[procindex].reply_params_female := msgtemp;
          femalemode := false;
        //  debug('female joined reply');
        end
        else
          ssldata[procindex].reply_params := msgtemp;

      end;

     // debug('params := ' + params);

    end;
  end;
end;

end.

