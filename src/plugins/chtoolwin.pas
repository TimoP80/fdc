unit chtoolwin;

interface

uses
    Classes,
    ComCtrls,
    Controls,
    Dialogs,
    Forms,
    Graphics,
    JvExComCtrls,
    JvListView,
    Menus,
    Messages,
    pluginfunc,
    StdCtrls,
    SysUtils,
    Variants,
    Windows;

type
    TForm1 = class(TForm)
        Memo1: TMemo;
        Label1: TLabel;
        Button1: TButton;
        ListView1: TJvListView;
        Label6: TLabel;
        Label7: TLabel;
        Memo2: TMemo;
        Button2: TButton;
        PopupMenu1: TPopupMenu;
        Editplayeroption1: TMenuItem;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Edit1: TEdit;
        Edit2: TEdit;
        Edit3: TEdit;
        ComboBox1: TComboBox;
        UpDown1: TUpDown;
        Button3: TButton;
        procedure ListView1Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure PopupMenu1Popup(Sender: TObject);
        procedure Editplayeroption1Click(Sender: TObject);

        procedure Memo1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
        procedure Button3Click(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
    Form1: TForm1;
    temp: string;
    teh_dlg: pnewdialogue;

implementation

{$R *.dfm}

function GetNodeIndex(node: string): integer;
var
    t: integer;
begin
    ;
    Result := -1;
    for  t := 0 to teh_dlg.nodecount - 1 do
        begin
        ;
        if teh_dlg.nodes[t].nodename = node then
            begin
            ;
            Result := t;
            exit;
            end;

        end;

end;

procedure TForm1.ListView1Click(Sender: TObject);
var
    x, opt_ind: integer;
var
    chr: string;
var
    node_ind: integer;
begin
    if listview1.selected = nil then
        begin
        edit1.Text := '';
        edit2.Text := '';
        memo1.Text := '';
        memo2.Text := '';
        combobox1.ItemIndex := -1;
        label6.Caption := '';
        end
    else
    if listview1.selected <> nil then
        begin
        ;
        edit1.Text := '';
        edit2.Text := '';

        memo1.Text := listview1.selected.subitems[1];
        node_ind := GetNodeIndex(listview1.selected.Caption);
        opt_ind := StrToInt(listview1.Selected.subitems[0]);
        Edit2.Text := teh_Dlg.nodes[node_ind].options[opt_ind].nodelink;
        memo2.Text := teh_Dlg.nodes[node_ind].options[opt_ind].optiontext;
        label6.Caption := 'Skill check parameters OK.';
        updown1.position := 0;
        if (pos('speech', memo1.Text) <> 0) or (pos('Speech', memo1.Text) <> 0) then
            begin
            ;
            combobox1.ItemIndex := combobox1.items.indexof('Speech');
            end;

        if (pos('first aid', memo1.Text) <> 0) or (pos('First Aid', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('First Aid');
            end;

        if (pos('sneak', memo1.Text) <> 0) or (pos('Sneak', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Sneak');
            end;


        if (pos('lockpick', memo1.Text) <> 0) or (pos('Lockpick', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Lockpick');
            end;

        if (pos('repair', memo1.Text) <> 0) or (pos('Repair', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Repair');
            end;


        if (pos('science', memo1.Text) <> 0) or (pos('Science', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Science');
            end;
        if (pos('traps', memo1.Text) <> 0) or (pos('Traps', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Traps');
            end;

        if (pos('gambling', memo1.Text) <> 0) or (pos('Gambling', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Gambling');
            end;

        if (pos('doctor', memo1.Text) <> 0) or (pos('Doctor', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Doctor');
            end;
        if (pos('barter', memo1.Text) <> 0) or (pos('Barter', memo1.Text) <> 0) then
            begin
            combobox1.ItemIndex := combobox1.items.indexof('Barter');
            end;


        if (pos('outdoorsman', memo1.Text) <> 0) or (pos('Outdoorsman', memo1.Text) <> 0) then
            begin
             combobox1.ItemIndex := combobox1.items.indexof('Outdoorsman');
            end;

        if pos('Moderate', memo1.Text) <> 0 then
            begin
            updown1.Position := -5;
            end;
        if pos('Easy', memo1.Text) <> 0 then
            begin
            updown1.Position := 0;
            end;
        if (pos('Difficult', memo1.Text) <> 0) or (pos('Hard', memo1.Text) <> 0) then
            begin
            updown1.Position := -10;
            end;

        if pos('Very difficult', memo1.Text) <> 0 then
            begin
            updown1.Position := -20;
            end;

        if pos('Insanely difficult', memo1.Text) <> 0 then
            begin
            updown1.Position := -50;
            end;

        if pos('Impossible', memo1.Text) <> 0 then
            begin
            updown1.Position := -80;
            end;

        if (pos('go', memo1.Text) <> 0) and (pos('to', memo1.Text) <> 0) then
            begin
      //  senddebugmsg(PChar('START=' + IntToStr(pos('go to', memo1.text) + 6) +
      //    ' END=' + IntToStr(pos('instead.', memo1.text) - 9)));
      //  edit1.Text := copy(memo1.text, pos(
      //    'go to', memo1.text) + 6, pos(
      //    'instead.', memo1.text) - 9);

            x := pos('go to', memo1.Text) + 6;
            if x = 0 then
                begin
                x := pos('to', memo1.Text) + 3
                end;
            edit1.Text := '';
            while (x <= length(memo1.Text)) and (memo1.Text[x] <> ' ') and (memo1.Text[x] <> '.') do
                begin
                ;
                edit1.Text := edit1.Text + memo1.Text[x];
        //chr := memo1.text[x];
        // senddebugmsg(pchar(chr));
                Inc(x);
                end;

            if getnodeindex(edit1.Text) = -1 then
                begin
                label6.Caption := 'Warning: Unresolved failure node ' + edit1.Text
                end;

            end;

        end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    if listview1.selected = nil then
        begin
        exit
        end;
    if (getnodeindex(edit1.Text) = -1) then
        begin
        senddebugmsg(pchar('Skipping ' + listview1.selected.Caption + ' due to an incorrect failure node link.'));
        MessageDlg(format('Warning: Unresolved failure node %s!' + #13 + #10 + '' + #13 + #10 +
            'Skill check not generated.', [edit1.Text]),
            mtWarning, [mbOK], 0);
        end
    else
    if (combobox1.ItemIndex <> -1) and (edit1.Text <> '') and (edit2.Text <> '') then
        begin
    // procedure AddSkillCheck(node : String; name : String;
    // skill : Integer; modifier : Integer;
    // onsuccess : String; onfailure : String);
    //  procedure SetOptionToSkillCheck(node : String; opt_ind : Integer; skillcheck : String);

        executescriptlines(pchar('addskillcheck(''' + listview1.selected.Caption + ''',''SkillCheck_' +
            listview1.selected.subitems[0] + '_' + listview1.selected.Caption + ''',' +
            IntToStr(combobox1.ItemIndex + 1) + ',' + IntToStr(updown1.Position) + ',''' + edit2.Text +
            ''',''' + edit1.Text + ''');'));
        executescriptlines(pchar('SetOptionToSkillCheck(''' + listview1.selected.Caption + ''',' +
            listview1.selected.subitems[0] + ', ''SkillCheck_' + listview1.selected.subitems[0] +
            '_' + listview1.selected.Caption + ''');'));
        if Sender <> Button2 then
            begin
            executescriptlines('RequestPluginRefresh;')
            end;

        end
    else
        begin
        MessageDlg('Unable to generate skill check for ' + listview1.selected.Caption +
            ', some fields are empty or incorrect.',
            mtWarning, [mbOK], 0)
        end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
    g: integer;
begin

    for g := 0 to ListView1.Items.Count - 1 do
        begin
        ;
        listview1.ItemIndex := g;
        listview1.Selected := listview1.Items[g];
        listview1click(nil);
        Button1Click(button2);

        end;
    executescriptlines('RequestPluginRefresh;');
    label6.Caption := 'Skill check generation complete.';
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
    if listview1.selected <> nil then
        begin
        Editplayeroption1.Visible := true;

        end
    else
        begin
        editplayeroption1.Visible := false
        end;

end;

procedure TForm1.Editplayeroption1Click(Sender: TObject);
begin
    executescriptlines(pchar('EditPlayerOption(''' + listview1.selected.Caption + ''',' +
        listview1.Selected.subitems[0] + ');'));
end;


procedure TForm1.Memo1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);

var
    nodeind, optind: integer;
begin
    if listview1.selected <> nil then
        begin
        if memo1.Text <> '' then
            begin
            nodeind := GetNodeIndex(listview1.selected.Caption);
            optind := StrToInt(listview1.selected.subitems[0]);
      //teh_dlg.nodes[nodeind].options[optind].notes := memo1.text;
            temp := memo1.Text;
            temp := stringreplace(temp, #13#10, '''+#13#10+''', [rfReplaceAll]);
            temp := stringreplace(temp, '''', '''''', [rfReplaceAll]);

      //  executescriptlines(PChar(format('SetPlayerOptionStringData(''%s'',%d,FIELD_PLAYEROPTION_NOTES,''%s'');',
      //    [listview1.selected.Caption, optind, temp])));
      // teH_dlg := GetDLGNew;

            listview1.selected.subitems[1] := memo1.Text;
            ListView1Click(nil);
            end;

        end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   form1.hide;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    senddebugmsg('Form destroying...');
end;

end.

