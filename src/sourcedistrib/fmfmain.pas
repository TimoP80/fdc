(*

FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen

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

unit fmfmain;

interface

uses SysUtils, Classes, gvarparse, fmf, cocobasenew, codesnippets,
  ComCtrls, condcheck, Controls, debugwnd, Dialogs, dws2classes,
  dws2classeslibmodule, dws2comp, dws2compiler, dws2exprs, dws2stringresult,
  dws2vclguifunctions, ExtCtrls, fmxutils, Forms, Graphics, helpscreen,
  ImgList, inifiles, JclFileUtils, JclStrings, jvcomponent, jvfindreplace,
  jvrichedit, Menus, Messages, parseinclude, pluginapi,
  shareddlgdata, StdCtrls, syncompletionproposal, synedittypes, variants, Windows, Grids;

type
  tform1 = class(TForm)
    mainmenu1:    tmainmenu;
    label1:       TLabel;
    memo1:        TMemo;
    label2:       TLabel;
    file1:        TMenuItem;
    help1:        TMenuItem;
    about1:       TMenuItem;
    loaddialogue1: TMenuItem;
    savedialogue1: TMenuItem;
    n1:           TMenuItem;
    quit1:        TMenuItem;
    label3:       TLabel;
    memo2:        TMemo;
    statusbar1:   tstatusbar;
    savedialog1:  tsavedialog;
    opendialog1:  topendialog;
    global1:      TMenuItem;
    npcproperties1: TMenuItem;
    label4:       TLabel;
    exporthtml1:  TMenuItem;
    n2:           TMenuItem;
    new1:         TMenuItem;
    dialoguetoolhelp1: TMenuItem;
    plugins1:     TMenuItem;
    import1:      TMenuItem;
    n3:           TMenuItem;
    savedialogue2: TMenuItem;
    delphiwebscriptii1: tdelphiwebscriptii;
    func_unit:    tdws2unit;
    label5:       TLabel;
    listbox1:     TListView;
    dev1:         TMenuItem;
    dumpscriptcommands1: TMenuItem;
    n4:           TMenuItem;
    preferences1: TMenuItem;
    label6:       TLabel;
    memo3:        TMemo;
    dws2stringresulttype1: tdws2stringresulttype;
    dws2guifunctions1: tdws2guifunctions;
    editfunctiondescriptions1: TMenuItem;
    dialog1:      TMenuItem;
    showtranscriptlist1: TMenuItem;
    saveall1:     TMenuItem;
    dws2classeslib1: tdws2classeslib;
    helperscripts1: TMenuItem;
    playercharactersetup1: TMenuItem;
    hiddenopts:   TLabel;
    syncompletionproposal1: tsyncompletionproposal;
    syncompletionproposal2: tsyncompletionproposal;
    nodelabel:    tedit;
    n5:           TMenuItem;
    opendialogueeditor1: TMenuItem;
    customprocedures1: TMenuItem;
    timer1:       ttimer;
    button1:      TButton;
    button2:      TButton;
    button3:      TButton;
    button4:      TButton;
    button5:      TButton;
    button6:      TButton;
    combobox1:    TComboBox;
    replacedialog1: treplacedialog;
    procedure executescriptconsole(line: string);
    procedure quit1click(Sender: TObject);
    procedure button3click(Sender: TObject);
    procedure formcreate(Sender: TObject);
    procedure savedialogue1click(Sender: TObject);
    procedure loaddialogue1click(Sender: TObject);
    procedure button1click(Sender: TObject);
    procedure listbox1dblclick(Sender: TObject);
    procedure button2click(Sender: TObject);
    procedure listbox1click(Sender: TObject);
    procedure loadscript(filename: string);
    procedure new1click(Sender: TObject);
    procedure npcproperties1click(Sender: TObject);
    procedure pluginexec(Sender: TObject);
    procedure scriptclick(Sender: TObject);
    procedure te_scriptclick(Sender: TObject);
    procedure dialoguetoolhelp1click(Sender: TObject);
    procedure about1click(Sender: TObject);
    procedure mxwebupdate1updateavailable(Sender: TObject;
      actualversion, newversion: string; var canupdate: boolean);
    procedure mxwebupdate1noupdatefound(Sender: TObject);
    procedure mxwebupdate1beforedownload(Sender: TObject; filename: string);
    procedure mxwebupdate1download(Sender: TObject; total, downloaded: integer);
    procedure mxwebupdate1afterdownload(Sender: TObject; filename: string);
    procedure mxwebupdate1beforeshowinfo(Sender: TObject;
      var showinfo, checkforupdate: boolean);
    procedure mxwebupdate1getclientfilename(Sender: TObject; var filename: string);
    procedure mxwebupdate1clientfileexists(Sender: TObject;
      var filename: string; var overwrite: boolean);
    procedure button4click(Sender: TObject);
    procedure button5click(Sender: TObject);
    procedure savedialogue2click(Sender: TObject);
    procedure formclosequery(Sender: TObject; var canclose: boolean);
    procedure func_unitfunctionsaddnodeeval(info: tprograminfo);
    procedure func_unitfunctionsaddplayeroptioneval(info: tprograminfo);
    procedure button6click(Sender: TObject);
    procedure mxwebupdate1downloaderror(Sender: TObject);
    procedure fmf1error(Sender: TObject; error: tcocoerror);
    procedure mxwebupdate1aftershowinfo(Sender: TObject; checkforupdate: boolean);
    procedure func_unitfunctionssetnodenameeval(info: tprograminfo);
    procedure func_unitfunctionsrefreshalleval(info: tprograminfo);
    procedure func_unitfunctionssetplayeroptionlinkeval(info: tprograminfo);
    procedure func_unitfunctionsmovenodelinktonoteseval(info: tprograminfo);
    procedure dumpscriptcommands1click(Sender: TObject);
    procedure func_unitfunctionsgetcurrentnodeeval(info: tprograminfo);
    procedure func_unitfunctionssetcurrentnodeeval(info: tprograminfo);
    procedure preferences1click(Sender: TObject);
    procedure func_unitfunctionsgetsslpatheval(info: tprograminfo);
    procedure func_unitfunctionsgetmsgpatheval(info: tprograminfo);
    procedure func_unitfunctionsdebugmsgeval(info: tprograminfo);
    procedure func_unitfunctionseditnodeeval(info: tprograminfo);
    procedure editfunctiondescriptions1click(Sender: TObject);
    procedure func_unitfunctionssaveconfirmeval(info: tprograminfo);
    function xahelprouter1help(command: word; Data: integer;
      var callhelp: boolean): boolean;
    procedure func_unitfunctionshelpeval(info: tprograminfo);
    procedure func_unitfunctionsprinteval(info: tprograminfo);
    procedure func_unitfunctionsgethelpeval(info: tprograminfo);
    procedure func_unitfunctionslistnodeseval(info: tprograminfo);
    procedure func_unitfunctionsshownodeeval(info: tprograminfo);
    procedure func_unitfunctionsshowconstantseval(info: tprograminfo);
    procedure func_unitfunctionsshowdialogglobalseval(info: tprograminfo);
    procedure func_unitfunctionsstartplugineval(info: tprograminfo);
    procedure func_unitfunctionslistpluginseval(info: tprograminfo);
    procedure func_unitfunctionsgetprogramversioneval(info: tprograminfo);
    procedure func_unitfunctionssetdialogglobalseval(info: tprograminfo);
    procedure func_unitfunctionssavedialogueeval(info: tprograminfo);
    procedure func_unitfunctionsloaddialogueeval(info: tprograminfo);
    procedure func_unitfunctionsshowcurrentdireval(info: tprograminfo);
    procedure func_unitfunctionsrundialogueeval(info: tprograminfo);
    procedure func_unitfunctionsstopdialogueeval(info: tprograminfo);
    procedure func_unitfunctionsshownodehistoryeval(info: tprograminfo);
    procedure func_unitfunctionsisdialoguerunningeval(info: tprograminfo);
    procedure func_unitfunctionslisttranscriptseval(info: tprograminfo);
    procedure func_unitfunctionsshowtranscripteval(info: tprograminfo);
    procedure func_unitfunctionsclseval(info: tprograminfo);
    procedure func_unitfunctionsflushdialogueeval(info: tprograminfo);
    procedure func_unitfunctionscdeval(info: tprograminfo);
    procedure func_unitfunctionsdireval(info: tprograminfo);
    procedure showtranscriptlist1click(Sender: TObject);
    procedure saveall1click(Sender: TObject);
    procedure func_unitfunctionssavedialogtranscriptseval(info: tprograminfo);
    procedure sortnodes(info: tprograminfo);
    procedure func_unitfunctionsdumphelptohtmleval(info: tprograminfo);
    procedure func_unitfunctionsaddhelperscripteval(info: tprograminfo);
    procedure func_unitfunctionssetnodedataeval(info: tprograminfo);
    procedure func_unitfunctionsgetnodedataeval(info: tprograminfo);
    procedure func_unitfunctionsgetnodenameeval(info: tprograminfo);
    procedure func_unitfunctionsgetplayeroptionstringdataeval(info: tprograminfo);
    procedure func_unitfunctionsgetplayeroptionintegerdataeval(info: tprograminfo);
    procedure func_unitfunctionssetplayeroptionstringdataeval(info: tprograminfo);
    procedure func_unitfunctionssetplayeroptionintegerdataeval(info: tprograminfo);
    procedure func_unitfunctionseditplayeroptioneval(info: tprograminfo);
    procedure func_unitfunctionsgetnodecounteval(info: tprograminfo);
    procedure func_unitfunctionsdeletenodeeval(info: tprograminfo);
    procedure func_unitfunctionsdeleteplayeroptioneval(info: tprograminfo);
    procedure playercharactersetup1click(Sender: TObject);
    procedure func_unitfunctionsconfirmeval(info: tprograminfo);
    procedure func_unitfunctionsstringreplaceeval(info: tprograminfo);
    procedure func_unitfunctionsaddtimeeventcommandeval(info: tprograminfo);
    procedure func_unitfunctionsaddtimeeventcodeeval(info: tprograminfo);
    procedure func_unitfunctionsselectfloatnodeeval(info: tprograminfo);
    procedure func_unitfunctionsselecttimedeventeval(info: tprograminfo);
    procedure formclose(Sender: TObject; var action: tcloseaction);
    procedure func_unitfunctionsaddnodenorefresheval(info: tprograminfo);
    procedure func_unitfunctionsaddtimedeventeval(info: tprograminfo);
    procedure func_unitfunctionsaddcodetoeventeval(info: tprograminfo);
    procedure func_unitfunctionsdialoguechangenotifyeval(info: tprograminfo);
    procedure func_unitfunctionsaddfloatnodeeval(info: tprograminfo);
    procedure func_unitfunctionsaddmsgtofloatnodeeval(info: tprograminfo);
    procedure func_unitfunctionseditfloatnodeeval(info: tprograminfo);
    procedure func_unitfunctionsgettimedeventdataeval(info: tprograminfo);
    procedure func_unitfunctionsdolink_showexportseval(info: tprograminfo);
    procedure func_unitfunctionsexecutefileeval(info: tprograminfo);
    procedure func_unitfunctionsloaddefeval(info: tprograminfo);
    procedure customprocedures1click(Sender: TObject);
    procedure opendialogueeditor1click(Sender: TObject);
    procedure func_unitvariablesbasepathreadvar(var Value: variant);
    procedure func_unitfunctionsaddskillcheckeval(info: tprograminfo);
    procedure func_unitfunctionssetoptiontoskillcheckeval(info: tprograminfo);
    procedure func_unitfunctionsrequestpluginrefresheval(info: tprograminfo);
    procedure func_unitfunctionssetnodecustomcodeeval(info: tprograminfo);
    procedure timer1timer(Sender: TObject);
    procedure replacedialog1replace(Sender: TObject);
    procedure func_unitfunctionsopenprogressbareval(info: tprograminfo);
    procedure func_unitfunctionssetprogressmaxeval(info: tprograminfo);
    procedure func_unitfunctionsupdateprogresseval(info: tprograminfo);
    procedure func_unitfunctionscloseprogressbareval(info: tprograminfo);
    procedure func_unitfunctionssetprogressbarcaptioneval(info: tprograminfo);
    procedure syncompletionproposal1execute(kind: tsyncompletiontype;
      Sender: TObject; var currentinput: string; var x, y: integer;
      var canexecute: boolean);
    procedure listbox1customdrawsubitem(Sender: tcustomlistview;
      item: tlistitem; subitem: integer; state: tcustomdrawstate;
      var defaultdraw: boolean);
    procedure func_unitfunctionsisnodehiddeneval(info: tprograminfo);
    procedure func_unitfunctionscopyconditionseval(info: tprograminfo);
    procedure mxWebUpdate1BeforeGetInfo(Sender: TObject);
  private
  public
  end;{$INCLUDE 'version.inc'}

type
  dlgtranscript = record
    histname: string;
    date:     tdatetime;
    dlgname:  string;
    npcname:  string;
    Lines:    array of string;
    linecnt:  integer;
  end;

type
  templatescript = record
    filename:    string;
    description: string;
    category:    string;
    deleted:     boolean;
  end;

type
  timeeventcommand = record
    scriptname: string;
    menuitem:   string;
    shortcut:   string;
  end;

var
  form1:         tform1;
  dlgrunning:    boolean;
  dlgtranscripts: array of dlgtranscript;
  timeeventcommands: array[0..100] of ^timeeventcommand;
  te_cmdcnt:     integer;
  templatescripts: array[0..100] of ^templatescript;
  tempscnt:      integer;
  dlgtranscriptcnt: integer;
  zerrorstr:     string;
  checksilent:   boolean;
  date:          tdatetime;
  builddate:     string;
  dlgchanged:    boolean;
  globmsgind:    integer;
  prevmsg:       string;
  scriptdata:    TStrings;
  dlgcopy:       dialog;
  booting_up:    boolean;
  currentprog:   tprogram;
  currentnode:   integer;
  funcdesc:      tinifile;
  nodehistory:   array of integer;
  nodehistoryoption: array of integer;
  nodehistorypreviousnode: array of integer;
  current_skin:  integer;
  nodehistorysize: integer;
  nodehistoryposition: integer;
  previousnode:  integer;
  temp_dlg:      dialog;
  outputwnd:     TStrings;
  checkforupdatesatstartup: boolean;
  cfg:           tinifile;
  helpapiform:   tform28;
  scriptconsole: tprogram;
  forwardnode:   integer;
  lookuplist:    TStrings;
  incparser:     tparseinclude;
  codesnip_parser: tcodesnippets;
  fo2datapath:   string;
  evalskillchecks, dlgeval: boolean;
  numskillsimulations: integer;
  usestartconds: boolean;
  last_option:   integer;
  dumbcolmode:   boolean;
  neutral_col, good_col, bad_col, dumb_col: tcolor;
  fmf1:          tfmf;
  gvarparser:    tgvarparse;
  autonodemap:   boolean;
  runtimedlgedit: boolean;
  currentfile:   string;

procedure NodeUpdate;
function SaveChangeNotify: boolean;
procedure WNDOutput(str: string);
procedure DoNodeSort;
procedure DisplayTranscript(ind: integer);
procedure DialogueChangenotify;
procedure DoExternalRegister(appname: PChar; Name: PChar; desc: PChar;
  interfacever: shortstring); stdcall;
procedure addautocompletestuff;

implementation

uses aboutbox, parseerror, addnode, custom_proc_ed, devfunced, dlged,
  dlgterminate, dlgtrans, floatnode_ed, globalnpc, JclPeImage, Math,
  playercharsetup, prefs, selectfloatnode, skillcheck_eval, te_dataed,
  transclist, updateprog, ValEdit, scriptprogressbar;

{$R WindowsXP.res}

{$R *.dfm}

procedure generatenodehistoryandsave;
var
  t: integer;
var
  datestr: string;
begin
  debugmsg('Generating node history.');
  setlength(dlgtranscripts, dlgtranscriptcnt + 1);
  for t := 0 to nodehistorysize - 1 do
  begin
    setlength(dlgtranscripts[dlgtranscriptcnt].Lines,
      dlgtranscripts[dlgtranscriptcnt].linecnt + 2);
    dlgtranscripts[dlgtranscriptcnt].Lines[dlgtranscripts[dlgtranscriptcnt].linecnt] :=
      'NPC: (' + currentdlg.nodes[nodehistory[t]].nodename + ') ' +
      currentdlg.nodes[nodehistory[t]].npctext;
    if (player.gender = gender_female) and
      (currentdlg.nodes[nodehistory[t]].npctext_female <> '') then
      dlgtranscripts[dlgtranscriptcnt].Lines[dlgtranscripts[dlgtranscriptcnt].linecnt] :=
        'NPC: (' + currentdlg.nodes[nodehistory[t]].nodename + ') ' +
        currentdlg.nodes[nodehistory[t]].npctext_female;
    dlgtranscripts
      [dlgtranscriptcnt].Lines[dlgtranscripts[dlgtranscriptcnt].linecnt] :=
      stringreplace(dlgtranscripts[dlgtranscriptcnt].Lines[
      dlgtranscripts[dlgtranscriptcnt].linecnt], '<PC>', player.Name, [rfreplaceall]);
    dlgtranscripts[dlgtranscriptcnt].Lines[dlgtranscripts[dlgtranscriptcnt].linecnt] :=
      stringreplace(dlgtranscripts[dlgtranscriptcnt].Lines[
      dlgtranscripts[dlgtranscriptcnt].linecnt], '${dude_name}',
      player.Name, [rfreplaceall]);
    Inc(dlgtranscripts[dlgtranscriptcnt].linecnt);
    if (nodehistorypreviousnode[t] <> -1) and (nodehistoryoption[t] <> -1) then
    begin
      dlgtranscripts[dlgtranscriptcnt].Lines[
        dlgtranscripts[dlgtranscriptcnt].linecnt]  :=
        'Player: ' + currentdlg.nodes[nodehistorypreviousnode[t]].options[nodehistoryoption[t]].optiontext;
      dlgtranscripts[dlgtranscriptcnt].Lines
        [dlgtranscripts[dlgtranscriptcnt].linecnt] :=
        stringreplace(dlgtranscripts[dlgtranscriptcnt].Lines[
        dlgtranscripts[dlgtranscriptcnt].linecnt], '<PC>', player.Name, [rfreplaceall]);
      dlgtranscripts[dlgtranscriptcnt].Lines[dlgtranscripts[dlgtranscriptcnt].linecnt] :=
        stringreplace(dlgtranscripts[dlgtranscriptcnt].Lines[
        dlgtranscripts[dlgtranscriptcnt].linecnt], '${dude_name}',
        player.Name, [rfreplaceall]);
      Inc(dlgtranscripts[dlgtranscriptcnt].linecnt);
    end;
  end;
  dlgtranscripts[dlgtranscriptcnt].date := now;
  datestr := datetimetostr(dlgtranscripts[dlgtranscriptcnt].date);
  datestr := stringreplace(datestr, '/', '_', [rfreplaceall]);
  datestr := stringreplace(datestr, '.', '_', [rfreplaceall]);
  datestr := stringreplace(datestr, ':', '_', [rfreplaceall]);
  dlgtranscripts[dlgtranscriptcnt].dlgname := currentdlg.filename;
  dlgtranscripts[dlgtranscriptcnt].npcname := currentdlg.npcname;
  dlgtranscripts
    [dlgtranscriptcnt].histname :=
    format('%s_%0.3d_%s.txt', [extractfiledir(ParamStr(0)) +
    '\dialogue\history\' + extractfilename(changefileext(currentdlg.filename, '')),
    dlgtranscriptcnt, datestr]);
  debugmsg('Transcript #' + IntToStr(dlgtranscriptcnt) + ' generated.');
  Inc(
    dlgtranscriptcnt);
end;

function GetCurrentNode: shortstring; stdcall;
begin
  Result := '';
  if dlgrunning = True then
    Result := currentdlg.nodes[currentnode].nodename;
end;

procedure setcurrentnode(node: shortstring); stdcall;
begin
  if dlgrunning = True then
  begin
    if getnodeindex(node) <> -1 then
    begin
      currentnode := getnodeindex(node);
    end;
  end;
end;

procedure freedlgptrs;
var
  u, t, z: integer;
begin
  debugmsg('Deallocating dialog node pointers');
  if currentdlg.nodecount = 0 then
  begin
    debugmsg('No nodes to deallocate, exiting procedure for safety.');
    exit;
  end;
  if currentdlg.floatnodecount > 0 then
  begin
    for t := 0 to currentdlg.floatnodecount - 1 do
    begin
      dispose(currentdlg.floatnodes[t]);
    end;
  end;
  if currentdlg.timedeventcnt > 0 then
  begin
    for t := 0 to currentdlg.timedeventcnt - 1 do
    begin
      dispose(currentdlg.timedevents[t]);
    end;
  end;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    for u := 0 to currentdlg.nodes[t].optioncnt - 1 do
    begin
      if currentdlg.nodes[t].options[u].conditioncnt > 0 then
      begin
        for z := 0 to currentdlg.nodes[t].options[u].conditioncnt - 1 do
        begin
          if currentdlg.nodes[t].options[u].conditions[z] <> nil then
            dispose(currentdlg.nodes[t].options[u].conditions[z])
          else
            debugmsg('Not deallocating null condition pointer ' + IntToStr(z));
        end;
      end;
      if currentdlg.nodes[t].options[u] <> nil then
        dispose(currentdlg.nodes[t].options[u])
      else
        debugmsg('NODE:' + IntToStr(t) + ':OPT:' + IntToStr(u) +
          ': Already null pointer, not going to do anything!');
    end;
    if (currentdlg.nodes[t] <> nil) then
      dispose(currentdlg.nodes[t]);
  end;
  debugmsg(
    'disposed ' + IntToStr(currentdlg.nodecount) + ' nodes.');
end;

procedure tform1.quit1click(Sender: TObject);
begin
  form1.Close;
end;

procedure GetCurrentDLGName(var dastr: PChar); stdcall;
begin
  dastr := PChar(currentfile);
end;

procedure setdlgnode(nodenum: integer; srcnode: pdlgnode); stdcall;
var
  i: integer;
begin
  new(currentdlg.nodes[nodenum]);
  currentdlg.nodes[nodenum].nodename := srcnode^.nodename;
  currentdlg.nodes[nodenum].npctext := srcnode^.npctext;
  currentdlg.nodes[nodenum].notes := srcnode^.notes;
  currentdlg.nodes[nodenum].optioncnt := srcnode^.optioncnt;
  for i := 0 to srcnode^.optioncnt - 1 do
  begin
    new(currentdlg.nodes[nodenum].options[i]);
    currentdlg.nodes[nodenum].options[i].optiontext := srcnode^.options[i].optiontext;
    currentdlg.nodes[nodenum].options[i].nodelink := srcnode^.options[i].nodelink;
    currentdlg.nodes[nodenum].options[i].notes := srcnode^.options[i].notes;
  end;
  Inc(currentdlg.nodecount);
end;

function GetPlayer: playerptr; stdcall;
begin
  new(Result);
  Result^ := player^;
end;

function GetDLG: pdialogue; stdcall;
var
  t: integer;
begin
  debugmsg('Sending dialogue to plugin...');
  new(Result);
  Result^.filename := currentdlg.filename;
  Result^.npcname  := currentdlg.npcname;
  Result^.description := currentdlg.description;
  Result^.location := currentdlg.location;
  Result^.unknowndesc := currentdlg.unknowndesc;
  Result^.knowndesc := currentdlg.knowndesc;
  Result^.detaileddesc := currentdlg.detaileddesc;
  Result^.nodecount := currentdlg.nodecount;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    new(Result^.nodes[t]);
    Result^.nodes[t]^ := currentdlg.nodes[t]^;
  end;
  debugmsg('Done..');
end;

 // alternate method of returning dialogue
 // for use with script exporter in an attempt
 // to make it work again
procedure GetDLGNew_Alt(var dlg: pnewdialogue); stdcall;
begin
  new(dlg);
  dlg^ := currentdlg;
end;


function GetDLGNew: pnewdialogue; stdcall;
begin
  new(Result);
  Result^ := currentdlg;
end;

function GetSSLPath: shortstring; stdcall;
begin
  Result := cfg.readstring('Global Config', 'DefaultSSLPath', '');
end;

function GetMSGPath: shortstring; stdcall;
begin
  Result := cfg.readstring('Global Config', 'DefaultMSGPath', '');
end;

procedure tform1.button3click(Sender: TObject);
begin
  debugmsg('Attempting to resolve nodes...');
  resolvenodes;
  debugmsg('Attempting to refresh node list.');
  refreshnodes;
  debugmsg('Done!');
  form2.showmodal;
  if dlgrunning = True then
  begin
    nodeupdate;
  end;
  requestpluginrefresh;
end;

procedure donodesort;
var
  t: integer;
  newind: integer;
  nodenames: TStringList;
begin
  temp_dlg  := currentdlg;
  nodenames := TStringList.Create;
  for t := 0 to temp_dlg.nodecount - 1 do
  begin
    nodenames.add(temp_dlg.nodes[t].nodename);
  end;
  nodenames.sort;
  currentdlg.nodecount := 0;
  for t := 0 to nodenames.Count - 1 do
  begin
    new(currentdlg.nodes[currentdlg.nodecount]);
    newind := getnodeindexfromdlg(nodenames[t], temp_dlg);
    currentdlg.nodes[currentdlg.nodecount]^ := temp_dlg.nodes[newind]^;
    Inc(currentdlg.nodecount);
  end;
  wndoutput('Node sorting complete.');
  resolvenodes;
  refreshnodes;
  requestpluginrefresh;
end;

procedure addautocompletestuff;
var
  x, y: integer;
var
  str:  string;
begin
  form1.syncompletionproposal2.insertlist.Clear;
  form1.syncompletionproposal2.itemlist.Clear;
  for x := 0 to gvarcount - 1 do
  begin
    form1.syncompletionproposal2.insertlist.add(gvars[x].Name);
    form1.syncompletionproposal2.itemlist.add(gvars[x].Name + ' (' + IntToStr(x) + ')');
  end;

  for x := 0 to currentdlg.floatnodecount - 1 do
  begin
    form1.syncompletionproposal2.insertlist.add(currentdlg.floatnodes[x].nodename);
    form1.syncompletionproposal2.itemlist.add(currentdlg.floatnodes[x].nodename);
  end;
  for x := 0 to currentdlg.nodecount - 1 do
  begin
    form1.syncompletionproposal2.insertlist.add(currentdlg.nodes[x].nodename);
    form1.syncompletionproposal2.itemlist.add(currentdlg.nodes[x].nodename +
      ' "' + currentdlg.nodes[x].npctext + '"');
  end;
  for x := 0 to currentdlg.varcnt - 1 do
  begin
    if currentdlg.variables[x].flags = var_flags_local then
    begin
      form1.syncompletionproposal2.insertlist.add('LVAR_' +
        currentdlg.variables[x].Name);
      form1.syncompletionproposal2.itemlist.add('LVAR_' + currentdlg.variables[x].Name);
    end else
    begin
      form1.syncompletionproposal2.insertlist.add(currentdlg.variables[x].Name);
      form1.syncompletionproposal2.itemlist.add(currentdlg.variables[x].Name);
    end;
  end;
  for x :=
    0 to inc_cnt - 1 do
  begin
    lookuplist.add(incs[x].Name);
    form1.syncompletionproposal2.insertlist.add(incs[x].Name);
    if incs[x].paramcnt > 0 then
    begin
      str := incs[x].Name + ' (';
      for y := 0 to incs[x].paramcnt - 1 do
      begin
        if incs[x].paramtype[y] <> 0 then
        begin
          case incs[x].paramtype[y] of
            ptype_objectptr: str := str + 'objectptr ';
            ptype_integer: str := str + 'integer ';
            ptype_string: str  := str + 'string ';
          end;
        end;
        str := str + incs[x].params[y];
        if y < incs[x].paramcnt - 1 then
          str := str + ', ';
      end;
      str := str + ')';
      form1.syncompletionproposal2.itemlist.add(str);
    end else
    begin
      str := '' + incs[x].Name;
      if incs[x].Value <> '' then
      begin
        str := str + ' = ' + incs[x].Value;
      end;
      form1.syncompletionproposal2.itemlist.add(str);
    end;
  end;
end;

procedure tform1.formcreate(Sender: TObject);
var
  t: integer;
var
  data_dir: string;
begin
  fmf1 := tfmf.Create(form1);
  fmf1.onerror := form1.fmf1error;
  randomize;
  data_dir :=
    extractfiledir(ParamStr(0));
  basepath := extractfiledir(ParamStr(0));
  booting_up := True;
  resetlog;
  new(player);
  lookuplist := TStringList.Create;
  condcfg := tinifile.Create(data_dir + '\conditions.ini');
  dlgtranscriptcnt := 0;
  cfg := tinifile.Create(data_dir + '\fdc.ini');
  debugmode := cfg.readbool('Global Config', 'Debugmode', False);
  current_skin := cfg.readinteger('Global Config', 'SkinIndex', 0);
  neutral_col := stringtocolor(cfg.readstring('Dialogue Engine',
    'Neutral Reaction Color', 'clBlack'));
  good_col := stringtocolor(cfg.readstring('Dialogue Engine',
    'Good Reaction Color', 'clGreen'));
  bad_col := stringtocolor(cfg.readstring('Dialogue Engine',
    'Bad Reaction Color', 'clRed'));
  dumb_col := stringtocolor(cfg.readstring('Dialogue Engine',
    'Dumb Player Option Color', 'clPurple'));
  timer1.Enabled := cfg.readbool('Global Config', 'AutoSave', False);
  numskillsimulations := cfg.readinteger('Dialogue Engine', 'NumSkillSimulations', 20);
  timer1.interval := cfg.readinteger('Global Config', 'AutoSaveInterVal', 300000);
  t := 0;
  if debugmode = True then
  begin
    form11 := tform11.Create(form1);
    form11.Show;
  end;
  decimalseparator := '.';
  debugmsg('Starting up FMF Dialogue tool...');
  incparser := tparseinclude.Create(nil);
  loadscript(data_dir + '\def\def_list.dws');
  codesnip_parser := tcodesnippets.Create(nil);
  codesnip_parser.sourcefilename := basepath + '\def\codesnippets.def';
  codesnip_parser.Execute;
  if codesnip_parser.successful = True then
  begin
    debugmsg('CodeSnippets parsed: ' + IntToStr(codesnippetcnt));
  end;
  codesnip_parser.Free;
  incparser.Free;
  debugmsg(IntToStr(inc_cnt) + ' completion proposal definitions loaded.');
  addautocompletestuff;
  dlgeval := cfg.readbool('Dialogue Engine', 'EvaluateConditions', True);
  evalskillchecks := cfg.readbool('Dialogue Engine', 'EvaluateSkillChecks', True);
  player.Name := cfg.readstring('Player Character', 'Name', '');
  player.gender := cfg.readinteger('Player Character', 'Gender', gender_male);
  player.age := cfg.readinteger('Player Character', 'Age', 16);
  player.strength := cfg.readinteger('Player Character', 'Strength', 5);
  player.perception := cfg.readinteger('Player Character', 'Perception', 5);
  player.endurance := cfg.readinteger('Player Character', 'Endurance', 5);
  player.charisma := cfg.readinteger('Player Character', 'Charisma', 5);
  player.intelligence := cfg.readinteger('Player Character', 'Intelligence', 5);
  player.agility := cfg.readinteger('Player Character', 'Agility', 5);
  player.luck :=
    cfg.readinteger('Player Character', 'Luck', 5);
  player.dude_caps := cfg.readinteger('Player Character', 'Dude_Caps', 0);
  for t := 0 to 17 do
  begin
    player.skills[t].Name  := cfg.readstring('Skills', 'Skill' + IntToStr(t + 1), '');
    player.skills[t].Value := cfg.readinteger('Player Character',
      player.skills[t].Name, 0);
  end;
  if ParamStr(1) = '/devmode' then
  begin
    debugmsg('Developer mode enabled.');
    dev1.Visible := True;
  end;
  fo2datapath := cfg.readstring('Global Config', 'FO2DataPath', '');
  gvarparser  := tgvarparse.Create(form1);
  if fileexists(fo2datapath + '\data\VAULT13.GAM') then
  begin
    debugmsg('VAULT13.GAM found: Loading global variables');
    gvarparser.sourcefilename := fo2datapath + '\data\VAULT13.GAM';
    gvarparser.Execute;
    if gvarparser.successful = True then
    begin
      debugmsg('Successfully parsed ' + IntToStr(gvarcount) + ' variables.');
    end;
  end;
  getfilelastwrite(ParamStr(0), date);
  builddate := datetimetostr(date);
  debugmsg('Reading config');
  delphiwebscriptii1.addunit(func_unit);
  loadscript(data_dir + '\helperscripts\helpermain.dws');
  if tempscnt > 0 then
    helperscripts1.Visible := True
  else
    helperscripts1.Visible := False;
  autonodemap := cfg.readbool('Global Config', 'AutoRemapNodes', False);
  runtimedlgedit := cfg.readbool('Global Config', 'RuntimeDLGEditing', False);
  case runtimedlgedit of
    True: debugmsg('Runtime DLG Editing ON');
    False: debugmsg('Runtime DLG Editing OFF');
  end;
  defsmartint := cfg.readinteger('Global Config', 'DefaultIntForSmartPlayer', 4);
  defdumbint  := cfg.readinteger('Global Config', 'DefaultIntForDumbPlayer', -3);
  debugmsg('Default Smart INT is ' + IntToStr(defsmartint));
  debugmsg('Default Dumb INT is ' + IntToStr(defdumbint));
  globmsgind := 0;
  funcdesc := tinifile.Create(extractfiledir(ParamStr(0)) + '\func_desc.ini');
  checkforupdatesatstartup := cfg.readbool('Global Config',
    'Check for updates at startup', True);
  currentfile :=
    'untitled';
  case checkforupdatesatstartup of
    True: debugmsg('Autoupdate checking ON');
    False: debugmsg('Autoupdate checking OFF');
  end;
  form6 := tform6.Create(form1);

  scanforplugins(basepath + '\plugins\Net_*.dll', form1.mainmenu1,
    file1, form1.pluginexec, False, preferences1.menuindex + 1,
    'Loading internet-related plugins...');
  scanforplugins(basepath + '\plugins\Utility_*.dll', form1.mainmenu1,
    plugins1, form1.pluginexec, True, -1, 'Loading generic plugins...');
  scanforplugins(basepath + '\plugins\DEV_*.dll', form1.mainmenu1,
    plugins1, form1.pluginexec, False, -1, 'Loading development tool plugins...');
  scanforplugins(basepath + '\plugins\Export_*.dll', form1.mainmenu1,
    exporthtml1, form1.pluginexec, True, -1, 'Loading export plugins...');
  scanforplugins(basepath + '\plugins\Import_*.dll', form1.mainmenu1,
    import1, form1.pluginexec, True, -1, 'Loading import plugins...');
  currentdlg.nodecount := 0;
  form1.Caption := 'Fallout Dialogue Creator - [untitled]';
  debugmsg('Init complete.');
  booting_up := False;
end;

procedure tform1.pluginexec(Sender: TObject);
var
  i: integer;
begin
  executeplugin(dllplugins[TMenuItem(Sender).tag].filename);
end;

procedure savedata(filename: string);
var
  t, ux, y: integer;
  condstr, genderconst, reactionconst: string;
  tempdesc, tempdesc2, tempdesc3, tempdesc4, tempdesc5: string;
  version_str, temp, temp2, temp3: string;
  thelist, Data: TStrings;
begin
  Data := TStringList.Create;
  Data.add('/*');
  Data.add('');
  Data.add('    Fan Made Fallout Dialogue Tool');
  Data.add('         dialogue script file');
  Data.add('');
  Data.add(' -- hand editing this file is not recommended');
  Data.add('');
  version_str := format('%d.%d.%d-%s', [version_major, version_minor,
    version_release, version_status]);
  Data.add(format(' Created with version %s', [version_str]));
  Data.add('');
  Data.add('*/');
  Data.add('');
  tempdesc  := currentdlg.description;
  tempdesc2 :=
    currentdlg.location;
  tempdesc3 := currentdlg.unknowndesc;
  tempdesc4 := currentdlg.knowndesc;
  tempdesc5 := currentdlg.detaileddesc;
  tempdesc  := stringreplace(tempdesc, '"', '\"', [rfreplaceall]);
  tempdesc  := stringreplace(tempdesc, #13#10, '\n', [rfreplaceall]);
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
      if currentdlg.variables[t].flags = var_flags_import then
        temp := temp + 'import '
      else if currentdlg.variables[t].flags = var_flags_export then
        temp := temp + 'export '
      else if currentdlg.variables[t].flags = var_flags_local then
        temp := temp + 'local '
      else if currentdlg.variables[t].flags = var_flags_global then
        temp := temp + 'global ';
      temp := temp + 'var ' + currentdlg.variables[t].Name + ' notes "' +
        currentdlg.variables[t].notes + '"';
      if currentdlg.variables[t].vartype <> -1 then
      begin
        case currentdlg.variables[t].vartype of
          var_type_int: temp := temp + ' = ' + IntToStr(currentdlg.variables[t].Value);
          var_type_float: temp :=
              temp + ' = ' + floattostr(currentdlg.variables[t].Value);
          var_type_string: temp := temp + ' = "' + currentdlg.variables[t].Value + '"';
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
          Data.add(format(
            '    SSL "%s" var_param "%s" eval %d value_to_check "%s" ini_index %d link %d,',
            [
            currentdlg.startconditions[t].conditions[y].resultcode,
            currentdlg.startconditions[t].conditions[y].parameter,
            currentdlg.startconditions[t].conditions[y].evaluator,
            currentdlg.startconditions[t].conditions[y].compareto,
            currentdlg.startconditions[t].conditions[y].index_of_selection,
            currentdlg.startconditions[t].conditions[y].linkage]))
        else
          Data.add(format(
            '    SSL "%s" var_param "%s" eval %d value_to_check "%s" ini_index %d link %d',
            [
            currentdlg.startconditions[t].conditions[y].resultcode,
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
    Data.
      add('// starting from zero');
    Data.add('Default_Event = ' + IntToStr(currentdlg.start_time_event));
    for t := 0 to currentdlg.timedeventcnt - 1 do
    begin
      Data.add('TimeEvent fixed_param_name="' +
        currentdlg.timedevents[t].fixedparamname + '", enum=' +
        IntToStr(currentdlg.timedevents[t].fixedparamenumindex));
      Data.add('IsRandomInterval = ' +
        booltostr(currentdlg.timedevents[t].israndom, True));
      if currentdlg.timedevents[t].israndom then
      begin
        Data.add('IntervalMin=' + IntToStr(currentdlg.timedevents[t].mininterval));
        Data.add('IntervalMax=' + IntToStr(currentdlg.timedevents[t].maxinterval));
      end else
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
        end else
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
      temp := StringReplace(temp, #13#10, '\n', [rfReplaceAll]);
      temp := StringReplace(temp, '"', '\"', [rfReplaceAll]);

      Data.add('Floatnode "' + currentdlg.floatnodes[t].nodename + '"');
      Data.add('notes "' + temp + '"');
      Data.add('{');
      for y :=
        0 to currentdlg.floatnodes[t].messagecnt - 1 do
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
    Data.add('is_wtg = ' + lowercase(booltostr(currentdlg.nodes[t].is_wtg, True)));
    if currentdlg.nodes[t].customcode <> '' then
    begin
      Data.add('    insert_custom_code {');
      thelist := TStringList.Create;
      temp := currentdlg.nodes[t].customcode;
      strtostrings(temp, #13#10, thelist);
      for y := 0 to thelist.Count - 1 do
      begin
        if y < thelist.Count - 1 then
          Data.add('    "' + stringreplace(thelist[y], '"', '\"', [rfreplaceall]) + '",')
        else
          Data.add('    "' + stringreplace(thelist[y], '"', '\"', [rfreplaceall]) + '"');
      end;
      Data.add(
        '    }');
    end;
    if currentdlg.nodes[t].skillcheckcnt > 0 then
    begin
      Data.add('/* Skill checks for node ' + currentdlg.nodes[t].nodename + ' */');
      Data.add('');
      for y := 0 to currentdlg.nodes[t].skillcheckcnt - 1 do
      begin
        Data.add('      define_skill_check ' +
          currentdlg.nodes[t].skillchecks[y].check_proc_name + ' {');
        Data.add(format('      skill_num = %d;' + #13#10 +
          '      difficulty_modifier = %d;' + #13#10 + '      onsuccess => %s;' +
          #13#10 + '      onfailure => %s;',
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
      temp :=
        stringreplace(temp, '"', '\"', [rfreplaceall]);
      temp := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
      Data.add(' NPCFemaleText "' + temp + '"');
    end;
    Data.add('      options {');
    for y := 0 to currentdlg.nodes[t].optioncnt - 1 do
    begin
      temp  := currentdlg.nodes[t].options[y].optiontext;
      temp  := stringreplace(temp, '"', '\"', [rfreplaceall]);
      temp  := stringreplace(temp, #13#10, '\n', [rfreplaceall]);
      temp2 := currentdlg.nodes[t].options[y].nodelink;
      temp3 := currentdlg.nodes[t].options[y].notes;
      temp2 := stringreplace(temp2, '"', '\"', [rfreplaceall]);
      temp2 := stringreplace(temp2, #13#10, '\n', [rfreplaceall]);
      temp3 := stringreplace(temp3, '"', '\"', [rfreplaceall]);
      temp3 := stringreplace(temp3, #13#10, '\n', [rfreplaceall]);
      genderconst := '';
      case currentdlg.nodes[t].options[y].genderflags of
        gender_male: genderconst := ' Gender=MALE';
        gender_female: genderconst := ' Gender=FEMALE';
      end;
      reactionconst := 'REACTION_NEUTRAL';
      case currentdlg.nodes[t].options[y].reaction of
        reaction_neutral: reactionconst := 'REACTION_NEUTRAL';
        reaction_good: reactionconst := 'REACTION_GOOD';
        reaction_bad: reactionconst  := 'REACTION_BAD';
      end;
      if currentdlg.nodes[t].options[y].conditioncnt > 0 then
      begin
        condstr := 'conditions { ';
        for ux := 0 to currentdlg.nodes[t].options[y].conditioncnt - 1 do
        begin
          condstr := condstr + generatecondstring(
            currentdlg.nodes[t].options[y].conditions[ux]^);
          if ux < currentdlg.nodes[t].options[y].conditioncnt - 1 then
            condstr := condstr + ', ';
        end;
        condstr := condstr + ' }';
      end else
        condstr := '';
      if (currentdlg.nodes[t].options[y].link_to_proc = True) and
        (currentdlg.nodes[t].options[y].link_to_skillcheck = False) then
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y].intcheck) +
          ' linkflags custom_proc Reaction=' + reactionconst +
          genderconst + ' playertext "' + temp + '" linkto "' + temp2 +
          '" ' + condstr + ' notes "' + temp3 + '"')
      else if (currentdlg.nodes[t].options[y].link_to_proc = False) and
        (currentdlg.nodes[t].options[y].link_to_skillcheck = True) then
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y].intcheck) +
          ' linkflags skill_check Reaction=' + reactionconst +
          genderconst + ' playertext "' + temp + '" linkto "' + temp2 +
          '" ' + condstr + ' notes "' + temp3 + '"')
      else
        Data.add('          int=' + IntToStr(currentdlg.nodes[t].options[y].intcheck) +
          ' Reaction=' + reactionconst + genderconst + ' playertext "' +
          temp + '" linkto "' + temp2 + '" ' + condstr + ' notes "' + temp3 + '"');
    end;
    Data.add('              }');
    Data.add('}');
  end;
  if currentdlg.customproccnt > 0 then
  begin
    ;
    Data.add('/* Custom procedures */');
    for t := 0 to currentdlg.customproccnt - 1 do
    begin
      ;
      Data.add('      custom_proc ' + currentdlg.customprocs[t].Name +
        ' associate_node ' + IntToStr(
        currentdlg.customprocs[t].associatewithnode) + ' {');
      thelist := TStringList.Create;
      temp := currentdlg.customprocs[t].Lines;
      strtostrings(temp, #13#10, thelist);
      for
        y := 0 to thelist.Count - 1 do
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
  currentfile := filename;
  currentdlg.filename := filename;
  form1.Caption := 'Fallout Dialogue Creator - [' + filename + ']';
end;

procedure tform1.savedialogue1click(Sender: TObject);
var
  y, t: integer;
begin
  savedialog1.initialdir := getcurrentdir + '\dialogue';
  if savedialog1.Execute then
  begin
    savedata(savedialog1.filename);
    form1.Caption :=
      'Fallout Dialogue Creator - [' + savedialog1.filename + ']';
  end;
end;

procedure tform1.loaddialogue1click(Sender: TObject);
var
  f, plugind: integer;
  numerrors, x: integer;
  oldname: string;
  errorlist: TStrings;
  errormsg: string;
begin
  if dlgrunning = True then
    button2click(nil);
  if cfg.readbool('Global Config', 'Savenodehistory', True) = True then
    saveall1click(nil);
  dlgtranscriptcnt := 0;
  setlength(dlgtranscripts, 0);
  if savechangenotify = False then
    exit;
  opendialog1.initialdir := getcurrentdir + '\dialogue';
  if opendialog1.Execute then
  begin
    if currentdlg.nodecount > 0 then
      freedlgptrs;
    fmf1.sourcefilename := opendialog1.filename;
    zerrorstr := '';
    currentdlg.npcname := '';
    currentdlg.description := '';
    currentdlg.location := '';
    currentdlg.unknowndesc := '';
    currentdlg.knowndesc := '';
    currentdlg.detaileddesc := '';
    currentdlg.varcnt := 0;
    currentdlg.startconditioncnt := 0;
    currentdlg.default_cond := -1;
    currentdlg.floatnodecount := 0;
    if opendialog1.filterindex = 1 then
    begin
      fmf1.Execute;
      if fmf1.successful = True then
      begin
        currentdlg.filename := opendialog1.filename;
        debugmsg('Successful load of ' + currentdlg.filename);
        if currentdlg.nodecount > 0 then
        begin
          errorlist := TStringList.Create;
          debugmsg('Node count = ' + IntToStr(currentdlg.nodecount));
          debugmsg('Validating dialogue file...');
          for f := 0 to currentdlg.nodecount - 1 do
          begin
            if IsValidNodeName(currentdlg.nodes[f].nodename, errormsg) = False then
            begin
              errorlist.add(currentdlg.nodes[f].nodename +
                ' is not valid - ' + errormsg);

              oldname := currentdlg.nodes[f].nodename;
              currentdlg.nodes[f].nodename :=
                StringReplace(currentdlg.nodes[f].nodename, '-', '_', [rfReplaceAll]);
              currentdlg.nodes[f].nodename :=
                StringReplace(currentdlg.nodes[f].nodename, ' ', '_', [rfReplaceAll]);
              currentdlg.nodes[f].nodename :=
                StringReplace(currentdlg.nodes[f].nodename, '''', '', [rfReplaceAll]);
              if currentdlg.nodes[f].nodename <> '' then
              begin
                errorlist.add('Node renamed to ' + currentdlg.nodes[f].nodename);
                RemapNodes(oldname, currentdlg.nodes[f].nodename);
              end;
             inc(numerrors);
            end;
            if currentdlg.nodes[f].nodename = '' then
            begin
              errorlist.add('Empty node name at position ' + IntToStr(f) +
                ' renamed to ' + format('Node%0.3d', [f]));
              currentdlg.nodes[f].nodename := format('Node%0.3d', [f]);
              //  RemapNodes('', currentdlg.nodes[f].options[x].nodelink);
             inc(numerrors);
            end;

            for x := 0 to currentdlg.nodes[f].optioncnt - 1 do
            begin
              if (currentdlg.nodes[f].options[x].nodelink <> '') and
                (GetNodeIndex(currentdlg.nodes[f].options[x].nodelink) = -1) and
                (currentdlg.nodes[f].options[x].link_to_skillcheck = False) and
                (currentdlg.nodes[f].options[x].link_to_proc = False) and
                (currentdlg.nodes[f].options[x].nodelink <> 'done') and
                (currentdlg.nodes[f].options[x].nodelink <> 'combat') then
              begin
                errorlist.add('[WARNING] Player option ' + IntToStr(x) +
                  ' at node ' + currentdlg.nodes[f].nodename +
                  ' links to a non-existent node "' +
                  currentdlg.nodes[f].options[x].nodelink +
                  '" and is not linking to skill check or custom procedure.');

              end else

              if currentdlg.nodes[f].options[x].nodelink = '' then
              begin
                errorlist.add('[WARNING] Player option ' + IntToStr(x) +
                  ' at node ' + currentdlg.nodes[f].nodename + ' has null node link. ');
              end;

            end;

          end;


          for f := 0 to currentdlg.floatnodecount - 1 do
          begin
            if IsValidNodeName(currentdlg.floatnodes[f].nodename, errormsg) = False then
            begin
              errorlist.add(currentdlg.floatnodes[f].nodename +
                ' is not valid - ' + errormsg);

              oldname := currentdlg.floatnodes[f].nodename;
              currentdlg.floatnodes[f].nodename :=
                StringReplace(currentdlg.floatnodes[f].nodename, ' ',
                '_', [rfReplaceAll]);
              currentdlg.floatnodes[f].nodename :=
                StringReplace(currentdlg.floatnodes[f].nodename, '''',
                '', [rfReplaceAll]);

              errorlist.add('Node renamed to ' + currentdlg.floatnodes[f].nodename);
             inc(numerrors);

            end;
            if currentdlg.floatnodes[f].nodename = '' then
            begin
              errorlist.add('Empty node name at position ' + IntToStr(f) +
                ' renamed to ' + format('Node%0.3d', [f]));
              currentdlg.floatnodes[f].nodename := format('Node%0.3d', [f]);

            end;
          end;


          if errorlist.Count > 0 then
          begin
          debugmsg(inttostr(numerrors)+' errors found.');
            form7.memo1.Lines.Clear;
            form7.memo1.Lines.Add(
              'This dialogue contained the following errors: ' + #13#10);
            form7.memo1.Lines.add(errorlist.Text);
            form7.ShowModal;
          end;
          refreshnodes;
          resolvenodes;
        end else
        begin
        end;
        form1.Caption := 'Fallout Dialogue Creator - [' + opendialog1.filename + ']';
        form1.statusbar1.simpletext :=
          'Dialogue ' + currentfile + ', ' + IntToStr(currentdlg.nodecount) + ' nodes';
        currentfile := opendialog1.filename;
        requestpluginrefresh;
      end else
      begin
        form7.memo1.Text := 'There were errors while parsing the dialogue script. ' +
          #13#10 + zerrorstr;
        form7.showmodal;
      end;
    end else
    begin
      debugmsg('FilterIndex := ' + IntToStr(opendialog1.filterindex));
      plugind := getpluginbyfilterindex(opendialog1.filterindex);
      if plugind <> -1 then
      begin
        debugmsg('plugin: ' + IntToStr(plugind) + ': ' + dllplugins[plugind].filename);
        executeimportaction(opendialog1.filename, dllplugins[plugind].filename);
      end;
    end;
  end;
end;

function checkconds(theopt: option): boolean;
var
  t: integer;
var
  chk, fld: integer;
var
  evaluate: integer;
var
  againstvalue: integer;
var
  val: integer;
var
  fieldstrue: integer;
var
  fieldsfalse: integer;
var
  evalresult: boolean;
begin
  evalresult := False;
  Result := True;
  fieldsfalse := 0;
  fieldstrue := 0;
  debugmsg('THEOPT: CONDITIONCNT: ' + IntToStr(theopt.conditioncnt));
  for t := 0 to theopt.conditioncnt - 1 do
  begin
    chk := theopt.conditions[t].check_type;
    fld := theopt.conditions[t].check_field;
    if theopt.conditions[t].check_value = '' then
    begin
      debugmsg('condition value was null, returning true.');
      Result := True;
      exit;
    end;
    val := StrToInt(theopt.conditions[t].check_value);
    case chk
      of
      check_type_checkmoney:
      begin
        case fld of
          check_field_dude_caps: againstvalue := player.dude_caps;
        end;
      end;
      check_type_skill:
      begin
        case fld of
          check_field_skill_smallguns: againstvalue := player.skills[0].Value;
          check_field_skill_bigguns: againstvalue := player.skills[1].Value;
          check_field_skill_energyweapons: againstvalue := player.skills[2].Value;
          check_field_skill_unarmed: againstvalue := player.skills[3].Value;
          check_field_skill_melee: againstvalue  := player.skills[4].Value;
          check_field_skill_throwing: againstvalue := player.skills[5].Value;
          check_field_skill_firstaid: againstvalue := player.skills[6].Value;
          check_field_skill_doctor: againstvalue := player.skills[7].Value;
          check_field_skill_sneak: againstvalue  := player.skills[8].Value;
          check_field_skill_lockpick: againstvalue := player.skills[9].Value;
          check_field_skill_steal: againstvalue  := player.skills[10].Value;
          check_field_skill_traps: againstvalue  := player.skills[11].Value;
          check_field_skill_science: againstvalue := player.skills[12].Value;
          check_field_skill_repair: againstvalue := player.skills[13].Value;
          check_field_skill_speech: againstvalue := player.skills[14].Value;
          check_field_skill_barter: againstvalue := player.skills[15].Value;
          check_field_skill_gambling: againstvalue := player.skills[16].Value;
          check_field_skill_outdoorsman: againstvalue := player.skills[17].Value;
        end;
      end;
      check_type_stat:
      begin
        case fld of
          check_field_stat_st: againstvalue := player.strength;
          check_field_stat_pe: againstvalue := player.perception;
          check_field_stat_en: againstvalue := player.endurance;
          check_field_stat_ch: againstvalue := player.charisma;
          check_field_stat_in: againstvalue := player.intelligence;
          check_field_stat_ag: againstvalue := player.agility;
          check_field_stat_lk: againstvalue := player.luck;
        end;
      end;
    end;
    evaluate := theopt.conditions[t].check_eval;
    case evaluate of
      compare_equal: evalresult := (againstvalue = val);
      compare_not_equal: evalresult := (againstvalue <> val);
      compare_larger_than: evalresult := (againstvalue > val);
      compare_less_than: evalresult := (againstvalue < val);
      compare_larger_than_or_equal: evalresult := (againstvalue >= val);
      compare_less_than_or_equal: evalresult := (againstvalue <= val);
    end;
    if evalresult = True then
      Inc(fieldstrue)
    else
      Inc(fieldsfalse);
    debugmsg(
      'CheckCondition: ' + theopt.conditions[t].resolved_code + ' == ' +
      booltostr(evalresult, True));
  end;
  if fieldstrue = theopt.conditioncnt then
    Result := True
  else
    Result := False;
end;

function isoptionvisible(opt: option): boolean;
var
  intcheckpassed:  boolean;
var
  gendercheckpassed: boolean;
var
  condcheckpassed: boolean;
begin
  if dlgeval = False then
  begin
    Result := True;
    exit;
  end;
  Result := True;
  if opt.conditioncnt > 0 then
  begin
    condcheckpassed := checkconds(opt);
  end else
    condcheckpassed := True;
  if (opt.intcheck > 0) and (player.intelligence >= opt.intcheck) then
    intcheckpassed := True;
  if (opt.intcheck < 0) and (player.intelligence <=
    (opt.intcheck + (opt.intcheck * -2))) then
  begin
    intcheckpassed := True;
  end else if (opt.intcheck < 0) and (player.intelligence >
    (opt.intcheck + (opt.intcheck * -2))) then
  begin
    intcheckpassed := False;
  end;
  if opt.genderflags > 0 then
  begin
    debugmsg('OPT Genderflags: ' + IntToStr(opt.genderflags) +
      ' Player genderflags: ' + IntToStr(player.gender));
    gendercheckpassed := (player.gender = opt.genderflags);
  end else
    gendercheckpassed := True;
  Result := ((intcheckpassed = True) and (gendercheckpassed = True) and
    (condcheckpassed = True));
end;

function reacttostr(reaction: integer): string;
begin
  case reaction of
    reaction_neutral: Result := 'Neutral';
    reaction_bad: Result  := 'Bad';
    reaction_good: Result := 'Good';
  end;
end;

procedure getnodeplayeroptions;
var
  hiddenopts, t: integer;
var
  s: tlistitem;
begin
  form1.listbox1.Clear;
  hiddenopts :=
    0;
  if (currentdlg.nodes[currentnode].optioncnt = 0) then
  begin
    messagedlg('Dialogue is assumed to end here since there are no player options available.', mtInformation, [mbOK], 0);
    form1.button2click(form1);
    form1.nodelabel.Text := '';
    exit;
  end;
  for t := 0 to currentdlg.nodes[currentnode].optioncnt - 1 do
  begin
    if isoptionvisible(currentdlg.nodes[currentnode].options[t]^) then
    begin
      s := form1.listbox1.items.add;
      s.Caption := IntToStr(t);
      s.subitems.add(currentdlg.nodes[currentnode].options[t].optiontext);
      s.subitems[0] := stringreplace(s.subitems[0], '<PC>', player.Name, [rfreplaceall]);
      s.subitems[0] := stringreplace(s.subitems[0], '${dude_name}',
        player.Name, [rfreplaceall]);
      s.subitems.add(currentdlg.nodes[currentnode].options[t].nodelink);
      s.subitems.add(reacttostr(currentdlg.nodes[currentnode].options[t].reaction));
    end else
      Inc(hiddenopts);
  end;
  if hiddenopts > 0 then
    form1.hiddenopts.Caption :=
      format('There are %d hidden player options.', [hiddenopts])
  else
    form1.hiddenopts.Caption := '';
end;

procedure setnodehistory(ind: integer; thenode: integer; playeropt: integer = -1;
  previous: integer = -1);
begin
  if thenode <> -1 then
  begin
    setlength(nodehistory, nodehistorysize + 1);
    setlength(nodehistoryoption, nodehistorysize + 1);
    setlength(nodehistorypreviousnode, nodehistorysize + 1);
    nodehistory
      [ind] := thenode;
    nodehistoryoption[ind] := playeropt;
    nodehistorypreviousnode[ind] := previous;
    debugmsg('SetNodeHistory(''' + IntToStr(ind) + ''',''' +
      currentdlg.nodes[thenode].nodename + ''') Playeroption: ' + IntToStr(playeropt));
  end;
end;

procedure addnodetohistory(thenode: integer; playeropt: integer = -1;
  previous: integer = -1);
begin
  if thenode <> -1 then
  begin
    setlength(nodehistory, nodehistorysize + 1);
    setlength(nodehistoryoption, nodehistorysize + 1);
    setlength(nodehistorypreviousnode, nodehistorysize + 1);
    nodehistory[nodehistorysize] := thenode;
    nodehistoryoption[nodehistorysize] := playeropt;
    nodehistorypreviousnode[
      nodehistorysize] := previous;
    if playeropt <> -1 then
      debugmsg('AddNodeToHistory(''' + currentdlg.nodes[thenode].nodename +
        ''') Playeroption: ' + IntToStr(playeropt) + ' TEXT=' +
        currentdlg.nodes[previous].options[playeropt].optiontext)
    else
      debugmsg('AddNodeToHistory(''' + currentdlg.nodes[thenode].nodename +
        ''') Playeroption: ' + IntToStr(playeropt));
    Inc(nodehistorysize);
    nodehistoryposition := nodehistorysize;
    if nodehistorysize > 0 then
    begin
      form1.button4.Enabled := True;
    end;
  end;
end;

procedure tform1.button1click(Sender: TObject);
begin
  if currentdlg.nodecount > 0 then
  begin
    if combobox1.Text = '' then
    begin
      messagedlg('Not going to run dialogue from a node with' + #13 +
        #10 + 'no name.' + #13 + #10 + '' + #13 + #10 +
        '(This is for preventing crashes)', mtWarning, [mbOK], 0);
      exit;
    end;
    debugmsg('Starting dialogue test from node ' + combobox1.Text);
    dlgrunning  := True;
    currentnode := getnodeindex(combobox1.Text);
    if currentnode = -1 then
    begin
      messagedlg(format('Error occured: Node ''%s'' not found.', [combobox1.Text]),
        mtWarning, [mbOK], 0);
      exit;
    end;
    nodehistorysize := 0;
    addnodetohistory(currentnode, -1, currentnode);
    button5.Enabled := False;
    button4.Enabled := False;
    if nodelabel.Visible = False then
      nodelabel.Visible := True;
    button6.Visible := True;
    nodelabel.Text  :=
      currentdlg.nodes[currentnode].nodename;
    label5.Visible  := True;
    button2.Enabled := True;
    button1.Enabled := False;
    nodeupdate;
  end else
    messagedlg('No nodes defined in dialogue!', mtError, [mbOK], 0);
end;

function checkskills(skcheck: string; showdebug: boolean = True): integer;
var
  skill: integer;
  ind: integer;
  nodeind: integer;
  skillname: string;
  skill_rollval, roll_value: integer;
  skill_final, skill_value: integer;
  random_threat: integer;
  dice_roll, dice_skill: integer;
begin
  ind := getskillcheckindex(skcheck, nodeind);
  if showdebug = True then
    debugmsg('Performing skill check ' +
      currentdlg.nodes[nodeind].skillchecks[ind].check_proc_name);
  skill := currentdlg.nodes[nodeind].skillchecks[ind].check_what;
  if skill > 18 then
  begin
    case skill of
      18 + check_field_stat_st:
      begin
        skill_value := player.strength;
        skillname := 'Strength';
      end;
      18 + check_field_stat_pe:
      begin
        skill_value := player.perception;
        skillname := 'Perception';
      end;
      18 + check_field_stat_en:
      begin
        skill_value :=
          player.endurance;
        skillname := 'Endurance';
      end;
      18 + check_field_stat_ch:
      begin
        skill_value := player.charisma;
        skillname := 'Charisma';
      end;
      18 + check_field_stat_in:
      begin
        skill_value := player.intelligence;
        skillname := 'Intelligence';
      end;
      18 + check_field_stat_ag:
      begin
        skill_value := player.agility;
        skillname := 'Agility';
      end;
      18 + check_field_stat_lk:
      begin
        skill_value := player.luck;
        skillname := 'Luck';
      end;
    end;
  end else
  begin
    skillname := player.skills[skill - 1].Name;
    skill_value := player.skills[skill - 1].Value;
  end;
  if showdebug = True then
    debugmsg('Skill "' + skillname + '" value = ' + IntToStr(skill_value));
  skill_value := skill_value -
    (currentdlg.nodes[nodeind].skillchecks[ind].modifier * -1);
  roll_value := 0;
  dice_roll  := 1 + random(6);
  dice_skill := 1 + random(6);
  random_threat := random(10) *
    (currentdlg.nodes[nodeind].skillchecks[ind].modifier * -1);
  skill_rollval := random(skill_value);
  roll_value := (currentdlg.nodes[nodeind].skillchecks[ind].modifier * -1) +
    (skill_rollval) + random_threat;
  if showdebug = True then
    debugmsg('Rolled (' + IntToStr(
      (currentdlg.nodes[nodeind].skillchecks[ind].modifier * -1)) +
      ' + ' + IntToStr(skill_rollval) + ' + (random_threat=' +
      IntToStr(random_threat) + ') = ' + IntToStr(roll_value) +
      ') against ' + IntToStr(skill_value));
  if roll_value > skill_value then
  begin
    if showdebug = True then
    begin
      debugmsg('Skill check failed.');
      debugmsg('Difference: ' + IntToStr(skill_value - roll_value));
    end;
    Result := getnodeindex(currentdlg.nodes[nodeind].skillchecks[ind].failurenode);
  end else if roll_value <= skill_value then
  begin
    if showdebug = True then
    begin
      debugmsg('Skill check succeeded.');
      debugmsg('Difference: ' + IntToStr(skill_value - roll_value));
    end;
    Result := getnodeindex(currentdlg.nodes[nodeind].skillchecks[ind].successnode);
  end;
end;

procedure skilltest(skname: string; var successes, failures: integer);
var
  nodeind, ind, x, t: integer;
begin
  ind := getskillcheckindex(skname, nodeind);
  failures := 0;
  successes := 0;
  for t := 1 to numskillsimulations do
  begin
    x := checkskills(skname, False);
    if x = getnodeindex(currentdlg.nodes[nodeind].skillchecks[ind].successnode) then
      Inc(successes)
    else if x = getnodeindex(currentdlg.nodes[nodeind].skillchecks[ind].failurenode) then
      Inc(failures);
  end;
  debugmsg('SkillTest: ' + IntToStr(successes) + ' succeeded, ' +
    IntToStr(failures) + ' failed.');
end;

procedure tform1.listbox1dblclick(Sender: TObject);
var
  done_node: boolean;
  _nodeind, skind: integer;
  skillname, statname: string;
  skill, prevnode: integer;
  successes, failures: integer;
  optionind: integer;
  Text: string;
begin
  if listbox1.selected = nil then
    exit;
  optionind := StrToInt(listbox1.selected.Caption);
  if dlgrunning = True then
  begin
    done_node := False;
    prevnode  := currentnode;
    if (currentdlg.nodes[currentnode].options[optionind].link_to_skillcheck = True) then
    begin
      if (evalskillchecks = True) then
        currentnode := checkskills(
          currentdlg.nodes[currentnode].options[optionind].nodelink)
      else
      begin
        skind := getskillcheckindex(
          currentdlg.nodes[currentnode].options[optionind].nodelink, _nodeind);
        skilltest(currentdlg.nodes[currentnode].options[optionind].nodelink,
          successes, failures);
        Text := form27.jvmarkuplabel1.Text;
        if currentdlg.nodes[_nodeind].skillchecks[skind].check_what > 18 then
        begin
          skill := currentdlg.nodes[_nodeind].skillchecks[skind].check_what;
          case skill
            of
            18 + check_field_stat_st: statname := 'Strength';
            18 + check_field_stat_pe: statname := 'Perception';
            18 + check_field_stat_en: statname := 'Endurance';
            18 + check_field_stat_ch: statname := 'Charisma';
            18 + check_field_stat_in: statname := 'Intelligence';
            18 + check_field_stat_ag: statname :=
                'Agility';
            18 + check_field_stat_lk: statname := 'Luck';
          end;
          form27.jvmarkuplabel1.Text :=
            format(Text, [currentdlg.nodes[_nodeind].skillchecks[skind].check_proc_name,
            statname, currentdlg.nodes[_nodeind].skillchecks[skind].modifier,
            currentdlg.nodes[_nodeind].skillchecks[skind].successnode,
            currentdlg.nodes[_nodeind].skillchecks[skind].failurenode,
            (successes / numskillsimulations) * 100, numskillsimulations,
            (failures / numskillsimulations) * 100, numskillsimulations]);
        end else
        begin
          form27.jvmarkuplabel1.Text :=
            format(Text, [currentdlg.nodes[_nodeind].skillchecks[skind].check_proc_name,
            player.skills[currentdlg.nodes[_nodeind].skillchecks[skind].check_what -
            1].Name, currentdlg.nodes[_nodeind].skillchecks[skind].modifier,
            currentdlg.nodes[_nodeind].skillchecks[skind].successnode,
            currentdlg.nodes[_nodeind].skillchecks[skind].failurenode,
            (successes / numskillsimulations) * 100, numskillsimulations,
            (failures / numskillsimulations) * 100, numskillsimulations]);
        end;
        form27.showmodal;
        form27.jvmarkuplabel1.Text := Text;
        if form27.modalresult = mrOk then
        begin
          case state of
            state_go_success:
            begin
              currentnode :=
                getnodeindex(currentdlg.nodes[_nodeind].skillchecks[skind].successnode);
              debugmsg('Going to node: ' +
                currentdlg.nodes[_nodeind].skillchecks[skind].successnode);
            end;
            state_go_failure:
            begin
              currentnode :=
                getnodeindex(currentdlg.nodes[_nodeind].skillchecks[skind].failurenode);
              debugmsg('Going to node: ' +
                currentdlg.nodes[_nodeind].skillchecks[skind].failurenode);
            end;
            state_go_eval: currentnode :=
                checkskills(currentdlg.nodes[currentnode].options[optionind].nodelink)
          end;
        end;
      end;
    end else
      currentnode := currentdlg.nodes[currentnode].options[optionind].noderesolved;
    if nodehistorysize > 0 then
    begin
      debugmsg('Setting node history -- ');
      setnodehistory(nodehistorysize - 1, nodehistory[nodehistorysize - 1],
        optionind, prevnode);
    end;
    addnodetohistory(currentnode, optionind, prevnode);
    nodehistoryposition  := nodehistorysize - 1;
    form8.notesmemo.Text := '';
    if currentnode = -1 then
    begin
      if runtimedlgedit = False then
      begin
        messagedlg('Dialogue ends here.' + #13 + #10 + '' + #13 +
          #10 + '(Runtime dialogue editing = OFF)',
          mtInformation, [mbOK], 0);
        last_option := optionind;
        button2click(nil);
        nodelabel.Text := '';
        Inc(nodehistorysize);
        exit;
      end;
      form8.nodelabel.Caption := currentdlg.nodes[prevnode].options[optionind].nodelink;
      if form8.nodelabel.Caption = '' then
        form8.nodelabel.Caption := '<empty>';
      form8.notesmemo.Text := currentdlg.nodes[prevnode].options[optionind].notes;
      form8.button1.Caption := 'Edit node';
      if form8.nodelabel.Caption = 'combat' then
        form8.notesmemo.Text :=
          'This option triggers combat by setting the critter to hostile towards the player.';
      if (currentdlg.nodes[prevnode].options[optionind].nodelink <> 'done') and
        (currentdlg.nodes[prevnode].options[optionind].nodelink <> 'combat') then
      begin
        form8.button1.
          Enabled := True;
        if currentdlg.nodes[prevnode].options[optionind].nodelink = '' then
          form8.notesmemo.Text := 'The player option node link was null.';
      end else
      begin
        done_node := True;
        form8.notesmemo.Text :=
          'This is a pre-defined dialogue termination node and therefore it can''t be edited. Instead, you can edit the node you got here from. Dialogue will continue after updating.';
        form8.button1.Caption := 'Edit node';
      end;
      form8.showmodal;
      if form8.modalresult = mrCancel then
      begin
        currentnode := prevnode;
      end;
      if form8.modalresult = mrOk then
      begin
        form3.edit1.Text := currentdlg.nodes[prevnode].options[optionind].nodelink;
        if done_node = True then
          editnode(prevnode)
        else
          form2.button1click(nil);
        if (form3.modalresult = mrOk) and (done_node = False) then
        begin
          debugmsg(format('Updated node %s playeroption %d reference to %s.',
            [currentdlg.nodes[prevnode].nodename, optionind, globalnodename]));
          currentdlg.nodes
            [prevnode].options[optionind].nodelink := globalnodename;
        end;
        currentnode := getnodeindex(globalnodename);
        resolvenodes;
        refreshnodes;
        if currentnode = -1 then
        begin
          debugmsg(
            'Error: NodeIndex is still -1, can''t continue.');
          messagedlg('The node reference is still null, remaining in current node.',
            mtWarning, [mbOK], 0);
          currentnode := prevnode;
        end else
          nodeupdate;
      end;
      if done_node = False then
      begin
        memo1.Clear;
        memo2.Clear;
        listbox1.Clear;
        dlgrunning := False;
        button2.Enabled := False;
        button1.Enabled := True;
        button4.Enabled := False;
        button6.Visible := False;
        button5.Enabled := False;
        label5.Visible := False;
        nodelabel.Text := '';
      end;
    end else
    begin
      nodelabel.Text := currentdlg.nodes[currentnode].nodename;
      nodeupdate;
    end;
  end;
end;

procedure displaytranscript(ind: integer);
var
  t: integer;
begin
  trans_index := ind;
  debugmsg('Transcript index == ' + IntToStr(trans_index));
  form13.jvrichedit1.Clear;
  for t := 0 to dlgtranscripts[ind].linecnt - 1 do
  begin
    if pos('NPC', dlgtranscripts[ind].Lines[t]) <> 0 then
    begin
      form13.jvrichedit1.addformattext(currentdlg.npcname + ': ',
        [fsbold], 'Arial', $112211);
      form13.jvrichedit1.addformattext(copy(dlgtranscripts[ind].Lines[t],
        pos(':', dlgtranscripts[ind].Lines[t]) + 2,
        length(dlgtranscripts[ind].Lines[t])),
        [fsbold], 'Tahoma', $A20012);
    end else
    begin
      form13.jvrichedit1.addformattext(player.Name + ': ', [fsbold], 'Arial', $000000);
      form13.jvrichedit1.addformattext(copy(dlgtranscripts[ind].Lines[t],
        pos(':', dlgtranscripts[ind].Lines[t]) + 2,
        length(dlgtranscripts[ind].Lines[t])), [], 'Tahoma', $CA0021);
    end;
    form13.jvrichedit1.Lines.add('');
  end;
end;

procedure tform1.button2click(Sender: TObject);
var
  t: integer;
begin
  memo1.Clear;
  memo2.Clear;
  listbox1.Clear;
  if nodehistorysize > 0 then
  begin
    debugmsg('Setting node history -- on button2click');
    if last_option <> -1 then
      debugmsg('a player option of index: ' + IntToStr(last_option) +
        ' was selected when this was called.')
    else
      debugmsg('no player option was selected when this was called.');
    if last_option <> -1 then
    begin
    end else
      setnodehistory(nodehistorysize - 1, nodehistory[nodehistorysize - 1],
        -1, currentnode);
  end;
  button5.Enabled := False;
  button4.Enabled := False;
  button2.Enabled := False;
  button1.Enabled := True;
  label5.Visible  := False;
  hiddenopts.Caption := '';
  nodelabel.Visible := False;
  memo3.Clear;
  button6.Visible := False;
  generatenodehistoryandsave;
  setlength(nodehistory, 0);
  nodehistorysize := 0;
  if cfg.readbool('Global Config', 'ShowLastDialogue', True) = True then
  begin
    form13.Show;
    displaytranscript(dlgtranscriptcnt - 1);
  end;
  dlgrunning := False;
  requestpluginrefresh;
  nodelabel.Text := '';
  nodelabel.Visible := False;
end;

function getconds(opt: option): string;
var
  t: integer;
var
  condsstr: string;
begin
  condsstr := #13#10 + 'Conditions: ' + #13#10;
  for t := 0 to opt.conditioncnt - 1 do
  begin
    condsstr := condsstr + opt.conditions[t].resolved_code + #13#10;
  end;
  if opt.conditioncnt = 0 then
    condsstr :=
      '';
  Result := condsstr;
end;

procedure tform1.listbox1click(Sender: TObject);
var
  optind: integer;
begin
  if listbox1.selected <> nil then
  begin
    optind := StrToInt(listbox1.selected.Caption);
    if (dlgrunning = True) then
    begin
      if currentnode = -1 then
      begin
        debugmsg('NodeIndex = -1!');
        exit;
      end;
      if currentdlg.nodes[currentnode].options[optind].noderesolved <> -1 then
        memo2.Text := 'Leads to node ' +
          currentdlg.nodes[currentnode].options[optind].nodelink
      else if (currentdlg.nodes[currentnode].options[optind].noderesolved = -1) and
        (currentdlg.nodes[currentnode].options[optind].link_to_skillcheck = True) then
      begin
        memo2.Text := 'Linked to a skill check [see Dialogue Editor->Skill Checks->' +
          currentdlg.nodes[currentnode].options[optind].nodelink + ']';
      end else if (currentdlg.nodes[currentnode].options[optind].noderesolved = -1) and
        (currentdlg.nodes[currentnode].options[optind].link_to_proc = True) then
      begin
        memo2.Text := 'Linked to a custom procedure ' +
          currentdlg.nodes[currentnode].options[optind].nodelink + '.';
      end else if (currentdlg.nodes[currentnode].options[optind].nodelink <> 'done') and
        (currentdlg.nodes[currentnode].options[optind].nodelink <> 'combat') then
        memo2.Text := 'Unresolved node ' +
          currentdlg.nodes[currentnode].options[optind].nodelink
      else if (currentdlg.nodes[currentnode].options[optind].nodelink = 'done') then
        memo2.Text := 'This option will end the dialogue.'
      else if (currentdlg.nodes[currentnode].options[optind].nodelink = 'combat') then
        memo2.Text := 'This option will initiate combat.';
      memo2.Text := memo2.Text + #13#10 +
        currentdlg.nodes[currentnode].options[optind].notes +
        getconds(currentdlg.nodes[currentnode].options[optind]^);
    end;
  end;
end;

function savechangenotify: boolean;
var
  msgresult: integer;
begin
  Result := True;
  if dlgchanged = True then
  begin
    msgresult := messagedlg('Save changes to dialogue ''' + currentfile +
      '''' + #13 + #10 + 'before proceeding?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    if msgresult = mrYes then
    begin
      form1.savedialogue2click(form1);
    end else if msgresult = mrCancel then
      Result := False;
  end;
end;

procedure tform1.new1click(Sender: TObject);
begin
  if cfg.readbool('Global Config', 'Savenodehistory', True) = True then
    saveall1click(nil);
  dlgtranscriptcnt := 0;
  setlength(dlgtranscripts,
    0);
  form1.statusbar1.simpletext := '';
  if savechangenotify = False then
    exit;
  if dlgrunning = True then
    button2click(new1);
  form1.Caption := 'Fallout Dialogue Creator - [untitled]';
  currentdlg.nodecount := 0;
  currentfile := 'untitled';
  dlgchanged  := False;
  fillchar(currentdlg, sizeof(currentdlg), #0);
  refreshnodes;
  requestpluginrefresh;
  if currentdlg.nodecount > 0 then
  begin
    freedlgptrs;
  end;
end;

procedure SetOutputControl(ctrl: tcontrol); stdcall;
begin
  debugmsg('Getting output control, name == ' + ctrl.Name);
  outputwnd := TStringList.Create;
  outputwnd := TStrings(ctrl);
end;

procedure UnsetOutputControl; stdcall;
begin
  debugmsg('Releasing output control.');
  outputwnd.Free;
  outputwnd := nil;
end;

procedure ExecuteScriptLines(Data: PChar); stdcall;
begin
  form1.executescriptconsole(ansistring(Data));
end;

procedure tform1.npcproperties1click(Sender: TObject);
begin
  form9.npcname.Text := currentdlg.npcname;
  form9.npcloc.Text  := currentdlg.location;
  form9.npcnotes.Text := currentdlg.description;
  form9.npcunknowndesc.Text := currentdlg.unknowndesc;
  form9.npcknowndesc.Text := currentdlg.knowndesc;
  form9.npcdetailed.Text := currentdlg.detaileddesc;
  form9.showmodal;
  if form9.modalresult = mrOk then
  begin
    dialoguechangenotify;
    currentdlg.npcname  := form9.npcname.Text;
    currentdlg.location := form9.npcloc.Text;
    currentdlg.unknowndesc := form9.npcunknowndesc.Text;
    currentdlg.knowndesc := form9.npcknowndesc.Text;
    currentdlg.detaileddesc := form9.npcdetailed.Text;
    currentdlg.description := form9.npcnotes.Text;
    requestpluginrefresh;
  end;
end;

procedure tform1.dialoguetoolhelp1click(Sender: TObject);
begin
  executefile(getcurrentdir + '\doc\fmfdlgtool.chm', '', getcurrentdir +
    '\doc', sw_shownormal);
end;

procedure tform1.about1click(Sender: TObject);
var
  t: integer;
var
  version_str: string;
begin
  version_str := format('%d.%d.%d-%s', [version_major, version_minor,
    version_release, version_status]);
  form5.label1.Caption := format(form5.label1.Caption,
    [version_str, builddate, func_unit.functions.Count, plugincnt]);
  form5.listbox1.Clear;
  for t := 0 to plugincnt - 1 do
  begin
    ;
    form5.listbox1.items.add(extractfilename(dllplugins[t].filename));
  end;
{$IFDEF BETARELEASE}


    form5.Label4.Caption := 'Note: This is a beta release. This means that not everything has been thoroughly tested. If you encounter a bug, please report it on the Mantis site';


{$ENDIF}
  form5.Show;
end;

procedure SendDebugMSG(str: PChar); stdcall;
begin
  debugmsg(
    str, 'Plugin');
end;

procedure tform1.mxwebupdate1updateavailable(Sender: TObject;
  actualversion, newversion: string; var canupdate: boolean);
begin
  debugmsg('New version found: ' + newversion + ', Current=' + actualversion);
  canupdate := messagedlg(format(
    'There is a new version of FMF Dialogue tool available online. Current version is %s.'
    + #13 + #10 + '' + #13 + #10 + 'The new version is %s.' + #13 +
    #10 + 'Do you wish to download the update?', [actualversion, newversion]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure tform1.mxwebupdate1noupdatefound(Sender: TObject);
begin
  if checksilent = False then
    messagedlg('No updates found. The dialogue tool is up-to-date.',
      mtInformation, [mbOK], 0);
  debugmsg('No updates found.');
end;

procedure tform1.mxwebupdate1beforedownload(Sender: TObject; filename: string);
begin
  debugmsg('Downloading ' + filename);
  form6.label2.Caption := filename;
end;

procedure tform1.mxwebupdate1download(Sender: TObject; total, downloaded: integer);
begin
  if (downloaded < total) then
  begin
    form6.Show;
  end;
  form6.progressbar1.max := total;
  form6.progressbar1.position := downloaded;
  form6.label1.Caption := format('Downloaded %d bytes of %d bytes', [downloaded, total]);
  if downloaded = total then
    form6.hide;
end;

procedure tform1.mxwebupdate1afterdownload(Sender: TObject; filename: string);
begin
  debugmsg(filename + ' downloaded.');
end;

procedure tform1.mxwebupdate1beforeshowinfo(Sender: TObject;
  var showinfo, checkforupdate: boolean);
begin
  debugmsg('Request show info ...');
  showinfo := messagedlg('Do you wish to view the release notes?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
  if showinfo = True then
    debugmsg('Showing release notes.')
  else
    debugmsg('Skipping release notes.');
end;

procedure tform1.mxwebupdate1getclientfilename(Sender: TObject; var filename: string);
begin
  filename := getcurrentdir + '\downloads\' + extractfilename(filename);
  debugmsg('GetClientFilename => ' + filename);
end;

procedure tform1.mxwebupdate1clientfileexists(Sender: TObject;
  var filename: string; var overwrite: boolean);
begin
  overwrite := (messagedlg(format('File ''%s'' already exists. Overwrite?', [filename]),
    mtWarning, [mbYes, mbNo], 0) = mrYes);
end;

procedure nodeupdate;
begin
  last_option := -1;
  requestpluginrefresh;
  form1.memo1.Text := currentdlg.nodes[currentnode].npctext;
  if (currentdlg.nodes[currentnode].npctext_female <> '') and
    (player.gender = gender_female) then
    form1.memo1.Text := currentdlg.nodes[currentnode].npctext_female;
  form1.memo1.Text := stringreplace(form1.memo1.Text, '<PC>',
    player.Name, [rfreplaceall]);
  form1.memo1.Text := stringreplace(form1.memo1.Text, '${dude_name}',
    player.Name, [rfreplaceall]);
  getnodeplayeroptions;
  form1.memo3.Text := currentdlg.nodes[currentnode].notes;
  form1.nodelabel.Text := currentdlg.nodes[currentnode].nodename;
end;

procedure tform1.button4click(Sender: TObject);
begin
  if nodehistoryposition >= 0 then
  begin
    Dec(nodehistoryposition);
    currentnode := nodehistory[nodehistoryposition];
    button5.Enabled := True;
  end;
  if nodehistoryposition = 0 then
  begin
    button4.Enabled :=
      False;
  end;
  nodeupdate;
end;

procedure tform1.button5click(Sender: TObject);
begin
  if nodehistoryposition < nodehistorysize - 1 then
  begin
    Inc(nodehistoryposition);
    button4.Enabled := True;
    currentnode := nodehistory[nodehistoryposition];
    nodeupdate;
  end;
  if nodehistoryposition = nodehistorysize - 1 then
  begin
    button5.Enabled := False;
    exit;
  end;
end;

procedure tform1.savedialogue2click(Sender: TObject);
begin
  if currentfile <> 'untitled' then
  begin
    debugmsg('Current file == ' + currentfile);
    savedata(currentfile);
    savedialogue2.Enabled := False;
    dlgchanged := False;
  end else if currentfile = 'untitled' then
  begin
    savedialogue1click(savedialogue2);
  end;
end;

procedure tform1.loadscript(filename: string);
var
  t: integer;
var
  errorlist: string;
begin
  if not (fileexists(filename)) then
  begin
    debugmsg(filename + ' not found! at dir: ' + getcurrentdir);
    messagedlg(format('Error executing script %s:' + #13 + #10 + '' +
      #13 + #10 + 'File does not exist!', [filename]),
      mtError, [mbOK], 0);
    exit;
  end;
  debugmsg('ExecuteScript: ' + filename);
  scriptdata := TStringList.Create;
  scriptdata.loadfromfile(filename);
  currentprog := delphiwebscriptii1.compile(scriptdata.Text);
  currentprog.Execute;
  if currentprog.msgs.Count > 0 then
  begin
    if outputwnd = nil then
      errorlist := '[ExecuteScript]' + #13#10 + 'Script data has errors:';
    for t := 0 to currentprog.msgs.Count - 1 do
    begin
      if outputwnd = nil then
        errorlist := errorlist + #13#10 + currentprog.msgs[t].asinfo;
    end;
    if outputwnd <> nil then
    begin
      wndoutput('Error executing command. ' + IntToStr(currentprog.msgs.Count) +
        ' messages returned.');
    end else
      messagedlg(errorlist, mtError, [mbOK], 0);
  end;
  currentprog.Free;
  scriptdata.Free;
end;

procedure tform1.executescriptconsole(line: string);
var
  t: integer;
var
  errorlist: string;
begin
  scriptconsole := delphiwebscriptii1.compile(line);
  scriptconsole.Execute;
  if scriptconsole.msgs.Count > 0 then
  begin
    if outputwnd = nil then
      errorlist := '[ExecuteScriptConsole]' + #13#10 + 'Script data has errors:';
    for t := 0 to scriptconsole.msgs.Count - 1 do
    begin
      errorlist := errorlist + #13#10 + scriptconsole.msgs[t].asinfo;
    end;
    if outputwnd = nil then
      errorlist := errorlist + #13#10 + 'Source line was:' + #13#10 + line;
    if outputwnd <> nil then
    begin
      wndoutput('Error executing command: ' + errorlist);
    end else
      messagedlg(errorlist, mtError, [mbOK], 0);
  end;
  scriptconsole.Free;
end;

procedure tform1.formclosequery(Sender: TObject; var canclose: boolean);
var
  z, msgresult: integer;
  deinitresult: boolean;
begin
  if booting_up = True then
  begin
    messagedlg('Cannot close program while starting up!' + #13 + #10 +
      '' + #13 + #10 + '"Patience, young padawan..."',
      mtError, [mbOK], 0);
    canclose := False;
    exit;
  end;
  if cfg.readbool('Global Config', 'Savenodehistory', True) = True then
    saveall1click(nil);
  if dlgchanged = True then
  begin
    msgresult := messagedlg('Save changes to dialogue ''' + currentfile +
      '''' + #13 + #10 + 'before closing FMF Dialogue Tool?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgresult = mrYes then
    begin
      savedialogue2click(form1);
    end else
    if msgresult = mrCancel then
    begin
      canclose := False;
      exit;
    end;
  end;
  deinitresult := deinitpluginlib;
  if deinitresult = False then
  begin
    canclose := False;
    debugmsg('DeInit returned false, not going to continue.');
    exit;
  end else if deinitresult = True then
  begin
    debugmsg('Plugin lib deinit returned true.');
    canclose := True;
  end;
end;

procedure tform1.func_unitfunctionsaddnodeeval(info: tprograminfo);
var
  nodename: string;
  npctext: string;
  notes: string;
  npctextfemale: string;
begin
  nodename := info['nodename'];
  npctext := info['npctext'];
  npctextfemale := info['npctext_female'];
  notes := info['notes'];
  if getnodeindex(nodename) <> -1 then
  begin
    wndoutput('Error! Node ' + nodename + ' already exists!');
    exit;
  end;
  new(currentdlg.nodes[currentdlg.nodecount]);
  currentdlg.nodes[currentdlg.nodecount].npctext := npctext;
  currentdlg.nodes[currentdlg.nodecount].npctext_female := npctextfemale;
  currentdlg.nodes[currentdlg.nodecount].
    nodename := nodename;
  currentdlg.nodes[currentdlg.nodecount].notes := notes;
  currentdlg.nodes[currentdlg.nodecount].hidden := False;
  currentdlg.nodes[currentdlg.nodecount].optioncnt := 0;
  currentdlg.nodes[currentdlg.nodecount].skillcheckcnt := 0;
  if outputwnd <> nil then
    wndoutput('Added node "' + nodename + '"');
  Inc(currentdlg.nodecount);
  refreshnodes;
  requestpluginrefresh;
end;

procedure tform1.func_unitfunctionsaddplayeroptioneval(info: tprograminfo);
var
  destnodename: string;
  opttext: string;
  nodelink: string;
  notes: string;
  nodeind: integer;
begin
  destnodename := info['destnodename'];
  opttext := info['opttext'];
  nodelink := info['nodelink'];
  notes := info['notes'];
  nodeind := getnodeindex(destnodename);
  if nodeind = -1 then
  begin
    if outputwnd <> nil then
      wndoutput('Error: requested node "' + destnodename + '" does not exist!');
  end else
  begin
    new(currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt]);
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].conditioncnt
    := 0;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].optiontext :=
      opttext;
    currentdlg.nodes[nodeind].options
      [currentdlg.nodes[nodeind].optioncnt].link_to_proc := False;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].
      link_to_skillcheck := False;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].nodelink :=
      nodelink;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].notes :=
      notes;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].reaction :=
      reaction_neutral;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].genderflags :=
      gender_none;
    currentdlg.nodes[nodeind].options[currentdlg.nodes[nodeind].optioncnt].intcheck := 4;
    Inc(currentdlg.nodes[nodeind].optioncnt);
    resolvenodes;
    requestpluginrefresh;
  end;
end;

procedure tform1.button6click(Sender: TObject);
begin
  if dlgrunning = False then
  begin
    messagedlg('Dialogue is not running,' + #13 + #10 +
      'use ''Edit dialogue'' instead.', mtWarning, [mbOK], 0);
  end else
  begin
    editnode(currentnode);
    resolvenodes;
    refreshnodes;
    nodeupdate;
    requestpluginrefresh;
  end;
end;

procedure tform1.mxwebupdate1downloaderror(Sender: TObject);
begin

  messagedlg('Error while downloading update!', mtError, [mbOK], 0);
end;

procedure tform1.fmf1error(Sender: TObject; error: tcocoerror);
var
  s: TStrings;
  errordata: string;
begin
  s := TStringList.Create;
  s.loadfromfile(fmf1.sourcefilename);
  if error.line > s.Count then
    errordata := 'Null line. (Probably end of file?)'
  else
    errordata := s[error.line - 1];
  debugmsg('Linecount: ' + IntToStr(s.Count));
  zerrorstr := zerrorstr + format('Error on line %d column %d:' +
    #13 + #10 + '%s' + #13 + #10 + '%s', [error.line, error.col,
    fmf1.errorstr(error.errorcode, ''), errordata]);
  s.Free;
end;

procedure tform1.mxwebupdate1aftershowinfo(Sender: TObject; checkforupdate: boolean);
begin
  cfg.writebool('Global Config', 'Check for updates at startup',
    checkforupdatesatstartup);
end;

procedure tform1.func_unitfunctionssetnodenameeval(info: tprograminfo);
var
  x, j, i: integer;
begin
  i := getnodeindex(info['Oldname']);
  if i <> -1 then
  begin
    currentdlg.nodes[i].nodename := info['Newname'];
    wndoutput('Renamed ' + info['Oldname'] + ' to ' + info['Newname']);
    remapnodes(info['Oldname'], info['Newname']);
    requestpluginrefresh;
  end;
end;

procedure tform1.func_unitfunctionsrefreshalleval(info: tprograminfo);
begin
  refreshnodes;
  resolvenodes;
end;

procedure tform1.func_unitfunctionssetplayeroptionlinkeval(info: tprograminfo);
var
  nodeind, optind: integer;
  newdata: string;
begin
  nodeind := info['Nodeindex'];
  optind  := info['OptionIndex'];
  newdata := info['Newdata'];
  currentdlg.nodes
    [nodeind].options[optind].nodelink := newdata;
  requestpluginrefresh;
end;

procedure tform1.func_unitfunctionsmovenodelinktonoteseval(info: tprograminfo);
var
  nodeind, optind: integer;
  newdata: string;
begin
  nodeind := info['Nodeindex'];
  optind  := info['OptionIndex'];
  newdata := info['Newdata'];
  currentdlg.nodes[nodeind].options[optind].nodelink := newdata;
  requestpluginrefresh;
end;

procedure tform1.dumpscriptcommands1click(Sender: TObject);
var
  f: integer;
  str: string;
  t: textfile;
begin
  str := '';
  str := 'funccnt=' + IntToStr(func_unit.functions.Count) + #13#10;
  funcdesc.writeinteger('Main', 'ClassCnt', dws2classeslib1.dws2unit.Classes.Count);
  for f := 0 to dws2classeslib1.dws2unit.Classes.Count - 1 do
  begin
    if (funcdesc.readstring('Main', 'Class' + IntToStr(f + 1), '') = '') then
    begin
      funcdesc.writestring('Main', 'Class' + IntToStr(f + 1),
        dws2classeslib1.dws2unit.Classes.items[f].Name);
      debugmsg('Dumped class ' + dws2classeslib1.dws2unit.Classes.items[f].Name);
    end else
      debugmsg('CLASS: ' + dws2classeslib1.dws2unit.Classes.items[f].Name +
        ' already exists.');
  end;
  for f := 0 to dws2classeslib1.dws2unit.Classes.Count - 1 do
  begin
    if (funcdesc.readstring('Classes', dws2classeslib1.dws2unit.Classes.items[f].Name,
      '') = '') then
    begin
      funcdesc.writestring('Classes', dws2classeslib1.dws2unit.Classes.items[f].Name,
        dws2classeslib1.dws2unit.Classes.items[f].displayname +
        '\n\n<insert description here>');
      debugmsg(
        'Dumped funcdesc ' + dws2classeslib1.dws2unit.Classes.items[f].Name);
    end;
  end;
  funcdesc.writeinteger('Main', 'funccnt', func_unit.functions.Count);
  for f := 0 to func_unit.functions.Count - 1 do
  begin
    if (funcdesc.readstring('Main', 'Func' + IntToStr(f + 1), '') = '') then
    begin
      funcdesc.writestring('Main', 'Func' + IntToStr(f + 1),
        func_unit.functions.items[f].Name);
      debugmsg('Dumped func ' + func_unit.functions.items[f].Name);
    end else
    begin
      ;
      debugmsg('FUNC: ' + func_unit.functions.items[f].Name + ' already exists.');
    end;
  end;
  for f := 0 to func_unit.functions.Count - 1 do
  begin
    funcdesc.writestring('Functions', func_unit.functions.items[f].Name +
      '_decl', func_unit.functions.items[f].displayname);
    if (funcdesc.readstring('Functions', func_unit.functions.items[f].Name,
      '') = '') then
    begin
      funcdesc.writestring('Functions', func_unit.functions.items[f].Name,
        func_unit.functions.items[f].displayname + '\n\n<insert description here>');
      debugmsg('Dumped funcdesc ' + func_unit.functions.items[f].Name);
    end;
  end;
end;

procedure tform1.func_unitfunctionsgetcurrentnodeeval(info: tprograminfo);
begin
  if dlgrunning = True then
    info['result'] := currentdlg.nodes[currentnode].nodename
  else
    info['result'] := 'ERROR';
  wndoutput('CurrentNode: ' + info['result']);
end;

procedure tform1.func_unitfunctionssetcurrentnodeeval(info: tprograminfo);
begin
  if dlgrunning = True then
  begin
    currentnode := getnodeindex(info['name']);
    if currentnode <> -1 then
    begin
      nodeupdate;
      wndoutput('Current node set to ' + info['name']);
    end;
  end;
end;

procedure tform1.preferences1click(Sender: TObject);
var
  n: integer;
begin
  form10.runtimedlgedit.Checked :=
    cfg.readbool('Global Config', 'RuntimeDLGEditing', False);
  form10.last_trans.Checked := cfg.readbool('Global Config', 'ShowLastDialogue', True);
  form10.jvdirectoryedit3.Text := cfg.readstring('Global Config', 'HeadersPath', '');
  form10.checkbox2.Checked := evalskillchecks;
  form10.jvdirectoryedit4.Text := cfg.readstring('Global Config', 'FO2Basepath', '');
  form10.autonodemap.Checked := autonodemap;
  form10.checkupdates.Checked := checkforupdatesatstartup;
  form10.compwarn.Checked := cfg.readbool('Global Config',
    'PluginCompatibilityWarnings', False);
  form10.jvdirectoryedit1.Text := cfg.readstring('Global Config', 'DefaultSSLPath', '');
  form10.jvdirectoryedit2.Text := cfg.readstring('Global Config', 'DefaultMSGPath', '');
  form10.evalcond.Checked := cfg.readbool('Dialogue Engine', 'EvaluateConditions', True);
  form10.fo2datapath.Text := cfg.readstring('Global Config', 'FO2DataPath', '');
  form10.savenodehist.Checked := cfg.readbool('Global Config', 'Savenodehistory', False);
  form10.edit1.Text := cfg.readstring('Global Config', 'ClonedNodeFormatString',
    'Copy_of_%s');
  form10.debug.Checked := cfg.readbool('Global Config', 'Debugmode', False);
  form10.updown1.position := cfg.readinteger('Global Config',
    'DefaultIntForSmartPlayer', 4);
  form10.updown2.position := cfg.readinteger('Global Config',
    'DefaultIntForDumbPlayer', -3);
  form10.skillsimulations.Value := numskillsimulations;
  form10.jvspinedit1.Value :=
    (cfg.readinteger('Global Config', 'AutoSaveInterval', 300000) div 60) div 1000;
  form10.checkbox3.Checked := timer1.Enabled;
  form10.listbox1.Clear;
  for n := 0 to tempscnt - 1 do
  begin
    form10.listbox1.items.add(templatescripts[n].description + ': (' +
      templatescripts[n].category + ')');
  end;
  form10.neutralcolor.colorvalue := neutral_col;
  form10.goodcolor.colorvalue := good_col;
  form10.badcolor.colorvalue  := bad_col;
  form10.dumbcolor.colorvalue := dumb_col;
  form10.dumboptcolormode.Checked := dumbcolmode;
  form10.showmodal;
  dlgeval :=
    form10.evalcond.Checked;
  runtimedlgedit := form10.runtimedlgedit.Checked;
  debugmsg('Reloading global vars...');
  fo2datapath := cfg.readstring('Global Config', 'FO2DataPath', '');
  gvarparser  := tgvarparse.Create(form1);
  if fileexists(fo2datapath + '\data\VAULT13.GAM') then
  begin
    gvarparser.sourcefilename := fo2datapath + '\data\VAULT13.GAM';
    gvarparser.Execute;
    if gvarparser.successful = True then
    begin
      debugmsg('Successfully parsed ' + IntToStr(gvarcount) + ' variables.');
    end;
  end;
  timer1.Enabled := cfg.readbool('Global Config', 'AutoSave', False);
  timer1.interval := cfg.readinteger('Global Config', 'AutoSaveInterVal', 300000);
  dumbcolmode := form10.dumboptcolormode.Checked;
  evalskillchecks := form10.checkbox2.Checked;
end;

procedure tform1.func_unitfunctionsgetsslpatheval(info: tprograminfo);
begin
  info['result'] :=
    cfg.readstring('Global Config', 'DefaultSSLPath', '');
  wndoutput('SSL Path = ' + info['result']);
end;

procedure tform1.func_unitfunctionsgetmsgpatheval(info: tprograminfo);
begin
  info['result'] := cfg.readstring('Global Config', 'DefaultMSGPath', '');
  wndoutput('MSG Path = ' + info['result']);
end;

procedure tform1.func_unitfunctionsdebugmsgeval(info: tprograminfo);
begin
  debugmsg(info['message']);
end;

procedure tform1.func_unitfunctionseditnodeeval(info: tprograminfo);
var
  s: integer;
begin
  wndoutput('Launching editnode on ' + info['node']);
  s := getnodeindex(info['node']);
  if s = -1 then
  begin
    messagedlg('Node ' + info['node'] + ' not found!', mtWarning, [mbOK], 0);
  end else
  begin
    editnode(s);
    resolvenodes;
    refreshnodes;
    requestpluginrefresh;
  end;
end;

procedure tform1.editfunctiondescriptions1click(Sender: TObject);
var
  t: integer;
begin
  with form12.listbox1.items do
  begin
    Clear;
    for t := 0
      to funcdesc.readinteger('Main', 'funccnt', 0) - 1 do
      add(funcdesc.readstring('Main', 'Func' + IntToStr(t + 1), ''));
  end;
  form12.showmodal;
end;

procedure tform1.func_unitfunctionssaveconfirmeval(info: tprograminfo);
begin
  if (savechangenotify = True) then
    info['result'] := True
  else
    info['result'] := False;
end;

function tform1.xahelprouter1help(command: word; Data: integer;
  var callhelp: boolean): boolean;
begin
  debugmsg('OnHelp: ' + IntToStr(command) + ' Data: ' + IntToStr(Data));
  callhelp := True;
end;

procedure wndoutput(str: string);
begin
  if outputwnd = nil then
    exit;
  str := stringreplace(str, '\n', #13#10, [rfreplaceall]);
  TMemo(outputwnd).Lines.add(str);
end;

function dospace(start: integer; stop: integer): string;
var
  t: integer;
begin
  Result := '';
  for t := start to stop do
    Result := Result + ' ';
end;

procedure tform1.func_unitfunctionshelpeval(info: tprograminfo);
var
  cnt, t: integer;
var
  func_col1, func_col2, func_col3, func_col4: string;
begin
  if outputwnd <> nil then
  begin
    wndoutput('Valid script commands are:');
    wndoutput('');
    cnt := funcdesc.readinteger('Main', 'funccnt', 0);
    t := 0;
    while t < cnt + 3 do
    begin
      func_col1 := funcdesc.readstring('Main', 'Func' + IntToStr(t + 1), '');
      func_col2 := funcdesc.readstring('Main', 'Func' + IntToStr(t + 2), '');
      func_col3 := funcdesc.readstring('Main', 'Func' + IntToStr(t + 3), '');
      wndoutput(func_col1 + dospace(length(func_col1), 28) + func_col2 +
        dospace(length(func_col2), 28) + func_col3 + dospace(length(func_col3), 20));
      Inc(t, 3);
    end;
    wndoutput('Type "help <command>" to get more help on a specific command.');
  end;
end;

procedure tform1.func_unitfunctionsprinteval(info: tprograminfo);
begin
  if outputwnd <> nil then
  begin
    wndoutput(info['text']);
  end else
  begin
    debugmsg('Print: ' + info['text']);
  end;
end;

procedure tform1.func_unitfunctionsgethelpeval(info: tprograminfo);
begin
  if outputwnd <> nil then
  begin
    if funcdesc.readstring('Functions', info['cmd'], '') <> '' then
    begin
      wndoutput('Syntax: ' + funcdesc.readstring('Functions', info['cmd'] +
        '_decl', ''));
      wndoutput('');
      wndoutput(funcdesc.readstring('Functions', info['cmd'], ''));
    end else
      wndoutput('Unknown command ' + info['cmd']);
  end;
end;

procedure tform1.func_unitfunctionslistnodeseval(info: tprograminfo);
var
  t: integer;
begin
  if currentdlg.nodecount = 0 then
  begin
    wndoutput('No nodes in dialogue.');
  end else
  begin
    wndoutput('Dialogue has ' + IntToStr(currentdlg.nodecount) + ' nodes:');
    wndoutput('');
    for t := 0
      to currentdlg.nodecount - 1 do
    begin
      wndoutput(currentdlg.nodes[t].nodename + ': ' +
        IntToStr(currentdlg.nodes[t].optioncnt) + ' player options.');
    end;
  end;
end;

procedure tform1.
func_unitfunctionsshownodeeval(info: tprograminfo);
var
  s, ind: integer;
var
  node: dlgnode;
begin
  ind := getnodeindex(info['name']);
  if ind = -1 then
    wndoutput('Node "' + info['name'] + '" not found!')
  else
  begin
    node := currentdlg.nodes[ind]^;
    wndoutput('Node info for ' + node.nodename + ':\nNPC Default:' + node.npctext);
    if node.npctext_female <> '' then
      wndoutput('NPC (pc=female): ' + node.npctext_female);
    if node.notes <> '' then
      wndoutput('Notes for the node:\n' + node.notes);
    if node.optioncnt > 0 then
    begin
      wndoutput('Player options (' + IntToStr(node.optioncnt) + '):\n');
      for s := 0 to node.optioncnt - 1 do
        wndoutput(IntToStr(s + 1) + ': ' + node.options[s].optiontext +
          ' -> ' + node.options[s].nodelink);
    end;
  end;
end;

procedure tform1.func_unitfunctionsshowconstantseval(info: tprograminfo);
var
  t: integer;
begin
  wndoutput('Valid constants to use in scripts/console commands:\n');
  for t := 0 to func_unit.constants.Count - 1 do
  begin
    wndoutput(func_unit.constants.items[t].displayname);
  end;
end;

procedure tform1.func_unitfunctionsshowdialogglobalseval(info: tprograminfo);
begin
  wndoutput('Dialogue globals for "' + currentdlg.filename + '"\n');
  wndoutput('NPC Name:               ' + currentdlg.npcname);
  wndoutput('Location:               ' + currentdlg.location);
  wndoutput('Description:            ' + currentdlg.description + '\n');
  wndoutput('look_p_proc(unknown):   ' + currentdlg.unknowndesc);
  wndoutput('look_p_proc(known):     ' + currentdlg.knowndesc);
  wndoutput('description_p_proc:     ' + currentdlg.detaileddesc);
  wndoutput('\nNumber of nodes:      ' + IntToStr(currentdlg.nodecount));
end;

procedure tform1.func_unitfunctionsstartplugineval(info: tprograminfo);
begin
  executeplugin(info['name']);
end;

procedure tform1.func_unitfunctionslistpluginseval(info: tprograminfo);
var
  t: integer;
begin
  wndoutput('Valid plugins:');
  for t := 0 to plugincnt - 1 do
  begin
    wndoutput(IntToStr(t + 1) + ': ' + dllplugins[t].filename + ' (' +
      dllplugins[t].displayname + ')\nInterface Version: ' +
      dllplugins[t].interfaceversion + '\nBuild date:    ' +
      datetimetostr(dllplugins[t].builddate) + '\nCreation date: ' +
      datetimetostr(dllplugins[t].creationdate) + '\n' + dllplugins[t].longdesc + '\n');
    if getmodulehandle(PChar(dllplugins[t].filename)) <> 0 then
      wndoutput(' >> Plugin is currently loaded into memory\n');
  end;
end;

function GetProgramVer: shortstring; stdcall;
var
  version_str: string;
begin
  version_str := format('%d.%d.%d-%s', [version_major, version_minor,
    version_release, version_status]);
  Result := version_str;
end;

procedure tform1.func_unitfunctionsgetprogramversioneval(info: tprograminfo);
var
  version_str: string;
begin
  version_str := format('%d.%d.%d-%s', [version_major, version_minor,
    version_release, version_status]);
  wndoutput('FMF Dialogue tool ' + version_str + ', Compiled on [' + builddate + ']');
end;

procedure tform1.func_unitfunctionssetdialogglobalseval(info: tprograminfo);
var
  field: integer;
var
  Data:  string;
begin
  field := info['field'];
  Data  := info['data'];
  case field of
    field_npc_name:
    begin
      wndoutput('SetDialogGlobals: Changed npc name to ' + Data);
      currentdlg.npcname := Data;
    end;
    field_npc_location:
    begin
      wndoutput('SetDialogGlobals: Changed npc location to ' + Data);
      currentdlg.location := Data;
    end;
    field_npc_description:
    begin
      wndoutput('SetDialogGlobals: Changed npc description to ' + Data);
      currentdlg.description := Data;
    end;
    field_npc_unknown_look:
    begin
      wndoutput('SetDialogGlobals: Changed npc unknown_look_desc to ' + Data);
      currentdlg.unknowndesc := Data;
    end;
    field_npc_known_look:
    begin
      wndoutput('SetDialogGlobals: Changed npc known_look_desc to ' + Data);
      currentdlg.knowndesc := Data;
    end;
    field_npc_detailed_look:
    begin
      wndoutput('SetDialogGlobals: Changed npc description_p_proc message to ' + Data);
      currentdlg.detaileddesc := Data;
    end;
    else
    begin
      wndoutput('Unknown field: ' + IntToStr(field));
    end;
  end;
  wndoutput('Requesting plugins to refresh data.');
  requestpluginrefresh;
end;

procedure tform1.func_unitfunctionssavedialogueeval(info: tprograminfo);
begin
  savedata(info['filename']);
  wndoutput('Dialogue saved to ' + info['filename']);
  form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + ']';
end;

procedure tform1.func_unitfunctionsloaddialogueeval(info: tprograminfo);
var
  thefile: string;
begin
  thefile := info['filename'];
  zerrorstr :=
    '';
  currentdlg.npcname := '';
  currentdlg.description := '';
  currentdlg.location := '';
  currentdlg.unknowndesc := '';
  currentdlg.knowndesc := '';
  currentdlg.detaileddesc := '';
  debugmsg('Attempting to load ' + thefile);
  fmf1.sourcefilename := thefile;
  fmf1.Execute;
  if fmf1.successful = True then
  begin
    currentdlg.filename := thefile;
    debugmsg('Successful load of ' + thefile);
    wndoutput(thefile + ' loaded.');
    if currentdlg.nodecount > 0 then
    begin
      debugmsg('Node count = ' + IntToStr(currentdlg.nodecount));
      refreshnodes;
      resolvenodes;
    end else
    begin
      messagedlg('Warning! No nodes found in dialogue.', mtWarning, [mbOK], 0);
    end;
    form1.Caption := 'Fallout Dialogue Creator - [' + thefile + ']';
    form1.statusbar1.simpletext :=
      'Dialogue ' + thefile + ', ' + IntToStr(currentdlg.nodecount) + ' nodes';
    currentfile := thefile;
  end;
end;

procedure tform1.func_unitfunctionsshowcurrentdireval(info: tprograminfo);
begin
  wndoutput('Current directory is "' + getcurrentdir + '"');
end;

procedure tform1.func_unitfunctionsrundialogueeval(info: tprograminfo);
var
  t: integer;
begin
  t := getnodeindex(info['node']);
  if t <> -1 then
  begin
    wndoutput('Dialogue started.');
    combobox1.ItemIndex := t;
    button1click(nil);
  end;
end;

procedure tform1.func_unitfunctionsstopdialogueeval(info: tprograminfo);
begin
  if dlgrunning = True then
  begin
    wndoutput('Dialogue stopped.');
    button2click(nil);
  end;
end;

procedure tform1.func_unitfunctionsshownodehistoryeval(info: tprograminfo);
var
  s: integer;
begin
  if nodehistorysize = 0 then
    wndoutput('Nodehistory is empty.')
  else
  begin
    wndoutput(IntToStr(nodehistorysize) + ' entries in history.');
    for s := 0
      to nodehistorysize - 1 do
    begin
      if nodehistoryoption[s] <> -1 then
        wndoutput(format('Entry %0.3d %s\nNPC: %s\nPlayer: %s -> %s\n\n',
          [s + 1, currentdlg.nodes[nodehistory[s]].nodename,
          currentdlg.nodes[nodehistory[s]].npctext,
          currentdlg.nodes[nodehistorypreviousnode[s]].options[nodehistoryoption[s]].optiontext, currentdlg.nodes[nodehistorypreviousnode[s]].options[nodehistoryoption[s]].nodelink]))
      else
        wndoutput(format('Entry %0.3d %s\nNPC: %s\n',
          [s + 1, currentdlg.nodes[nodehistory[s]].nodename,
          currentdlg.nodes[nodehistory[s]].npctext]));
    end;
  end;
end;

procedure tform1.func_unitfunctionsisdialoguerunningeval(info: tprograminfo);
begin
  info['result'] := dlgrunning;
  if dlgrunning = True then
    wndoutput('IsDialogueRunning: TRUE')
  else
    wndoutput('IsDialogueRunning: FALSE');
end;

procedure tform1.func_unitfunctionslisttranscriptseval(info: tprograminfo);
var
  t: integer;
begin
  if dlgtranscriptcnt > 0 then
  begin
    wndoutput(IntToStr(dlgtranscriptcnt) + ' dialogue transcript(s) available:\n');
    wndoutput('Use the number denoted by # to access the transcript with the ShowTranscript command.\n');
    for t := 0 to dlgtranscriptcnt - 1 do
    begin
      wndoutput('#' + IntToStr(t) + ' ' + dlgtranscripts[t].npcname +
        ' [' + dlgtranscripts[t].dlgname + '] ' + datetimetostr(dlgtranscripts[t].date) +
        ' Lines: ' + IntToStr(dlgtranscripts[t].linecnt));
    end;
  end else
    wndoutput('No transcripts recorded.');
end;

procedure tform1.func_unitfunctionsshowtranscripteval(info: tprograminfo);
var
  ind: integer;
var
  z: integer;
begin
  ind := info['num'];
  if ind > dlgtranscriptcnt then
  begin
    ;
    wndoutput('Transcript out of range. (max = ' + IntToStr(dlgtranscriptcnt - 1) + ')');
  end
  else
  begin
    for z := 0 to dlgtranscripts[ind].linecnt - 1 do
    begin
      wndoutput(dlgtranscripts[ind].Lines[z]);
    end;
  end;
end;

procedure tform1.func_unitfunctionsclseval(info: tprograminfo);
begin
  if outputwnd <> nil then
    TMemo(outputwnd).Lines.Clear;
end;

procedure tform1.
func_unitfunctionsflushdialogueeval(info: tprograminfo);
begin
  wndoutput('Flushing dialogue table.');
  if dlgrunning = True then
    button2click(new1);
  form1.Caption := 'Fallout Dialogue Creator - [untitled]';
  if currentdlg.nodecount > 0 then
  begin
    freedlgptrs;
  end;
  currentdlg.nodecount := 0;
  currentfile := 'untitled';
  dlgchanged  := False;
  fillchar(currentdlg, sizeof(currentdlg), #0);
  refreshnodes;
  requestpluginrefresh;
  statusbar1.simpletext := '';
  wndoutput('Finished.');
end;

procedure tform1.func_unitfunctionscdeval(info: tprograminfo);
begin
  if directoryexists(info['path']) then
  begin
    chdir(info['path']);
    wndoutput('Path is now: ' + getcurrentdir);
  end else
    wndoutput(info['path'] + ': no such directory.');
end;

procedure tform1.func_unitfunctionsdireval(info: tprograminfo);
var
  files: TStrings;
var
  g: integer;
begin
  files := TStringList.Create;
  advbuildfilelist(getcurrentdir + '\*.*', faanyfile, files, amany);
  for g := 0 to files.Count - 1 do
    wndoutput(files[g]);
end;

procedure tform1.showtranscriptlist1click(Sender: TObject);
var
  t: tlistitem;
  x: integer;
begin
  form14.listview1.Clear;
  for x := 0 to dlgtranscriptcnt - 1 do
  begin
    t := form14.listview1.items.add;
    t.Caption := IntToStr(x + 1);
    t.subitems.add(dlgtranscripts[x].npcname);
    t.subitems.add(datetimetostr(dlgtranscripts[x].date));
    t.subitems.add(dlgtranscripts[x].histname);
  end;
  form14.Show;
end;

procedure tform1.
saveall1click(Sender: TObject);
var
  z, t: integer;
var
  s: textfile;
begin
  if dlgtranscriptcnt > 0 then
  begin
    if directoryexists(extractfiledir(ParamStr(0)) + '\dialogue\history') = False then
    begin
      debugmsg('History folder "' + extractfiledir(ParamStr(0)) +
        '\dialogue\history' + '" did not exist, creating.');
      mkdir(extractfiledir(ParamStr(0)) + '\dialogue\history');
    end;
    for t := 0 to dlgtranscriptcnt - 1 do
    begin
      debugmsg('Saving history ' + dlgtranscripts[t].histname);
      try
        assignfile(s, dlgtranscripts[t].histname);
        rewrite(s);
        for z := 0 to
          dlgtranscripts[t].linecnt - 1 do
        begin
          dlgtranscripts[t].Lines[z] :=
            stringreplace(dlgtranscripts[t].Lines[z], 'Player',
            player.Name, [rfreplaceall]);
          dlgtranscripts[t].Lines[z] :=
            stringreplace(dlgtranscripts[t].Lines[z], 'NPC',
            currentdlg.npcname, [rfreplaceall]);
          writeln(s, dlgtranscripts[t].Lines[z]);
        end;
        closefile(s);
      except
        on e: Exception do
        begin
          messagedlg(format('Error while saving dialog transcript #%d:' +
            #13 + #10 + '' + #13 + #10 + '%s' + #13 + #10 + '' + #13 +
            #10 + 'Filename: %s', [z + 1, e.message, dlgtranscripts[t].histname]),
            mtWarning, [mbOK],
            0);
        end;
      end;
    end;
  end;
end;

procedure tform1.func_unitfunctionssavedialogtranscriptseval(info: tprograminfo);
begin
  wndoutput('Saving dialog transcripts...');
  if dlgtranscriptcnt = 0 then
  begin
    wndoutput('No transcripts recorded.');
    exit;
  end;
  saveall1click(nil);
  wndoutput('Dialog transcript save complete.');
end;

procedure tform1.sortnodes(info: tprograminfo);
begin
  donodesort;
end;

function getfunctionindexbyname(Name: string): integer;
var
  t: integer;
begin
  for t := 0 to form1.func_unit.functions.Count - 1 do
  begin
    ;
    if (Name = form1.func_unit.functions.items[t].Name) then
    begin
      Result := t;
      exit;
    end;
  end;
end;

procedure tform1.func_unitfunctionsdumphelptohtmleval(info: tprograminfo);
var
  f, i, cnt, t: integer;
  x: textfile;
  Data: TStrings;
  datanames: TStringList;
  pas_output: TStrings;
  temp, Lines: string;
  fullrows: integer;
  lastrow: integer;
  commands: string;
  func_col1, func_col2: string;
begin
  wndoutput('Dumping ScriptCommands.html');
  cnt := funcdesc.readinteger('Main', 'funccnt', 0);
  t := 0;
  Data := TStringList.Create;
  pas_output := TStringList.Create;
  pas_output.add('{*-----------------------------------------------');
  pas_output.add(' Summary');
  pas_output.add(' DelphiWebScript functions documentation');
  pas_output.add('');
  pas_output.add(' @author djunique [Generated by the dialogue tool]');
  pas_output.add(' Description');
  pas_output.add(' This file contains detailed information about each');
  pas_output.add(' built-in function in the dialogue tool.');
  pas_output.add(' These are the functions that can be used in helper scripts');
  pas_output.add('-----------------------------------------------}');
  pas_output.add('unit DWSFunctions;');
  pas_output.add('');
  pas_output.add('interface');
  pas_output.
    add('');
  Data.loadfromfile(extractfiledir(ParamStr(0)) + '\html\funchelptemplate.htm');
  datanames := TStringList.Create;
  commands  := '';
  for t := 0 to cnt - 1 do
  begin
    temp := funcdesc.readstring('Main', 'Func' + IntToStr(t + 1), '');
    datanames.add(temp);
  end;
  datanames.sorted := True;
  commands :=
    '<table class="funclist" width="100%"  border="1" cellspacing="1" cellpadding="4">\n';
  fullrows := datanames.Count div 4;
  lastrow := datanames.Count mod 4;
  t := 0;
  while t < (fullrows * 4) - 1 do
  begin
    commands := commands + '<tr><td><a href="ScriptFunctions.html#' +
      datanames[t] + '">' + datanames[t] + '</a></td>\n' +
      '<td><a href="ScriptFunctions.html#' + datanames[t + 1] + '">' +
      datanames[t + 1] + '</a></td>\n' + '<td><a href="ScriptFunctions.html#' +
      datanames[t + 2] + '">' + datanames[t + 2] + '</a></td>\n' +
      '<td><a href="ScriptFunctions.html#' + datanames[t + 3] + '">' +
      datanames[t + 3] + '</a></td>\n' + '</tr>\n';
    Inc(t, 4);
  end;
  commands := commands + '<tr>';
  while t < (fullrows * 4) + lastrow do
  begin
    commands := commands + '<td><a href="ScriptFunctions.html#' +
      datanames[t] + '">' + datanames[t] + '</a></td>\n';
    Inc(t);
  end;
  commands := commands + '<tr>\n';
  commands := commands + '\n' + '</table>\n';
  for t := 0 to datanames.Count - 1 do
  begin
    func_col1 := datanames[t];
    func_col2 := funcdesc.readstring('Functions', func_col1, '');
    pas_output.add('{');
    pas_output.add('');
    pas_output.add('Description');
    temp := func_col2;
    temp :=
      stringreplace(func_col2, '\n', #13#10, [rfreplaceall]);
    pas_output.add(temp);
    pas_output.add('');
    f := getfunctionindexbyname(func_col1);
    pas_output.add('}');
    pas_output.add(
      '');
    pas_output.add(funcdesc.readstring('Functions', func_col1 + '_decl', ''));
    pas_output.add('');
    func_col2 := stringreplace(func_col2, '\n', '<br>', [rfreplaceall]);
    func_col2 := stringreplace(func_col2, 'procedure', '<b>procedure</b>', []);
    func_col2 := stringreplace(func_col2, 'function', '<b>function</b>', []);
    func_col2 := stringreplace(func_col2, 'NOTE:', '<span class="note">NOTE:</span>',
      [rfreplaceall]);
    func_col2 := stringreplace(func_col2, ' : ', ': ', [rfreplaceall]);
    func_col2 := stringreplace(func_col2, ' String;', '<b> string</b>;', [rfreplaceall]);
    func_col2 := stringreplace(func_col2, ' String)', '<b> string</b>)', [rfreplaceall]);
    func_col2 := stringreplace(func_col2, 'var', '<b>var</b>', [rfreplaceall]);
    Lines := Lines + '<a name="' + func_col1 + '"></a><p class="funcname">' +
      func_col1 + '</p>' + #13#10 +
      '<p class="funcdesc"> [ <a href="ScriptFunctions.html#index">Back to index</a> ] <br><br>'
      + ' ' + funcdesc.readstring('Functions', func_col1 + '_decl', '') +
      '<br><br> ' + func_col2 + '</p>' + #13#10;
  end;
  pas_output.add('');
  pas_output.add('implementation');
  pas_output.
    add('');
  pas_output.add('end.');
  pas_output.savetofile('DWSFunctions_NEW.pas');
  Data.Text := stringreplace(Data.Text, '%%InsertIndexHere%%', commands, [rfreplaceall]);
  Data.Text := stringreplace(Data.Text, '%%InsertFunctionsHere%%',
    Lines, [rfreplaceall]);
  Data.Text := stringreplace(Data.Text, '\n', #13#10, [rfreplaceall]);
  Data.savetofile('doc\ScriptFunctions.html');
  wndoutput('All done. ' + IntToStr(cnt) + ' command(s) in list. Lines dumped: ' +
    IntToStr(Data.Count));
  datanames.Free;
  Data.Free;
end;

 // This function does nothing
 // The original idea wsas trying to have a link between the FMFDLG executable
 // and an external program but it just didn't work out

 // reading up on this at the moment
 // perhaps I'll get this working
procedure doexternalregister(appname: PChar; Name: PChar; desc: PChar;
  interfacever: shortstring); stdcall;
begin
  debugmsg('Received external reg!');
  externalregister(appname, Name, desc, interfacever);
end;

procedure tform1.te_scriptclick(Sender: TObject);
begin
  loadscript(timeeventcommands[TMenuItem(Sender).tag].scriptname);
end;

procedure tform1.scriptclick(Sender: TObject);
begin
  loadscript(templatescripts[TMenuItem(Sender).tag].filename);
end;

procedure tform1.func_unitfunctionsaddhelperscripteval(info: tprograminfo);
var
  y: integer;
var
  category, s: TMenuItem;
begin
  if fileexists(info['Filename']) = False then
  begin
    wndoutput(format('Warning: Supplied helper script "%s" does not exist.',
      [info['filename']]));
    debugmsg(format('Warning: Supplied helper script "%s" does not exist.',
      [info['filename']]));
  end;
  new(templatescripts[tempscnt]);
  templatescripts[tempscnt].filename := info['Filename'];
  templatescripts[tempscnt].description := info['Description'];
  templatescripts[tempscnt].category := info['Category'];
  templatescripts[tempscnt].
    deleted := False;
  s := TMenuItem.Create(mainmenu1);
  s.Caption := templatescripts[tempscnt].description;
  s.tag := tempscnt;
  s.onclick := form1.scriptclick;
  category := TMenuItem.Create(mainmenu1);
  category.Caption := info['Category'];
  if helperscripts1.find(info['Category']) = nil then
    helperscripts1.add(category)
  else
    category := helperscripts1.find(info['Category']);
  category.add(s);
  Inc(tempscnt);
  if tempscnt > 0 then
    form1.helperscripts1.Visible :=
      True;
end;

procedure tform1.func_unitfunctionssetnodedataeval(info: tprograminfo);
var
  datafield: integer;
var
  thenodeindex: integer;
begin
  thenodeindex := info['Node'];
  if thenodeindex <> -1 then
  begin
    datafield := info['Field'];
    case datafield of
      field_node_npctext: currentdlg.nodes[thenodeindex].npctext := info['Newdata'];
      field_node_npcfemaletext: currentdlg.nodes[thenodeindex].npctext_female :=
          info['Newdata'];
      field_node_notes: currentdlg.
          nodes[thenodeindex].notes := info['Newdata'];
      field_node_name: currentdlg.nodes[thenodeindex].nodename := info['Newdata'];
    end;
    refreshnodes;
    requestpluginrefresh;
  end;
end;

procedure tform1.func_unitfunctionsgetnodedataeval(info: tprograminfo);
var
  datafield: integer;
var
  thenodeindex: integer;
begin
  thenodeindex := info['Node'];
  if thenodeindex <> -1 then
  begin
    datafield := info['Field'];
    case datafield of
      field_node_npctext: info['result'] := currentdlg.nodes[thenodeindex].npctext;
      field_node_npcfemaletext: info['result'] :=
          currentdlg.nodes[thenodeindex].npctext_female;
      field_node_notes: info['result'] :=
          currentdlg.nodes[thenodeindex].notes;
      field_node_optioncount: info['result'] :=
          IntToStr(currentdlg.nodes[thenodeindex].optioncnt);
      field_node_name: info['result']  := currentdlg.nodes[thenodeindex].nodename;
    end;
  end;
end;

procedure tform1.func_unitfunctionsgetnodenameeval(info: tprograminfo);
var
  x: integer;
begin
  if (info['nodeIndex'] >= 0) and (info['nodeIndex'] < currentdlg.nodecount - 1) then
  begin
    x := info['nodeIndex'];
    info['result'] := currentdlg.nodes[x].nodename;
  end;
end;

procedure tform1.func_unitfunctionsgetplayeroptionstringdataeval(info: tprograminfo);
var
  node:  string;
  thenode: integer;
  option: integer;
  field: integer;
begin
  node  := info['Node'];
  option := info['Option'];
  field := info['field'];
  thenode := getnodeindex(node);
  if thenode <> -1 then
  begin
    case field of
      field_playeroption_optiontext:
      begin
        ;
        info['result'] := currentdlg.nodes[thenode].options[option].optiontext;
      end;
      field_playeroption_nodelink:
      begin
        info['result'] := currentdlg.nodes[thenode].options[option].nodelink;
      end;
      field_playeroption_notes:
      begin
        info['result'] := currentdlg.nodes[thenode].options[option].notes;
      end;
    end;
  end;
end;

procedure tform1.func_unitfunctionsgetplayeroptionintegerdataeval(info: tprograminfo);
var
  node:  string;
  thenode: integer;
  option: integer;
  field: integer;
begin
  node  := info['Node'];
  option := info['Option'];
  field := info['Field'];
  thenode := getnodeindex(node);
  if thenode <> -1 then
  begin
    case field of
      field_playeroption_reaction:
      begin
        info['result'] :=
          currentdlg.nodes[thenode].options[option].reaction;
      end;
      field_playeroption_genderflags:
      begin
        info['result'] := currentdlg.nodes[thenode].options[option].genderflags;
      end;
      field_playeroption_intcheck:
      begin
        info['result'] := currentdlg.nodes[thenode].options[option].intcheck;
      end;
    end;
  end;
end;

procedure tform1.func_unitfunctionssetplayeroptionstringdataeval(info: tprograminfo);
var
  node:  string;
  thenode: integer;
  option: integer;
  field: integer;
  the_value: string;
begin
  node  := info['Node'];
  option := info['Option'];
  field := info['field'];
  the_value := info['newdata'];
  thenode := getnodeindex(node);
  if thenode <> -1 then
  begin
    ;
    case field of
      field_playeroption_optiontext:
      begin
        currentdlg.nodes[thenode].options
          [option].optiontext := the_value;
      end;
      field_playeroption_nodelink:
      begin
        currentdlg.
          nodes[thenode].options[option].nodelink := the_value;
      end;
      field_playeroption_notes:
      begin
        ;
        currentdlg.nodes[thenode].options[option].notes := the_value;
      end;
    end;
  end;
end;

procedure tform1.func_unitfunctionssetplayeroptionintegerdataeval(info: tprograminfo);
var
  node:  string;
  thenode: integer;
  option: integer;
  field: integer;
  Value: integer;
begin
  node  := info['Node'];
  option := info['Option'];
  field := info['field'];
  Value := info['newdata'];
  thenode := getnodeindex(node);
  if thenode <> -1 then
  begin
    case field of
      field_playeroption_reaction:
      begin
        currentdlg.nodes[thenode].options[option].reaction := Value;
      end;
      field_playeroption_genderflags:
      begin
        currentdlg.nodes[thenode].options[option].genderflags := Value;
      end;
      field_playeroption_intcheck:
      begin
        currentdlg.nodes[thenode].options[option].intcheck := Value;
      end;
    end;
  end;
end;

procedure tform1.func_unitfunctionseditplayeroptioneval(info: tprograminfo);
begin
  editoption(info['Node'], info['OptionNum']);
end;

procedure tform1.func_unitfunctionsgetnodecounteval(info: tprograminfo);
begin
  info['result'] := currentdlg.nodecount;
end;

procedure tform1.func_unitfunctionsdeletenodeeval(info: tprograminfo);
var
  nodeind: integer;
begin
  nodeind := getnodeindex(info['Name']);
  if nodeind <> -1 then
  begin
    deletenode(nodeind);
    requestpluginrefresh;
  end;
end;

procedure tform1.func_unitfunctionsdeleteplayeroptioneval(info: tprograminfo);
var
  optionind, nodeind: integer;
begin
  nodeind := getnodeindex(info['Node']);
  if nodeind <> -1 then
  begin
    optionind := info['OptionIndex'];
    deleteplayeroption(nodeind, optionind);
    requestpluginrefresh;
  end;
end;

procedure tform1.playercharactersetup1click(Sender: TObject);
var
  t: integer;
begin
  form15.edit1.Text := player.Name;
  form15.combobox1.ItemIndex := player.gender - 1;
  form15.updown1.position := player.age;
  form15.jvspinedit1.Value := player.strength;
  form15.jvspinedit2.Value := player.perception;
  form15.jvspinedit3.Value := player.endurance;
  form15.jvspinedit4.Value := player.charisma;
  form15.jvspinedit5.Value := player.intelligence;
  form15.jvspinedit6.Value := player.agility;
  form15.jvspinedit7.Value :=
    player.luck;
  form15.jvspinedit8.Value := player.dude_caps;
  for t := 0 to 17 do
  begin
    form15.valuelisteditor1.strings.valuefromindex[t] :=
      IntToStr(player.skills[t].Value);
  end;
  form15.showmodal;
  if form15.modalresult = mrOk then
  begin
    player.Name := form15.edit1.Text;
    player.gender := form15.combobox1.ItemIndex + 1;
    player.age  := form15.updown1.position;
    player.strength := trunc(form15.jvspinedit1.Value);
    player.perception := trunc(form15.jvspinedit2.Value);
    player.endurance := trunc(form15.jvspinedit3.Value);
    player.charisma := trunc(form15.jvspinedit4.Value);
    player.intelligence := trunc(form15.jvspinedit5.Value);
    player.agility := trunc(form15.jvspinedit6.Value);
    player.luck := trunc(form15.jvspinedit7.Value);
    player.dude_caps := trunc(form15.jvspinedit8.Value);
    cfg.writestring('Player Character', 'Name', player.Name);
    cfg.writeinteger('Player Character', 'Gender', player.gender);
    cfg.writeinteger('Player Character', 'Age', player.age);
    cfg.writeinteger('Player Character', 'Strength', player.strength);
    cfg.writeinteger('Player Character', 'Perception', player.perception);
    cfg.writeinteger('Player Character', 'Endurance', player.endurance);
    cfg.writeinteger('Player Character', 'Charisma', player.charisma);
    cfg.writeinteger('Player Character', 'Intelligence', player.intelligence);
    cfg.writeinteger('Player Character', 'Agility', player.agility);
    cfg.writeinteger('Player Character', 'Luck', player.luck);
    cfg.writeinteger('Player Character', 'Dude_Caps', player.dude_caps);
    for t := 0 to form15.valuelisteditor1.strings.Count - 1 do
    begin
      player.skills[t].Name  := form15.valuelisteditor1.strings.names[t];
      player.skills[t].Value :=
        StrToInt(form15.valuelisteditor1.strings.valuefromindex[t]);
      cfg.writeinteger('Player Character', player.skills[t].Name,
        player.skills[t].Value);
    end;
    if dlgrunning = True then
    begin
      nodeupdate;
    end;
    requestpluginrefresh;
  end;
end;

procedure tform1.func_unitfunctionsconfirmeval(info: tprograminfo);
begin
  if messagedlg(info['Message'], mtConfirmation, [mbYes, mbNo], 0) in [mrYes] then
    info['result'] := True
  else
    info['result'] := False;
end;

procedure tform1.func_unitfunctionsstringreplaceeval(info: tprograminfo);
var
  input: string;
var
  replaceall: boolean;
var
  replaceflags: treplaceflags;
begin
  input := info['srcString'];
  replaceall := info['ReplaceAll'];
  if replaceall = True then
    replaceflags := [rfreplaceall]
  else
    replaceflags := [];
  input := stringreplace(input, info['oldString'], info['newString'], replaceflags);
  info['result'] := input;
end;

procedure tform1.func_unitfunctionsaddtimeeventcommandeval(info: tprograminfo);
var
  menuitem: TMenuItem;
begin
  menuitem := TMenuItem.Create(form19.popupmenu1);
  new(timeeventcommands[te_cmdcnt]);
  timeeventcommands[te_cmdcnt].scriptname := info['script'];
  timeeventcommands
    [te_cmdcnt].menuitem := info['Name'];
  timeeventcommands[te_cmdcnt].shortcut := info['Shortcut'];
  menuitem.Caption := timeeventcommands[te_cmdcnt].menuitem;
  menuitem.onclick := form1.te_scriptclick;
  menuitem.shortcut := texttoshortcut(timeeventcommands[te_cmdcnt].shortcut);
  menuitem.tag := te_cmdcnt;
  form19.insertcommand1.add(menuitem);
  wndoutput('Added item: ' + menuitem.Caption);
  Inc(te_cmdcnt);
end;

procedure tform1.func_unitfunctionsaddtimeeventcodeeval(info: tprograminfo);
var
  Data: string;
  _pos: tpoint;
begin
  with form19.synmemo1 do
  begin
    ;
    Data := info['line'];
    seltext := Data;
    _pos.x := caretx;
    _pos.y := carety;
    Perform(wm_mbuttondown, 0, 0);
    application.ProcessMessages;
    caretx := _pos.x;
    carety := _pos.y;
  end;
end;

procedure tform1.func_unitfunctionsselectfloatnodeeval(info: tprograminfo);
var
  t: integer;
begin
  form20.Caption := 'Select float node';
  form20.label1.Caption := 'Choose a float node to call:';
  form20.listbox1.Clear;
  for t := 0 to currentdlg.floatnodecount - 1 do
  begin
    form20.listbox1.items.add(currentdlg.floatnodes[t].nodename);
  end;
  form20.showmodal;
  if form20.modalresult = mrOk then
  begin
    if form20.listbox1.ItemIndex <> -1 then
    begin
      info['result'] := form20.listbox1.items[form20.listbox1.ItemIndex];
    end;
  end;
  form20.Caption := '';
  form20.label1.Caption := '';
end;

procedure tform1.func_unitfunctionsselecttimedeventeval(info: tprograminfo);
var
  te_ind, t: integer;
begin
  form20.Caption := 'Select timed event';
  form20.label1.Caption := 'Choose a timed event to add:';
  form20.listbox1.Clear;
  for t := 0 to currentdlg.timedeventcnt - 1 do
  begin
    form20.listbox1.items.add(currentdlg.timedevents[t].fixedparamname);
  end;
  form20.showmodal;
  if form20.modalresult = mrOk then
  begin
    if form20.listbox1.ItemIndex <> -1 then
    begin
      te_ind := form20.listbox1.ItemIndex;
      if currentdlg.timedevents[te_ind].israndom = True then
        info['result'] := format(
          'flush_add_timer_event_sec(self_obj, random(%d, %d),%s);',
          [currentdlg.timedevents[te_ind].mininterval,
          currentdlg.timedevents[te_ind].maxinterval,
          currentdlg.timedevents[te_ind].fixedparamname])
      else
        info['result'] := format('flush_add_timer_event_sec(self_obj, %d,%s);',
          [currentdlg.timedevents[te_ind].interval,
          currentdlg.timedevents[te_ind].maxinterval,
          currentdlg.timedevents[te_ind].fixedparamname]);
    end;
  end;
  form20.Caption := '';
  form20.label1.Caption := '';
end;

procedure tform1.formclose(Sender: TObject; var action: tcloseaction);
var
  z: integer;
begin
  if booting_up = True then
  begin
    debugmsg('Booting up! Not closing the window.');
    action := canone;
  end;
  freedlgptrs;
  if fmf1 <> nil then
    fmf1.Free;
  cfg.Free;
  opendialog1.Free;
  savedialog1.Free;
  delphiwebscriptii1.removeunit(func_unit);
  funcdesc.Free;
  form6.Destroy;
  condcfg.Free;
  delphiwebscriptii1.Free;
  for z := 0 to plugincnt - 1 do
    dispose(
      dllplugins[z]);
  dispose(player);
  action := cafree;
  halt;
end;

procedure tform1.func_unitfunctionsaddnodenorefresheval(info: tprograminfo);
var
  nodename: string;
  npctext: string;
  notes: string;
  npctextfemale: string;
begin
  nodename := info['nodename'];
  npctext := info['npctext'];
  npctextfemale :=
    info['npctext_female'];
  notes := info['notes'];
  if getnodeindex(nodename) <> -1 then
  begin
    ;
    wndoutput('Error! Node ' + nodename + ' already exists!');
    exit;
  end;
  new(currentdlg.nodes[currentdlg.nodecount]);
  currentdlg.nodes[currentdlg.nodecount].npctext := npctext;
  currentdlg.nodes[currentdlg.nodecount].npctext_female := npctextfemale;
  currentdlg.nodes[currentdlg.nodecount].nodename := nodename;
  currentdlg.nodes[currentdlg.nodecount].notes  := notes;
  currentdlg.nodes[currentdlg.nodecount].hidden := False;
  currentdlg.nodes[currentdlg.nodecount].optioncnt := 0;

  currentdlg.nodes[currentdlg.nodecount].is_wtg := false;
currentdlg.nodes[currentdlg.nodecount].skillcheckcnt := 0;
  if outputwnd <> nil then
    wndoutput('Added node "' + nodename + '"');
  Inc(currentdlg.nodecount);
end;

procedure tform1.func_unitfunctionsaddtimedeventeval(info: tprograminfo);
begin
  new(currentdlg.timedevents[currentdlg.timedeventcnt]);
  currentdlg.timedevents[currentdlg.timedeventcnt].fixedparamenumindex :=
    currentdlg.timedeventcnt;
  currentdlg.timedevents
    [currentdlg.timedeventcnt].fixedparamname := info['name'];
  currentdlg.timedevents[currentdlg.timedeventcnt].israndom := True;
  currentdlg.timedevents[currentdlg.timedeventcnt].mininterval := info['interval1'];
  currentdlg.timedevents[currentdlg.timedeventcnt].maxinterval :=
    info['interval2'];
  currentdlg.timedevents[currentdlg.timedeventcnt].actioncnt := 0;
  wndoutput('Added Timed Event: ' +
    currentdlg.timedevents[currentdlg.timedeventcnt].fixedparamname +
    ' ( index=' + IntToStr(currentdlg.timedevents[
    currentdlg.timedeventcnt].fixedparamenumindex) + ' )');
  Inc(currentdlg.timedeventcnt);
end;

procedure tform1.func_unitfunctionsaddcodetoeventeval(info: tprograminfo);
var
  te_ind: integer;
begin
  te_ind := gettimedeventindex(info['eventname']);
  if te_ind <> -1 then
  begin
    new(currentdlg.timedevents[te_ind].actionlines[
      currentdlg.timedevents[te_ind].actioncnt]);
    currentdlg.timedevents[te_ind].actionlines[currentdlg.timedevents[
      te_ind].actioncnt].linedata := info['codeline'];
    Inc(currentdlg.timedevents[te_ind].actioncnt);
    wndoutput('Added code line (currentdlg.timedevents[te_ind].actioncnt) to timed event "'
      + currentdlg.timedevents[te_ind].fixedparamname + '" ( index=' +
      IntToStr(currentdlg.timedevents[te_ind].fixedparamenumindex) + ' )');
  end;
end;

procedure dialoguechangenotify;
begin
  ;
  dlgchanged := True;
  form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
  form1.savedialogue2.Enabled := True;
end;

procedure tform1.func_unitfunctionsdialoguechangenotifyeval(info: tprograminfo);
begin
  dlgchanged := True;
  form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
  form1.savedialogue2.Enabled := True;
end;

procedure tform1.func_unitfunctionsaddfloatnodeeval(info: tprograminfo);
var
  fnind: integer;
begin
  new(currentdlg.floatnodes[currentdlg.floatnodecount]);
  fnind := getfloatnodeindex(info['nodename']);
  if fnind <> -1 then
  begin
    ;
    wndoutput('The specified float node already exists at index ' + IntToStr(fnind));
    exit;
  end;
  currentdlg.floatnodes[currentdlg.floatnodecount].nodename := info['nodename'];
  currentdlg.floatnodes[currentdlg.floatnodecount].notes := info['desc'];
  currentdlg.floatnodes
    [currentdlg.floatnodecount].messagecnt := 0;
  wndoutput('Added floatnode "' +
    currentdlg.floatnodes[currentdlg.floatnodecount].nodename + '" (' +
    currentdlg.floatnodes[currentdlg.floatnodecount].notes + ')');
  Inc(currentdlg.floatnodecount);
end;

procedure tform1.func_unitfunctionsaddmsgtofloatnodeeval(info: tprograminfo);
var
  ind: integer;
begin
  ind := getfloatnodeindex(info['node']);
  if ind <> -1 then
  begin
    currentdlg.floatnodes[ind].Messages[currentdlg.floatnodes[ind].messagecnt] :=
      info['msg'];
    Inc(currentdlg.floatnodes[ind].messagecnt);
  end;
end;

procedure tform1.func_unitfunctionseditfloatnodeeval(info: tprograminfo);
var
  nodeind, fn_ind: integer;
begin
  fn_ind := getfloatnodeindex(info['node']);
  if fn_ind <> -1 then
  begin
    nodeind := fn_ind;
    refreshfloatmsgs;
    form17.edit1.Text := currentdlg.floatnodes[nodeind].nodename;
    form17.memo1.Text := currentdlg.floatnodes[nodeind].notes;
    form17.showmodal;
    if form17.modalresult = mrOk then
    begin
      currentdlg.floatnodes[nodeind].nodename := form17.edit1.Text;
      currentdlg.floatnodes[nodeind].notes := form17.memo1.Text;
      refreshnodes;
      dialoguechangenotify;
    end;
  end;
end;

procedure tform1.func_unitfunctionsgettimedeventdataeval(info: tprograminfo);
var
  te_ind: integer;
begin
  te_ind := gettimedeventindex(info['event']);
  if currentdlg.timedevents[te_ind].israndom = True then
    info['result'] := format('flush_add_timer_event_sec(self_obj, random(%d, %d),%s);',
      [currentdlg.timedevents[te_ind].mininterval,
      currentdlg.timedevents[te_ind].maxinterval,
      currentdlg.timedevents[te_ind].fixedparamname])
  else
    info['result'] := format('flush_add_timer_event_sec(self_obj, %d,%s);',
      [currentdlg.timedevents[te_ind].mininterval,
      currentdlg.timedevents[te_ind].fixedparamname]);
end;

function getitems(ind: integer): string;
var
  y: integer;
var
  str: string;
begin
  str := '';
  if incs[ind].paramcnt > 0 then
  begin
    for y := 0 to incs[ind].paramcnt - 1 do
    begin
      ;
      str := str + '"';
      str := str + incs[ind].params[y];
      if incs[ind].paramtype[y] <> 0 then
      begin
        ;
        case incs[ind].paramtype[y] of
          ptype_procptr: str := str + ': procedure';
          ptype_objectptr: str := str + ': object';
          ptype_integer: str := str + ': integer';
          ptype_string: str  := str + ': string';
        end;
      end;
      if y < incs[ind].paramcnt - 1 then
      begin
        str := str + ', ", ';
      end;
    end;
    str := str + '"';
  end else
    str := '"* No parameters expected *"';
  Result := str;
end;

procedure tform1.func_unitfunctionsdolink_showexportseval(info: tprograminfo);
var
  i: integer;
var
  str: string;
var
  the_message: string;
begin
  str := info['plugin'];
  plugin_info.filename := str;
  the_message := 'Plugin exports ' + IntToStr(plugin_info.exportlist.Count) +
    ' functions:';
  for i := 0 to plugin_info.exportlist.Count - 1 do
  begin
    the_message := the_message + #13#10 + plugin_info.exportlist[i].Name;
  end;
  ShowMessage(the_message);
end;

procedure tform1.func_unitfunctionsexecutefileeval(info: tprograminfo);
var
  app, params, defaultdir: string;
var
  displaycmd: integer;
begin
  app := info['app'];
  params := info['params'];
  defaultdir :=
    info['defaultdir'];
  displaycmd := info['displaycmd'];
  executefile(app, params, defaultdir, displaycmd);
end;

procedure tform1.func_unitfunctionsloaddefeval(info: tprograminfo);
begin
  debugmsg('Loading definition ' + info['fname']);
  incparser.sourcefilename := info['fname'];
  incparser.Execute;
end;

procedure HelpSystem(parentform: TForm; filename: PChar; Caption: PChar); stdcall;
begin
  helpapiform := tform28.Create(parentform);
  helpapiform.Show;
  helpapiform.displayhelp(ansistring(Caption), ansistring(filename));
end;

procedure HelpSystemDeInit;
begin
end;

procedure tform1.customprocedures1click(Sender: TObject);
begin
  set_current_node := False;
  form23.showmodal;
end;

procedure tform1.opendialogueeditor1click(Sender: TObject);
begin
  debugmsg('Attempting to resolve nodes...');
  resolvenodes;
  debugmsg('Attempting to refresh node list.');
  refreshnodes;
  debugmsg('Done!');
  form2.showmodal;
  if dlgrunning = True then
  begin
    nodeupdate;
  end;
  requestpluginrefresh;
end;

procedure tform1.func_unitvariablesbasepathreadvar(var Value: variant);
begin
  Value := basepath;
end;

procedure tform1.func_unitfunctionsaddskillcheckeval(info: tprograminfo);
var
  the_node: integer;
begin
  the_node := getnodeindex(info['node']);
  new(currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt]);
  currentdlg.nodes
    [the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].check_proc_name :=
    info['Name'];
  currentdlg.nodes[the_node].skillchecks[
    currentdlg.nodes[the_node].skillcheckcnt].check_what := info['skill'];
  currentdlg.nodes[the_node].skillchecks[
    currentdlg.nodes[the_node].skillcheckcnt].modifier :=
    info['modifier'];
  currentdlg.nodes[the_node].skillchecks
    [currentdlg.nodes[the_node].skillcheckcnt].successnode := info['onsuccess'];
  currentdlg.nodes[the_node].skillchecks[
    currentdlg.nodes[the_node].skillcheckcnt].failurenode :=
    info['onfailure'];
  Inc(currentdlg.nodes[the_node].skillcheckcnt);
end;

procedure tform1.func_unitfunctionssetoptiontoskillcheckeval(info: tprograminfo);
var
  nodeind, option: integer;
begin
  nodeind := getnodeindex(info['node']);
  option  := info['opt_ind'];
  currentdlg.nodes[nodeind].options[option].link_to_proc := False;
  currentdlg.nodes[nodeind].options
    [option].link_to_skillcheck := True;
  currentdlg.nodes[nodeind].options[option].nodelink := info['skillcheck'];
end;

procedure tform1.func_unitfunctionsrequestpluginrefresheval(info: tprograminfo);
begin
  requestpluginrefresh;
end;

procedure tform1.func_unitfunctionssetnodecustomcodeeval(info: tprograminfo);
var
  x: integer;
begin
  x := getnodeindex(info['Node']);
  if x <> -1 then
    currentdlg.nodes[x].customcode := info['code'];
end;

function getmainform: TForm; stdcall;
begin
  Result := form1;
end;

exports
  HelpSystem,
  HelpSystemDeInit,
  GetMainForm,
  GetPlayer,
  GetProgramVer,
  SetOutputControl,
  GetCurrentNode,
  SetCurrentNode,
  DoExternalRegister,
  UnSetOutputControl,
  SendDebugMSG,
  GetSSLPath,
  GetMSGPath,
  GetCurrentDLGName,
  GetDLG,
  GetDLGNew,
  GetDLGNew_Alt,
  ExecuteScriptLines;

procedure tform1.timer1timer(Sender: TObject);
var
  datestr: string;
var
  filenamez: string;
var
  old: string;
begin
  if (currentdlg.filename = 'untitled') or (currentdlg.filename = '') then
  begin
    exit;
  end;
  debugmsg('Backing up dialogue...');
  datestr := datetimetostr(now);
  datestr := stringreplace(datestr, ' ', '_', [rfreplaceall]);
  datestr := stringreplace(datestr, '/', '_', [rfreplaceall]);
  datestr := stringreplace(datestr, '.', '_', [rfreplaceall]);
  datestr := stringreplace(datestr, ':', '_', [rfreplaceall]);
  old := currentdlg.filename;
  filenamez := changefileext(currentdlg.filename, '') + '_backup_' + datestr + '.fmf';
  savedata(filenamez);
  statusbar1.simpletext := 'Saved backup of ' + old + ' to ' + filenamez;
  currentdlg.filename := old;
  form1.Caption := 'Fallout Dialogue Creator - [' + old + ']';
  savedata(old);
end;

procedure tform1.replacedialog1replace(Sender: TObject);
var
  t, u: integer;
var
  playeropt, node: integer;
var
  occ:  integer;
begin
  debugmsg('Start replace!');
  occ  := 0;
  node := 0;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    if pos(form1.replacedialog1.findtext, currentdlg.nodes[t].npctext) <> 0 then
    begin
      Inc(occ);
      Inc(node);
    end;
    if pos(form1.replacedialog1.findtext, currentdlg.nodes[t].npctext_female) <> 0 then
    begin
      Inc(occ);
      Inc(node);
    end;
    currentdlg.nodes[
      t].npctext := stringreplace(currentdlg.nodes[t].npctext,
      form1.replacedialog1.findtext, form1.replacedialog1.replacetext, [rfreplaceall]);
    currentdlg.nodes[t].npctext_female :=
      stringreplace(currentdlg.nodes[t].npctext_female,
      form1.replacedialog1.findtext, form1.replacedialog1.replacetext, [rfreplaceall]);
    for u := 0 to currentdlg.nodes[t].optioncnt - 1 do
    begin
      if pos(form1.replacedialog1.findtext, currentdlg.nodes[t].npctext_female) <> 0 then
      begin
        Inc(occ);
        Inc(playeropt);
      end;
      currentdlg.nodes[t].options[u].optiontext :=
        stringreplace(currentdlg.nodes[t].options[u].optiontext,
        form1.replacedialog1.findtext, form1.replacedialog1.replacetext, [rfreplaceall]);
    end;
  end;
  resolvenodes;
  refreshnodes;
  messagedlg(format('Search finished.' + #13 + #10 + '' + #13 + #10 +
    '%d total occurences:' + #13 + #10 + '' + #13 + #10 + '%d in npc text' +
    #13 + #10 + '%d in player options', [occ, node, playeropt]),
    mtWarning, [mbOK], 0);
end;

procedure tform1.func_unitfunctionsopenprogressbareval(info: tprograminfo);
begin
  progressform.Show;
end;

procedure tform1.func_unitfunctionssetprogressmaxeval(info: tprograminfo);
begin
  progressform.progressbar1.max := info['count'];
end;

procedure tform1.func_unitfunctionsupdateprogresseval(info: tprograminfo);
begin
  progressform.progressbar1.position := info['pos'];
  application.ProcessMessages;
end;

procedure tform1.func_unitfunctionscloseprogressbareval(info: tprograminfo);
begin
  progressform.hide;
end;

procedure tform1.func_unitfunctionssetprogressbarcaptioneval(info: tprograminfo);
begin
  progressform.label1.Caption := info['text'];
  application.ProcessMessages;
end;

procedure tform1.syncompletionproposal1execute(kind: tsyncompletiontype;
  Sender: TObject; var currentinput: string; var x, y: integer; var canexecute: boolean);
var
  locline, lookup: string;
  tmpx, savepos, startx, parencounter, tmplocation: integer;
  foundmatch: boolean;
begin
  with tsyncompletionproposal(Sender).editor do
  begin
    locline := linetext;
    tmpx := caretx;
    if tmpx > length(locline) then
      tmpx := length(locline)
    else
      Dec(tmpx);
    foundmatch  := False;
    tmplocation := 0;
    while (tmpx > 0) and not (foundmatch) do
    begin
      if locline[tmpx] = ',' then
      begin
        Inc(tmplocation);
        Dec(tmpx);
      end else if locline[tmpx] = ')' then
      begin
        parencounter := 1;
        Dec(tmpx);
        while (tmpx > 0) and (parencounter > 0) do
        begin
          if locline[tmpx] = ')' then
            Inc(parencounter)
          else if locline[tmpx] = '(' then
            Dec(parencounter);
          Dec(tmpx);
        end;
        if tmpx > 0 then
          Dec(tmpx);
      end else if locline[tmpx] = '(' then
      begin
        startx := tmpx;
        while (tmpx > 0) and not (locline[tmpx] in tsynvalidstringchars) do
          Dec(tmpx);
        if tmpx > 0 then
        begin
          savepos := tmpx;
          while (tmpx > 0) and (locline[tmpx] in tsynvalidstringchars) do
            Dec(tmpx);
          Inc(tmpx);
          lookup := uppercase(copy(locline, tmpx, savepos - tmpx + 1));
          foundmatch := lookuplist.indexof(lookup) > -1;
          if not (foundmatch) then
          begin
            tmpx := startx;
            Dec(tmpx);
          end;
        end;
      end
      else
        Dec(tmpx);
    end;
  end;
  canexecute := foundmatch;
  if canexecute then
  begin
    tsyncompletionproposal(Sender).form.currentindex := tmplocation;
    if lookup <> tsyncompletionproposal(Sender).previoustoken then
    begin
      tsyncompletionproposal(Sender).itemlist.Clear;
      tsyncompletionproposal(Sender).itemlist.add(getitems(lookuplist.indexof(lookup)));
    end;
  end else
    tsyncompletionproposal(Sender).itemlist.Clear;
end;

procedure tform1.listbox1customdrawsubitem(Sender: tcustomlistview;
  item: tlistitem; subitem: integer; state: tcustomdrawstate; var defaultdraw: boolean);
begin
  if (dumbcolmode = True) then
  begin
    if currentnode = -1 then
    begin
      exit;
    end;
    if currentdlg.nodes[currentnode].options[item.index].intcheck < 0 then
    begin
      listbox1.canvas.font.color := dumb_col;
      listbox1.canvas.font.style := [fsbold];
      exit;
    end;
  end else
  begin
    if item.subitems[2] = 'Neutral' then
    begin
      listbox1.canvas.font.color := neutral_col;
      listbox1.canvas.font.style := [];
    end else if item.subitems[2] = 'Good' then
    begin
      listbox1.canvas.font.color := good_col;
      listbox1.canvas.font.style := [fsbold];
    end else if item.subitems[2] = 'Bad' then
    begin
      listbox1.canvas.font.color := bad_col;
      listbox1.canvas.font.style := [fsbold];
    end;
  end;

end;

procedure tform1.func_unitfunctionsisnodehiddeneval(info: tprograminfo);
var
  ind: integer;
begin
  ind := info['index'];
  info['result'] := (currentdlg.nodes[ind].hidden = True);
end;

procedure copyconditions(src_node, dest_node, src_opt, dest_opt: integer);
var
  i: integer;
begin
  debugmsg('DEST_NODE=' + IntToStr(dest_node) + ' SRC_NODE=' +
    IntToStr(src_node) + '/' + IntToStr(currentdlg.nodecount));
  debugmsg('DEST_OPT=' + IntToStr(dest_opt) + ' SRC_OPT=' + IntToStr(src_opt));
  if currentdlg.nodes[src_node] = nil then
    messagedlg('FATAL! NULL NODE!', mtError, [mbOK], 0);
  if currentdlg.nodes[src_node].options[src_opt] = nil then
    messagedlg('FATAL! NULL OPTION!', mtError, [mbOK], 0);
  if currentdlg.nodes[src_node].options[src_opt].conditioncnt = 0 then
  begin
    debugmsg('No conditions - EXIT');
    exit;
  end;
  if currentdlg.nodes[dest_node].options[dest_opt] = nil then
  begin
    new(currentdlg.nodes[dest_node].options[dest_opt]);
  end;
  currentdlg.nodes[dest_node].options[dest_opt].conditioncnt :=
    currentdlg.nodes[src_node].options[src_opt].conditioncnt;
  for i := 0
    to currentdlg.nodes[src_node].options[src_opt].conditioncnt - 1 do
  begin
    debugmsg('Copy cond ' + IntToStr(i));
    new(currentdlg.nodes[dest_node].options[dest_opt].conditions[i]);
    currentdlg.nodes[dest_node].options[dest_opt].conditions[i]^ :=
      currentdlg.nodes[src_node].options[src_opt].conditions[i]^;
  end;
end;

procedure tform1.func_unitfunctionscopyconditionseval(info: tprograminfo);
var
  src_node, dest_node: integer;
  src_opt, dest_opt: integer;
  i: integer;
begin
  src_node := info['SourceNodeIndex'];
  dest_node := info['DestinationNodeIndex'];
  src_opt  := info['SourceConditionPlayerOption'];
  dest_opt := info['TargetConditionPlayerOption'];
  copyconditions(src_node, dest_node, src_opt, dest_opt);
end;

procedure tform1.mxWebUpdate1BeforeGetInfo(Sender: TObject);
begin
debugmsg('Trying to get info');
end;

end.

