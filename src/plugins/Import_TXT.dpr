library Import_TXT;

{

This is a plugin generated by the PluginHelper 
application. It serves as a starting point for developing plugins
for FMF Dialogue Tool.

Plugin Name: Text file 
Author: Dj Unique

Description:

Imports dialogue from a text file.

Syntax:

<nodenumber>: <npctext>
- <playeroption> (The '-' should help the parser to recognize it as a player line) (<nodetolink>)

Example:

0: This is an npc line.
- This is a player option. (1)

1. This is another npc line.
- This is a player option part II. (done)

Notice that 'done' is used to terminate the dialogue.

This is the format that is most likely used when the dialogue writers type out their dialogue so I figure why not add a possibility to just feed it to an import plugin for instant dialogue testing.

There are some limitations, however. One should not type a node like this:

  7: blah blah
  7a: blah blah blah
  - Blah (8)

Because then the parser would have trouble figuring out how to arrange a line like that.
In a normal situation it would create 2 nodes, one without player options and the other one with them.



}

uses
  SysUtils,
  Forms,
  Classes,
  pluginfunc,
  Dialogs,
  txtparser in 'txtparser.pas',
  improgres in 'improgres.pas' {Form1};

var
  opendlg: TOpenDialog;
var
  i:       integer;
var
  dlg:     dialog;

{$R *.res}

  function GetInterfaceVersion: shortstring; stdcall;
  begin
    ;
    Result := Interface_Version;
  end;

  function GetFilter: shortstring; stdcall;
  begin
    ;
    Result := 'Text files (*.txt)|*.txt';
  end;

  function GetPluginName: ShortString; stdcall;
  begin
    ;
    Result := 'Text file';
  end;

  function GetPluginDescription: ShortString; stdcall;
  begin
    ;
    Result := 'Text file import plugin';
  end;

  function CanAddToMenu: boolean; stdcall;
  begin
    ;
    Result := True;
  end;

  procedure PluginClose; stdcall;
  begin
    ;
  end;


  procedure ImportData(Data: shortstring); stdcall;
  var
    j, i: integer;
  begin
    ;

    senddebugmsg(PChar('Parsing: ' + Data));
    form1 := TForm1.Create(application);

    ParseTXT(Data, dlg);
    form1.JvSpecialProgress1.Maximum  := dlg.nodecount;
    form1.JvSpecialProgress1.Position := 0;
    form1.Show;
    for i := 0 to dlg.nodecount - 1 do
    begin
      ;
      //executescriptlines(pchar('AddNode('''+dlg.nodes[i]^.nodename+''','''+dlg.nodes[i].npctext+''','''+dlg.nodes[i].notes+''');'));
      application.ProcessMessages;
      form1.JvSpecialProgress1.Position := i;
      AddNode(dlg.nodes[i].nodename, dlg.nodes[i].npctext, dlg.nodes[i].notes,
        dlg.nodes[i].npctext_female);
      for j := 0 to dlg.nodes[i].optioncnt - 1 do
      begin
        ;
        executescriptlines(PChar(format('AddPlayerOption(''%s'',''%s'',''%s'',''%s'');',
          [dlg.nodes[i].nodename, dlg.nodes[i].options[j].optiontext, dlg.nodes[i].options[j].nodelink,
          dlg.nodes[i].options[j].notes])));

      end;

    end;

    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_NAME,''%s'');', [dlg.npcname])));
    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_LOCATION,''%s'');', [dlg.location])));
    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_DESCRIPTION,''%s'');', [dlg.description])));
    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_UNKNOWN_LOOK,''%s'');', [dlg.unknowndesc])));
    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_KNOWN_LOOK,''%s'');', [dlg.knowndesc])));
    executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_DETAILED_LOOK,''%s'');', [dlg.detaileddesc])));
    executescriptlines(PChar('RefreshAll;'));
    form1.Hide;
    form1.Free;
    senddebugmsg(PChar('Import done with ' + IntToStr(dlg.nodecount) + ' nodes.'));

    //setdlg(dlg);
  end;


  procedure RunPlugin(basepath: shortstring); stdcall;
  var
    j, i: integer;
  begin
    ;
    //MessageDlg('Hello Hi nothing here yet. OkaY?!1!', mtWarning, [mbOK], 0);
    senddebugmsg('Text Importer initialized.');
    opendlg            := TOpenDialog.Create(NIL);
    opendlg.Filter     := 'Text files (*.txt)|*.txt;All files (*.*)|*.*';
    opendlg.defaultext := 'txt';
    opendlg.initialdir := basepath;
    if opendlg.Execute then
    begin
      ;
      senddebugmsg(PChar('Parsing: ' + opendlg.filename));
      form1 := TForm1.Create(NIL);

      ParseTXT(opendlg.filename, dlg);
      form1.JvSpecialProgress1.Maximum := dlg.nodecount;
      form1.JvSpecialProgress1.Position := 0;
      form1.Show;
      for i := 0 to dlg.nodecount - 1 do
      begin
        ;
        //executescriptlines(pchar('AddNode('''+dlg.nodes[i]^.nodename+''','''+dlg.nodes[i].npctext+''','''+dlg.nodes[i].notes+''');'));
        application.ProcessMessages;
        form1.JvSpecialProgress1.Position := i;
        AddNode(dlg.nodes[i].nodename, dlg.nodes[i].npctext, dlg.nodes[i].notes,
          dlg.nodes[i].npctext_female);
        for j := 0 to dlg.nodes[i].optioncnt - 1 do
        begin
          ;
          executescriptlines(PChar(format('AddPlayerOption(''%s'',''%s'',''%s'',''%s'');',
            [dlg.nodes[i].nodename, dlg.nodes[i].options[j].optiontext, dlg.nodes[i].options[j].nodelink,
            dlg.nodes[i].options[j].notes])));

        end;

      end;

      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_NAME,''%s'');', [dlg.npcname])));
      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_LOCATION,''%s'');', [dlg.location])));
      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_DESCRIPTION,''%s'');', [dlg.description])));
      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_UNKNOWN_LOOK,''%s'');', [dlg.unknowndesc])));
      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_KNOWN_LOOK,''%s'');', [dlg.knowndesc])));
      executescriptlines(PChar(format('SetDialogGlobals(FIELD_NPC_DETAILED_LOOK,''%s'');',
        [dlg.detaileddesc])));
      executescriptlines(PChar('RefreshAll;'));
      form1.Hide;
      form1.Free;
      senddebugmsg(PChar('Import done with ' + IntToStr(dlg.nodecount) + ' nodes.'));

      //setdlg(dlg);
    end;

  end;

exports
  GetPluginName,
  GetFilter,
  ImportData,
  GetPluginDescription,
  SetApplicationHandle,
  CanAddToMenu,
  PluginClose,
  GetInterfaceVersion,
  RunPlugin;

begin

end.

