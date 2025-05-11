(*

---------------------------------------------------------------
FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen
---------------------------------------------------------------
Description:

  This unit contains various variable and type definitions
  related to the dialogue data structures.
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

unit SharedDLGData;

interface

uses
{$IFNDEF FMFCBuild}
  debugwnd,
  Dialogs, {$ENDIF}
  SysUtils,
  Inifiles;

const

  MAX_OPTIONS = 512;
  MAX_NODES   = 512;

  MAX_CONDITIONS        = 64;
  MAX_FLOAT_NODES       = 512;
  MAX_ACTIONS           = 64;
  MAX_TIMED_EVENTS      = 128;
  FIELD_NPC_NAME        = 0;
  FIELD_NPC_LOCATION    = 1;
  FIELD_NPC_DESCRIPTION = 2;
  FIELD_NPC_UNKNOWN_LOOK = 3;
  FIELD_NPC_KNOWN_LOOK  = 4;
  FIELD_NPC_DETAILED_LOOK = 5;
  FIELD_NODE_NPCTEXT    = 6;
  FIELD_NODE_NPCFEMALETEXT = 7;
  FIELD_NODE_NOTES      = 8;
  FIELD_NODE_OPTIONCOUNT = 9;
  FIELD_NODE_NAME       = 16;
  FIELD_PLAYEROPTION_OPTIONTEXT = 10;
  FIELD_PLAYEROPTION_REACTION = 11;
  FIELD_PLAYEROPTION_GENDERFLAGS = 12;
  FIELD_PLAYEROPTION_NODELINK = 13;
  FIELD_PLAYEROPTION_INTCHECK = 14;
  FIELD_PLAYEROPTION_NOTES = 15;


const
  REACTION_NEUTRAL = 0;
  REACTION_GOOD    = 1;
  REACTION_BAD     = 2;


  GENDER_NONE   = 0;
  GENDER_MALE   = 1;
  GENDER_FEMALE = 2;

type
  _skill = record
    Name:  string;
    Value: integer;
  end;

type
  PlayerChar = record
    Name:         string;
    gender:       integer;
    age:          integer; // not really useful but just for completeness sake
    strength:     integer;
    perception:   integer;
    endurance:    integer;
    charisma:     integer;
    intelligence: integer;
    agility:      integer;
    luck:         integer;
    dude_caps:    integer;
    skills:       array [0..17] of _skill;

  end;

const
  CHECK_TYPE_STAT           = 1;
  CHECK_TYPE_SKILL          = 2;
  CHECK_TYPE_CHECKMONEY     = 3;
  CHECK_TYPE_GLOBAL_VARIABLE = 4;
  CHECK_TYPE_LOCAL_VARIABLE = 5;
  CHECK_TYPE_SCRIPT_VARIABLE = 6;
  CHECK_TYPE_ITEM_PLAYER    = 7;

  CHECK_FIELD_DUDE_CAPS = 1;
  CHECK_FIELD_SELF_CAPS = 2;

  CHECK_FIELD_STAT_ST           = 1;
  CHECK_FIELD_STAT_PE           = 2;
  CHECK_FIELD_STAT_EN           = 3;
  CHECK_FIELD_STAT_CH           = 4;
  CHECK_FIELD_STAT_IN           = 5;
  CHECK_FIELD_STAT_AG           = 6;
  CHECK_FIELD_STAT_LK           = 7;
  CHECK_FIELD_STAT_ARMOR_CLASS  = 8;
  CHECK_FIELD_STAT_CARRY_AMOUNT = 9;
  CHECK_FIELD_STAT_HEALING_RATE = 10;
  CHECK_FIELD_STAT_MAXIMUM_HIT_POINTS = 11;
  CHECK_FIELD_STAT_CURRENT_HIT_POINTS = 12;
  CHECK_FIELD_STAT_CURRENT_RAD_LEVEL = 13;
  CHECK_FIELD_STAT_CURRENT_POISON_LEVEL = 14;

  CHECK_FIELD_SKILL_SMALLGUNS     = 1;
  CHECK_FIELD_SKILL_BIGGUNS       = 2;
  CHECK_FIELD_SKILL_ENERGYWEAPONS = 3;
  CHECK_FIELD_SKILL_UNARMED       = 4;
  CHECK_FIELD_SKILL_MELEE         = 5;
  CHECK_FIELD_SKILL_THROWING      = 6;
  CHECK_FIELD_SKILL_FIRSTAID      = 7;
  CHECK_FIELD_SKILL_DOCTOR        = 8;
  CHECK_FIELD_SKILL_SNEAK         = 9;
  CHECK_FIELD_SKILL_LOCKPICK      = 10;
  CHECK_FIELD_SKILL_STEAL         = 11;
  CHECK_FIELD_SKILL_TRAPS         = 12;
  CHECK_FIELD_SKILL_SCIENCE       = 13;
  CHECK_FIELD_SKILL_REPAIR        = 14;
  CHECK_FIELD_SKILL_SPEECH        = 15;
  CHECK_FIELD_SKILL_BARTER        = 16;
  CHECK_FIELD_SKILL_GAMBLING      = 17;
  CHECK_FIELD_SKILL_OUTDOORSMAN   = 18;

  COMPARE_EQUAL       = 1;                // ==
  COMPARE_NOT_EQUAL   = 2;                // !=
  COMPARE_LARGER_THAN = 3;                // >
  COMPARE_LESS_THAN   = 4;                // <
  COMPARE_LARGER_THAN_OR_EQUAL = 5;       // >=
  COMPARE_LESS_THAN_OR_EQUAL = 6;         // <=

const
  LINK_NONE = 0;

const
  LINK_AND = 1;

const
  LINK_OR = 2;


type
  condition = record
    check_type:    integer;
    check_field:   integer;
    check_eval:    integer;
    var_ptr:       string;
    check_value:   string;
    resolved_code: string;
    link:          integer;
  end;


const
  CHECK_FLAGS_SUCCESS = 1;


type
  option = record
    optiontext:         string;
    nodelink:           string;
    noderesolved:       integer;
    link_to_proc:       boolean;
    link_to_skillcheck: boolean;
    reaction:           integer;
    genderflags:        integer;
    intcheck:           integer;

    notes:        string;
    conditions:   array [0..MAX_CONDITIONS] of ^condition;
    conditioncnt: integer;
  end;

type
  skillcheck = record
    check_proc_name: string;
    check_what:      integer;
    modifier:        integer;
    successnode:     string;
    failurenode:     string;
  end;


type
  dlgnode = record
    // Determines if this node can be used as a
    // start node
    is_wtg:        boolean;
    // skill checks are located here so that when the DDF
    // is spit out, they will be found in the node that they are needed
    // in
    customcode:    string;
    skillchecks:   array [0..20] of ^skillcheck;
    skillcheckcnt: integer;

    nodename:       string;
    npctext:        string;
    npctext_female: string;
    notes:          string;
    hidden:         boolean;
    options:        array [0..MAX_OPTIONS] of ^option;
    optioncnt:      integer;
  end;

type
  floatnode = record
    nodename:   string;
    notes:      string;
    Messages:   array [0..256] of string;
    messagecnt: integer;
  end;

type
  action = record
    // This is regular SSL code, but
    // it is entered using pre-defined stuff
    // so it is easier to add more things here.
    linedata: string;
  end;

type
  time_event_data = record
    FixedParamName: string;
    FixedParamEnumIndex: integer;
    actionlines: array [0..MAX_ACTIONS] of ^action;
    actioncnt:   integer;
    israndom:    boolean;
    mininterval: integer;
    maxinterval: integer;
    interval:    integer;
  end;

const
  VAR_FLAGS_NONE   = 0;
  VAR_FLAGS_IMPORT = 1;
  VAR_FLAGS_EXPORT = 2;
  VAR_FLAGS_LOCAL  = 3;
  VAR_FLAGS_GLOBAL = 4;

type
  TVariable = record
    Name:    string;
    flags:   integer;
    vartype: integer;
    notes:   string;
    Value:   variant;
  end;

const

  LINKAGE_NONE = 0;
  LINKAGE_AND  = 1;
  LINKAGE_OR   = 2;


type
  cond_data = record
    resultcode: string;
    parameter: string;
    evaluator: integer;
    compareto: string;
    index_of_selection: integer;
    linkage: integer;
  end;


type
  starting_condition = record
    conditions: array [0..30] of ^cond_data;
    condcnt:    integer;
    goto_node:  string;

  end;

type
  custom_proc = record
    Name:  string;
    Lines: string;
    associatewithnode: integer;
  end;


type
  actor = record
    varName:     string;
    displayName: string;
  end;

type
  SequenceBlock = record
    speaker:        integer;
    delayToNext:    integer;
    floatmsg_color: integer;
    floatmessage:   string;
    //     action: boolean;
    //     action_type: integer;
    //     action_params:
  end;


// NOTE: These are not used yet

type
  scripted_dialogue = record
    SequenceID:   string;  // also the procedure name for the sequence
    ControlVar:   integer; // select from variable list in the editor
    IsUILocked:   boolean;
    Actors:       array [0..50] of ^actor;
    ActorCount:   integer;
    SequenceData: array [0..200] of ^SequenceBlock;
    SequenceDataCount: integer;
  end;


type
  dialog = record
    filename:         string;
    npcname:          string;
    description:      string;
    location:         string;
    unknowndesc, knowndesc, detaileddesc: string;
    // start time event is the first timed event to add
    // when the script starts
    start_time_event: integer;

    startconditions:   array [0..512] of ^starting_condition;
    startconditioncnt: integer;
    default_cond:      integer;
    customprocs:       array [0..400] of ^custom_proc;
    customproccnt:     integer;
    // TO BE IMPLEMENTED AT SOME POINT!

    // scripted_dialogues: array [0..100] of ^scripted_dialogue;
    timedevents:    array [0..MAX_TIMED_EVENTS] of ^time_event_data;
    timedeventcnt:  integer;
    floatnodes:     array [0..MAX_FLOAT_NODES] of ^floatnode;
    floatnodecount: integer;
    nodes:          array [0..MAX_NODES] of ^dlgnode;
    nodecount:      integer;
    variables:      array [0..1000] of ^TVariable;
    varcnt:         integer;
  end;



type
  dialog_oldformat = record
    filename:    string;
    npcname:     string;
    description: string;
    location:    string;
    unknowndesc, knowndesc, detaileddesc: string;
    nodes:       array [0..MAX_NODES] of ^dlgnode;
    nodecount:   integer;
  end;




type
  playerptr = ^playerchar;

type
  pdialogue = ^dialog_oldformat;

type
  pnewdialogue = ^dialog;

type
  pdlgnode = ^dlgnode;



const
  VAR_TYPE_STRING = 0;
  VAR_TYPE_INT    = 1;
  VAR_TYPE_FLOAT  = 2;




var
  currentdlg: dialog;

 {$IFDEF FMFCBuild}
    condcfg: TInifile;
 {$ENDIF}
  defdumbint:  integer;
  defsmartint: integer;
  player:      ^PlayerChar;

procedure SetStartCondition(index: integer; resultcode: string;
  condindex: integer; selector: string; eval: integer; valcheck: string;
  targetnode: string; set_as_default: boolean = False);

procedure DeleteStartCond(nodeindex: integer);
procedure AddStartCondition(targetnode: string; set_as_default: boolean = False);
procedure DeleteFloatNodeMessage(nodeindex: integer; optionindex: integer);
procedure DeleteTimedEvent(eventindex: integer);
function GetSkillCheckIndex(Name: string; var nodeind: integer): integer;
function GetVarDesc(Name: string): string;
procedure DeleteNode(nodeindex: integer);
function GetTimedEventIndex(Name: string): integer;
function ProcExists(Name: string): boolean;

procedure AddCondsToSC(resultcode: string; cond_ind: integer;
  condindex: integer; selector: string; eval: integer; valcheck: string; link: integer);
procedure DeleteCondFromSCStartCond(condind: integer; nodeindex: integer);
function GetNodeIndex(Name: string): integer;
function GetFloatNodeIndex(Name: string): integer;
procedure DeleteCustomProc(nodeindex: integer);
function GetVarIndexFromDLG(Name: string; dlg: dialog): integer;
procedure ResolveNodes;
procedure DeletePlayeroption(nodeindex: integer; optionindex: integer);
function GenerateCondString(cond: condition): string;
procedure RemapNodes(oldname, newname: string);

procedure SetCondToSC(cond_subid: integer; resultcode: string;
  cond_ind: integer; condindex: integer; selector: string; eval: integer;
  valcheck: string; link: integer);

function GetNodeIndexFromDLG(Name: string; dlg: dialog): integer;
procedure DeleteVar(varindex: integer);
procedure DeleteOptionCondition(nodeindex: integer; optionindex: integer;
  conditionindex: integer);
function ResolveToSSL(cond: condition): string;
procedure DeleteFloaterNode(nodeindex: integer);
procedure DeleteSkillCheck(Name: string);
function IsValidNodeName(nodename: string; var errormsg: string): boolean;


implementation

{$IFNDEF FMFCBuild}
{$MESSAGE 'Not FMFCBuild'}
uses
  condcheck,
  fmfmain;

{$ENDIF}

{$IFDEF FMFCBuild}
function GetEval(eval_type: integer): string;
begin
    ;
    case eval_type of
        COMPARE_EQUAL:
            Result := '==';
        COMPARE_NOT_EQUAL:
            Result := '!=';
        COMPARE_LARGER_THAN:
            Result := '>';
        COMPARE_LESS_THAN:
            Result := '<';
        COMPARE_LARGER_THAN_OR_EQUAL:
            Result := '>=';
        COMPARE_LESS_THAN_OR_EQUAL:
            Result := '<=';
        end;

end;

{$ENDIF}

procedure DeleteSkillCheck(Name: string);
var
  i, skillcheckind, nodeind: integer;
begin
  skillcheckind := GetSkillCheckIndex(Name, nodeind);
  if skillcheckind <> -1 then
  begin
    if skillcheckind = currentdlg.nodes[nodeind].skillcheckcnt - 1 then
    begin
      currentdlg.nodes[nodeind].skillcheckcnt :=
        currentdlg.nodes[nodeind].skillcheckcnt - 1;
      exit;
    end;
    for i := skillcheckind to currentdlg.nodes[nodeind].skillcheckcnt - 1 do
      currentdlg.nodes[nodeind].skillchecks[i] :=
        currentdlg.nodes[nodeind].skillchecks[i + 1];
    currentdlg.nodes[nodeind].skillcheckcnt :=
      currentdlg.nodes[nodeind].skillcheckcnt - 1;

  end;

end;

function IsValidNodeName(nodename: string; var errormsg: string): boolean;
var
  s: integer;
var
  charactersvalid: integer;
var
  t: char;
begin
  charactersvalid := 0;
  Result := False;
  if nodename = '' then

  begin
    Result := False;
    errormsg := 'Node name is empty!';
    exit;
  end;

  if length(nodename) > 1 then
  begin
    t := nodename[1];
    if (t in ['A'..'Z', 'a'..'z']) then
    begin
      s := 2;
      Inc(charactersvalid);
      while s < length(nodename) do
      begin
        t := nodename[s];
        if (t = ' ') then
        begin
          Result := False;
          errormsg := 'Node names cannot contain whitespace';
          exiT;

        end;

        if (t in ['A'..'Z', 'a'..'z', '_', '0'..'9']) then
        begin
          Inc(charactersvalid);
        end;

        Inc(s);

      end;
      if (charactersvalid = length(nodename) - 1) then
      begin
        Result := True;
      end
      else
      begin
        Result := False;
        errormsg :=
          'The node name contained disallowed characters. Valid chars: ' +
          IntToStr(charactersvalid + 1) + ', length: ' + IntToStr(length(nodename));
      end;

    end;

  end
  else
  begin
    t := nodename[1];
    if not (t in ['A'..'Z', 'a'..'z']) then
    begin
      errormsg := 'Node name must begin with a character';
      Result := False;
    end else
    result:=true;

  end;

end;



function GetVarDesc(Name: string): string;
var
  I: integer;
begin
  Result := 'No description available for this item.';
  for I := 0 to currentdlg.varcnt - 1 do
  begin
    if (Name = currentdlg.variables[i].Name) then
    begin
      Result := currentdlg.variables[i].notes;
      exit;
    end;

  end;
end;



function GetVarIndexFromDLG(Name: string; dlg: dialog): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to dlg.varcnt - 1 do
  begin
    if (Name = dlg.variables[i].Name) then
    begin
      Result := i;
      exit;
    end;

  end;
end;

function GetNodeIndexFromDLG(Name: string; dlg: dialog): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to dlg.nodecount - 1 do
  begin
    if (Name = dlg.nodes[i].nodename) then
    begin
      Result := i;
      exit;
    end;

  end;
end;



function GetSkillCheckIndex(Name: string; var nodeind: integer): integer;
var
  I, j: integer;
begin
  Result := -1;
  for I := 0 to currentdlg.nodecount - 1 do
  begin
    for j := 0 to currentdlg.nodes[i].skillcheckcnt - 1 do
    begin
      if (Name = currentdlg.nodes[i].skillchecks[j].check_proc_name) then
      begin
        nodeind := i;
        Result  := j;
        exit;
      end;
    end;

  end;
end;

function GetTimedEventIndex(Name: string): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to currentdlg.timedeventcnt - 1 do
  begin
    ;
    if (Name = currentdlg.timedevents[i].FixedParamName) then
    begin
      Result := i;
      exit;
    end;
  end;
end;


procedure DeleteCustomProc(nodeindex: integer);
var
  i: integer;
begin

  if nodeindex = currentdlg.customproccnt - 1 then
  begin
    currentdlg.customproccnt := currentdlg.customproccnt - 1;
    exit;
  end;
  for i := nodeindex to currentdlg.customproccnt - 1 do
    currentdlg.customprocs[i] := currentdlg.customprocs[i + 1];
  currentdlg.customproccnt := currentdlg.customproccnt - 1;
end;

procedure DeleteCondFromSCStartCond(condind: integer; nodeindex: integer);
var
  i: integer;
begin

  if nodeindex = currentdlg.startconditions[condind].condcnt - 1 then
  begin
    currentdlg.startconditions[condind].condcnt :=
      currentdlg.startconditions[condind].condcnt - 1;
    exit;
  end;
  for i := nodeindex to currentdlg.startconditions[condind].condcnt - 1 do
    currentdlg.startconditions[condind].conditions[i] :=
      currentdlg.startconditions[condind].conditions[i + 1];
  currentdlg.startconditions[condind].condcnt :=
    currentdlg.startconditions[condind].condcnt - 1;
end;



procedure DeleteStartCond(nodeindex: integer);
var
  i: integer;
begin
  if nodeindex = currentdlg.default_cond then
  begin
    currentdlg.default_cond := -1;
  end;

  if nodeindex = currentdlg.startconditioncnt - 1 then
  begin
    currentdlg.startconditioncnt := currentdlg.startconditioncnt - 1;
    exit;
  end;
  for i := nodeindex to currentdlg.startconditioncnt - 1 do
    currentdlg.startconditions[i] := currentdlg.startconditions[i + 1];
  currentdlg.startconditioncnt := currentdlg.startconditioncnt - 1;
end;


procedure SetStartCondition(index: integer; resultcode: string;
  condindex: integer; selector: string; eval: integer; valcheck: string;
  targetnode: string; set_as_default: boolean = False);
begin

  //  new(currentdlg.startconditions[currentdlg.startconditioncnt]);
  // condition code !! not the full statement
  // script exporter code generator will do that stuff
  currentdlg.startconditions[index].conditions[condindex].resultcode := resultcode;
  currentdlg.startconditions[index].conditions[condindex].parameter := selector;
  currentdlg.startconditions[index].conditions[condindex].compareto := Valcheck;
  currentdlg.startconditions[index].goto_node := targetnode;
  currentdlg.startconditions[index].conditions[condindex].index_of_selection :=
    condindex;
  if (set_as_default) then
    currentdlg.default_cond := currentdlg.startconditioncnt;
  //  Inc(currentdlg.startconditioncnt);
end;


procedure AddStartCondition(targetnode: string; set_as_default: boolean = False);
begin
  ;
  new(currentdlg.startconditions[currentdlg.startconditioncnt]);
  currentdlg.startconditions[currentdlg.startconditioncnt].goto_node := targetnode;
  currentdlg.startconditions[currentdlg.startconditioncnt].condcnt := 0;
  // condindex;
  if (set_as_default) then
    currentdlg.default_cond := currentdlg.startconditioncnt;
  Inc(currentdlg.startconditioncnt);
end;

procedure AddCondsToSC(resultcode: string; cond_ind: integer;
  condindex: integer; selector: string; eval: integer; valcheck: string; link: integer);
begin
  new(currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt]);
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].resultcode :=
    resultcode;
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].parameter := selector;
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].evaluator := eval;
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].compareto := valcheck;
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].linkage := link;
  currentdlg.startconditions[cond_ind].conditions[
    currentdlg.startconditions[cond_ind].condcnt].index_of_selection :=
    condindex;
  Inc(currentdlg.startconditions[cond_ind].condcnt);
