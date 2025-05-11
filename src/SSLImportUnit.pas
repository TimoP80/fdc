(*

  This unit handles the processing of the parsed SSL data, preserving conditions
  as single lines of code to be placed into the .fmf file as a custom condition
  with only the resolved_ssl field

  TODO:

  [X] Commands with conditions are doubled, check for duplicate code calls
  [X] Add non dialogue commands to custom code
  [X] Solve the issue of handling custom conditions, possibly by setting eval to EVAL_EQUALS and
  ignorning the rest of the dtta in the fmf parser
  [ ] Extract npc look descriptions from look_at_p_proc and examine_p_proc
  [X] Remove eztra commandline debug output once the parser works flawlessly (still
  crashing in some script cases)
  [ ] Import variables from script
  [X] Add reaction support
  [X] Handle else blocks in if statements
      partially working, single line else statements are imported but not begin..end blocks
  [ ] Fix else statements being omitted from the custom vode
  [X] import code inside dialogue nodes as custom code properly
  [X] Preprocessing pass to determine which nodes are actually dialogue nodes
      and which are branching nodes with procedure calls

  [X] Fix script import for dialogue scripts produced by DialogueConverter
  - this was due to the procedure begin being at a new line, when moved to
  after procedure name it was parsing in just fine, so code adjustments are
  needed
  [X] Import begin and end blocks
  [X] Fix custom code conditions being duplicated

*)

unit SSLImportUnit;

interface

uses System.classes, msgparser, JclStrings, System.strutils, SharedDLGData,
  SSLPreprocessingPass, System.sysutils,
  System.RegularExpressions,
  System.masks,System.ioutils;

type
  TScriptCommand = record
    Command: string;
    Parameters: TArray<String>;
    Resolved_MSG: string;
    HasIfBlock: boolean;
    ThenCondition: string;
    ConditionBlockThen: array of TScriptCommand;
    HasElseBlock: boolean;

    ConditionBlockElse: array of TScriptCommand;
  end;

type
  TSCriptVariable = record
    varname: string;
    vartype: integer;
    varvalue: string;
  end;

type
  TScriptProcedure = record
    ScriptProcName: string;
    Variables: array of TSCriptVariable;
    Variablecnt: integer;
    Commands: array of TScriptCommand;
    Commandcnt: integer;
  end;

var
  ScriptProcedures: array of TScriptProcedure;
  procedurecnt: integer;
  msgparser: TMSGParser;

procedure Data_AddProcedure(procname: string; Body: TStringlist);
procedure Data_AddCommand(procname: string; CMD: string;
  params: TArray<string>; condition: string = '');
procedure Data_AddProcedureHeader(procname: string);
procedure ParseMSG(filename: string);
procedure savedlgdata(filename: string; srcfilename: string);
procedure Data_AddCondition(procname: string; condition: string);
function GetProcNameIndex(procname: String): integer;
function AddPlayerOptionToNode(nodename: string; opttext: string;
  nodelink: string; notes: string = '';
  reaction: integer = REACTION_NEUTRAL; int_check : integer = 4): integer;
procedure Data_AddVariable(varname: string; varvalue: string; flags: integer);
procedure Data_AddElsePart(procname: string);
procedure AddCustomCodeToNode(nodename: string; code: string; condition: string;
  haselse: boolean = False);

implementation

procedure savedlgdata(filename: string; srcfilename: string);
var
  t, ux, y: integer;
  condstr, genderconst, reactionconst: string;
  tempdesc, tempdesc2, tempdesc3, tempdesc4, tempdesc5: string;
  version_str, temp, temp2, temp3: string;
  thelist, Data: TStrings;
