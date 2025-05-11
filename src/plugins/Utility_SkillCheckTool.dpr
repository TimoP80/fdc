library Utility_SkillCheckTool;

{

FMF Dialogue tool plugin

Plugin Name: Skill Check Tool
Author: DjUnique

Description:

This plugin will scan the dialogue for player options that contain the text 'skill check' or something similar and list them in a listbox. Then you can create a skillcheck for each of them.

}

uses
  chtoolwin in 'chtoolwin.pas',
  Classes,
  ComCtrls,
  Dialogs,
  Forms,  VCL.Themes, VCL.Styles,
  pluginfunc,
  SysUtils;

{$R *.res}
{$R VCLStyles.res}

 // This function should return the name of the plugin to be
 // displayed in the menu of the host application

  procedure UpdateOptions;
  var
    l_item: TListItem;
  var
    i, t: Integer;
  begin
    ;
    form1.listview1.Clear;
    form1.edit1.Text := '';
    form1.edit2.Text := '';
    form1.memo1.Text := '';
    form1.memo2.Text := '';
    form1.combobox1.ItemIndex := -1;
    form1.label6.Caption := '';

    for t := 0 to teh_Dlg.nodecount - 1 do
    begin
      ;
      for i := 0 to teh_dlg.nodes[t].optioncnt - 1 do
      begin
        ;
        if (((pos('check', teh_dlg.nodes[t].options[i].notes) <> 0) or (pos('test', teh_dlg.nodes[t].options[i].notes) <> 0)) and
          (pos('failed', teh_dlg.nodes[t].options[i].notes) <> 0) and (teh_dlg.nodes[t].options[i].link_to_skillcheck = False) and
          (teh_dlg.nodes[t].options[i].link_to_proc = False)) then
        begin
          ;
          l_item := form1.listview1.items.add;

          l_item.Caption := teh_dlg.nodes[t].nodename;
          l_item.subitems.add(IntToStr(i));
          l_item.subitems.add(teh_dlg.nodes[t].options[i].notes);

        end;
      end;

    end;

  end;

  function GetPluginName: ShortString; Stdcall;
  begin
    Result := 'Skill Check Tool';
  end;

  // This function should return a more detailed description of the plugin
  function GetPluginDescription: ShortString; Stdcall;
  begin
    Result := 'A quicker way to add skill checks to existing player options';
  end;

  function CanAddToMenu: Boolean; Stdcall;
  begin
    Result := True;
  end;

  // This procedure is called when the host application is
  // being closed. Here you should make sure the plugin
  // closes all windows it has opened.
  procedure PluginClose; Stdcall;
  begin
    form1.Close;

  end;


  // This procedure is called when the plugin needs to update its display
  // due to changes made to the dialogue

  procedure PluginUpdate; Stdcall;
  begin
    teh_dlg := GetDLGNew;
    UpdateOptions;
    if form1.ListView1.items.Count > 0 then
      form1.label6.Caption := IntToStr(form1.listview1.items.Count) + ' player options needing skill checks detected.'
    else
      form1.label6.Caption := 'No potential skill check player options found.';
  end;




  // This should contain pluginConfig!1
  // This procedure defines the code for launching a configuration dialog box
  procedure PluginConfig(basepath: shortstring); Stdcall;
  begin
  end;


  // This function should return a key shortcut to be used in the menu
  // format is:
  // CTRL|ALT|SHIFT+<key> [A-Z]
  // examples: CTRL+B, ALT+A, CTRL+ALT+H

  function GetKeyShortCut: shortstring; Stdcall;
  begin
    ;
    Result := 'Alt+W';
  end;

  // This function is automatically set to return the interface version
  // that is defined in the pluginfunc unit.
  function GetInterfaceVersion: shortstring; Stdcall;
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
  procedure ClosePlugin; Stdcall;
  begin

  end;

  procedure RunPlugin(basepath: shortstring); Stdcall;
  begin
    new(teh_dlg);
    teh_dlg := GetDLGNew;
   tstylemanager.TrySetStyle(GetStyle);
   form1 := Tform1.Create(nil);

    form1.Show;

    updateoptions;
    if form1.ListView1.items.Count > 0 then
      form1.label6.Caption := IntToStr(form1.listview1.items.Count) + ' player options needing skill checks detected.'
    else
      form1.label6.Caption := 'No potential skill check player options found.';
    while form1.Visible do
    begin
      application.ProcessMessages;
    end;
    senddebugmsg('FormAfterClose');
    //  dispose(teh_dlg);
         TStyleManager.TrySetStyle(TStyleManager.SystemStyle.Name); // Reset to default before unloading

     form1.Free;
  end;

exports
  GetPluginName,
  PluginClose,
  PluginUpdate,
  GetPluginDescription,
  // PluginConfig, //
  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  //  SetApplicationHandle,
  GetInterfaceVersion;

begin

end.

