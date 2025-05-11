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

unit prefs;

interface

uses
  Classes, ComCtrls, Controls, debugwnd, Dialogs, ExtCtrls, fmfmain, Forms,
  Graphics, JvComCtrls, JvComponent, JvExComCtrls,
  JvExControls, JvExMask, JvLabel, JvSpin, JvToolEdit, Mask, Messages, Registry, StdCtrls,
  SysUtils, Variants, Windows, JvComponentBase, JvExStdCtrls, JvCombobox,
  JvColorCombo;

type
  TForm10 = class(TForm)
    JvPageControl1:       TJvPageControl;
    TabSheet1:            TTabSheet;
    Button1:              TButton;
    Button2:              TButton;
    TabSheet2:            TTabSheet;
    Label1:               TLabel;
    Edit1:                TEdit;
    Label2:               TLabel;
    Edit2:                TEdit;
    UpDown1:              TUpDown;
    Label3:               TLabel;
    Edit3:                TEdit;
    UpDown2:              TUpDown;
    TabSheet3:            TTabSheet;
    JvLabel1:             TJvLabel;
    JvDirectoryEdit1:     TJvDirectoryEdit;
    JvLabel2:             TJvLabel;
    JvDirectoryEdit2:     TJvDirectoryEdit;
    JvDirectoryEdit3:     TJvDirectoryEdit;
    Label4:               TLabel;
    Label5:               TLabel;
    JvDirectoryEdit4:     TJvDirectoryEdit;
    Label6:               TLabel;
    JvSpinEdit1:          TJvSpinEdit;
    Button3:              TButton;
    debug:                TCheckBox;
    checkupdates:         TCheckBox;
    compwarn:             TCheckBox;
    CheckBox3:            TCheckBox;
    autonodemap:          TCheckBox;
    runtimedlgedit:       TCheckBox;
    evalcond:             TCheckBox;
    last_trans:           TCheckBox;
    savenodehist:         TCheckBox;
    CheckBox1:            TCheckBox;
    CheckBox2:            TCheckBox;
    TabSheet4:            TTabSheet;
    ListBox1:             TListBOx;
    Label7:               TLabel;
    Button4:              TButton;
    Button5:              TButton;
    Button6:              TButton;
    GroupBox1:            TGroupBox;
    Label10:              TLabel;
    badColor:             TJvColorComboBox;
    goodColor:            TJvColorComboBox;
    Label9:               TLabel;
    Label8:               TLabel;
    neutralColor:         TJvColorComboBox;
    Label11:              TLabel;
    dumbcolor:            TJvColorComboBox;
    dumboptcolormode:     TCheckBox;
    Label12:              TLabel;
    skillsimulations:     TJvSpinEdit;
    Label13:              TLabel;
    fo2datapath:          TJvDirectoryEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure xaWhatsThis1InvokePopupEvent(Sender: TComponent; X, Y: Integer; Control: TControl; var Handled: Boolean);
    procedure xaWhatsThis1ClickControl(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Control: TControl);
    procedure xaWhatsThis1Acivate(Sender: TObject);
    procedure xaWhatsThis1Click(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Handled: Boolean);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form10: TForm10;
  reg:    TRegistry;

implementation