end;

procedure SetCondToSC(cond_subid: integer; resultcode: string;
  cond_ind: integer; condindex: integer; selector: string; eval: integer;
  valcheck: string; link: integer);
begin
  //  new(currentdlg.startconditions[cond_ind].conditions[currentdlg.startconditions[cond_ind].condcnt]);
  currentdlg.startconditions[cond_ind].conditions[cond_subid].resultcode :=
    resultcode;
  currentdlg.startconditions[cond_ind].conditions[cond_subid].parameter := selector;
  currentdlg.startconditions[cond_ind].conditions[cond_subid].evaluator := eval;
  currentdlg.startconditions[cond_ind].conditions[cond_subid].compareto := valcheck;
  currentdlg.startconditions[cond_ind].conditions[cond_subid].linkage := link;
  currentdlg.startconditions[cond_ind].conditions[cond_subid].index_of_selection :=
    condindex;
end;

function GetFloatNodeIndex(Name: string): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to currentdlg.floatnodecount - 1 do
  begin
    ;
    if (Name = currentdlg.floatnodes[i].nodename) then
    begin
      ;
      Result := i;
      exit;
    end;
  end;
end;

function ProcExists(Name: string): boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to currentdlg.customproccnt - 1 do
  begin
    if (Name = currentdlg.customprocs[i].Name) then
    begin
      ;
      Result := True;
      exit;
    end;
  end;