begin
  Data := TStringlist.Create;
  Data.add('/*');
  Data.add('');
  Data.add('       Fallout Dialogue Creator');
  Data.add('         dialogue script file');
  Data.add('');
  Data.add(' -- hand editing this file is not recommended');
  Data.add('');
  Data.add('Ímported From SSL script ' + srcfilename);
  Data.add('');
  Data.add('*/');
  Data.add('');
  tempdesc := currentdlg.description;
  tempdesc2 := currentdlg.location;
  tempdesc3 := currentdlg.unknowndesc;
  tempdesc4 := currentdlg.knowndesc;
  tempdesc5 := currentdlg.detaileddesc;
  tempdesc := stringreplace(tempdesc, '"', '\"', [rfreplaceall]);
  tempdesc := stringreplace(tempdesc, #13#10, '\n', [rfreplaceall]);
  tempdesc2 := stringreplace(tempdesc2, '"', '\"', [rfreplaceall]);
  tempdesc2 := stringreplace(tempdesc2, #13#10, '\n', [rfreplaceall]);
  tempdesc3 := stringreplace(tempdesc3, '"', '\"', [rfreplaceall]);
  tempdesc3 := stringreplace(tempdesc3, #13#10, '\n', [rfreplaceall]);
  tempdesc4 := stringreplace(tempdesc4, '"', '\"', [rfreplaceall]);
  tempdesc4 := stringreplace(tempdesc4, #13#10, '\n', [rfreplaceall]);
  tempdesc5 := stringreplace(tempdesc5, '"', '\"', [rfreplaceall]);
  tempdesc5 := stringreplace(tempdesc5, #13#10, '\n', [rfreplaceall]);
  if currentdlg.varcnt > 0 then
  begin
    Data.add('vars {');
    for t := 0 to currentdlg.varcnt - 1 do
    begin
      temp := '';
      if currentdlg.Variables[t].flags = var_flags_import then
        temp := temp + 'import '
      else if currentdlg.Variables[t].flags = var_flags_export then
        temp := temp + 'export '
      else if currentdlg.Variables[t].flags = var_flags_local then
        temp := temp + 'local '
      else if currentdlg.Variables[t].flags = var_flags_global then
        temp := temp + 'global ';
      temp := temp + 'var ' + currentdlg.Variables[t].Name + ' notes "' +
        currentdlg.Variables[t].notes + '"';
      if currentdlg.Variables[t].vartype <> -1 then
      begin
        case currentdlg.Variables[t].vartype of
          var_type_int:
            temp := temp + ' = ' + IntToStr(currentdlg.Variables[t].value);
          var_type_float:
            temp := temp + ' = ' + floattostr(currentdlg.Variables[t].value);
          var_type_string:
            temp := temp + ' = "' + currentdlg.Variables[t].value + '"';
        end;
      end;
      Data.add(temp + ';');
      temp := '';
    end;
    Data.add('}');
  end;
  Data.add('NPCName "' + currentdlg.npcname + '"');
  Data.add('Location "' + tempdesc2 + '"');
  Data.add('Description "' + tempdesc + '"');
  Data.add('Unknown_Desc "' + tempdesc3 + '"');
  Data.add('Known_Desc "' + tempdesc4 + '"');
  Data.add('Detailed_Desc "' + tempdesc5 + '"');
  Data.add('');
  if currentdlg.startconditioncnt > 0 then
  begin
    Data.add('/* Dialogue starting conditions */');
    Data.add('');
    Data.add('start_conditions');
    Data.add('default_condition ' + IntToStr(currentdlg.default_cond));
    Data.add('{');
    for t := 0 to currentdlg.startconditioncnt - 1 do
    begin
      Data.add(format('cond target_node "%s"',
        [currentdlg.startconditions[t].goto_node]));
      Data.add('{');
      for y := 0 to currentdlg.startconditions[t].condcnt - 1 do
      begin
        if y < currentdlg.startconditions[t].condcnt - 1 then
          Data.add(format
            ('    SSL "%s" var_param "%s" eval %d value_to_check "%s" ini_index %d link %d,',
            [currentdlg.startconditions[t].conditions[y].resultcode,
            currentdlg.startconditions[t].conditions[y].parameter,
            currentdlg.startconditions[t].conditions[y].evaluator,
            currentdlg.startconditions[t].conditions[y].compareto,
            currentdlg.startconditions[t].conditions[y].index_of_selection,
            currentdlg.startconditions[t].conditions[y].linkage]))
        else
          Data.add(format
            ('    SSL "%s" var_param "%s" eval %d value_to_check "%s" ini_index %d link %d',
            [currentdlg.startconditions[t].conditions[y].resultcode,
            currentdlg.startconditions[t].conditions[y].parameter,
            currentdlg.startconditions[t].conditions[y].evaluator,
            currentdlg.startconditions[t].conditions[y].compareto,
            currentdlg.startconditions[t].conditions[y].index_of_selection,
            currentdlg.startconditions[t].conditions[y].linkage]));
      end;
      if t < currentdlg.startconditioncnt - 1 then
        Data.add('},')
      else
        Data.add('}');
    end;
    Data.add('};');
    Data.add('');
  end;
  if currentdlg.timedeventcnt > 0 then
  begin
    Data.add('/* Timed events */');
    Data.add('');
    Data.add('// Intervals are entered in seconds (converted to game ticks by the script)');
    Data.add('// default_event points to an index from the timed event list');
    Data.add('// starting from zero');
    Data.add('Default_Event = ' + IntToStr(currentdlg.start_time_event));
    for t := 0 to currentdlg.timedeventcnt - 1 do
    begin
      Data.add('TimeEvent fixed_param_name="' + currentdlg.timedevents[t]
        .fixedparamname + '", enum=' + IntToStr(currentdlg.timedevents[t]
        .fixedparamenumindex));
      Data.add('IsRandomInterval = ' + booltostr(currentdlg.timedevents[t]
        .israndom, True));
      if currentdlg.timedevents[t].israndom then
      begin
        Data.add('IntervalMin=' + IntToStr(currentdlg.timedevents[t]
          .mininterval));
        Data.add('IntervalMax=' + IntToStr(currentdlg.timedevents[t]
          .maxinterval));
      end
      else
      begin
        Data.add('Interval=' + IntToStr(currentdlg.timedevents[t].interval));
      end;
      Data.add('   code = {');
      for y := 0 to currentdlg.timedevents[t].actioncnt - 1 do
      begin
        temp := currentdlg.timedevents[t].actionlines[y].linedata;
        temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
        if (y < currentdlg.timedevents[t].actioncnt - 1) then
        begin
          Data.add('    "' + temp + '",');
        end
        else
          Data.add('    "' + temp + '"');
      end;
      Data.add('  }');
    end;
    Data.add('');
  end;
  if currentdlg.floatnodecount > 0 then
  begin
    Data.add('/* Float message nodes */');
    Data.add('');
    for t := 0 to currentdlg.floatnodecount - 1 do
    begin
      temp := currentdlg.floatnodes[t].notes;
      temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
      temp := stringreplace(temp, '"', '\"', [rfreplaceall]);

      Data.add('Floatnode "' + currentdlg.floatnodes[t].nodename + '"');
      Data.add('notes "' + temp + '"');
      Data.add('{');
      for y := 0 to currentdlg.floatnodes[t].messagecnt - 1 do
      begin
        temp := currentdlg.floatnodes[t].Messages[y];
        temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
        if y < currentdlg.floatnodes[t].messagecnt - 1 then
          Data.add('"' + temp + '",')
        else
          Data.add('"' + temp + '"');
      end;
      Data.add('}');
    end;
    Data.add('');
  end;
  Data.add('/* Regular nodes */');
  Data.add('');
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    Data.add('Node "' + currentdlg.nodes[t].nodename + '"');
    temp := currentdlg.nodes[t].notes;
    temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
    temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
    Data.add('notes "' + temp + '"');
    Data.add('is_wtg = ' + lowercase(booltostr(currentdlg.nodes[t]
      .is_wtg, True)));
    if currentdlg.nodes[t].customcode <> '' then
    begin
      Data.add('    insert_custom_code {');
      thelist := TStringlist.Create;
      temp := currentdlg.nodes[t].customcode;
      strtostrings(temp, #13#10, thelist);
      for y := 0 to thelist.Count - 1 do
      begin
        if y < thelist.Count - 1 then
          Data.add('    "' + stringreplace(thelist[y], '"', '\"',
            [rfreplaceall]) + '",')
        else
          Data.add('    "' + stringreplace(thelist[y], '"', '\"',
            [rfreplaceall]) + '"');
      end;
      Data.add('    }');
    end;
    if currentdlg.nodes[t].skillcheckcnt > 0 then
    begin
      Data.add('/* Skill checks for node ' + currentdlg.nodes[t]
        .nodename + ' */');
      Data.add('');
      for y := 0 to currentdlg.nodes[t].skillcheckcnt - 1 do
      begin
        Data.add('      define_skill_check ' + currentdlg.nodes[t].skillchecks
          [y].check_proc_name + ' {');
        Data.add(format('      skill_num = %d;' + #13#10 +
          '      difficulty_modifier = %d;' + #13#10 + '      onsuccess => %s;'
          + #13#10 + '      onfailure => %s;',
          [currentdlg.nodes[t].skillchecks[y].check_what,
          currentdlg.nodes[t].skillchecks[y].modifier,
          currentdlg.nodes[t].skillchecks[y].successnode,
          currentdlg.nodes[t].skillchecks[y].failurenode]));
        Data.add('      }');
      end;
      Data.add('');
    end;
    Data.add('{');
    temp := currentdlg.nodes[t].npctext;
    temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
    temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
    Data.add('NPCText "' + temp + '"');
    if (currentdlg.nodes[t].npctext_female <> '') then
    begin
      temp := currentdlg.nodes[t].npctext_female;
      temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
      temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
      Data.add(' NPCFemaleText "' + temp + '"');
    end;
    Data.add('      options {');
    for y := 0 to currentdlg.nodes[t].optioncnt - 1 do
    begin
      temp := currentdlg.nodes[t].options[y].optiontext;
      temp := stringreplace(temp, '"', '\"', [rfreplaceall]);
      temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
      temp2 := currentdlg.nodes[t].options[y].nodelink;
      temp3 := currentdlg.nodes[t].options[y].notes;
      temp2 := stringreplace(temp2, '"', '\"', [rfreplaceall]);
      temp2 := stringreplace(temp2, #13#10, '\n', [rfreplaceall]);
      temp3 := stringreplace(temp3, '"', '\"', [rfreplaceall]);
      temp3 := stringreplace(temp3, #13#10, '\n', [rfreplaceall]);
      genderconst := '';
      case currentdlg.nodes[t].options[y].genderflags of
        gender_male:
          genderconst := ' Gender=MALE';
        gender_female:
          genderconst := ' Gender=FEMALE';
      end;
      reactionconst := 'REACTION_NEUTRAL';
      case currentdlg.nodes[t].options[y].reaction of
        REACTION_NEUTRAL:
          reactionconst := 'REACTION_NEUTRAL';
        reaction_good:
          reactionconst := 'REACTION_GOOD';
        reaction_bad:
          reactionconst := 'REACTION_BAD';
      end;
      if currentdlg.nodes[t].options[y].conditioncnt > 0 then
      begin
        condstr := 'conditions { ';
        for ux := 0 to currentdlg.nodes[t].options[y].conditioncnt - 1 do
        begin
          condstr := condstr + generatecondstring
            (currentdlg.nodes[t].options[y].conditions[ux]^);
          if ux < currentdlg.nodes[t].options[y].conditioncnt - 1 then
            condstr := condstr + ', ';
        end;
        condstr := condstr + ' }';
      end
      else
        condstr := '';
      if (currentdlg.nodes[t].options[y].link_to_proc = True) and
        (currentdlg.nodes[t].options[y].link_to_skillcheck = False) then
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y]
          .intcheck) + ' linkflags custom_proc Reaction=' + reactionconst +
          genderconst + ' playertext "' + temp + '" linkto "' + temp2 + '" ' +
          condstr + ' notes "' + temp3 + '"')
      else if (currentdlg.nodes[t].options[y].link_to_proc = False) and
        (currentdlg.nodes[t].options[y].link_to_skillcheck = True) then
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y]
          .intcheck) + ' linkflags skill_check Reaction=' + reactionconst +
          genderconst + ' playertext "' + temp + '" linkto "' + temp2 + '" ' +
          condstr + ' notes "' + temp3 + '"')
      else
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y]
          .intcheck) + ' Reaction=' + reactionconst + genderconst +
          ' playertext "' + temp + '" linkto "' + temp2 + '" ' + condstr +
          ' notes "' + temp3 + '"');
    end;
    Data.add('              }');
    Data.add('}');
  end;
  if currentdlg.customproccnt > 0 then
  begin;
    Data.add('/* Custom procedures */');
    for t := 0 to currentdlg.customproccnt - 1 do
    begin;
      Data.add('      custom_proc ' + currentdlg.customprocs[t].Name +
        ' associate_node ' + IntToStr(currentdlg.customprocs[t]
        .associatewithnode) + ' {');
      thelist := TStringlist.Create;
      temp := currentdlg.customprocs[t].Lines;
      strtostrings(temp, #13#10, thelist);
      for y := 0 to thelist.Count - 1 do
      begin
        if y < thelist.Count - 1 then
          Data.add('      "' + stringreplace(thelist[y], '"', '\"',
            [rfreplaceall]) + '",')
        else
          Data.add('      "' + stringreplace(thelist[y], '"', '\"',
            [rfreplaceall]) + '"');
      end;
      Data.add('      }');
      thelist.Free;
    end;
  end;
  Data.savetofile(filename);
  Data.Free;

end;

function GetProcNameIndex(procname: String): integer;
var
  u: integer;
begin
  result := -1;
  for u := 0 to currentdlg.customproccnt - 1 do
  begin
    if procname = currentdlg.customprocs[u].Name then
    begin
      result := u;
      exit;
    end;
  end;
end;

procedure Data_AddVariable(varname: string; varvalue: string; flags: integer);
begin
  new(currentdlg.Variables[currentdlg.varcnt]);
  currentdlg.Variables[currentdlg.varcnt].Name := varname;
  currentdlg.Variables[currentdlg.varcnt].flags := flags;
  currentdlg.Variables[currentdlg.varcnt].vartype := var_type_string;
  currentdlg.Variables[currentdlg.varcnt].value := varvalue;
  inc(currentdlg.varcnt);

end;

procedure AddCustomCodeToNode(nodename: string; code: string; condition: string;
  haselse: boolean = False);
var
  customprocind: integer;
  nodeind: integer;

begin
  nodeind := GetNodeIndex(nodename);
  if nodename = '' then
  begin

    exit;
  end;
  if nodeind <> -1 then
  begin
 //   writeln('Adding custom code ', code, ' to node ', nodename,' nodeind: ',nodeind);
    if condition <> '' then
   begin
writeln('Condition at ',nodename,' == ',condition);
      currentdlg.nodes[nodeind].customcode := currentdlg.nodes[nodeind].customcode + 'if ' + condition + ' then '+code + #13#10
   end else

      currentdlg.nodes[nodeind].customcode := currentdlg.nodes[nodeind]
        .customcode + code + #13#10;
// writeln('Code: ',currentdlg.nodes[nodeind].customcode );
  end
  else
  begin
    // here we assume that the procedure is a custom procedure instead of a node
    // writeln('Node ', nodename,
    // ' not found, perhaps this is a custom procedure?');
    customprocind := GetProcNameIndex(nodename);
    if customprocind <> -1 then
    begin
      writeln('Added code to existing custom proc ', nodename);

      currentdlg.customprocs[customprocind].Lines := currentdlg.customprocs
        [customprocind].Lines + code + #13#10;

    end
    else
    begin
      customprocind := currentdlg.customproccnt;
      new(currentdlg.customprocs[customprocind]);
    writeln('Created new custom proc ', nodename);
      currentdlg.customprocs[customprocind].Name := nodename;
      if condition <> '' then
        currentdlg.customprocs[customprocind].Lines := 'if ' + condition +
          ' then ' + currentdlg.customprocs[customprocind].Lines + #13#10 + code
      else
      begin
        if haselse = True then
          currentdlg.customprocs[customprocind].Lines := currentdlg.customprocs
            [customprocind].Lines + ' else ' + code + #13#10
        else
          currentdlg.customprocs[customprocind].Lines := currentdlg.customprocs
            [customprocind].Lines + code + #13#10;
      end;
      currentdlg.customprocs[customprocind].associatewithnode := 0;
      inc(currentdlg.customproccnt);
    end;

  end;

end;

procedure AddNode(nodename: string; npctext: string);
var
  nodeind: integer;
begin
  nodeind := GetNodeIndex(nodename);
  if nodeind = -1 then
  begin
    nodeind := currentdlg.nodecount;
    new(currentdlg.nodes[nodeind]);
    currentdlg.nodes[nodeind].nodename := nodename;
    currentdlg.nodes[nodeind].npctext := npctext;
    currentdlg.nodes[nodeind].is_wtg := False;
    currentdlg.nodes[nodeind].skillcheckcnt := 0;
    currentdlg.nodes[nodeind].customcode := '';
    currentdlg.nodes[nodeind].optioncnt := 0;


    inc(currentdlg.nodecount);
  end
  else
  begin
//  writeln('Existing node at index ',nodeind);
    currentdlg.nodes[nodeind].nodename := nodename;
    currentdlg.nodes[nodeind].npctext := npctext;
    currentdlg.nodes[nodeind].is_wtg := False;
    currentdlg.nodes[nodeind].optioncnt := 0;



    if currentdlg.nodes[nodeind].customcode <> '' then
begin

  // writeln('Code is here : ',currentdlg.nodes[nodeind].customcode );
end else
    currentdlg.nodes[nodeind].customcode := '';
  end;
end;

procedure AddConditionsToPlayerOption(playeroptindex: integer; nodename: string;
  conditionstr: string);
var
  nodeind: integer;

begin
  nodeind := GetNodeIndex(nodename);
  if nodeind = -1 then
  begin
  end
  else
  begin
    // writeln('Condition count: ', currentdlg.nodes[nodeind].options
    // [playeroptindex].conditioncnt);
    new(currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]);

    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .check_type := CHECK_TYPE_CUSTOM_CODE;
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .check_field := CHECK_FIELD_NONE;
    // defaults to == but it is not used with the custom condition code, this is to prevent rewriting the fmf parser from scratxh
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .check_eval := COMPARE_EQUAL;
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .check_value := '';
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .var_ptr := '';
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt]
      .resolved_code := conditionstr;
    currentdlg.nodes[nodeind].options[playeroptindex].conditions
      [currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt].link :=
      LINK_NONE;
    inc(currentdlg.nodes[nodeind].options[playeroptindex].conditioncnt);
  end;

