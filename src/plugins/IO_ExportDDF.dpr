// Compilable for FSS and AMDS using a define: 'AMDS' or 'FSS'
library IO_ExportDDF;
{$DEFINE AMDS}





uses
  SysUtils,
  Classes,
  dialogs,
  Controls,
{$IFDEF FSS}
  FSS_Pluginlib,
{$ENDIF}
{$IFDEF AMDS}
  AMDS_Pluginlib,
{$ENDIF}
  Inifiles,
  DLGDef,
  exportcfg in 'exportcfg.pas' {Form1},
  ddfabout in 'ddfabout.pas' {Form2};

  var DLGDef1: TDlgDef;
  msgname, sslname: string;
  cur_dlg: ^DialogueNodes;

  {$R *.res}

function GetPluginName: ShortString; stdcall;
begin;
result := 'DDF Exporter';
end;


function GetExportDescription: ShortString;  stdcall;
begin;
result := 'This export plugin is specially made for exporting a dialogue into a custom DDF script format to be converted into Fallout2 SSL and MSG files. Later on I might add a DDF compiler directly as a plug-in for AMDS.';
end;

function GetPluginDescription: ShortString; stdcall;
begin;
result := 'Import functionality for this plugin currently not implemented.';
end;

procedure ImportData (filename: shortstring); stdcall;
begin;
end;

procedure ExportData;  stdcall;
var nodes: Integer;
var i,j: integer;
var node,tempstr: pchar;
var script: TStrings;
begin;
form1 := TForm1.Create(nil);

npc_count := amds_cfg.ReadInteger('DDF Exporter','NPCCount',0);
for I:=0 to npc_count-1 do
begin;
form1.ComboBox1.items.Add(amds_cfg.readstring('DDF Exporter','NPC_'+inttostr(i+1), ''));
end;
form1.LMDFileOpenEdit1.initialdir := amds_cfg.ReadString('DDF Exporter','SSL Path','');
form1.LMDFileOpenEdit2.initialdir := amds_cfg.ReadString('DDF Exporter','MSG Path','');

form1.CheckBox2.Checked := amds_cfg.Readbool('DDF Exporter','Auto Fetch Descriptions',false);
(*
amds_cfg.writestring('DDF Exporter', 'NPC Name', edit1.text);
amds_cfg.writestring('DDF Exporter', 'Description', edit2.text);
amds_cfg.writestring('DDF Exporter', 'Location', edit3.text);
amds_cfg.writestring('DDF Exporter', 'Script ID', edit4.text);
amds_cfg.WriteString('DDF Exporter', 'DDF Output Path', ExtractFileDir(form1.SaveDialog1.filename));
amds_cfg.writebool('DDF Exporter', 'ProcessDDF', form1.checkbox1.checked);

*)


// form1.memo1.Text := amds_cfg.readstring('DDF Descriptions - '+npcname,'Unknown','');

form1.edit1.text := amds_cfg.readstring('DDF Exporter', 'Current NPC', '');
npcname := form1.edit1.text;

form1.combobox1.text := npcname;
form1.LMDFileOpenEdit3.Filename :=
amds_cfg.readstring('DDF Settings - '+npcname,'Template',amds_cfg.ReadString('DDF Exporter','Script Template',''));

form1.edit2.text := amds_cfg.readstring('DDF Descriptions - '+npcname, 'Description', '');
form1.edit3.text := amds_cfg.readstring('DDF Descriptions - '+npcname, 'Location', '');
form1.edit4.text := amds_cfg.readstring('DDF Descriptions - '+npcname, 'Script ID', '');
(*
amds_cfg.writestring('DDF Descriptions - '+npcname,'Unknown',unknowndesc);
amds_cfg.writestring('DDF Descriptions - '+npcname,'Known',knowndesc);
amds_cfg.writestring('DDF Descriptions - '+npcname,'Detailed',detailed);
*)
if form1.CheckBox2.checked=true then
begin;
fetchdesc := true;
end else fetchdesc := false;

if fetchdesc=true then
begin;
form1.memo1.Text := amds_cfg.readstring('DDF Descriptions - '+npcname,'Unknown','');
form1.memo2.Text := amds_cfg.readstring('DDF Descriptions - '+npcname,'Known','');
form1.memo3.Text := amds_cfg.readstring('DDF Descriptions - '+npcname,'Detailed','');
end;

msgname := amds_cfg.ReadString('DDF Settings - '+npcname,'MSG Output name','');
sslname := amds_cfg.ReadString('DDF Settings - '+npcname,'SSL Output name','');

