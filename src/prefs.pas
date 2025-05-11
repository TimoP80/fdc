(*

  Fallout Dialogue Creator - dialogue editor for Fallout 2 mods
  Copyright (C) 2005-2025 T. Pitk�nen

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
  pluginapi, Graphics, JvComCtrls, JvComponent, JvExComCtrls,
  JvExControls, JvExMask, JvLabel, JvSpin, JvToolEdit, Mask, Messages, Registry,
  StdCtrls,
  JclFileUtils, VCL.Styles, VCL.Themes, SysUtils, Variants, Winapi.Windows,
  JvComponentBase, JvExStdCtrls, JvCombobox,
  JvColorCombo;

type
  TForm10 = class(TForm)
    JvPageControl1: TJvPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    Edit3: TEdit;
    UpDown2: TUpDown;
    TabSheet3: TTabSheet;
    JvLabel1: TJvLabel;
    JvDirectoryEdit1: TJvDirectoryEdit;
    JvLabel2: TJvLabel;
    JvDirectoryEdit2: TJvDirectoryEdit;
    JvDirectoryEdit3: TJvDirectoryEdit;
    Label4: TLabel;
    Label5: TLabel;
    JvDirectoryEdit4: TJvDirectoryEdit;
    Label6: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    Button3: TButton;
    debug: TCheckBox;
    checkupdates: TCheckBox;
    compwarn: TCheckBox;
    CheckBox3: TCheckBox;
    autonodemap: TCheckBox;
    runtimedlgedit: TCheckBox;
    evalcond: TCheckBox;
    last_trans: TCheckBox;
    savenodehist: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    TabSheet4: TTabSheet;
    ListBox1: TListBOx;
    Label7: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    badColor: TJvColorComboBox;
    goodColor: TJvColorComboBox;
    Label9: TLabel;
    Label8: TLabel;
    neutralColor: TJvColorComboBox;
    Label11: TLabel;
    dumbcolor: TJvColorComboBox;
    dumboptcolormode: TCheckBox;
    Label12: TLabel;
    skillsimulations: TJvSpinEdit;
    Label13: TLabel;
    fo2datapath: TJvDirectoryEdit;
    TabSheet5: TTabSheet;
    Label14: TLabel;
    StyleList: TListBOx;
    StyleChangeTimer: TTimer;
    Label15: TLabel;
    globalfontsize: TEdit;
    Label16: TLabel;
    JvFontComboBox1: TJvFontComboBox;
    Label17: TLabel;
    fontpreview: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure xaWhatsThis1InvokePopupEvent(Sender: TComponent; X, Y: Integer;
      Control: TControl; var Handled: Boolean);
    procedure xaWhatsThis1ClickControl(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Control: TControl);
    procedure xaWhatsThis1Acivate(Sender: TObject);
    procedure xaWhatsThis1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; var Handled: Boolean);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure StyleListDblClick(Sender: TObject);
    procedure StyleChangeTimerTimer(Sender: TObject);
    procedure JvFontComboBox1Click(Sender: TObject);
    procedure globalfontsizeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  Private
    FSelectedStyle: string;
  Public
    { Public declarations }
  end;

var
  Form10: TForm10;
  reg: TRegistry;
procedure ListStyles;

