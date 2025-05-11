library WE_PluginHelper;

{

pluginHelper
by DjUnique

This will help me create new plugins
for WareLord tools

}

uses
  Dialogs, SysUtils, plgwind in 'plgwind.pas' {plgwnd};

{$R *.res}

  function GetPluginName: ShortString; stdcall;
  begin;
    Result := 'WareLord Plugin Helper';
  end;
  function GetPluginDescription: ShortString; stdcall;
  begin;
    Result := 'Plugin to generate a dpr file for a new plugin. Weird. Eh.';
  end;

  function CanAddToMenu: boolean; stdcall;
  begin;
    Result := True;
  end;

  procedure RunPlugin(basepath: shortstring); stdcall;
  begin;
    plgwnd     := Tplgwnd.Create(nil);
    dabasepath := basepath;

    plgwnd.showmodal;

    plgwnd.Free;
  end;

exports
  GetPluginName, CanAddToMenu,
  GetPluginDescription,
  RunPlugin;

begin

end.
