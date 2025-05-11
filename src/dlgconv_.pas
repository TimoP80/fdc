(*

---------------------------------------------------------------
Fallout Dialogye Creator
Dialogue Converter - Converts .FMF files to SSL/INT+MSG
Copyright (C) 2005-2025 T. Pitkänen
---------------------------------------------------------------

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


unit dlgconv_;

interface

uses
  Windows,
  Messages,
  Inifiles,
  CocoBase, ScriptCompilerIntf,
  fmxutils,
  shareddlgdata,
  SysUtils,
  Registry,
  variants,
  FMF,
  ddf_output,
  DlgDef,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  jvtooledit,
  StdCtrls,
  Mask,
  jvexmask,
  XPMan,
  ComCtrls;

type
  tdlg_form = class(TForm)
    mainmenu1:    tmainmenu;
    filr1:        TMenuItem;
    loadfmffile1: TMenuItem;
    n1:           TMenuItem;
    quit1:        TMenuItem;
    groupbox1:    tgroupbox;
    label1:       TLabel;
    label2:       TLabel;
    lmdfileopenedit1: tjvfilenameedit;
    lmdfileopenedit2: tjvfilenameedit;
    groupbox2:    tgroupbox;
    label3:       TLabel;
    label4:       TLabel;
    label5:       TLabel;
    label6:       TLabel;
    label10:      TLabel;
    edit1:        tedit;
    edit3:        tedit;
    edit4:        tedit;
    edit2:        TMemo;
    lmdfileopenedit3: tjvfilenameedit;
    templatelist: TComboBox;
    write_text:   TCheckBox;
    node_names:   TCheckBox;
    debug_dump:   TCheckBox;
    debug_info:   TCheckBox;
    groupbox3:    tgroupbox;
    label7:       TLabel;
    label8:       TLabel;
    label9:       TLabel;
    memo1:        TMemo;
    memo2:        TMemo;
    memo3:        TMemo;
    opendialog1:  topendialog;
    Button1:      TButton;
    XPManifest1:  TXPManifest;
    Help1:        TMenuItem;
    About1:       TMenuItem;
    N2:           TMenuItem;
    New1:         TMenuItem;
    Label11:      TLabel;
    msgstep:      TEdit;
    UpDown1:      TUpDown;
    GroupBox4:    TGroupBox;
    CheckBox2:    TCheckBox;
    JvDirectoryEdit1: TJvDirectoryEdit;
    varnotes:     TCheckBox;
    procedure quit1click(Sender: TObject);
    procedure loadfmffile1click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure New1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure msgstepKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FMFError(Sender: TObject; Error: TCocoError);
  private
  public
  end;

var
  dlg_form:  tdlg_form;
  thefmf:    tfmf;
  temcnt:    integer;
  templatecfg: TIniFile;
  dialogue_had_errors: boolean;
  dialogue_loaded: boolean;
  parse_errors_list: string;
  reg:       TRegistry;
  ddfparser: TDLGDef;
  Data:      string;
  ssl_path, msg_path: string;

implementation

uses
  viewscript, parseerror;

{$R *.dfm}

procedure tdlg_form.quit1click(Sender: TObject);
begin
  dlg_form.Close;
end;


procedure Clear_Dlg;
begin

  currentdlg.filename := '';
  dlg_form.Caption := 'Fallout Dialogue Creator - Dialogue Converter - [untitled]';
  dlg_form.memo1.Text := '';
  dlg_form.memo2.Text := '';
  dlg_form.memo3.Text := '';
  dlg_form.edit1.Text := '';
  dlg_form.edit2.Text := '';
  dlg_form.edit3.Text := '';
  dlg_Form.lmdfileopenedit1.Text := '';
  dlg_Form.lmdfileopenedit2.Text := '';
  dlg_form.edit4.Text := '';

end;


procedure Update_Dlg;
begin

  currentdlg.filename := extractfilename(dlg_form.opendialog1.FileName);
  dlg_form.Caption := 'Fallout Dialogue Creator - Dialogue Converter - [' +
    dlg_form.opendialog1.filename + ']';
  dlg_form.memo1.Text := currentdlg.unknowndesc;
  dlg_form.memo2.Text := currentdlg.knowndesc;
  dlg_form.memo3.Text := currentdlg.detaileddesc;
  dlg_form.edit1.Text := currentdlg.npcname;
  dlg_form.edit2.Text := currentdlg.description;
  dlg_form.edit3.Text := currentdlg.location;
  dlg_Form.lmdfileopenedit1.Text :=
    ssl_path + '\' + extractfilename(
    changefileext(dlg_form.opendialog1.FileName, '.ssl'));
  dlg_Form.lmdfileopenedit2.Text :=
    msg_path + '\' + extractfilename(
    changefileext(dlg_form.opendialog1.FileName, '.msg'));
  dlg_form.edit4.Text := uppercase(changefileext(currentdlg.filename, ''));