end;


function GetNodeIndex(Name: string): integer;
var
  chek: string;
  I: integer;
begin
  Result := -1;
  for I := 0 to currentdlg.nodecount - 1 do
  begin
    chek := currentdlg.nodes[i].nodename;
    if (lowercase(Name) = lowercase(chek)) then
    begin
      Result := i;
      exit;
    end;
  end;
end;

procedure ResolveNodes;
var
  i, l: integer;
var
  resolved, unresolved: integer;
begin
  // resolved   := 0;
  // unresolved := 0;

  for I := 0 to currentdlg.nodecount - 1 do
  begin
    for l := 0 to currentdlg.nodes[i].optioncnt - 1 do
    begin
      currentdlg.nodes[i].options[l].noderesolved :=
        GetNodeIndex(currentdlg.nodes[i].options[l].nodelink);
      if currentdlg.nodes[i].options[l].noderesolved = -1 then
      begin
        if (currentdlg.nodes[i].options[l].nodelink <> 'done') and
          (currentdlg.nodes[i].options[l].nodelink <> 'combat') then
        begin
          //  debugmsg('Warning: [' + currentdlg.nodes[i].nodename + ', option ' + IntToStr(l) +
          //    '] Unable to resolve nodelink: ' + currentdlg.nodes[i].options[l].nodelink);
          Inc(unresolved);
        end;

      end
      else
      begin
        Inc(resolved);
      end;
    end;
  end;
  //  debugmsg('Resolved nodes: ' + IntToStr(resolved) + ', unresolved nodes: ' + IntToStr(unresolved));
