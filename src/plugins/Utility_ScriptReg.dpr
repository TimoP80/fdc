library Utility_ScriptReg;

{

FMF Dialogue tool plugin

Plugin Name: Register Script
Author: DjUnique

Description:

This plugin is a simple tool for registering script in the Fallout 2 data files.

}

uses
  SysUtils,
  Controls,
  Forms,
  Classes,
  Inifiles,
  VCL.Themes, VCL.Styles,
  pluginfunc,
  Dialogs,
  regscrunit in 'regscrunit.pas' {Form1},
  ScriptRegister in '..\ScriptRegister.pas',
  ScriptRegConfig in 'ScriptRegConfig.pas' {Form2};

{$R *.res}
{$R VCLStyles.res}

var
  cfg: TInifile;

  // This function should return the name of the plugin to be
  // displayed in the menu of the host application

function GetPluginName: ShortString; stdcall;
begin
  Result := 'Register Script';
end;

// This function should return a more detailed description of the plugin

function GetPluginDescription: ShortString; stdcall;
begin
  Result :=
    'Registers a script into the data files (scripts.h, scripts.lst, scrname.msg)';
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

// This function should return a key shortcut to be used in the menu
// format is:
// CTRL|ALT|SHIFT+<key> [A-Z]
// examples: CTRL+B, ALT+A, CTRL+ALT+H

function GetKeyShortCut: shortstring; stdcall;
begin
  Result := 'Shift+Alt+R';
end;

// This function is automatically set to return the interface version
// that is defined in the pluginfunc unit.

function GetInterfaceVersion: shortstring; stdcall;
begin
  Result := interface_version;
end;

procedure PluginConfig; stdcall;
begin
  cfg := TInifile.Create(getcurrentdir + '\fmfdlg.ini');
    datapath := InputBox('Enter data path',
      'Enter data path name to find scripts.lst from:', '');
  Form2 := TForm2.Create(application);
  form2.Edit1.Text := cfg.ReadString('RegisterScript config', 'datapath', '');

  form2.ShowModal;
  if form2.modalresult = mrOk then
    cfg.WriteString('RegisterScript config', 'datapath', form2.edit1.text);

  form2.Free;

 // cfg.Free;
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
tstylemanager.TrySetStyle(GetStyle);
   form1 := TForm1.Create(application);
  cfg := TInifile.Create(basepath + '\fdc.ini');
  fo2basepath := cfg.ReadString('Global Config', 'FO2Basepath', '');
  headerspath := cfg.ReadString('Global Config', 'HeadersPath', '');
  datapath := cfg.ReadString('RegisterScript config', 'datapath', 'data');

  if (fo2basepath = '') and (headerspath = '') then
  begin
    MessageDlg('Fallout 2 base path + Script headers path not configured properly!'
      +
      #13 + #10 + '' + #13 + #10 +
        'You can configure them from File->Preferences.',
      mtWarning, [mbOK], 0);
    exit;
  end;

  if (directoryexists(fo2basepath + '\' + datapath + '\scripts') = False) then
  begin
    MessageDlg(format('It looks like you don''t have a ''scripts'' folder ' +
      #13 + #10 + 'in %s' + #13 + #10 + '' + #13 + #10 +
      'The script registration plugin requires the' + #13 + #10 +
      'contents of patch000.dat to be extracted' + #13 + #10 +
      'before being able to perform any operations.', [fo2basepath + '\' +
        datapath]),
      mtWarning, [mbOK], 0);
    exit;
  end;

  form1.Show;
 LoadScriptList(fo2basepath + '\' + datapath + '\scripts\scripts.lst');
 RefreshScripts;

  while (form1.Visible <> False) do
  begin
   application.ProcessMessages;
  end;
   TStyleManager.TrySetStyle(TStyleManager.SystemStyle.Name);
 form1.Free;
end;

exports
  GetPluginName,
  PluginClose,
  PluginUpdate,
  GetPluginDescription,
  PluginConfig,
  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  GetInterfaceVersion;

begin

end.