end;

function AddPlayerOptionToNode(nodename: string; opttext: string;
  nodelink: string; notes: string = '';
  reaction: integer = REACTION_NEUTRAL; int_check : integer = 4): integer;
var
  destnodename: string;
  nodeind: integer;
begin
  destnodename := nodename;
  notes := '';
  nodeind := GetNodeIndex(destnodename);
  if nodeind = -1 then
  begin
    // if outputwnd <> nil then
    // WNDOutput('Error: requested node "' + destnodename + '" does not exist!');
    result := -1;
  end
  else
  begin
    // writeln('option index: ', currentdlg.nodes[nodeind].optioncnt);
    new(currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]);
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .conditioncnt := 0;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .optiontext := opttext;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .link_to_proc := False;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .link_to_skillcheck := False;
    if GetNodeIndex(nodelink) = -1 then
    begin
      // writeln('Nodeindex : ',nodelink,' returned -1');
      /// /  .link_to_proc := true;
    end;
    if nodelink = 'Node999' then
      currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
        .nodelink := 'done'
    else if nodelink = 'Node998' then
      currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
        .nodelink := 'combat'
    else

      currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
        .nodelink := nodelink;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .notes := notes;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .reaction := reaction;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .genderflags := gender_none;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .intcheck := int_check;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]
      .conditioncnt := 0;
    inc(currentdlg.nodes[nodeind].optioncnt);
    result := currentdlg.nodes[nodeind].optioncnt;

  end;