end;


function skillfieldtostr(fld: integer): string;
begin
  case fld of
    CHECK_FIELD_SKILL_SMALLGUNS:
      Result := 'small_guns';
    CHECK_FIELD_SKILL_BIGGUNS:
      Result := 'big_guns';
    CHECK_FIELD_SKILL_ENERGYWEAPONS:
      Result := 'energy_weapons';
    CHECK_FIELD_SKILL_UNARMED:
      Result := 'unarmed_combat';
    CHECK_FIELD_SKILL_MELEE:
      Result := 'skill_melee';
    CHECK_FIELD_SKILL_THROWING:
      Result := 'throwing';
    CHECK_FIELD_SKILL_FIRSTAID:
      Result := 'first_aid';
    CHECK_FIELD_SKILL_DOCTOR:
      Result := 'doctor';
    CHECK_FIELD_SKILL_SNEAK:
      Result := 'sneak';
    CHECK_FIELD_SKILL_LOCKPICK:
      Result := 'lockpick';
    CHECK_FIELD_SKILL_STEAL:
      Result := 'steal';
    CHECK_FIELD_SKILL_TRAPS:
      Result := 'traps';
    CHECK_FIELD_SKILL_SCIENCE:
      Result := 'science';
    CHECK_FIELD_SKILL_REPAIR:
      Result := 'repair';
    CHECK_FIELD_SKILL_SPEECH:
      Result := 'speech';
    CHECK_FIELD_SKILL_BARTER:
      Result := 'barter';
    CHECK_FIELD_SKILL_GAMBLING:
      Result := 'gambling';
    CHECK_FIELD_SKILL_OUTDOORSMAN:
      Result := 'outdoorsman';
  end;

