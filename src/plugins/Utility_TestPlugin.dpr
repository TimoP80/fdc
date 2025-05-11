library Utility_TestPlugin;

{ 

FMF Dialogue tool plugin 

Plugin Name: Node display test 
Author: DjUnique

Description:

This is a test to see if the plugin refresh callback func works.

}

uses
  forms,
  SysUtils,
  Classes,
  pluginfunc,
  dialogs,
  testwnd in 'testwnd.pas' {Form1};

  var dlg: pdialogue;
      theplayer: playerptr;
{$R *.res}

// This function should return the name of the plugin to be
// displayed in the menu of the host application
function GetPluginName: ShortString; stdcall;
begin;
result := 'Node display test';
end;

// This function should return a more detailed description of the plugin
function GetPluginDescription: ShortString; stdcall;
begin;
result := 'This is just a test plugin to test some stuff.';
end;
function CanAddToMenu: boolean; stdcall;
begin;
result := True;
end;


// This procedure is called when the plugin needs to update its display
// due to changes made to the dialogue
procedure PluginUpdate; stdcall;
var nodestr: string;
begin;
dlg := getdlg;
theplayer := GetPlayer;
form1.Label2.Caption := format('%d nodes in dialogue. Player name: %s',[dlg.nodecount,theplayer.name]);
nodestr:=getcurrentnode;
if nodestr<>'' then
form1.Label3.Caption := 'Dialogue is running at node '+nodestr else
form1.label3.caption := 'Dialogue is not running.';

end;

procedure PluginClose; stdcall;
begin;
form1.close;

end;

// This function should return a key shortcut to be used in the menu
// format is:
// CTRL|ALT|SHIFT+<key> [A-Z]
// examples: CTRL+B, ALT+A, CTRL+ALT+H
//
function GetKeyShortCut: shortstring; stdcall;
begin;
result := 'Ctrl+Alt+N';
end;

procedure DebugIntercept(msg: pchar); stdcall;
begin;
if form1<>nil then
begin;

form1.memo1.lines.add(msg);

end;

end;

// This function is automatically set to return the interface version
// that is defined in the pluginfunc unit.
function GetInterfaceVersion: shortstring; stdcall;
begin;
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

procedure RunPlugin (basepath: shortstring); stdcall;
begin;
New(dlg);
//dlg := GetDLG;
new(theplayer);
form1 := TForm1.create(nil);

form1.show;
PluginUpdate;
//theplayer := GetPlayer;
form1.Label2.Caption := format('%d nodes in dialogue. Player name: %s',[dlg.nodecount,theplayer.name]);

while form1.visible do
begin;
application.processmessages;
end;

form1.free;


end;

exports
   GetPluginName,
   PluginUpdate,
   GetPluginDescription,
   CanAddToMenu,
   RunPlugin, DebugIntercept,
   GetKeyShortCut,
   GetInterfaceVersion,
   PluginClose;

begin

end.