end;

function GetMessageStringByIndex(ind: integer): string;
var
  i: integer;
begin
  result := '';
  for i := 0 to currentmessagefile.entrycnt - 1 do
  begin
    if currentmessagefile.entries[i].index = ind then
    begin
      result := currentmessagefile.entries[i].messagestr;
      exit;

    end;
  end;
end;

function SplitCMDParameters(const Input: string): TArray<string>;
var
  Parts: TStringlist;
  i, StartPos: integer;
  InFunction: boolean;
begin
  Parts := TStringlist.Create;
  try
    StartPos := 1;
    InFunction := False;

    for i := 1 to Length(Input) do
    begin
      case Input[i] of
        '(':
          InFunction := True; // Entering a function call
        ')':
          InFunction := False; // Exiting a function call
        ',':
          if not InFunction then
          begin
            Parts.add(Trim(Copy(Input, StartPos, i - StartPos)));
            StartPos := i + 1;
          end;
      end;
    end;

    // Add the last part
    if StartPos <= Length(Input) then
      Parts.add(Trim(Copy(Input, StartPos, Length(Input) - StartPos + 1)));

    result := Parts.ToStringArray;
  finally
    Parts.Free;
  end;
end;

function SplitExpression(const Input: string): TArray<string>;
var
  Parts: TStringlist;
  i, StartPos: integer;
  InFunction: boolean;