implementation

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
  cfg.writeBool('Global Config', 'Check for updates at startup',
    checkupdates.Checked);
  cfg.writeBool('Global Config', 'Debugmode', debug.Checked);
  cfg.writeString('Global Config', 'FO2Basepath', JvDirectoryEdit4.Text);

  cfg.writeBool('Global Config', 'AutoSave', CheckBox3.Checked);
  if CheckBox3.Checked = True then
    cfg.writeinteger('Global Config', 'AutoSaveInterval',
      (trunc(JvSpinEdit1.Value) * 60) * 1000);
  cfg.writeBool('Global Config', 'Savenodehistory', savenodehist.Checked);
  cfg.writeBool('Global Config', 'AutoRemapNodes', autonodemap.Checked);
  cfg.writeBool('Global Config', 'ShowLastDialogue', last_trans.Checked);
  cfg.writeBool('Global Config', 'PluginCompatibilityWarnings',
    compwarn.Checked);
  cfg.writeBool('Global Config', 'RuntimeDLGEditing', runtimedlgedit.Checked);
  cfg.writeString('Global Config', 'StyleName',
    StyleList.Items[StyleList.itemindex]);
  cfg.writeinteger('Dialogue Engine', 'NumSkillSimulations',
    trunc(skillsimulations.Value));

  cfg.writeString('Global Config', 'FO2DataPath', fo2datapath.Text);
  cfg.writeString('Global Config', 'HeadersPath', JvDirectoryEdit3.Text);
  cfg.writeString('Global Config', 'DefaultSSLPath', JvDirectoryEdit1.Text);
  cfg.writeString('Global Config', 'DefaultMSGPath', JvDirectoryEdit2.Text);
  cfg.writeString('Global Config', 'ClonedNodeFormatString', Edit1.Text);
  cfg.writeinteger('Global Config', 'DefaultIntForSmartPlayer',
    UpDown1.position);
  cfg.writeinteger('Global Config', 'DefaultIntForDumbPlayer',
    UpDown2.position);
  cfg.writeBool('Dialogue Engine', 'EvaluateConditions',
    Form10.evalcond.Checked);
  cfg.writeBool('Dialogue Engine', 'EvaluateSkillChecks',
    Form10.CheckBox2.Checked);
  good_col := Form10.goodColor.ColorValue;
  bad_col := Form10.badColor.ColorValue;
  neutral_col := Form10.neutralColor.ColorValue;
  dumb_col := Form10.dumbcolor.ColorValue;
  numskillsimulations := trunc(Form10.skillsimulations.Value);
  cfg.writeBool('Dialogue Engine', 'DumbOptColorMode',
    Form10.dumboptcolormode.Checked);
  cfg.writeString('Dialogue Engine', 'Good Reaction Color',
    ColorToString(good_col));
  cfg.writeString('Dialogue Engine', 'Bad Reaction Color',
    ColorToString(bad_col));
  cfg.writeString('Dialogue Engine', 'Neutral Reaction Color',
    ColorToString(neutral_col));
  cfg.writeString('Dialogue Engine', 'Dumb Player Option Color',
    ColorToString(dumb_col));

    Tstylemanager.TrySetStyle(StyleList.Items[StyleList.itemindex]);
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
  modalresult := mrCancel;

end;

procedure ListStyles;
var
  StyleName: string;

var
  u: Integer;
begin
  Form10.StyleList.Clear;
  for StyleName in TStyleManager.StyleNames do
    Form10.StyleList.Items.Add(StyleName);

end;

procedure TForm10.FormCreate(Sender: TObject);
var
  t: Integer;
begin
  JvPageControl1.ActivePage := TabSheet1;

end;

procedure TForm10.globalfontsizeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
fontpreview.caption := 'This is the new text on '+#13#10+'the selected font.';
fontpreview.font.name := JvFontComboBox1.text;
fontpreview.font.size:= strtoint(globalfontsize.text);
end;

procedure TForm10.JvFontComboBox1Click(Sender: TObject);
begin
fontpreview.caption := 'This is the new text on '+#13#10+'the selected font.';
fontpreview.font.name := JvFontComboBox1.text;
fontpreview.font.size:= strtoint(globalfontsize.text);
end;

procedure TForm10.xaWhatsThis1InvokePopupEvent(Sender: TComponent;
  X, Y: Integer; Control: TControl; var Handled: Boolean);
begin
  debugmsg('Popup invoked on :' + Control.Name);
end;

procedure TForm10.xaWhatsThis1ClickControl(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Control: TControl);
begin
  debugmsg('Clicked control: ' + Control.Name);
end;

procedure TForm10.xaWhatsThis1Acivate(Sender: TObject);
begin
  debugmsg('OnActivate.');
end;

procedure TForm10.xaWhatsThis1Click(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; var Handled: Boolean);
begin
  debugmsg('Click: ' + IntToStr(X) + ', ' + IntToStr(Y));
  Handled := True;
end;

procedure TForm10.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = True then
  begin
    Label6.Visible := True;
    JvSpinEdit1.Visible := True;
  end
  else
  begin
    Label6.Visible := False;
    JvSpinEdit1.Visible := False;
  end;

