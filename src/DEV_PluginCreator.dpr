library DEV_PluginCreator;

{

  pluginHelper
  by DjUnique

  This will help me create new plugins
  for FMF Dialogue Tool

}

uses
  Windows, VCL.Forms, VCL.sysStyles, System.classes, VCL.Themes, VCL.Styles,
  VCL.Dialogs, plgwind in 'plgwind.pas' {plgwnd} , pluginfunc, SysUtils;

{$R *.res}
{$R VCLStyles.res}

procedure PluginClose; stdcall;
begin;
  // plgwnd.Free;
end;

function GetPluginName: ShortString; stdcall;
begin;
  Result := 'FMF Plugin Creator';
end;

function GetPluginDescription: ShortString; stdcall;
begin;
  Result := 'Plugin to generate a dpr file for a new plugin.';
end;

function GetInterfaceVersion: ShortString; stdcall;
begin;
  Result := interface_version;
end;

function CanAddToMenu: boolean; stdcall;
begin;
  Result := True;
end;

procedure RunPlugin(basepath: ShortString); stdcall;
begin;
  plgwnd := Tplgwnd.Create(nil);
  dabasepath := basepath;
  tstylemanager.TrySetStyle(GetStyle);
  plgwnd.showmodal;
  tstylemanager.TrySetStyle(tstylemanager.SystemStyle.Name);
  plgwnd.free;
  Dispose(dlg);
dispose(theplayer);
end;



exports
  GetPluginName,
  PluginClose,
  SetApplicationHandle,
  GetInterfaceVersion, CanAddToMenu,
  GetPluginDescription,
  RunPlugin;

begin

end.