begin
  Parts := TStringlist.Create;
  try
    StartPos := 1;
    InFunction := False;

    for i := 1 to Length(Input) do
    begin
      case Input[i] of
        '(':
          InFunction := True; // Entering a function call
        ')':
          InFunction := False; // Exiting a function call
        '+':
          if not InFunction then
          begin
            Parts.add(Trim(Copy(Input, StartPos, i - StartPos)));
            StartPos := i + 1;
          end;
      end;
    end;

    // Add the last part
    if StartPos <= Length(Input) then
      Parts.add(Trim(Copy(Input, StartPos, Length(Input) - StartPos + 1)));

    result := Parts.ToStringArray;
  finally
    Parts.Free;
  end;
end;

procedure AddMessageToFloatNode(msg: string; nodename: string);
var
  floatnodeind: integer;
begin
  floatnodeind := GetFloatNodeIndex(nodename);
  if floatnodeind <> -1 then
  begin
    currentdlg.floatnodes[floatnodeind].Messages
      [currentdlg.floatnodes[floatnodeind].messagecnt] := msg;
    inc(currentdlg.floatnodes[floatnodeind].messagecnt);
  end
  else
  begin
    new(currentdlg.floatnodes[currentdlg.floatnodecount]);
    currentdlg.floatnodes[currentdlg.floatnodecount].nodename := nodename;
    currentdlg.floatnodes[currentdlg.floatnodecount].messagecnt := 0;
    currentdlg.floatnodes[currentdlg.floatnodecount].Messages
      [currentdlg.floatnodes[currentdlg.floatnodecount].messagecnt] := msg;
    inc(currentdlg.floatnodes[currentdlg.floatnodecount].messagecnt);
    inc(currentdlg.floatnodecount);

  end;

