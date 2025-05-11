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

unit helpscreen;

interface

uses
  Classes, Controls, debugwnd, Dialogs, Forms,
  Graphics, Inifiles, JvExStdCtrls, JvRichEdit,ShellApi, Messages,  StdCtrls, SysUtils, Variants, Windows;
type
  TForm28 = class(TForm)
    Button1: TButton;
    Memo1:   TJvRichEdit;
    Label1:  TLabel;
    procedure HelpButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DisplayHelp(Caption: string; filename: string);
    procedure FormCreate(Sender: TObject);
    procedure Memo1URLClick(Sender: TObject; const URLText: String;
      Button: TMouseButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form28:   TForm28;
  button:   TButton;
  help_ini: TInifile;
procedure GenerateHelpButton(formsrc: TForm);

implementation

{$R *.dfm}

function _MyGetControlByName(form: TForm; Name: string): TWinControl;
var t: integer;
begin

  Result := NIL;
  for t := 0 to form.ComponentCount - 1 do
  begin
    if form.Components[t].Name = Name then
    begin
      Result := TWinControl(form.Components[t]);
      exit;
    end;

  end;

end;

procedure GenerateHelpButton(formsrc: TForm);
var section:       string;
var helpenabled, multibutton: boolean;
var firstrunfound: boolean;
var i:             integer;
var Count:         integer;
begin
  help_ini := TInifile.Create(extractfiledir(ParamStr(0)) + '\helpdata\help_data.ini');
  section  := help_ini.readstring('help_data_main', formsrc.Name, '');
  if section = '' then
  begin
    if (formsrc.Caption <> '') and (ParamStr(1) = '/regeneratehelp') then
    begin
      help_ini.WriteString('help_data_main', formsrc.Name, formsrc.Caption);
      help_ini.writebool(formsrc.Caption, 'HelpEnabled', False);
    end;

    exit;
  end;

  if section <> '' then
  begin
    helpenabled := help_ini.readbool(section, 'HelpEnabled', True);
    if helpenabled = False then
    begin
      exit;
    end;
    firstrunfound := (help_ini.ReadBool(formsrc.Caption, 'FirstRun', False) = True);

    if firstrunfound = False then
    begin
      help_ini.WriteBool(formsrc.Caption, 'FirstRun', True);
      debugmsg(formsrc.Name + ': Flagging help as first run pop up.');
    end;

    multibutton := help_ini.ReadBool(section, 'MultipleButtons', False);
    if multibutton = True then
    begin
      Count := help_ini.readinteger(section, 'Count', 0);
      for i := 0 to Count - 1 do
      begin
        button          := TButton.Create(formsrc);
        button.parent   := _MyGetControlByName(formsrc, help_ini.readstring(section, 'Button' +
          IntToStr(i + 1) + 'Parent', ''));
        button.Left     := help_ini.readinteger(section, 'Button' + IntToStr(i + 1) + 'Left', 8);
        button.Top      := help_ini.readinteger(section, 'Button' + IntToStr(i + 1) + 'Top', 448);
        button.Width    := help_ini.readinteger(section, 'Button' + IntToStr(i + 1) + 'Width', 65);
        button.Height   := help_ini.readinteger(section, 'Button' + IntToStr(i + 1) + 'Height', 25);
        button.Caption  := 'Help';
        button.OnClick  := Form28.HelpButtonClick;
        button.Visible  := True;
        button.Hint     := 'Display ' + help_ini.readstring(section, 'Button' + IntToStr(i + 1) + 'Caption', '');
        button.showhint := True;
      end;

    end else
    begin
      button          := TButton.Create(formsrc);
      button.parent   := formsrc;
      button.Left     := help_ini.readinteger(section, 'ButtonLeft', 8);
      button.Top      := help_ini.readinteger(section, 'ButtonTop', 448);
      button.Width    := help_ini.readinteger(section, 'ButtonWidth', 65);
      button.Height   := help_ini.readinteger(section, 'ButtonHeight', 25);
      button.Caption  := 'Help';
      button.OnClick  := Form28.HelpButtonClick;
      button.Visible  := True;
      button.Hint     := 'Display ' + help_ini.readstring(section, 'Caption', '');
      button.showhint := True;
    end;

  end;
  help_ini.Free;
end;


procedure Tform28.DisplayHelp(Caption: string; filename: string);
begin
  self.Caption := Caption;
  debugmsg('Loading help: ' + extractfiledir(ParamStr(0)) + '\helpdata\' + filename);
  self.Memo1.Lines.LoadFromFile(extractfiledir(ParamStr(0)) + '\helpdata\' + filename);
end;


function GetButtonByParent(section, parentname: string): integer;
var i:     integer;
var Count: integer;
begin
  Result := -1;
  Count  := help_ini.readinteger(section, 'Count', 0);
  for i := 0 to Count - 1 do
  begin
    if help_ini.readstring(section, 'Button' + IntToStr(i + 1) + 'Parent', '') = parentname then
      Result := i + 1;
  end;

end;

procedure Tform28.HelpButtonClick(Sender: TObject);
var helpfilename, helpfilecaption: string;
var multibutton: boolean;
var section:     string;
begin
  help_ini    := TInifile.Create(extractfiledir(ParamStr(0)) + '\helpdata\help_data.ini');
  section     := help_ini.readstring('help_data_main', TComponent(TControl(Sender).owner).Name, '');
  multibutton := help_ini.ReadBool(section, 'MultipleButtons', False);
  if section <> '' then
  begin
    debugmsg('Finding help in section: ' + section);
    if multibutton = True then
    begin

      helpfilename    := help_ini.readstring(section, 'Button' +
        IntToStr(GetButtonByParent(section, TControl(Sender).parent.Name)) + 'HelpFile', '');
      helpfilecaption := help_ini.readstring(section, 'Button' +
        IntToStr(GetButtonByParent(section, TControl(Sender).parent.Name)) + 'Caption', '');

    end else
    begin
      helpfilename    := help_ini.readstring(section, 'HelpFile', '');
      helpfilecaption := help_ini.readstring(section, 'Caption', '');
    end;

    form28.Show;
    Form28.DisplayHelp(helpfilecaption, helpfilename);

  end;

  help_ini.Free;

end;

procedure TForm28.Button1Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm28.FormCreate(Sender: TObject);
begin
  // init help system

end;

procedure TForm28.Memo1URLClick(Sender: TObject; const URLText: String;
  Button: TMouseButton);
begin
 
     ShellExecute(0, 'open',pchar(urltext),
                  nil,nil,0);
end;

end.

