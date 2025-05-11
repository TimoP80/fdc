library FMF_PluginCreator;

{

pluginHelper
by DjUnique

This will help me create new plugins
for FMF Dialogue Tool

}

uses
  Dialogs, SysUtils, plgwind in 'plgwind.pas' {plgwnd};

{$R *.res}

  function GetPluginName: ShortString; stdcall;
  begin;
    Result := 'FMF Plugin Creator';
  end;
  function GetPluginDescription: ShortString; stdcall;
  begin;
    Result := 'Plugin to generate a dpr file for a new plugin.';
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