end;

procedure ParseMSG(filename: string);
begin
  msgparser := TMSGParser.Create(nil);
  msgparser.SourceFileName := filename;
  msgparser.Execute;
  if msgparser.Successful = True then
  begin
    writeln('Msg parsed with ', currentmessagefile.entrycnt, ' entries.');
  end;
end;

function GetProcIndex(procname: string): integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to procedurecnt - 1 do
  begin
    if procname = ScriptProcedures[i].ScriptProcName then
    begin
      result := i;
      exit;
    end;
  end;
end;

function ExtractFunctionAndParametersManual(const Input: string)
  : TArray<string>;
var
  FunctionName, ParametersStr: string;
  StartPos, EndPos: integer;
  Parameters: TArray<string>;
  i: integer;
begin
  StartPos := Pos('(', Input);
  EndPos := Pos(')', Input);

  if (StartPos = 0) or (EndPos = 0) then
    exit;

  // Extract function name
  FunctionName := Trim(Copy(Input, 1, StartPos - 1));

  // Extract and split parameters
  ParametersStr := Trim(Copy(Input, StartPos + 1, EndPos - StartPos - 1));
  Parameters := ParametersStr.Split([',']);

  // Output results
  result := Parameters;
  // writeln('Function Name: ', FunctionName);
  for i := 0 to High(Parameters) do

    // writeln('Parameter ', i + 1, ': ', Trim(Parameters[i]));
end;

function ExtractFunctionName(const Input: string): string;
var
  Regex: TRegEx;
  Match: TMatch;
  FunctionName, parameter: string;
begin
  // Regular expression to capture function name and parameter
  Regex := TRegEx.Create('(\w+)\(([^)]+)\)');
  Match := Regex.Match(Input);

  if Match.Success then
  begin
    FunctionName := Match.Groups[1].value; // e.g., "mstr"
    parameter := Match.Groups[2].value; // e.g., "112"
    result := FunctionName;
  end
  else
    writeln('No valid function pattern found! from ', Input);
end;

function ExtractFunctionParameter(const Input: string): string;
var
  Regex: TRegEx;
  Match: TMatch;
  FunctionName, parameter: string;
begin
  // Regular expression to capture function name and parameter
  Regex := TRegEx.Create('(\w+)\(([^)]+)\)');
  Match := Regex.Match(Input);

  if Match.Success then
  begin
    FunctionName := Match.Groups[1].value; // e.g., "mstr"
    parameter := Match.Groups[2].value; // e.g., "112"
    result := parameter;
  end
  else
    writeln('No valid function pattern found!');
end;

procedure Data_AddElsePart(procname: string);
var
  procindex: integer;