end;

function moneyfieldtostr(fld: integer): string;
begin
  case fld of
    CHECK_FIELD_DUDE_CAPS:
      Result := 'dude_caps';
  end;

end;

function statfieldtostr(fld: integer): string;
begin
  case fld of
    CHECK_FIELD_STAT_ST:
      Result := 'strength';
    CHECK_FIELD_STAT_PE:
      Result := 'perception';
    CHECK_FIELD_STAT_EN:
      Result := 'endurance';
    CHECK_FIELD_STAT_CH:
      Result := 'charisma';
    CHECK_FIELD_STAT_IN:
      Result := 'intelligence';
    CHECK_FIELD_STAT_AG:
      Result := 'agility';
    CHECK_FIELD_STAT_LK:
      Result := 'luck';
    CHECK_FIELD_STAT_ARMOR_CLASS:
      Result := 'armor_class';
    CHECK_FIELD_STAT_CARRY_AMOUNT:
      Result := 'carry_amount';
    CHECK_FIELD_STAT_HEALING_RATE:
      Result := 'healing_rate';
    CHECK_FIELD_STAT_MAXIMUM_HIT_POINTS:
      Result := 'max_hp';
    CHECK_FIELD_STAT_CURRENT_HIT_POINTS:
      Result := 'cur_hp';
    CHECK_FIELD_STAT_CURRENT_RAD_LEVEL:
      Result := 'cur_rad_lev';
    CHECK_FIELD_STAT_CURRENT_POISON_LEVEL:
      Result := 'cur_poison_lev';
  end;