{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
  cfg.writeBool('Global Config', 'Check for updates at startup', checkupdates.Checked);
  cfg.writeBool('Global Config', 'Debugmode', debug.Checked);
  cfg.writeString('Global Config', 'FO2Basepath', JvDirectoryEdit4.Text);

  cfg.writebool('Global Config', 'AutoSave', checkbox3.Checked);
  if checkbox3.Checked = True then
    cfg.writeinteger('Global Config', 'AutoSaveInterval', (trunc(jvspinedit1.Value) * 60) * 1000);
  cfg.writeBool('Global Config', 'Savenodehistory', savenodehist.Checked);
  cfg.writeBool('Global Config', 'AutoRemapNodes', autonodemap.Checked);
  cfg.writeBool('Global Config', 'ShowLastDialogue', last_trans.Checked);
  cfg.writeBool('Global Config', 'PluginCompatibilityWarnings', compwarn.Checked);
  cfg.writeBool('Global Config', 'RuntimeDLGEditing', runtimedlgedit.Checked);

  cfg.writeinteger('Dialogue Engine', 'NumSkillSimulations', TRUNC(skillsimulations.Value));

  cfg.writestring('Global Config', 'FO2DataPath', fo2datapath.Text);
  cfg.writestring('Global Config', 'HeadersPath', JvDirectoryEdit3.Text);
  cfg.writestring('Global Config', 'DefaultSSLPath', JvDirectoryEdit1.Text);
  cfg.writestring('Global Config', 'DefaultMSGPath', JvDirectoryEdit2.Text);
  cfg.writestring('Global Config', 'ClonedNodeFormatString', edit1.Text);
  cfg.writeInteger('Global Config', 'DefaultIntForSmartPlayer', UpDown1.position);
  cfg.writeInteger('Global Config', 'DefaultIntForDumbPlayer', UpDown2.position);
  cfg.writeBool('Dialogue Engine', 'EvaluateConditions', form10.evalcond.Checked);
  cfg.writeBool('Dialogue Engine', 'EvaluateSkillChecks', form10.checkbox2.Checked);
  good_col := Form10.goodColor.ColorValue;
  bad_col  := Form10.badColor.ColorValue;
  neutral_col := Form10.neutralColor.ColorValue;
  dumb_col := Form10.dumbcolor.ColorValue;
  numskillsimulations := trunc(form10.skillsimulations.Value);
  cfg.writeBool('Dialogue Engine', 'DumbOptColorMode', form10.dumboptcolormode.Checked);
  cfg.writestring('Dialogue Engine', 'Good Reaction Color', ColorToString(good_col));
  cfg.writestring('Dialogue Engine', 'Bad Reaction Color', ColorToString(bad_col));
  cfg.writestring('Dialogue Engine', 'Neutral Reaction Color', ColorToString(neutral_col));
  cfg.writestring('Dialogue Engine', 'Dumb Player Option Color', ColorToString(dumb_col));
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;

end;

procedure TForm10.FormCreate(Sender: TObject);
var
  t: Integer;
begin
  JvPageControl1.ActivePage := TabSheet1;

end;

procedure TForm10.xaWhatsThis1InvokePopupEvent(Sender: TComponent; X, Y: Integer; Control: TControl; var Handled: Boolean);
begin
  debugmsg('Popup invoked on :' + control.Name);
end;

procedure TForm10.xaWhatsThis1ClickControl(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Control: TControl);
begin
  debugmsg('Clicked control: ' + control.Name);
end;

procedure TForm10.xaWhatsThis1Acivate(Sender: TObject);
begin
  debugmsg('OnActivate.');
end;

procedure TForm10.xaWhatsThis1Click(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Handled: Boolean);
begin
  debugmsg('Click: ' + IntToStr(x) + ', ' + IntToStr(y));
  handled := True;
end;

procedure TForm10.CheckBox3Click(Sender: TObject);
begin
  if checkbox3.Checked = True then
  begin
    Label6.Visible := True;
    JvSpinEdit1.Visible := True;
  end else
  begin
    Label6.Visible := False;
    JvSpinEdit1.Visible := False;
  end;

end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  reg := Tregistry.Create;
  reg.rootkey := HKEY_LOCAL_MACHINE;
  if reg.openkey('SOFTWARE\Interplay\Fallout2\1.0', False) then
  begin
    jvdirectoryedit4.Text := reg.readstring('DestPath');
    reg.closekey;

  end else
  begin
    debugmsg('Trying alternate key "Fallout 2"');
    if reg.openkey('SOFTWARE\Interplay\Fallout 2\1.0', False) then
    begin
      jvdirectoryedit4.Text := reg.readstring('DestPath');
      reg.closekey;
      debugmsg('Got i1!');

    end;
    debugmsg('Can''t open registry key');
    MessageDlg('Registry key not found!' + #13 + #10 + '' + #13 + #10 + 'Expected:' + #13 + #10 + 'HKEY_LOCAL_MACHiNE\SOFTWARE\Fallout2\1.0\DestPath' +
      #13 + #10 + 'or' + #13 + #10 + 'HKEY_LOCAL_MACHiNE\SOFTWARE\Fallout 2\1.0\DestPath', mtWarning, [mbOK], 0);
  end;

end;

procedure TForm10.sCheckBox1Click(Sender: TObject);
begin
  // form1.skindata1.Active := scheckbox1.Checked;

end;

procedure TForm10.ListBox1Click(Sender: TObject);
begin
  //Form1.SkinData1.LoadFromCollection(form1.SkinStore1, ListBox1.ItemIndex);
  // form1.skindata1.SkinForm(form10.handle);
end;

end.

