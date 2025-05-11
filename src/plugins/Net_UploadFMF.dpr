library Net_UploadFMF;

{

FMF Dialogue tool plugin

Plugin Name: Upload dialogue to FMF server
Author: DjUnique

Description:

This plugin is exclusively made for the FMF team for uploading their dialogue files to the ftp server. It should make things less painful for those without knowledge on how to operate FTP clients.

}

uses
  WIndows,Forms,ftpwnd in 'ftpwnd.pas', pluginfunc, SysUtils;

{$R *.res}

 // This function should return the name of the plugin to be
 // displayed in the menu of the host application
  function GetPluginName: ShortString; stdcall;
  begin
    Result := 'Upload dialogue to FMF server...';
  end;

  // This function should return a more detailed description of the plugin
  function GetPluginDescription: ShortString; stdcall;
  begin
    Result := 'This plugin is exclusively made for the FMF team for uploading their dialogue files to the ftp server. It should make things less painful for those without knowledge on how to operate FTP clients.';
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
    senddebugmsg('PluginUpdate called!');
    if form1.Visible = True then
    begin;
      the_dlg := GetDLGNew;
      form1.ftpclient1.HostFileName := extractfilename(the_dlg.filename);
      form1.FtpClient1.HostDirName := '/dialogue/' + form1.ComboBox1.Text;
      url     := 'http://www.fanmadefallout.com/project/dialogue/' + form1.ComboBox1.Text +
        '/' + form1.ftpclient1.HostFileName;
      form1.Memo1.Text := url;
      Form1.JvMarkupLabel1.Text := format(labeltemplate, [the_dlg.filename, the_dlg.npcname,
        the_dlg.location, the_dlg.description, the_dlg.nodecount]);
    end;

  end;




  // This should contain pluginConfig!1
  // This procedure defines the code for launching a configuration dialog box


  // This function should return a key shortcut to be used in the menu
  // format is:
  // CTRL|ALT|SHIFT+<key> [A-Z]
  // examples: CTRL+B, ALT+A, CTRL+ALT+H

  function GetKeyShortCut: shortstring; stdcall;
  begin;
    Result := '';
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

    form1 := TForm1.Create(NIL);
    initdata;
    form1.Show;

    while form1 <> NIL do
    begin;
      application.ProcessMessages;
    end;



    //   form1.Free;
    //    application.
  end;

exports
  GetPluginName, PluginClose,
  // PluginUpdate,
  GetPluginDescription,

  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  SetApplicationHandle,
  GetInterfaceVersion;

begin

end.