end;

function checktypetostr(chk: integer): string;
var
  checktype: string;
var
  Data: string;
begin
  checktype := condcfg.ReadString('Main', 'CheckType' + IntToStr(chk), '');
  Data := condcfg.readstring(checktype, 'fmf_output', '');

  Result := Data;
end;

function GenerateCondString(cond: condition): string;
begin
  Result := '';
  case cond.check_type of
    CHECK_TYPE_SCRIPT_VARIABLE:
      Result := checktypetostr(cond.check_type) + ' ' + cond.var_ptr +
        ' ' + GetEval(cond.check_eval) + ' ' + cond.check_value;
    CHECK_TYPE_LOCAL_VARIABLE:
      Result := checktypetostr(cond.check_type) + ' ' + cond.var_ptr +
        ' ' + GetEval(cond.check_eval) + ' ' + cond.check_value;
    CHECK_TYPE_GLOBAL_VARIABLE:
      Result := checktypetostr(cond.check_type) + ' ' + cond.var_ptr +
        ' ' + GetEval(cond.check_eval) + ' ' + cond.check_value;

    CHECK_TYPE_ITEM_PLAYER:
      Result := checktypetostr(cond.check_type) + ' ' + cond.var_ptr +
        ' ' + GetEval(cond.check_eval) + ' ' + cond.check_value;

    CHECK_TYPE_STAT:
      Result := checktypetostr(cond.check_type) + ' ' +
        statfieldtostr(cond.check_field) + ' ' + GetEval(cond.check_eval) +
        ' ' + cond.check_value;
    CHECK_TYPE_SKILL:
      Result := checktypetostr(cond.check_type) + ' ' +
        skillfieldtostr(cond.check_field) + ' ' + GetEval(cond.check_eval) +
        ' ' + cond.check_value;
    CHECK_TYPE_CHECKMONEY:
      Result := checktypetostr(cond.check_type) + ' ' +
        moneyfieldtostr(cond.check_field) + ' ' + GetEval(cond.check_eval) +
        ' ' + cond.check_value;

  end;
  Result := Result + ' link_next ';
  case cond.link of
    LINKAGE_NONE:
      Result := Result + 'NONE';
    LINKAGE_AND:
      Result := Result + 'AND';
    LINKAGE_OR:
      Result := Result + 'OR';
    else
    begin
{$IFNDEF FMFCBuild}
      MessageDlg(format('Warning! Unknown link type %d, resetting to NONE',
        [cond.link]), mtWarning, [mbOK], 0);
      debugmsg('Warning: Unknown link_type ' + IntToStr(cond.link) +
        ', resetting to NONE.');
{$ENDIF}
      Result := Result + 'NONE';
    end;

  end;