if msgname<>'' then
form1.LMDFileOpenEdit2.text := msgname;

if sslname<>'' then
form1.LMDFileOpenEdit1.text := sslname;

form1.savedialog1.InitialDir := amds_cfg.readstring('DDF Exporter', 'DDF Output Path', '');
form1.checkbox1.Checked := amds_cfg.readbool('DDF Exporter', 'Process DDF', false);
form1.showmodal;

if form1.modalresult = mrOK then
begin;
ddfmode := Form1.CheckBox1.checked;
sslfile := form1.LMDFileOpenEdit1.text;
msgfile := form1.LMDFileOpenEdit2.text;
script_template := form1.lmdfileopenedit3.text;
npcname := form1.edit1.text;
description := form1.edit2.text;
location := form1.edit3.text;
scriptID := form1.edit4.text;
unknowndesc := form1.memo1.text;
knowndesc := form1.memo2.text;
detailed := form1.memo3.text;
nodes := GetNodeCount;
script := TStringList.create;
script.add('/*');
script.add('');
script.add(' DDF Script exported from AMDS');
script.add('');
script.add('NPC: '+npcname);
script.add('Location: '+location);
script.add('description: '+description);
script.add('');
script.add('*/');
script.add('');
script.add(Format('MSGOutputName = "%s"',[msgfile]));
script.add(Format('SCROutputName = "%s"',[sslfile]));
script.add(Format('ScriptTemplate = "%s"',[script_template]));
script.add(Format('ScriptID = %s',[scriptID]));
script.add(Format('NPCName = "%s"',[npcname]));
script.add(Format('Description = "%s"',[description]));
script.add(Format('Location = "%s"',[location]));
script.add('');
script.add('descproc');
script.add('begin;');
script.add(Format('unknown = "%s"',[unknowndesc]));
script.add(Format('known = "%s"',[knowndesc]));
script.add(Format('detailed = "%s"',[detailed]));
script.add('end;');
script.add('');
script.add('StartNodes');
script.add('Begin');
//script.add('// Insert start node list here manually');
new(cur_dlg);
GetDLGNode(0, cur_dlg^);
script.add('DefaultNode: '+cur_dlg.nodename);
script.add('End');

script.add('');
script.add('dialogue:');
script.add('begin');
for I:=0 to nodes-1 do
begin;
new(cur_dlg);
GetDLGNode(i, cur_dlg^);
if cur_Dlg.Description<>'' then
script.add(Format('     %s: ( "%s" )',[cur_dlg.NodeName,cur_Dlg.Description])) else
script.add(Format('     %s: ',[cur_dlg.NodeName]));


script.add(Format('     StartNum=%d;',[cur_Dlg.linenumberbase]));
script.add('    begin');
// Later on: Create if..then structure for checking gender
cur_dlg.maletext := StringReplace(cur_dlg.MaleText, '@pcname@', '"+dude_name+"',[rfReplaceAll]);
cur_dlg.maletext := StringReplace(cur_dlg.MaleText, '@PCNAME@', '"+dude_name+"',[rfReplaceAll]);

cur_dlg.femaletext := StringReplace(cur_dlg.feMaleText, '@pcname@', '"+dude_name+"',[rfReplaceAll]);
cur_dlg.femaletext := StringReplace(cur_dlg.feMaleText, '@PCNAME@', '"+dude_name+"',[rfReplaceAll]);

cur_dlg.maletext := StringReplace(cur_dlg.MaleText, '${','"+',[rfReplaceAll]);
cur_dlg.maletext := StringReplace(cur_dlg.MaleText, '}','+"',[rfReplaceAll]);

cur_dlg.femaletext := StringReplace(cur_dlg.feMaleText, '${','"+',[rfReplaceAll]);
cur_dlg.femaletext := StringReplace(cur_dlg.feMaleText, '}','+"',[rfReplaceAll]);

if cur_dlg.femaletext<>'' then
script.add(Format('     NPC: "%s" female: "%s";',[cur_dlg.maletext,cur_Dlg.FemaleText])) else

script.add(Format('     NPC: "%s";',[cur_dlg.maletext]));
for j:=0 to cur_Dlg.PlayerOptcnt-1 do
begin;
if cur_dlg.playeroptions[j].genderflags = 1 then
tempstr := '    Player [int=%d] [reaction=NEUTRAL] condition: dude_is_female: "%s", Goto=>%s;'
else
if cur_dlg.playeroptions[j].genderflags = 2 then
tempstr := '    Player [int=%d] [reaction=NEUTRAL] condition: dude_is_male: "%s", Goto=>%s;' else