end;

procedure tdlg_form.loadfmffile1click(Sender: TObject);
var
  x, f: integer;
  oldname: string;
  numerrors: integer;
  errorlist: TStringList;
  errormsg: string;
begin
  dialogue_had_errors := False;
  if opendialog1.Execute then
  begin
    thefmf.SourceFileName := opendialog1.FileName;

    currentdlg.nodecount := 0;
    currentdlg.filename := '';
    currentdlg.npcname := '';
    currentdlg.description := '';
    currentdlg.location := '';
    currentdlg.unknowndesc := '';
    currentdlg.knowndesc := '';
    currentdlg.detaileddesc := '';
    currentdlg.startconditioncnt := 0;
    currentdlg.customproccnt := 0;
    currentdlg.timedeventcnt := 0;
    currentdlg.floatnodecount := 0;
    currentdlg.nodecount := 0;
    currentdlg.varcnt := 0;

    thefmf.Execute;
    if thefmf.Successful then
    begin
      errorlist := TStringList.Create;
      for f := 0 to currentdlg.nodecount - 1 do
      begin
        if IsValidNodeName(currentdlg.nodes[f].nodename, errormsg) = False then
        begin
          errorlist.add(currentdlg.nodes[f].nodename +
            ' is not valid - ' + errormsg);

          oldname := currentdlg.nodes[f].nodename;
          currentdlg.nodes[f].nodename :=
                StringReplace(currentdlg.nodes[f].nodename, '-', '_', [rfReplaceAll]);

          currentdlg.nodes[f].nodename :=
            StringReplace(currentdlg.nodes[f].nodename, ' ', '_', [rfReplaceAll]);
          currentdlg.nodes[f].nodename :=
            StringReplace(currentdlg.nodes[f].nodename, '''', '', [rfReplaceAll]);
          if currentdlg.nodes[f].nodename <> '' then
          begin
            errorlist.add('Node renamed to ' + currentdlg.nodes[f].nodename);
            RemapNodes(oldname, currentdlg.nodes[f].nodename);
          end else
          Inc(numerrors);
        end;
        if currentdlg.nodes[f].nodename = '' then
        begin
          errorlist.add('Empty node name at position ' + IntToStr(f) +
            ' renamed to ' + format('Node%0.3d', [f]));
          currentdlg.nodes[f].nodename := format('Node%0.3d', [f]);
          //  RemapNodes('', currentdlg.nodes[f].options[x].nodelink);
          Inc(numerrors);
        end;

        for x := 0 to currentdlg.nodes[f].optioncnt - 1 do
        begin
          if (currentdlg.nodes[f].options[x].nodelink <> '') and
            (GetNodeIndex(currentdlg.nodes[f].options[x].nodelink) = -1) and
            (currentdlg.nodes[f].options[x].link_to_skillcheck = False) and
            (currentdlg.nodes[f].options[x].link_to_proc = False) and
            (currentdlg.nodes[f].options[x].nodelink <> 'done') and
            (currentdlg.nodes[f].options[x].nodelink <> 'combat') then
          begin
            errorlist.add('[WARNING] Player option ' + IntToStr(x) +
              ' at node ' + currentdlg.nodes[f].nodename +
              ' links to a non-existent node "' +
              currentdlg.nodes[f].options[x].nodelink +
              '" and is not linking to skill check or custom procedure.');
           inc(numerrors);
          end else

          if currentdlg.nodes[f].options[x].nodelink = '' then
          begin
            errorlist.add('[WARNING] Player option ' + IntToStr(x) +
              ' at node ' + currentdlg.nodes[f].nodename + ' has null node link. ');
           inc(numerrors);
          end;

        end;

      end;


      for f := 0 to currentdlg.floatnodecount - 1 do
      begin
        if IsValidNodeName(currentdlg.floatnodes[f].nodename, errormsg) = False then
        begin
          errorlist.add(currentdlg.floatnodes[f].nodename +
            ' is not valid - ' + errormsg);

          oldname := currentdlg.floatnodes[f].nodename;
          currentdlg.floatnodes[f].nodename :=
            StringReplace(currentdlg.floatnodes[f].nodename, ' ',
            '_', [rfReplaceAll]);
          currentdlg.floatnodes[f].nodename :=
            StringReplace(currentdlg.floatnodes[f].nodename, '''',
            '', [rfReplaceAll]);

          errorlist.add('Node renamed to ' + currentdlg.floatnodes[f].nodename);
          Inc(numerrors);

        end;
        if currentdlg.floatnodes[f].nodename = '' then
        begin
          errorlist.add('Empty node name at position ' + IntToStr(f) +
            ' renamed to ' + format('Node%0.3d', [f]));
          currentdlg.floatnodes[f].nodename := format('Node%0.3d', [f]);
           inc(numerrors);

        end;
      end;


      if errorlist.Count > 0 then
      begin

      if numerrors > 0 then  dialogue_had_errors := True;
        form7.memo1.Lines.Clear;
        form7.memo1.Lines.Add(
          'This dialogue contained the following errors: ' + #13#10);
        form7.memo1.Lines.add(errorlist.Text);
        form7.ShowModal;
      end;

      dialogue_loaded := True;
      Update_Dlg;
    end else
    begin
      dialogue_loaded := False;
      thefmf.ListStream.SaveToFile('errors.lst');
      MessageDlg('Parse error while loading FMF file! ' + #13#10 +
        parse_errors_list + #13#10 + 'More details on these errors in errors.lst',
        mtError, [mbOK], 0);
    end;

  end;
end;

procedure tdlg_form.FMFError(Sender: TObject; Error: TCocoError);
begin

  parse_errors_list := parse_Errors_list + 'Line: ' + IntToStr(Error.Line) +
    ' Column ' + IntToStr(error.col) + ': ' +
    thefmf.ErrorStr(Error.ErrorCode, Error.Data) + #13#10;
  // Hold still damn it
end;

procedure tdlg_form.FormCreate(Sender: TObject);
var
  i: integer;
begin
  dialogue_loaded := False;
  condcfg := tinifile.Create('.\conditions.ini');

  thefmf := TFMF.Create(nil);
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.Access := KEY_READ;
  thefmf.OnError := FMFError;
  if reg.OpenKey('Software\Fallout Dialogue Creator', False) then
  begin

    Data := reg.ReadString('installpath');
    //ShowMessage('DATA : ' +data );
    //writeln('data := ',data);               
    config := TInifile.Create(Data + '\fdc.ini');
    condcfg := Tinifile.Create(Data + '\conditions.ini');
    headerspath := config.readstring('Global Config', 'HeadersPath', '');
    templatecfg := Tinifile.Create(Data + '\ssltemplates\templates.cfg');


    temcnt := templatecfg.ReadInteger('TemplateMain', 'count', 0);
    if temcnt > 0 then
    begin

      for i := 1 to temcnt do
      begin

        dlg_form.templateList.Items.add(templatecfg.ReadString('TemplateMain',
          'Template' + IntToStr(i), ''));
      end;
      dlg_form.templateList.ItemIndex := 0;
    end;
    direct_compile := config.readbool('Global Config', 'DirectCompile', False);
    jvdirectoryedit1.Text := config.ReadString('Global Config', 'DirectCompilePath', '');
    checkbox2.Checked := direct_compile;
    script_output  := jvdirectoryedit1.Text;
    initDDFDumper(Data);
    ssl_path := config.readstring('Global Config', 'DefaultSSLPath', '');
    msg_path := config.readstring('Global Config', 'DefaultMSGPath', '');
    // writeln('Compiling script after conversion.');
    InitCompiler(Data + '\plugins');
    headerspath := config.readstring('Global Config', 'HeadersPath', '');
    if headerspath = '' then
      MessageDlg('Header configuration invalid!' + #13 + #10 + '' +
        #13 + #10 + '(The path was a null string)', mtWarning, [mbOK], 0)
    else
    begin
      //writeln('Header configuration invalid!');
      exit;
    end;
  end else showmessage('Ubable to open reg key.');



  //  condcfg     := Tinifile.Create(+ '\conditions.ini');

end;

procedure tdlg_form.Button1Click(Sender: TObject);
var
  output: string;
  x: integer;
  errors, errorlist: string;
begin
  if dialogue_had_errors = True then
  begin

    case MessageDlg('Caution: This dialogue was found to have some' + #13 +
        #10 + 'errors. If you attempt to export this file,' + #13 + #10 +
        'the exporting process may fail.' + #13 + #10 + '' + #13 + #10 + 'Do you wish to continue?',
        mtWarning, [mbYes, mbNo], 0) of
      mrNo:
        exit;

    end;

  end;

  if dialogue_loaded = False then
  begin
    MessageDlg('No dialogue file loaded!', mtWarning, [mbOK], 0);
    exit;
  end;


  parse_errors_list := '';
  write_text_data := write_text.Checked;
  debug_nodes := node_names.Checked;
  debug_skillchecks := debug_info.Checked;
  debug_local_vars := debug_dump.Checked;
  include_variablenotes := varnotes.Checked;
  msg_step := UpDown1.position;
  //templatecfg       := Tinifile.Create(Data + '\ssltemplates\templates.cfg');
  template_name := templatelist.Text;
  script_template := Data + '\' + templatecfg.ReadString(template_name, 'filename', '');


  sslfile := lmdfileopenedit1.Text;
  msgfile := lmdfileopenedit2.Text;

  errorlist := '';


  output := SaveFMF2DDF(currentdlg);
  // MessageDlg(format('Output := %s', [output]), mtInformation, [mbOK], 0);
  ddfparser := TDLGDef.Create(nil);
  ddfparser.SourceFileName := output;

  ddfparser.Execute;
  if ddfparser.successful = True then
  begin
    MessageDlg('Dialogue successfully exported.', mtInformation, [mbOK], 0);
    conv_view.SynMemo1.Lines.loadfromfile(msgfile);
    conv_view.SynMemo2.Lines.loadfromfile(sslfile);
    conv_view.scrloc.Caption := sslfile;
    conv_view.msgloc.Caption := msgfile;

    conv_view.Show;
  end
  else
  begin
    errors := '';
    for x := 0 to ddfparser.ErrorList.Count - 1 do
    begin
    end;

    MessageDlg('Parse error occured while generating script file. Displaying error dump now. ', mtWarning, [mbOK], 0);
    ddfparser.ListStream.savetofile('convert_parse_error.log');
    ExecuteFile('notepad.exe', '"'+getcurrentdir+'\convert_parse_error.log"', '"'+getcurrentdir+'"', SW_SHOW);
  end;

  ddfparser.Free;

end;

procedure tdlg_form.About1Click(Sender: TObject);
begin
  MessageBox(0, 'Dialogue Converter' + #13 + #10 +
    'version 1.04' + #13 + #10 + '' + #13 + #10 + '(c) 2006-2025 T. Pitkänen',
    'About Dialogue Converter', MB_ICONINFORMATION or MB_OK or MB_APPLMODAL);
end;

procedure tdlg_form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  config.writebool('Global Config', 'DirectCompile', checkbox2.Checked);
  config.writestring('Global Config', 'DirectCompilePath', jvdirectoryedit1.Text);
  config.writeinteger('Global Config', 'MSG ID Step', updown1.Position);
  action := caFree;
end;

procedure tdlg_form.New1Click(Sender: TObject);
begin
  currentdlg.nodecount := 0;
  currentdlg.filename := '';
  currentdlg.npcname := '';
  currentdlg.description := '';
  currentdlg.location := '';
  currentdlg.unknowndesc := '';
  currentdlg.knowndesc := '';
  currentdlg.detaileddesc := '';
  currentdlg.startconditioncnt := 0;
  currentdlg.customproccnt := 0;
  currentdlg.timedeventcnt := 0;
  currentdlg.floatnodecount := 0;
  currentdlg.nodecount := 0;
  currentdlg.varcnt := 0;
  clear_dlg;
end;

procedure tdlg_form.CheckBox2Click(Sender: TObject);
begin
  direct_compile := checkbox2.Checked;

end;

procedure tdlg_form.msgstepKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if msgstep.Text <> '' then
    UpDown1.Position := StrToInt(msgstep.Text);
end;

end.

