library DEV_PluginCreator;

{

pluginHelper
by DjUnique

This will help me create new plugins
for FMF Dialogue Tool

}

uses
  Windows, Forms, Dialogs, plgwind in 'plgwind.pas' {plgwnd}, pluginfunc, SysUtils;

{$R *.res}
  procedure PluginClose; stdcall;
  begin;
//    plgwnd.Free;
  end;


  function GetPluginName: ShortString; stdcall;
  begin;
    Result := 'FMF Plugin Creator';
  end;
  function GetPluginDescription: ShortString; stdcall;
  begin;
    Result := 'Plugin to generate a dpr file for a new plugin.';
  end;
  function GetInterfaceVersion: shortstring; stdcall;
  begin;
    Result := interface_version;
  end;

  function CanAddToMenu: boolean; stdcall;
  begin;
    Result := True;
  end;

  procedure RunPlugin(basepath: shortstring); stdcall;
  begin;
    plgwnd     := Tplgwnd.Create(application);
    dabasepath := basepath;

    plgwnd.showmodal;
    plgwnd.free;
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