tempstr := '    Player [int=%d] [reaction=NEUTRAL]: "%s", Goto=>%s;';

cur_dlg.playeroptions[j].linetext := StringReplace(cur_dlg.playeroptions[j].linetext, '@pcname@','"+dude_name+"',[rfReplaceAll]);
cur_dlg.playeroptions[j].linetext := StringReplace(cur_dlg.playeroptions[j].linetext, '@PCNAME@','"+dude_name+"',[rfReplaceAll]);

cur_dlg.playeroptions[j].linetext := StringReplace(cur_dlg.playeroptions[j].linetext, '${','"+',[rfReplaceAll]);
cur_dlg.playeroptions[j].linetext := StringReplace(cur_dlg.playeroptions[j].linetext, '}','+"',[rfReplaceAll]);


if cur_dlg.PlayerOptions[j].NodeLink='' then
node := 'Node999' else
node := pchar(cur_dlg.PlayerOptions[j].NodeLink);
script.add(Format(tempstr, [cur_dlg.playeroptions[j].intgroup, cur_dlg.playeroptions[j].linetext, node]));
end;

script.add('    end');

end;

script.add('end');
amds_cfg.WriteString('DDF Exporter', 'Script Template', form1.LMDFileOpenEdit3.text);
amds_cfg.WriteString('DDF Exporter', 'SSL Path', extractfiledir(form1.LMDFileOpenEdit1.Filename));
amds_cfg.WriteString('DDF Exporter', 'MSG Path', extractfiledir(form1.LMDFileOpenEdit2.Filename));
amds_cfg.WriteBool  ('DDF Exporter', 'Auto Fetch Descriptions',form1.checkbox2.checked);
amds_cfg.writebool  ('DDF Exporter', 'Process DDF', form1.checkbox1.checked);
amds_cfg.WriteString('DDF Exporter', 'Current NPC', form1.edit1.text);

amds_cfg.writestring('DDF Descriptions - '+npcname,'Unknown',unknowndesc);
amds_cfg.writestring('DDF Descriptions - '+npcname,'Known',knowndesc);
amds_cfg.writestring('DDF Descriptions - '+npcname,'Detailed',detailed);

amds_cfg.writestring('DDF Descriptions - '+npcname, 'NPC Name', form1.edit1.text);
amds_cfg.writestring('DDF Descriptions - '+npcname, 'Description', form1.edit2.text);
amds_cfg.writestring('DDF Descriptions - '+npcname, 'Location', form1.edit3.text);
amds_cfg.writestring('DDF Descriptions - '+npcname, 'Script ID', form1.edit4.text);
amds_cfg.writestring('DDF Settings - '+npcname,'MSG Output name',form1.lmdfileopenedit2.filename);
amds_cfg.writestring('DDF Settings - '+npcname,'SSL Output name',form1.lmdfileopenedit1.filename);
amds_cfg.writestring('DDF Settings - '+npcname,'Template',form1.lmdfileopenedit3.filename);

if form1.SaveDialog1.Execute then
begin;
script.SaveToFile(form1.SaveDialog1.filename);

if ddfmode=true then
begin;
DLGDef1 := TDLGDef.Create(nil);
dlgdef1.SourceFileName := form1.savedialog1.filename;
dlgdef1.Execute;

if dlgdef1.successful then
begin;
PrintToLog('The DDF script was successfully processed. Export process finished.');
end else
begin;
MessageDlg(Format('Errors found in DDF script!'+#13+#10+'List file is located at %s\error.log',[getcurrentdir]), mtWarning, [mbOK], 0);
dlgdef1.ListStream.SaveToFile('error.log');
end;


amds_cfg.WriteString('DDF Exporter', 'DDF Output Path', ExtractFileDir(form1.SaveDialog1.filename));
end;
dlgdef1.Free;
end;

end;


Form1.Free;
AMDS_Cfg.Free;
end;

procedure RunPlugin (BasePath: ShortString); stdcall;
begin;
MessageDlg('This plug-in does not have import capabilities.', mtInformation, [mbOK], 0);
end;

function GetIsImportHidden: boolean; stdcall;
begin;
result := true;
end;

exports

GetIsImportHidden,
GetPluginName,
GetPluginDescription,
RunPlugin,
GetExportDescription,
ImportData,
ExportData;

begin
{$IFDEF AMDS}
AMDS_Cfg := TInifile.create(getcurrentdir+'\amds.cfg');
{$ELSE}
AMDS_Cfg := TInifile.create(getcurrentdir+'\fss.cfg');
{$ENDIF}
end.
