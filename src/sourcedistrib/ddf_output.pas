(*

---------------------------------------------------------------
FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitk�nen
---------------------------------------------------------------
Description:

  This unit is used for dumping FMF dialogues into the DDF
  format for use with the FMFC commandline compiler and the
  GUI dialogue converter.
---------------------------------------------------------------

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


unit ddf_output;

interface

uses
  Classes,
  DLGDef,
  Inifiles,
  JclStrings,
  SharedDLGData,
  strutils,
  SysUtils;

var


  msg_step: integer;

{$IFDEF FMFCBuild}
 AMDS_Cfg,
 templatecfg: TInifile;
  config:           TInifile;
  nodes:            integer;
  node, tempstr:    string;
  temp:             string;
  tempstrz:         string;
  scriptoutputpath: string;

  reaction:         shortstring;
  // msgname, sslname: shortstring;
  sslpath, msgpath: shortstring;
  startpath:        string;
  cur_node:         dlgnode;
  linebase:         integer;
  sslfile, msgfile, script_template, npcname, description, location, scriptID, unknowndesc,
  knowndesc, detailed: string;
{$ENDIF}
function SaveFMF2DDF(dlg: dialog): string;

procedure InitDDFDumper(basepath: string);

implementation

function skillfieldtoconst(fld: integer): string;
begin
  ;
  case fld of
    CHECK_FIELD_SKILL_SMALLGUNS:
      Result := ' CHECK_FIELD_SKILL_SMALLGUNS';
    CHECK_FIELD_SKILL_BIGGUNS:
      Result := 'CHECK_FIELD_SKILL_BIGGUNS';
    CHECK_FIELD_SKILL_ENERGYWEAPONS:
      Result := 'CHECK_FIELD_SKILL_ENERGYWEAPONS';
    CHECK_FIELD_SKILL_UNARMED:
      Result := 'CHECK_FIELD_SKILL_UNARMED';
    CHECK_FIELD_SKILL_MELEE:
      Result := 'CHECK_FIELD_SKILL_MELEE';
    CHECK_FIELD_SKILL_THROWING:
      Result := 'CHECK_FIELD_SKILL_THROWING';
    CHECK_FIELD_SKILL_FIRSTAID:
      Result := 'CHECK_FIELD_SKILL_FIRSTAID';
    CHECK_FIELD_SKILL_DOCTOR:
      Result := 'CHECK_FIELD_SKILL_DOCTOR';
    CHECK_FIELD_SKILL_SNEAK:
      Result := 'CHECK_FIELD_SKILL_SNEAK';
    CHECK_FIELD_SKILL_LOCKPICK:
      Result := 'CHECK_FIELD_SKILL_LOCKPICK';
    CHECK_FIELD_SKILL_STEAL:
      Result := 'CHECK_FIELD_SKILL_STEAL';
    CHECK_FIELD_SKILL_TRAPS:
      Result := 'CHECK_FIELD_SKILL_TRAPS';
    CHECK_FIELD_SKILL_SCIENCE:
      Result := 'CHECK_FIELD_SKILL_SCIENCE';
    CHECK_FIELD_SKILL_REPAIR:
      Result := 'CHECK_FIELD_SKILL_REPAIR';
    CHECK_FIELD_SKILL_SPEECH:
      Result := 'CHECK_FIELD_SKILL_SPEECH';
    CHECK_FIELD_SKILL_BARTER:
      Result := 'CHECK_FIELD_SKILL_BARTER';
    CHECK_FIELD_SKILL_GAMBLING:
      Result := 'CHECK_FIELD_SKILL_GAMBLING';
    CHECK_FIELD_SKILL_OUTDOORSMAN:
      Result := 'CHECK_FIELD_SKILL_OUTDOORSMAN';
    18 + CHECK_FIELD_STAT_ST:
      Result := 'CHECK_FIELD_STAT_STRENGTH';
    18 + CHECK_FIELD_STAT_PE:
      Result := 'CHECK_FIELD_STAT_PERCEPTION';
    18 + CHECK_FIELD_STAT_EN:
      Result := 'CHECK_FIELD_STAT_ENDURANCE';
    18 + CHECK_FIELD_STAT_CH:
      Result := 'CHECK_FIELD_STAT_CHARISMA';
    18 + CHECK_FIELD_STAT_IN:
      Result := 'CHECK_FIELD_STAT_INTELLIGENCE';
    18 + CHECK_FIELD_STAT_AG:
      Result := 'CHECK_FIELD_STAT_AGILITY';
    18 + CHECK_FIELD_STAT_LK:
      Result := 'CHECK_FIELD_STAT_LUCK';
  end;

end;

function GetConditionSTR(Data: starting_condition): string;
var
  t: integer;
begin
  ;
  Result := '';
  for t := 0 to Data.condcnt - 1 do
  begin
    ;
    Result := Result + '(' + Data.conditions[t].resultcode + ')';
    if t < Data.condcnt - 1 then
    begin
      ;
      case Data.conditions[t].linkage of
        1:
          Result := Result + ' and ';
        2:
          Result := Result + ' or ';
      end;
    end;

  end;

end;


procedure InitDDFDumper(basepath: string);
begin
  ;
  {$IFDEF FMFCBuild}
  templatecfg     := TInifile.Create(basepath + '\ssltemplates\templates.cfg');
  // dlgcfg          := TInifile.Create(basepath + '\fmfdlg.ini');
  sslpath         := config.ReadString('Global Config', 'DefaultSSLPath', '');
  msgpath         := config.ReadString('Global Config', 'DefaultMSGPath', '');

  if template_name<>'' then
  begin;
  script_template := basepath + '\' + templatecfg.ReadString(template_name, 'filename', '');

  end else
    script_template := basepath + '\' + templatecfg.ReadString('Basic Dialogue', 'filename', '');

  script_template := stringreplace(script_template, '"', '', [rfreplaceall]);
  {$ENDIF}
end;


function GetNotes(var_src: Tvariable): string;
begin
  Result := '';
  Result := var_src.notes;
  Result := StringReplace(Result, #13#10, '\n', [rfReplaceAll]);
  Result := StringReplace(Result, #9, '\t', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '\"', [rfReplaceAll]);
  if var_Src.notes = '' then
    Result := ''
  else
    Result := ' notes "' + Result + '"';

end;

function SaveFMF2DDF(dlg: dialog): string;
var
  temcnt, l, k, c, i, j: integer;
  varflags: string;
  script:  TStrings;
  codelst: TStrings;
  codetemp: string;
  npctext_temp, npcfemaletext_temp: string;
  temp, conds: string;
  male_starts_with_id: boolean;
  female_starts_with_id: boolean;

begin
  ;


   {$IFDEF CONSOLE}
  sslfile := sslpath + '\' + changefileext(extractfilename(dlg.filename), '.ssl');
  msgfile := msgpath + '\' + changefileext(extractfilename(dlg.filename), '.msg');
  sslfile := stringreplace(sslfile, '"', '', [rfreplaceall]);
  msgfile := stringreplace(msgfile, '"', '', [rfreplaceall]);
 {$ENDIF}
  {$IFDEF FMFCBuild}

  npcname     := dlg.npcname;
  description := dlg.description;
  location    := dlg.location;
  scriptID    := uppercase(changefileext(dlg.filename,''));
  scriptID := StringReplace(scriptID,' ','_',[rfReplaceAll]);
  unknowndesc := dlg.unknowndesc;
  knowndesc   := dlg.knowndesc;
  detailed    := dlg.detaileddesc;
  nodes       := dlg.nodecount;
  {$ENDIF}
  script := TStringList.Create;

  script.add('/*');
  script.add('');
  script.add(' Intermediate DDF File');
  script.add(' Exported by FMF Dialogue tool Dialogue Converter.');
  script.add('');
  script.add('NPC: ' + npcname);
  script.add('Location: ' + location);
  script.add('description: ' + description);
  script.add('');
  script.add('*/');
  script.add('');
  description := stringreplace(description, #13#10, '\n', [rfreplaceall]);
  unknowndesc := stringreplace(unknowndesc, #13#10, '\n', [rfreplaceall]);
  knowndesc := stringreplace(knowndesc, #13#10, '\n', [rfreplaceall]);
  detailed  := stringreplace(detailed, #13#10, '\n', [rfreplaceall]);


  description := stringreplace(description, '"', '\"', [rfreplaceall]);
  unknowndesc := stringreplace(unknowndesc, '"', '\"', [rfreplaceall]);
  knowndesc := stringreplace(knowndesc,  '"', '\"', [rfreplaceall]);
  detailed  := stringreplace(detailed,  '"', '\"', [rfreplaceall]);

  script.add(Format('MSGOutputName = "%s"', [msgfile]));
  script.add(Format('SCROutputName = "%s"', [sslfile]));
  script.add(Format('ScriptTemplate = "%s"', [script_template]));
  script.add(Format('ScriptID = %s', [scriptID]));
  script.add(Format('NPCName = "%s"', [npcname]));
  script.add(Format('Description = "%s"', [description]));
  script.add(Format('Location = "%s"', [location]));

  script.add('');
  script.add('descproc');
  script.add('begin;');
  script.add(Format('unknown = "%s"', [unknowndesc]));
  script.add(Format('known = "%s"', [knowndesc]));
  script.add(Format('detailed = "%s"', [detailed]));
  script.add('end;');
  script.add('');
  script.add('StartNodes');
  script.add('Begin');
  if dlg.startconditioncnt = 0 then
  begin
    if dlg.nodecount = 0 then
      script.add('Case (default): ' + dlg.floatnodes[0].nodename + ' EndCase')
    else

      script.add('Case (default): ' + dlg.nodes[0].nodename + ' EndCase');
  end
  else
  begin
    ;

    for j := 0 to dlg.startconditioncnt - 1 do
    begin
      ;
      if (J <> dlg.default_cond) then
      begin
        ;
        script.add(format('Case %s: %s EndCase',
          [GetConditionSTR(dlg.startconditions[j]^), dlg.startconditions[j].goto_node]));
      end;

      //   writeln('Skipped default startnode: ' + dlg.startconditions[dlg.default_cond].goto_node);
    end;
    if (dlg.default_cond <> -1) then
    begin
      ;
      script.add('Case (default): ' + dlg.startconditions[dlg.default_cond].goto_node +
        ' EndCase');
    end;
  end;

  script.add('End');

  script.add('');

  if dlg.varcnt > 0 then
  begin
    ;
    script.add('/* Variable definitions */');
    for j := 0 to Dlg.varcnt - 1 do
    begin
      ;

      case dlg.variables[j].flags of
        VAR_FLAGS_NONE:
          varflags := ' ';
        VAR_FLAGS_IMPORT:
          varflags := ' import ';
        VAR_FLAGS_EXPORT:
          varflags := ' export ';
        VAR_FLAGS_LOCAL:
          varflags := ' local ';
      end;

      if dlg.variables[j].vartype <> -1 then
      begin
        ;
        case dlg.variables[j].vartype of
          VAR_TYPE_INT:
            script.add('variable' + varflags + dlg.variables[j].Name +
              GetNotes(dlg.variables[j]^) + ' = ' +
              IntToStr(dlg.variables[j].Value) + ';');
          VAR_TYPE_STRING:
            script.add('variable' + varflags + dlg.variables[j].Name +
              GetNotes(dlg.variables[j]^) + ' = "' + dlg.variables[j].Value + '";');
          VAR_TYPE_FLOAT:
            script.add('variable' + varflags + dlg.variables[j].Name +
              GetNotes(dlg.variables[j]^) + ' = ' +
              floattostr(dlg.variables[j].Value) + ';');

        end;

      end
      else
      begin
        ;
        script.add('variable' + varflags + dlg.variables[j].Name +
          GetNotes(dlg.variables[j]^) + ';');
      end;
    end;

    script.add('');
  end;


  if dlg.timedeventcnt > 0 then
  begin
    ;
    script.add('timed_events_block');
    script.add('default_event=' + IntToStr(dlg.start_time_event) + ';');
    script.add('begin');
    for j := 0 to dlg.timedeventcnt - 1 do
    begin
      ;
      script.add('    time_event ' + dlg.timedevents[j].FixedParamName +
        '=' + IntToStr(dlg.timedevents[j].FixedParamEnumIndex) + ';');
      if (dlg.timedevents[j].israndom = False) then
        script.add
        (format('    interval %d;', [dlg.timedevents[j].interval]))
      else
        script.add(format('    interval %d - %d;',
          [dlg.timedevents[j].mininterval, dlg.timedevents[j].maxinterval]));
      script.add('    code');
      script.add('       begin');
      for i := 0 to dlg.timedevents[j].actioncnt - 1 do
      begin
        ;
        temp := dlg.timedevents[j].actionlines[i].linedata;
        temp := StringReplace(temp, '"', '\"', [rfReplaceAll]);
        if i < dlg.timedevents[j].actioncnt - 1 then
        begin
          ;
          script.add('      "' + temp + '",');
        end
        else
          script.add('      "' + temp + '"');

      end;

      script.add('        end');

    end;

    script.add('  end');

  end;



  script.add('dialogue:');
  script.add('begin');
  linebase := 200;
  for i := 0 to dlg.floatnodecount - 1 do
  begin
    ;

    if dlg.floatnodes[i].notes <> '' then
    begin
      ;
      temp := dlg.floatnodes[i].notes;
      temp := StringReplace(temp, '"', '\"', [rfReplaceAll]);
      temp := StringReplace(temp, #13#10, '\n', [rfReplaceAll]);

      script.add('  ' + dlg.floatnodes[i].nodename + ': ("' +
        dlg.floatnodes[i].notes + '") notes "' + temp + '"');

    end
    else

      script.add('  ' + dlg.floatnodes[i].nodename + ': ');

    script.add('  StartNum=' + IntToStr(linebase) + ';');

    script.add('');

    script.add('   begin');

    script.add('    RandomFloats');
    script.add('    (');
    for j := 0 to dlg.floatnodes[i].messagecnt - 1 do
    begin
      temp := dlg.floatnodes[i].Messages[j];
      temp := StringReplace(temp, '"', '\"', [rfReplaceAll]);
      if j < dlg.floatnodes[i].messagecnt - 1 then
        script.add('    "' + temp + '",')
      else
        script.add('    "' + temp + '"');
    end;
    script.add('    )');
    script.add('   end');

    if dlg.floatnodes[i].messagecnt > msg_Step then
      Inc(linebase, dlg.floatnodes[i].messagecnt)
    else
      Inc(linebase, msg_step);
  end;

  for I := 0 to dlg.nodecount - 1 do
  begin
    cur_node := dlg.nodes[i]^;
    //senddebugmsg(PChar('LineBase for node (' + cur_node.nodename + ') = ' + IntToStr(linebase)));
    if cur_node.notes <> '' then
    begin
      tempstrz := cur_node.notes;
      tempstrz := stringreplace(tempstrz, #13#10, '\"', [rfReplaceAll]);
      tempstrz := stringreplace(tempstrz, '"', '\"', [rfReplaceAll]);
      script.add(Format('     %s: notes "%s"', [cur_node.NodeName, tempstrz]));
    end
    else
      script.add(Format('     %s: ', [cur_node.NodeName]));
    script.add(Format('     StartNum=%d;', [linebase]));

    for k := 0 to dlg.customproccnt - 1 do
    begin
      ;
      if dlg.customprocs[k].associatewithnode = i then
      begin
        ;
        script.add('add_new_proc ' + dlg.customprocs[k].Name + ' {');
        codetemp := dlg.customprocs[k].Lines;
        codelst  := TStringList.Create;
        StrToStrings(codetemp, #13#10, codelst);
        for l := 0 to codelst.Count - 1 do
        begin
          ;
          if l < codelst.Count - 1 then
            script.add('  "' + stringreplace(codelst[l], '"', '\"',
              [rfReplaceAll]) + '",')
          else
            script.add('  "' + stringreplace(codelst[l], '"', '\"',
              [rfReplaceAll]) + '"');

        end;

        script.add('}');
        codelst.Free;

      end;

    end;


    script.add('    begin');

    for k := 0 to dlg.nodes[i].skillcheckcnt - 1 do
    begin
      ;
      script.add('addskillcheck ' + dlg.nodes[i].skillchecks[k].check_proc_name + ' {');
      script.add('field = ' + skillfieldtoconst(dlg.nodes[i].skillchecks[k].check_what));
      script.add('modifier = ' + IntToStr(dlg.nodes[i].skillchecks[k].modifier));
      script.add('onsuccess => ' + dlg.nodes[i].skillchecks[k].successnode);
      script.add('onfailure => ' + dlg.nodes[i].skillchecks[k].failurenode);
      script.add('}');
      script.add('');
    end;

    if (dlg.nodes[i].customcode <> '') then
    begin
      ;
      script.Add('custom_code {');
      codetemp := dlg.nodes[i].customcode;
      codelst  := TStringList.Create;
      StrToStrings(codetemp, #13#10, codelst);
      for k := 0 to codelst.Count - 1 do
      begin
        ;
        if k < codelst.Count - 1 then
          script.add('  "' + stringreplace(codelst[k], '"', '\"', [rfReplaceAll]) + '",')
        else
          script.add('  "' + stringreplace(codelst[k], '"', '\"', [rfReplaceAll]) + '"');

      end;
      script.Add('}');

      codelst.Free;
    end;
    script.add('');
    npctext_temp := cur_node.npctext;
    npctext_temp :=
      StringReplace(npctext_temp, '"', '\"', [rfReplaceAll]);
    npctext_temp :=
      StringReplace(npctext_temp, #13#10, '\n', [rfReplaceAll]);

    npctext_temp :=
      StringReplace(npctext_temp, '|', '"+"', [rfReplaceAll]);

    npctext_temp :=
      StringReplace(npctext_temp, '${', '"+', [rfReplaceAll]);
    npctext_temp :=
      StringReplace(npctext_temp, '}', '+"', [rfReplaceAll]);
    npctext_temp := StringReplace(npctext_temp, '<PC>', '"+dude_name+"',
      [rfReplaceAll]);
    male_starts_with_id := False;
    female_starts_with_id := False;

    if pos('"+', npctext_temp) = 1 then
    begin
      ;
      npctext_temp :=
        StringReplace(npctext_temp, '"+', '', []);
      male_starts_with_id := True;
    end;

    npcfemaletext_temp := cur_node.npctext_female;
    npcfemaletext_temp :=
      StringReplace(npcfemaletext_temp, '"', '\"', [rfReplaceAll]);


    npcfemaletext_temp :=
      StringReplace(npcfemaletext_temp, '${', '"+', [rfReplaceAll]);



    npcfemaletext_temp :=
      StringReplace(npcfemaletext_temp, '|', '"+"', [rfReplaceAll]);

    npcfemaletext_temp :=
      StringReplace(npcfemaletext_temp, '}', '+"', [rfReplaceAll]);
    npcfemaletext_temp :=
      StringReplace(npcfemaletext_temp, '<PC>', '"+dude_name+"', [rfReplaceAll]);

    if pos('"+', npcfemaletext_temp) = 1 then
    begin
      ;
      npcfemaletext_temp :=
        StringReplace(npcfemaletext_temp, '"+', '', []);
      female_starts_with_id := True;

    end;



    if npcfemaletext_temp <> '' then
    begin
      ;
      if (male_starts_with_id = True) and (female_starts_with_id = False) then
        script.add(Format('     NPC: %s" female: "%s";',
          [npctext_temp, npcfemaletext_temp]))
      else
      if (male_starts_with_id = True) and (female_starts_with_id = True) then
        script.add(Format('     NPC: %s" female: %s";',
          [npctext_temp, npcfemaletext_temp]))
      else
      if (male_starts_with_id = False) and (female_starts_with_id = True) then
        script.add(Format('     NPC: "%s" female: %s";',
          [npctext_temp, npcfemaletext_temp]))
      else

        script.add(Format('     NPC: "%s" female: "%s";',
          [npctext_temp, npcfemaletext_temp]));
    end
    else
    begin
      ;
      if (male_starts_with_id = True) then
        script.add(Format('     NPC: %s";', [npctext_temp]))
      else

        script.add(Format('     NPC: "%s";', [npctext_temp]));
    end;


    for j := 0 to cur_node.optioncnt - 1 do
    begin
      assert(cur_Node.options[j] <> nil, 'Player option ' + IntToStr(j) +
        ' has a null pointer!');
      temp := cur_node.options[j].optiontext;

      temp := stringreplace(temp, '"', '\"', [rfReplaceAll]);
      temp := stringreplace(temp, #13#10, '\n', [rfReplaceAll]);

      conds := '';
      case cur_node.options[j].reaction of
        REACTION_NEUTRAL:
          reaction := 'NEUTRAL';
        REACTION_GOOD:
          reaction := 'GOOD';
        REACTION_BAD:
          reaction := 'BAD';
      end;
      tempstr := '    Player [int=%d] [reaction=' + reaction + ']: "%s", Goto=>%s';
      if (cur_node.options[j].conditioncnt > 0) then
      begin
        ;
        for c := 0 to cur_node.options[j].conditioncnt - 1 do
        begin
          ;
          conds := conds + '(' + cur_node.options[j].conditions[c].resolved_code + ')';
          if c < cur_node.options[j].conditioncnt - 1 then
          begin
            ;
            case cur_node.options[j].conditions[c].link of
              LINK_NONE:
                conds := conds + ' ';
              LINK_AND:
                conds := conds + ' and ';
              LINK_OR:
                conds := conds + ' or ';
            end;

          end;

        end;
        tempstr := '    Player [int=%d] [reaction=' + reaction +
          '] condition: ' + conds + ': "%s", Goto=>%s';
      end;

      if cur_node.options[j].genderflags = GENDER_FEMALE then
      begin
        ;
        if cur_node.options[j].conditioncnt > 0 then
          conds := conds + ' and (dude_is_female)'
        else
          conds := '(dude_is_female)';
        tempstr := '    Player [int=%d] [reaction=' + reaction +
          '] condition: ' + conds + ': "%s", Goto=>%s';
      end
      else
      if cur_node.options[j].genderflags = GENDER_MALE then
      begin
        if cur_node.options[j].conditioncnt > 0 then
          conds := conds + ' and (dude_is_male)'
        else
          conds := '(dude_is_male)';

        tempstr :=
          '    Player [int=%d] [reaction=' + reaction + '] condition: ' +
          conds + ': "%s", Goto=>%s';
      end;
      tempstrz := '';
      if cur_node.options[j].notes <> '' then
      begin
        tempstrz := cur_node.options[j].notes;
        tempstrz := stringreplace(tempstrz, #13#10, '\n', [rfReplaceAll]);
        tempstrz := stringreplace(tempstrz, '"', '\"', [rfReplaceAll]);
        tempstrz := stringreplace(tempstrz, '%', '%%', [rfReplaceAll]);
        tempstr  := tempstr + ' notes "' + tempstrz + '"';
      end;
      tempstr := tempstr + ';';
      if pos('${', cur_node.options[j].optiontext) <> 0 then
      begin
        temp := StringReplace(temp, '${', '"+', [rfReplaceAll]);
        temp := StringReplace(temp, '}', '+"', [rfReplaceAll]);
      end;
      if pos('<PC>', cur_node.options[j].optiontext) <> 0 then
      begin
        ;
        temp := StringReplace(temp, '<PC>', '"+dude_name+"', [rfReplaceAll]);
      end;
      if cur_node.Options[j].NodeLink = 'done' then
        node := 'Node999'
      else
      if cur_node.Options[j].NodeLink = 'combat' then
        node := 'Node998'
      else
        node := cur_node.Options[j].nodelink;
      try
        script.add(Format(tempstr, [cur_node.options[j].intcheck, temp, node]));
      except
        on e: Exception do
        begin
          //   ShowMessage('Error while adding: ' + tempstr);
        end;
      end;
    end;
    script.add('    end');
    if msg_step = 1 then
      Inc(linebase, cur_node.optioncnt + 1)
    else

      Inc(linebase, msg_Step);
  end;
  script.add('end');
  temp := changefileext(dlg.filename, '.ddf');
  script.SaveToFile(temp);

  Result := temp;

end;


end.