end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  reg := TRegistry.Create;
  reg.rootkey := HKEY_LOCAL_MACHINE;
  if reg.openkey('SOFTWARE\Interplay\Fallout2\1.0', False) then
  begin
    JvDirectoryEdit4.Text := reg.readstring('DestPath');
    reg.closekey;

  end
  else
  begin
    debugmsg('Trying alternate key "Fallout 2"');
    if reg.openkey('SOFTWARE\Interplay\Fallout 2\1.0', False) then
    begin
      JvDirectoryEdit4.Text := reg.readstring('DestPath');
      reg.closekey;
      debugmsg('Got i1!');

    end;
    debugmsg('Can''t open registry key');
    MessageDlg('Registry key not found!' + #13 + #10 + '' + #13 + #10 +
      'Expected:' + #13 + #10 +
      'HKEY_LOCAL_MACHINE\SOFTWARE\Interplay\Fallout2\1.0\DestPath' + #13 + #10
      + 'or' + #13 + #10 +
      'HKEY_LOCAL_MACHINE\SOFTWARE\Interplay\Fallout 2\1.0\DestPath', mtWarning,
      [mbOK], 0);
  end;

end;

procedure TForm10.sCheckBox1Click(Sender: TObject);
begin
  // form1.skindata1.Active := scheckbox1.Checked;

end;

procedure ChangeStyleKeepForm(const NewStyle: string);
var
  ActiveForm: TCustomForm;
begin
  ActiveForm := Screen.ActiveCustomForm;

  if Assigned(ActiveForm) and (fsModal in ActiveForm.FormState) then
  begin
    ActiveForm.Hide; // Temporarily hide to prevent flickering
    try
      TStyleManager.SetStyle(NewStyle);
    finally
      ActiveForm.Show; // Restore visibility
      SetForegroundWindow(ActiveForm.Handle); // Bring it back to front
    end;
  end
  else
    TStyleManager.SetStyle(NewStyle);
end;

procedure ChangeStyleRestoreForm(const NewStyle: string);
var
  ActiveForm: TCustomForm;
  R: TRect;
begin
  ActiveForm := Screen.ActiveCustomForm;

  if Assigned(ActiveForm) and (fsModal in ActiveForm.FormState) then
  begin
    GetWindowRect(ActiveForm.Handle, R); // Save current position
    ActiveForm.Hide;
    try
      TStyleManager.SetStyle(NewStyle);
    finally
      ActiveForm.Show;
      SetWindowPos(ActiveForm.Handle, HWND_TOP, R.Left, R.Top, 0, 0,
        SWP_NOSIZE or SWP_NOZORDER or SWP_SHOWWINDOW);
    end;
  end
  else
    TStyleManager.SetStyle(NewStyle);
end;

procedure TForm10.StyleChangeTimerTimer(Sender: TObject);
var
  ActiveForm: TCustomForm;
  ParentHandle: HWND;
  WindowRect: TRect; // Add rect to store window position
begin
  StyleChangeTimer.Enabled := False;
  ActiveForm := Screen.ActiveCustomForm;

  if Assigned(ActiveForm) and (fsModal in ActiveForm.FormState) then
  begin
    // Store current window position and size
    GetWindowRect(ActiveForm.Handle, WindowRect);
    ParentHandle := Winapi.Windows.GetParent(ActiveForm.Handle);
    try
      Winapi.Windows.SetParent(ActiveForm.Handle, 0);
      TStyleManager.SetStyle(FSelectedStyle);
    finally
      Winapi.Windows.SetParent(ActiveForm.Handle, ParentHandle);
      // Restore original position and size
      SetWindowPos(ActiveForm.Handle, HWND_TOP, WindowRect.Left, WindowRect.Top,
        WindowRect.Right - WindowRect.Left, WindowRect.Bottom - WindowRect.Top,
        SWP_SHOWWINDOW);
      Winapi.Windows.SetActiveWindow(ActiveForm.Handle);
      Winapi.Windows.SetForegroundWindow(ActiveForm.Handle);
    end;
  end
  else
  begin
    TStyleManager.SetStyle(FSelectedStyle);
  end;
end;

procedure TForm10.StyleListDblClick(Sender: TObject);
begin
  if StyleList.itemindex >= 0 then
  begin
    MessageDlg(format('The theme has been changed to %s.' + #13 + #10 + #13 +
      #10 + 'The style change applies after you click OK on the preferences screen.', [StyleList.Items[StyleList.itemindex]]),
      mtInformation, [mbOK], 0);
  end;
end;

procedure TForm10.ListBox1Click(Sender: TObject);
begin
  // Form1.SkinData1.LoadFromCollection(form1.SkinStore1, ListBox1.ItemIndex);
  // form1.skindata1.SkinForm(form10.handle);
end;

end.