begin

  procindex := GetProcIndex(procname);
  if procindex <> -1 then
  begin
    // writeln('Adding condition to command in proc ', procname, ': ', condition);
    // writeln('Command index: ',commandindex);
    setlength(ScriptProcedures[procindex].Commands,
      ScriptProcedures[procindex].Commandcnt + 1);
    ScriptProcedures[procindex].Commands[ScriptProcedures[procindex].Commandcnt]
      .HasElseBlock := True;
  end;

end;

(*

  This will import all dialogue commands to the currentdlg structure
  Currently it only handles functions related to dialogue options and npc text

  But the rest of the code should be added to the custom code section

*)
procedure Data_AddCondition(procname: string; condition: string);
var
  procindex: integer;
begin

  procindex := GetProcIndex(procname);
  if procindex <> -1 then
  begin
    writeln('Adding condition to command in proc ', procname, ': ', condition);
    // writeln('Command index: ',commandindex);
    setlength(ScriptProcedures[procindex].Commands,
      ScriptProcedures[procindex].Commandcnt + 1);
    ScriptProcedures[procindex].Commands[ScriptProcedures[procindex].Commandcnt]
      .ThenCondition := condition;
  end;

end;

function listparams(params: TArray<string>): string;
var
  i: integer;
begin
  result := '';
  for i := 0 to Length(params) do
  begin
    if i < Length(params) then
      result := result + ',';
  end;
end;

function ResolveVariablesInString(str: string): string;
var
  x: integer;
  splittedparams: TArray<string>;
  resolvedstring: string;
  thecommand: string;
  param: string;
begin
  result := '';
//  writeln('Resolving variables from ', str);
  for x := 0 to Length(splittedparams) - 1 do
  begin
    // writeln('Param ', x, ' = ', splittedparams[x]);
    thecommand := ExtractFunctionName(splittedparams[x]);
    param := ExtractFunctionParameter(splittedparams[x]);
    // writeln('CMD:      ', thecommand);
    // writeln('Param:    ', param);
    if thecommand = 'mstr' then

      result := resolvedstring + GetMessageStringByIndex(strtoint(param))
    else if thecommand = 'obj_name' then
      result := resolvedstring + '<PC>'
    else if thecommand = 'dude_name' then
      result := resolvedstring + '<PC>'
  end;
end;

procedure Data_AddCommand(procname: string; CMD: string;
  params: TArray<string>; condition: string = '');
var
  procindex: integer;
  splittedparams: TArray<string>;
  x: integer;
  thecommand, param: string;
  startrange, endrange: integer;
  resolvedstring: string;
  lastindex: integer;