end;

function ResolveToSSL(cond: condition): string;
var
  code: string;
  checktype, cmd: string;
  sslenum: string;
begin
  checktype := condcfg.readstring('Main', 'CheckType' + IntToStr(cond.check_type), '');
  cmd := condcfg.ReadString(checktype, 'SSLCommand', '');
  try
    if cond.var_ptr <> '' then
      sslenum := cond.var_ptr
    else
      sslenum := condcfg.ReadString(checktype, 'Item' +
        IntToStr(cond.check_field) + 'SSLEnum', '');
    cmd := stringreplace(cmd, '%eval%', GetEval(cond.check_eval), []);
    cmd := stringreplace(cmd, '%value%', cond.check_value, []);
    Result := Format(cmd, [sslenum]);
  except
    on e: Exception do
    begin
      //  MessageDlg('ERROR ERROR ERROR ' + #13 + #10 + 'SHIT SHIT SHIT CRAP' + #13 + #10 +
      //    'Why does this happen?', mtError, [mbOK], 0);
    end;
  end;
end;


procedure RemapNodes(oldname, newname: string);
var
  x, j: integer;
begin
  for x := 0 to currentdlg.nodecount - 1 do
  begin
    currentdlg.nodes[x].notes :=
      StringReplace(currentdlg.nodes[x].notes, oldname, newname, [rfReplaceAll]);
    for j := 0 to currentdlg.nodes[x].optioncnt - 1 do
    begin
      if (currentdlg.nodes[x].options[j].nodelink = oldname) then
      begin
        currentdlg.nodes[x].options[j].notes :=
          StringReplace(currentdlg.nodes[x].options[j].notes,
          oldname, newname, [rfReplaceAll]);

        //        wndoutput('Node:' + currentdlg.nodes[x].nodename + ':PlayerOpt:' + IntToStr(j) +
        //          ':' + currentdlg.nodes[x].options[j].optiontext);
        //        wndoutput(oldname + ' => ' + newname);
        currentdlg.nodes[x].options[j].nodelink := newname;
      end;
    end;
  end;
