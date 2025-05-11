library Utility_GraphicsView;

{

FMF Dialogue tool plugin

Plugin Name: Fancy Snazzy Plugin
Author: T. Pitkänen

Description:

Just some stupid crap I whipzored upzors

}

uses
  Forms,
  GR32,
  SysUtils,
  Classes,
  pluginfunc,
  Dialogs,
  MainWnd in 'MainWnd.pas' {Form1};

{$R *.res}

 // This function should return the name of the plugin to be
 // displayed in the menu of the host application
  function GetPluginName: ShortString; stdcall;
  begin
    Result := 'In-Game Dialogue preview';
  end;

  // This function should return a more detailed description of the plugin
  function GetPluginDescription: ShortString; stdcall;
  begin
    Result := 'This plugin uses graphics from Fallout 2 and attempts to emulate the actual game dialogue screen. The font is Red''s Fallouty font that was available from www.nma-fallout.com';
  end;

  function CanAddToMenu: boolean; stdcall;
  begin
    Result := True;
  end;

  // This procedure is called when the host application is
  // being closed. Here you should make sure the plugin
  // closes all windows it has opened.
  procedure PluginClose; stdcall;
  begin
  end;


  // This procedure is called when the plugin needs to update its display
  // due to changes made to the dialogue

  procedure PluginUpdate; stdcall;
  begin
  end;




  // This should contain pluginConfig!1


  // This function should return a key shortcut to be used in the menu
  // format is:
  // CTRL|ALT|SHIFT+<key> [A-Z]
  // examples: CTRL+B, ALT+A, CTRL+ALT+H

  function GetKeyShortCut: shortstring; stdcall;
  begin
    ;
    Result := 'Shift+Ctrl+E';
  end;

  // This function is automatically set to return the interface version
  // that is defined in the pluginfunc unit.
  function GetInterfaceVersion: shortstring; stdcall;
  begin
    Result := interface_version;
  end;

  // This is the main procedure for the plugin.

  // If you want the plugin to display a non-modal dialog
  // you should make a while..do loop
  // such as:

  // while Form1.visible do
  // begin;
  // application.processmessages
  // end;

  // This will allow the plugin to run in the background
  // and it will return from this procedure after the window is closed
  // either by a button or the exit callback function PluginClose

  // The basepath parameter contains the current path (the root
  // of the host application)

  procedure RunPlugin(basepath: shortstring); stdcall;
  begin
    form1 := TForm1.Create(nil);
    form1.Show;
    form1.Image321.Bitmap.Font.Name := 'Fallouty';
    form1.Image321.Bitmap.Font.Size := 9;


    while form1.Visible do
    begin
    application.processmessages;
    end;

  end;

exports
  GetPluginName,
  PluginClose,
  PluginUpdate,
  GetPluginDescription,

  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  GetInterfaceVersion;

begin

end.
