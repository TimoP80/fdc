{ <title Plugin Export functions>
  
  @author None
  Description
  This is a bare bones example plugin for the Delphi plugin
  SDK. Each exported function is described in detail here.  }

library Utility_Example;

uses
  SysUtils,
  Classes,
  pluginfunc,dialogs;
  
{$R *.res}

// This function should return the name of the plugin to be
// displayed in the menu of the host application
function GetPluginName: ShortString; stdcall;
begin
result := 'Delphi SDK Example plugin';
end;

// This function should return a more detailed description of the plugin
function GetPluginDescription: ShortString; stdcall;
begin
result := 'Just an example';
end;
{ Summary
  Determines if the plugin can be added to the main menu.
  Description
  This function
  @return <b>True </b>if the plugin can be added to the menu
  
  <b>False</b> if the plugin should remain hidden (for example.
  called by helper scripts only)                                }
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


// This procedure is called when the plugin needs to update its display
// due to changes made to the dialogue
//
procedure PluginUpdate; stdcall;
begin
end;


// This function is used when you want to receive debug messages from the
// host application
//
procedure DebugIntercept (msg: pchar); stdcall;
begin
end;

// This should contain pluginConfig!1
// This procedure defines the code for launching a configuration dialog box
procedure PluginConfig (basepath: shortstring); stdcall;
begin
end;


// This function should return a key shortcut to be used in the menu
// format is:
// CTRL|ALT|SHIFT+<key> [A-Z]
// examples: CTRL+B, ALT+A, CTRL+ALT+H
//
function GetKeyShortCut: shortstring; stdcall;
begin;
result := '';
end;

// This function is automatically set to return the interface version
// that is defined in the pluginfunc unit.
function GetInterfaceVersion: shortstring; stdcall;
begin
result := interface_version;
end;

{ This is the main procedure for the plugin.
  
  If you want the plugin to display a non-modal dialog you
  should make a while..do loop such as:
  
  <pre>
   while Form1.visible do
   begin;
   application.processmessages
   end;
  </pre>
  
  This will allow the plugin to run in the background and it
  will return from this procedure after the window is closed
  either by a button or the exit callback function PluginClose
  
  The basepath parameter contains the current path (the root of
  the host application)                                         }

procedure RunPlugin (basepath: shortstring); stdcall;
begin
end;

exports
   GetPluginName,PluginClose, PluginUpdate,
   GetPluginDescription, DebugIntercept,
   PluginConfig,
   CanAddToMenu,
   RunPlugin,
   GetKeyShortCut,
   GetInterfaceVersion;

begin

end.
