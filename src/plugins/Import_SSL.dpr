library Import_SSL;

{

FMF Dialogue tool plugin

Plugin Name: SSL + MSG
Author: T. Pitk�nen

Description:

SSL Importer. Works currently for basic scripts only.

}

uses
  SysUtils,
  Classes, Forms, inifiles, stdctrls, controls,
  SSLParser,SSLImportUnit,
  Dialogs, Messages, MSGParser,    SSLPreprocessingPass,
  pluginfunc,

  SSLImportMain in 'SSLImportMain.pas' {SSLForm};

var
  themsg: TMSGParser;
  sslparser: TScript;
  sslcfg: Tinifile;
{$R *.res}

  // This function should return the name of the plugin to be
  // displayed in the menu of the host application

function GetPluginName: ShortString; stdcall;
begin
  result := 'SSL + MSG';
end;

// This function should return a more detailed description of the plugin

function GetPluginDescription: ShortString; stdcall;
begin
  result := 'SSL Importer';
end;

function CanAddToMenu: boolean; stdcall;
begin
  result := True;
end;

// This procedure is called when the host application is
// being closed. Here you should make sure the plugin
// closes all windows it has opened.

procedure PluginClose; stdcall;
begin
end;

// This function should return a key shortcut to be used in the menu
// format is:
// CTRL|ALT|SHIFT+<key> [A-Z]
// examples: CTRL+B, ALT+A, CTRL+ALT+H
//

function GetKeyShortCut: shortstring; stdcall;
begin
  ;
  result := '';
end;

// This function is automatically set to return the interface version
// that is defined in the pluginfunc unit.

function GetInterfaceVersion: shortstring; stdcall;
begin
  result := interface_version;
end;

// This is the main procedure for the plugin.
//
// If you want the plugin to display a non-modal dialog
// you should make a while..do loop
// such as:
//
// while Form1.visible do
// begin;
// application.processmessages
// end;
//
// This will allow the plugin to run in the background
// and it will return from this procedure after the window is closed
// either by a button or the exit callback function PluginClose
//
// The basepath parameter contains the current path (the root
// of the host application)

procedure UpdateNodes;
begin
end;

procedure RunPlugin(basepath: shortstring); stdcall;
var
  z, x: integer;
  scriptdata: tstringlist;
begin
  sslcfg := Tinifile.Create(basepath + '\sslimport.cfg');
  sslform := TSSLForm.create(nil);
  scriptdata := TStringlist.create;
  sslform.opendlgssl.InitialDir := sslcfg.ReadString('Main', 'SSLPath', '');
  sslform.opendlgmsg.InitialDir := sslcfg.ReadString('Main', 'MSGPath', '');
  sslform.opendlgmsg.execute;
  sslform.opendlgssl.execute;
  themsg := tmsgparser.create(nil);
  themsg.sourcefilename := sslform.opendlgmsg.FileName;

  themsg.Execute;
  if themsg.Successful then
  begin
    SendDebugMSG(pchar('Parsed msg file, ' +
      inttostr(CurrentMessageFile.entrycnt) + ' entries found.'));
    sslparser := TScript.create;
    Preprocess(sslform.opendlgssl.FileName);
    scriptdata.LoadFromFile(sslform.opendlgssl.filename);

    sslparser.ParseScript(scriptdata);
    savedlgdata(changefileext(sslform.opendlgssl.filename,'.fmf'), extractfilename(sslform.opendlgssl.filename));
    //ParseS(sslform.opendlgssl.FileName);
   // updatenodes;
    ExecuteScriptLines(pchar('LoadDialogue('''+changefileext(sslform.opendlgssl.filename,'.fmf')+''')'));
    scriptdata.free;
    SendDebugMSG(pchar('Dialogue saved to '+changefileext(sslform.opendlgssl.filename,'.fmf')));
    themsg.free;
    sslform.free;
  end;
end;

exports
  GetPluginName, PluginClose,
  GetPluginDescription,
  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  GetInterfaceVersion;

begin

end.

