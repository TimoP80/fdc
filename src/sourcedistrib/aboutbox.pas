(*

FMF Dialogue Tool - dialogue editor for Fallout 2 mods
Copyright (C) 2005-2008 T. Pitkänen

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

*)

unit aboutbox;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, pluginapi, Messages, jclPeImage, StdCtrls, SysUtils, Variants,
  Windows, JvExControls,
  JvComponent, JvGradient,ComCtrls, JvExStdCtrls, JvHtControls;
type
  TForm5 = class(TForm)
    Bevel1 :       TBevel;
    Label1 :       TLabel;
    Button1 :      TButton;
    ListBox1 :     TListBox;
    Button2 :      TButton; 
    JvHTLabel1 :   TJvHTLabel;
    Bevel2 :       TBevel;
    JvHTListBox1 : TJvHTListBox;
    Bevel4 :       TBevel;
    Bevel5 :       TBevel;
    Bevel3 :       TBevel;
    Label2 :       TLabel;
    Label3 :       TLabel;
    Label4 :       TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure JvHTLabel1HyperLinkClick(Sender: TObject; LinkName: string);
    procedure JvHTLabel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure JvHTLabel1Click(Sender: TObject);
    procedure JvHTListBox1HyperLinkClick(Sender: TObject; LinkName: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  Form5:       TForm5;
  plugin_info: TJclPeImage;

implementation

uses debugwnd, fmfmain;
{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
  form5.hide;
end;

procedure GetPluginInfo(ind: integer);
var x: TListItem;
var i: integer;
begin
  Form5.JvHTListBox1.Clear;
  plugin_info          := TJclPeImage.Create;
  plugin_info.FileName := dllplugins[ind].filename;
  Form5.JvHTListBox1.Items.Add('<b>Filename:</b> ' + dllplugins[ind].filename);
  Form5.JvHTListBox1.Items.Add('<b>Display name:</b> ' + dllplugins[ind].displayname);
  Form5.JvHTListBox1.Items.Add('<b>Created on:</b> ' + datetimetostr(dllplugins[ind].creationdate));
  Form5.JvHTListBox1.Items.Add('<b>Compiled on:</b> ' + datetimetostr(dllplugins[ind].builddate));
  Form5.JvHTListBox1.Items.Add('<b>Description:</b> ' + wraptext(dllplugins[ind].longdesc,
    '<br>', [',', ' '], 48));
  Form5.JvHTListBox1.Items.Add('<b>Interface Version:</b> ' + dllplugins[ind].interfaceversion);
  Form5.JvHTListBox1.Items.Add('<b>Exported functions: </b> <a href="DoLink_ShowExports(''' +
    dllplugins[ind].filename + ''')">Show</a> [' + IntToStr(plugin_info.ExportList.Count) + ' total]');

  Form5.Button2.Visible := dllplugins[ind].hasconfig;
end;

procedure TForm5.ListBox1Click(Sender: TObject);

begin
  if listbox1.ItemIndex <> -1 then
  begin
    GetPluginInfo(listbox1.ItemIndex);
  end else
  begin
    jvhtlistbox1.Clear;
    button2.Visible := False;
  end;

end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    ExecutePluginConfig(dllplugins[listbox1.ItemIndex].filename);
  end;

end;

procedure TForm5.JvHTLabel1HyperLinkClick(Sender: TObject; LinkName: string);
begin
  debugmsg('Clicked link: ' + linkname);
end;

procedure TForm5.JvHTLabel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  TJvHTLabel(Sender).Canvas.Brush.Style := bsClear;
end;

procedure TForm5.JvHTLabel1Click(Sender: TObject);
begin
  TJVHTLabel(Sender).Canvas.Brush.Style := bsClear;
end;

procedure TForm5.JvHTListBox1HyperLinkClick(Sender: TObject; LinkName: string);
begin
  if (pos('DoLink_', linkname) <> 0) then
  begin
    Form1.ExecuteScriptConsole(linkname);
  end;

end;

end.