end;

procedure DeleteFloaterNode(nodeindex: integer);
var
  i: integer;
begin
  if nodeindex = currentdlg.floatnodecount - 1 then
  begin
    currentdlg.floatnodecount := currentdlg.floatnodecount - 1;
    exit;
  end;
  for i := nodeindex to currentdlg.floatnodecount - 1 do
    currentdlg.floatnodes[i] := currentdlg.floatnodes[i + 1];
  currentdlg.floatnodecount := currentdlg.floatnodecount - 1;
end;



procedure DeleteVar(varindex: integer);
var
  i: integer;
begin
  if varindex = currentdlg.varcnt - 1 then
  begin
    currentdlg.varcnt := currentdlg.varcnt - 1;
    exit;
  end;
  for i := varindex to currentdlg.varcnt - 1 do
    currentdlg.variables[i] := currentdlg.variables[i + 1];
  currentdlg.varcnt := currentdlg.varcnt - 1;
end;


procedure DeleteTimedEvent(eventindex: integer);
var
  i: integer;
begin
  if eventindex = currentdlg.timedeventcnt - 1 then
  begin
    currentdlg.timedeventcnt := currentdlg.timedeventcnt - 1;
    exit;
  end;
  for i := eventindex to currentdlg.timedeventcnt - 1 do
    currentdlg.timedevents[i] := currentdlg.timedevents[i + 1];
  currentdlg.timedeventcnt := currentdlg.timedeventcnt - 1;
end;


procedure DeleteNode(nodeindex: integer);
var
  i: integer;
begin
  if nodeindex = currentdlg.nodecount - 1 then
  begin
    currentdlg.nodecount := currentdlg.nodecount - 1;
    exit;
  end;
  for i := nodeindex to currentdlg.nodecount - 1 do
    currentdlg.nodes[i] := currentdlg.nodes[i + 1];
  currentdlg.nodecount := currentdlg.nodecount - 1;
end;

procedure DeleteOptionCondition(nodeindex: integer; optionindex: integer;
  conditionindex: integer);
var
  i: integer;
begin
  if conditionindex = currentdlg.nodes[nodeindex].options[optionindex].conditioncnt
    - 1 then
  begin
    currentdlg.nodes[nodeindex].options[optionindex].conditioncnt :=
      currentdlg.nodes[nodeindex].options[optionindex].conditioncnt - 1;
    exit;
  end;
  for i := conditionindex to currentdlg.nodes[nodeindex].options[
      optionindex].conditioncnt - 1 do
    currentdlg.nodes[nodeindex].options[optionindex].conditions[i] :=
      currentdlg.nodes[nodeindex].options[optionindex].conditions[i + 1];
  currentdlg.nodes[nodeindex].options[optionindex].conditioncnt :=
    currentdlg.nodes[nodeindex].options[optionindex].conditioncnt - 1;

end;


procedure DeleteFloatNodeMessage(nodeindex: integer; optionindex: integer);
var
  i: integer;
begin
  if optionindex = currentdlg.floatnodes[nodeindex].messagecnt - 1 then
  begin
    currentdlg.floatnodes[nodeindex].messagecnt :=
      currentdlg.floatnodes[nodeindex].messagecnt - 1;
    exit;
  end;
  for i := optionindex to currentdlg.floatnodes[nodeindex].messagecnt - 1 do
    currentdlg.floatnodes[nodeindex].Messages[i] :=
      currentdlg.floatnodes[nodeindex].Messages[i + 1];
  currentdlg.floatnodes[nodeindex].messagecnt :=
    currentdlg.floatnodes[nodeindex].messagecnt - 1;
end;


procedure DeletePlayeroption(nodeindex: integer; optionindex: integer);
var
  i: integer;
begin
  if optionindex = currentdlg.nodes[nodeindex].optioncnt - 1 then
  begin
    currentdlg.nodes[nodeindex].optioncnt :=
      currentdlg.nodes[nodeindex].optioncnt - 1;
    exit;
  end;
  for i := optionindex to currentdlg.nodes[nodeindex].optioncnt - 1 do
    currentdlg.nodes[nodeindex].options[i] :=
      currentdlg.nodes[nodeindex].options[i + 1];
  currentdlg.nodes[nodeindex].optioncnt := currentdlg.nodes[nodeindex].optioncnt - 1;

end;

end.