begin
  procindex := GetProcIndex(procname);
  if procindex <> -1 then
  begin
    /// /   string.join(', ', params));
    setlength(ScriptProcedures[procindex].Commands,
      ScriptProcedures[procindex].Commandcnt + 1);
    ScriptProcedures[procindex].Commands[ScriptProcedures[procindex].Commandcnt]
      .Command := CMD;
    // setlength( scriptprocedures[procindex].Commands[ scriptprocedures[procindex].Commandcnt].Parameters, params.count+1);
    ScriptProcedures[procindex].Commands[ScriptProcedures[procindex].Commandcnt]
      .Parameters := params;
    //writeln('Process command ', CMD, ' at ', procname);
    if CMD = 'Reply' then
    begin
      // writeln('Reply with msg number ' + params[0]);
      if (Pos('+', params[0]) <> 0) then
      begin
        resolvedstring := ResolveVariablesInString(params[0]);
        AddNode(procname, resolvedstring);

      end
      else
      begin
      if pos('(',params[0])<>0 then
        resolvedstring := GetMessageStringByIndex(strtoint(ExtractFunctionParameter(params[0]))) else

        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));
        // writeln(resolvedstring);
        AddNode(procname, resolvedstring);
      end;

    end

    else if CMD = 'NOption' then
    begin
      // writeln('Neutral option with msg number ' + params[0]);
 //     writeln(GetMessageStringByIndex(strtoint(params[0])));

      if (Pos('+', params[0]) <> 0) then
      begin
        // writeln('Split params!');
        resolvedstring := ResolveVariablesInString(params[0]);
        // writeln('Got ', Length(splittedparams), ' parameters.');

      end

      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', REACTION_NEUTRAL);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end else if CMD = 'NLowOption' then
    begin
      // writeln('Neutral option with msg number ' + params[0]);
    //  writeln(GetMessageStringByIndex(strtoint(params[0])));

      if (Pos('+', params[0]) <> 0) then
      begin
        // writeln('Split params!');
        resolvedstring := ResolveVariablesInString(params[0]);
        // writeln('Got ', Length(splittedparams), ' parameters.');

      end

      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', REACTION_NEUTRAL, -3);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end

    else if CMD = 'GLowOption' then
    begin
     // writeln('Good Low option with msg number ' + params[0]);
      //writeln(GetMessageStringByIndex(strtoint(params[0])));

      if (Pos('+', params[0]) <> 0) then
      begin
      //   writeln('Split params!');
        resolvedstring := ResolveVariablesInString(params[0]);
      //   writeln('resolved string: '+resolvedstring);

      end

      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', REACTION_GOOD, -3);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end

    else if CMD = 'BLowOption' then
    begin
      // writeln('Neutral option with msg number ' + params[0]);
    //  writeln(GetMessageStringByIndex(strtoint(params[0])));

      if (Pos('+', params[0]) <> 0) then
      begin
        // writeln('Split params!');
        resolvedstring := ResolveVariablesInString(params[0]);
        // writeln('Got ', Length(splittedparams), ' parameters.');

      end

      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', REACTION_BAD, -3);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end

    else if CMD = 'BOption' then
    begin
      // writeln('Bad option with msg number ' + params[0]);
      // writeln(GetMessageStringByIndex(strtoint(params[0])));

      if (Pos('+', params[0]) <> 0) then
      begin
        resolvedstring := ResolveVariablesInString(params[0]);
      end
      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', reaction_bad);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end
    else if CMD = 'GOption' then
    begin
      // writeln('Good option with msg number ' + params[0]);
      if (Pos('+', params[0]) <> 0) then
      begin

        resolvedstring := ResolveVariablesInString(params[0]);

      end
      else
        resolvedstring := GetMessageStringByIndex(strtoint(params[0]));

      // writeln(GetMessageStringByIndex(strtoint(params[0])));
      lastindex := AddPlayerOptionToNode(procname, resolvedstring, params[1],
        '', reaction_good);
      // writeln('Last index: ', lastindex);
      if ScriptProcedures[procindex].Commands
        [ScriptProcedures[procindex].Commandcnt].ThenCondition <> '' then
      begin
        AddConditionsToPlayerOption(lastindex - 1, procname,
          ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
          .Commandcnt].ThenCondition);
      end;
    end

    else if CMD = 'floater' then
    begin
      splittedparams := ExtractFunctionAndParametersManual
        ((string.join(', ', params)));
        writeln('FLOATER!');
        writeln('cmd: ',cmd);
        writeln('params ',string.join(', ',params));
       if length(params)=1 then
      begin
        AddMessageToFloatNode(GetMessageStringByIndex(strtoint(params[0])), procname);

      end else
      begin
      startrange := strtoint(splittedparams[0]);
      endrange := strtoint(splittedparams[1]);
      // writeln('Start message num: ', startrange);
      // writeln('End message num: ', endrange);
      for x := startrange to endrange do
      begin
        // writeln('Message :', x, ' = ', GetMessageStringByIndex(x));
        AddMessageToFloatNode(GetMessageStringByIndex(x), procname);
      end;
      end;
    end
    else
    begin

      if (CMD <> 'BOption') and (CMD <> 'NOption') and (CMD <> 'GOption') and
       (CMD <> 'BLowOption') and (CMD <> 'NLowOption') and (CMD <> 'GLowOption') and (CMD <> 'Reply') then
      begin
      //  writeln('Non dialogue command: ', CMD);
        if CMD = 'call' then
          AddCustomCodeToNode(procname, CMD + ' ' + string.join(',', params),
            ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
            .Commandcnt].ThenCondition, ScriptProcedures[procindex].Commands
            [ScriptProcedures[procindex].Commandcnt].HasElseBlock)
        else
        begin
        if (cmd='begin') or (cmd='end')  then
        begin
        writeln('Begin or end block');
        if condition <> '' then
        AddCustomCodeToNode(procname, CMD, condition,
           false) else

        AddCustomCodeToNode(procname, CMD, '',
           false);

        end else
          AddCustomCodeToNode(procname, CMD + '(' + string.join(',', params) +
            ');', ScriptProcedures[procindex].Commands
            [ScriptProcedures[procindex].Commandcnt].ThenCondition,
            ScriptProcedures[procindex].Commands[ScriptProcedures[procindex]
            .Commandcnt].HasElseBlock);
        end;
      end;
    end;
  inc(ScriptProcedures[procindex].Commandcnt);
  end;
end;

function MatchesPattern(const ProcName, Mask: string): Boolean;
var
  RegexPattern: string;
begin
  // Convert mask to regex pattern
  RegexPattern := '^' + Mask.Replace('#', '\d') + '$';

  // Check if the procedure name matches the regex pattern
  Result := TRegEx.IsMatch(ProcName, RegexPattern);
end;



procedure Data_AddProcedureHeader(procname: string);
var
  ind: integer;
begin
  ind := GetProcIndex(procname);
  if (ind = -1) and (procname <> '') then
  begin
    writeln('Added procedure ', procname);
    setlength(ScriptProcedures, procedurecnt + 1);
    // writeln('Adding procedure ', procname);
    ScriptProcedures[procedurecnt].ScriptProcName := procname;
    if (MatchesPattern(procname, 'Node###')) and (is_dialogue_node(procname)=true) then
    begin
     // writeln('Creating empty node: '+procname);
      AddNode(procname, '');
    end;
    inc(procedurecnt);
  end;

end;

procedure Data_AddProcedure(procname: string; Body: TStringlist);

begin

end;

end.
