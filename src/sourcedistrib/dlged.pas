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

unit dlged;

interface

uses
    Classes,
    ComCtrls,
    Controls,
    debugwnd,
    Dialogs,
    Forms,
    Graphics,
    helpscreen,
    Menus,
    Messages,
    pluginapi,
    poptadd,
    SharedDLGData,
    StdCtrls,
    strutils_,
    SysUtils,
    Variants,
    Windows;

type
    TForm2 = class(TForm)
        PageControl1: TPageControl;
        TabSheet1: TTabSheet;
        Label1: TLabel;
        ListView1: TListView;
        TabSheet2: TTabSheet;
        ListView2: TListView;
        lblSearch: TLabel;
        TabSheet3: TTabSheet;
        ListView3: TListView;
        Label2: TLabel;
        Edit1: TEdit;
        UpDown1: TUpDown;
        Label3: TLabel;
        Edit2: TEdit;
        TabSheet4: TTabSheet;
        ListView4: TListView;
        Label4: TLabel;
        Button1: TButton;
        Button2: TButton;
        Button3: TButton;
        Button5: TButton;
        Button6: TButton;
        Button7: TButton;
        Button8: TButton;
        Button13: TButton;
        Button14: TButton;
        Button15: TButton;
        Button16: TButton;
        Button9: TButton;
        Button10: TButton;
        Button11: TButton;
        Button12: TButton;
        Button17: TButton;
        Button18: TButton;
        Button22: TButton;
        Button19: TButton;
        Button20: TButton;
        Button21: TButton;
        Button4: TButton;
        srchEdit: TEdit;
        ComboBox1: TComboBox;
        TreeView1: TTreeView;
        srchBtn: TButton;
        Button23: TButton;
        TabSheet5: TTabSheet;
        ListView5: TListView;
        Button24: TButton;
        Button25: TButton;
        Button26: TButton;
        procedure Button4Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure ListView1DblClick(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure Button5Click(Sender: TObject);
        procedure Button6Click(Sender: TObject);
        procedure ListView1Click(Sender: TObject);
        procedure Button7Click(Sender: TObject);
        procedure Button8Click(Sender: TObject);
        procedure Button11Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure Button9Click(Sender: TObject);
        procedure Button10Click(Sender: TObject);
        procedure Button12Click(Sender: TObject);
        procedure ListView1Edited(Sender: TObject; Item: TListItem; var S: string);
        procedure ListView2DblClick(Sender: TObject);
        procedure Button14Click(Sender: TObject);
        procedure srchBtnClick(Sender: TObject);
        procedure Button13Click(Sender: TObject);
        procedure Button15Click(Sender: TObject);
        procedure Button16Click(Sender: TObject);
        procedure Button20Click(Sender: TObject);
        procedure ListView4DblClick(Sender: TObject);
        procedure Button19Click(Sender: TObject);
        procedure Button21Click(Sender: TObject);
        procedure Button23Click(Sender: TObject);

    private
    { Private declarations }
    public
    { Public declarations }
    end;

const
    FILTER_SHOW_ALL_NODES = 1;
    FILTER_SHOW_STARTING_NODES = 2;
    FILTER_SHOW_NONSTART_NODES = 3;
    FILTER_SHOW_EMPTYTEXT_NODES = 4;
    FILTER_SHOW_NOPLAYEROPTIONS_NODES = 5;
    FILTER_SHOW_NODES_BY_NAME = 6;
    FILTER_VIEW_DIALOGUE_AS_TREE = 7;

var
    tx: TListItem;
    Form2: TForm2;
    nodefilter: integer;
    temp_node: dlgnode;
    tempglobalnode: TTreeNode;
    string_path: TStringList;
    nodevisited: array [0..1000] of boolean;
    nodevisitcount: array [0..1000] of integer;
    loop_node: string;
    p_x: integer;
    iterations: integer;
    depth: integer;

procedure RefreshNodes;
procedure EditNode(nodex: integer);
procedure GenerateRecursion(root_node: TTreeNode; node: integer);

implementation

uses
    addnode,
    floatnode_ed,
    fmfmain,
    Masks,
    skillcheck_ed,
    startconds,
    timeevent_editor,
    varmanager;

{$R *.dfm}

function IsStartingNode(node: string): boolean;
var
    i, j, t: integer;
var
    linksfound: integer;
begin
    ;
    t := GetNodeIndex(node);
    linksfound := 0;
    if t <> -1 then
        begin
        ;
        for i := 0 to currentdlg.nodecount - 1 do
            begin
            ;
            for j := 0 to currentdlg.nodes[i].optioncnt - 1 do
                begin
                ;
                if currentdlg.nodes[i].options[j].nodelink = node then
                    begin
                    ;
                    Inc(linksfound);
                    end;
                end;

            end;

        end;
    if linksfound = 0 then
        begin
        Result := true
        end
    else
        begin
        Result := false
        end;
  //showmessage('Links found: '+inttostr(linksfound));
end;




procedure RefreshNodesNoClear;

var
    i, U: integer;
begin
    addautocompletestuff;
  //  Form2.ListView1.Clear;
    form1.combobox1.Clear;

    form2.listview4.Clear;
    for u := 0 to currentdlg.nodecount - 1 do
        begin
        if currentdlg.nodes[u].skillcheckcnt > 0 then
            begin
            ;
            for i := 0 to currentdlg.nodes[u].skillcheckcnt - 1 do
                begin
                ;
                tx := form2.ListView4.Items.add;
                tx.Caption := currentdlg.nodes[u].skillchecks[i].check_proc_name;
                tx.SubItems.Add(form24.combobox1.items[currentdlg.nodes[u].skillchecks[i].check_what - 1]);
                tx.SubItems.Add(IntToStr(currentdlg.nodes[u].skillchecks[i].modifier));
                tx.SubItems.Add(currentdlg.nodes[u].skillchecks[i].successnode);
                tx.SubItems.Add(currentdlg.nodes[u].skillchecks[i].failurenode);
                end;
            end;
        ;
        form1.combobox1.Items.Add(currentdlg.nodes[u].nodename);
    //debugmsg('Refresh at node: '+inttostr(u));
        if nodefilter = FILTER_SHOW_EMPTYTEXT_NODES then
            begin
            ;
            if (currentdlg.nodes[u].npctext = '') then
                begin

                tx := form2.listview1.items[u];
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems[0] := currentdlg.nodes[u].npctext;
                end;

            end
        else
        if nodefilter = FILTER_SHOW_NOPLAYEROPTIONS_NODES then
            begin
            ;
            if (currentdlg.nodes[u].optioncnt = 0) then
                begin

                tx := form2.listview1.items[u];
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems[0] := currentdlg.nodes[u].npctext;
                end;

            end


        else
        if nodefilter = FILTER_SHOW_STARTING_NODES then
            begin
            ;
            if (currentdlg.nodes[u].is_wtg = true) then
                begin
                ;
                tx := form2.listview1.items[u];
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems[0] := currentdlg.nodes[u].npctext;

                end;
            end
        else
        if nodefilter = FILTER_SHOW_NODES_BY_NAME then
            begin
            if Form2.srchEdit.Text <> '' then
                begin
                ;
                if (MatchesMask(currentdlg.nodes[u].nodename, Form2.srchedit.Text)) then
                    begin
                    ;
                    tx := form2.listview1.items.add;
                    tx.Caption := currentdlg.nodes[u].nodename;
                    tx.SubItems[0] := currentdlg.nodes[u].npctext;
                    end;

                end
            else
                begin
                ;
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems[0] := currentdlg.nodes[u].npctext;
                end;

            end


        else
        if nodefilter = FILTER_SHOW_NONSTART_NODES then
            begin
            if (currentdlg.nodes[u].is_wtg = false) then
                begin
                tx := form2.listview1.items[u];
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems[0] := currentdlg.nodes[u].npctext;

                end;
            end
        else
            begin
            tx := form2.listview1.items[u];
            tx.Caption := currentdlg.nodes[u].nodename;
            tx.SubItems[0] := currentdlg.nodes[u].npctext;
            end;

        end;
    form1.combobox1.ItemIndex := 0;
end;


procedure RecurseThroughNodeOption(callernode: integer; startnode: TTreeNode; parentnode: TTreeNode; node: integer; option: integer; selfcall: boolean; depth: integer);
var
    recursenode: TTreeNode;
    recurse_optionnode: TTreeNode;
    y: integer;
    z: integer;
    t: integer;
    s, found_exitnode: integer;
begin
    if node = -1 then
        begin
        ;
    //    debugmsg('Node ' + IntToStr(node) + ' Nonexistent!');
        exit;
        end;

    debugmsg('Depth := ' + IntToStr(depth) + ' ' + IntToStr(iterations));
    Inc(iterations);
    debugmsg('Called by: ' + currentdlg.nodes[callernode].nodename);
    t := node;

    nodevisited[node] := true;
    Inc(nodevisitcount[node]);

    debugmsg('Node that was linked to -> ' + currentdlg.nodes[t].nodename);
    debugmsg('Recursed NPCText : ' + currentdlg.nodes[t].npctext);
    application.ProcessMessages;
  //  if selfcall = False then
  //    iterations := 0;


    recursenode := form2.treeview1.Items.Addchild(parentnode, '(' + currentdlg.nodes[t].nodename +
        ') ' + currentdlg.nodes[t].npctext);


  // if selfcall = False then
    debugmsg('Recursed option: ' + currentdlg.nodes[t].options[p_x].optiontext + ' X=' + IntToStr(p_x));
    recurse_optionnode := form2.treeview1.items.addchild(recursenode, currentdlg.nodes[t].options[p_x].optiontext +
        ' -> ' + currentdlg.nodes[t].options[p_x].nodelink);
    y := currentdlg.nodes[t].options[p_x].noderesolved;
    debugmsg('RECURSE link to -> ' + currentdlg.nodes[t].options[p_x].nodelink);
  //     if y = -1 then
  //       Inc(p_x);


  //recursethroughnodeoption(t, recursenode, recurse_optionnode, y, p_x, True);
    if (nodevisitcount[y] < 10) then

        begin
        GenerateRecursion(recurse_optionnode, y)
        end;
    Inc(iterations);

  //   Inc(p_x);

end;

procedure GenerateRecursion(root_node: TTreeNode; node: integer);
var
    rootnode: TTreeNode;
    playeroptionnode: TTreeNode;
    tempnode: TTreeNode;
    i, U, z, y, n, b: integer;
begin
    u := node;
    debugmsg('NODE == ' + IntToStr(node));
    Inc(iterations);

    if (node = -1) then
        begin
        exit
        end;
    if root_node = nil then
        begin
        nodevisited[node] := true;
        Inc(nodevisitcount[node]);
        end;

    debugmsg('Start ' + currentdlg.nodes[u].nodename);

    if (root_node = nil) and (currentdlg.nodes[u].is_wtg = false) and (u < currentdlg.nodecount - 1) then
        begin
        debugmsg('Warning, node ' + currentdlg.nodes[u].nodename + ' is not WTG, trying next one!');
        generaterecursion(nil, u + 1);
        exit;

        end;


    application.ProcessMessages;
    if (currentdlg.nodes[u].is_wtg = true) then
        begin
        loop_node := currentdlg.nodes[u].nodename;
        rootnode := form2.treeview1.Items.Add(root_node, '(' + currentdlg.nodes[u].nodename +
            ') ' + currentdlg.nodes[u].npctext);

        end
    else
        begin
        rootnode := form2.treeview1.Items.AddChild(root_node, '(' + currentdlg.nodes[u].nodename +
            ') ' + currentdlg.nodes[u].npctext)
        end;

    z := 0;

    application.ProcessMessages;
    debugmsg('Recurse: ' + currentdlg.nodes[u].nodename + ' at (' + IntToStr(z) + ')');
    while z < currentdlg.nodes[u].optioncnt do
        begin
        tempglobalnode := form2.treeview1.items.AddChild(rootnode, currentdlg.nodes[u].options[z].optiontext +
            ' -> ' + currentdlg.nodes[u].options[z].nodelink);
        y := currentdlg.nodes[u].options[z].noderesolved;
        if y <> -1 then
            begin
            if (nodevisitcount[y] < 10) then
                begin
                RecurseThroughNodeOption(u, rootnode, tempglobalnode, y, z, false, depth)
                end;
            Inc(z);
      //     debugmsg('Finished with ' + IntToStr(iterations) + ' recursive iterations.');
            end
        else
            begin
            debugmsg('Ends dialogue.');
            Inc(z);

            end;

        if iterations > 8000 then
            begin
            MessageDlg('Warning! The dialogue seems to have an endless loop!' + #13 + #10 + '' +
                #13 + #10 + 'Aborting treeview build.',
                mtWarning, [mbOK], 0);
            break;
            end;
        end;

  //rootnode.expand(True);
  // if u <= currentdlg.nodecount - 2 then
  //   generaterecursion(root_node, u + 1);

end;


procedure RefreshNodes;
var
    temp: integer;
    i, U, z, y, n, b: integer;

begin
    addautocompletestuff;

    Form2.ListView1.Clear;
    form1.combobox1.Clear;

    form2.listview2.Clear;
    form2.ListView4.Clear;

    form2.listview1.items.BeginUpdate;

    Form1.statusbar1.simpletext :=
        'Dialogue ' + currentfile + ', ' + IntToStr(currentdlg.nodecount) + ' nodes';

    for u := 0 to currentdlg.floatnodecount - 1 do
        begin
        ;
        tx := form2.ListView2.Items.Add;
        tx.Caption := currentdlg.floatnodes[u].nodename;
        tx.subitems.add(IntToStr(currentdlg.floatnodes[u].messagecnt));
        tx.subitems.add(currentdlg.floatnodes[u].notes);
        end;

    for u := 0 to currentdlg.nodecount - 1 do
        begin
        if currentdlg.nodes[u].skillcheckcnt > 0 then
            begin
            ;

            for i := 0 to currentdlg.nodes[u].skillcheckcnt - 1 do
                begin
                ;
                tx := form2.ListView4.Items.add;
                tx.Caption := currentdlg.nodes[u].skillchecks[i].check_proc_name;
                tx.SubItems.Add(form24.combobox1.items[currentdlg.nodes[u].skillchecks[i].check_what - 1]);
                tx.SubItems.Add(IntToStr(currentdlg.nodes[u].skillchecks[i].modifier));
                tx.SubItems.Add(currentdlg.nodes[u].skillchecks[i].successnode);
                tx.SubItems.Add(currentdlg.nodes[u].skillchecks[i].failurenode);
                end;
            end;


        form1.combobox1.Items.Add(currentdlg.nodes[u].nodename);
    //debugmsg('Refresh at node: '+inttostr(u));
        if nodefilter = FILTER_SHOW_NOPLAYEROPTIONS_NODES then
            begin
            ;
            if (currentdlg.nodes[u].optioncnt = 0) and (currentdlg.nodes[u].hidden = false) then
                begin

                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);
                end;
            end
        else

        if nodefilter = FILTER_SHOW_EMPTYTEXT_NODES then
            begin
            if (currentdlg.nodes[u].npctext = '') and (currentdlg.nodes[u].hidden = false) then
                begin
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);
                end;
            end
        else
        if nodefilter = FILTER_SHOW_STARTING_NODES then
            begin
            if (currentdlg.nodes[u].is_wtg = true) and (currentdlg.nodes[u].hidden = false) then
                begin
                ;
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);
                end;
            end
        else
        if nodefilter = FILTER_SHOW_NONSTART_NODES then
            begin
            if ((currentdlg.nodes[u].is_wtg = false)) and (currentdlg.nodes[u].hidden = false) then
                begin
                ;
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);

                end;
            end
        else
        if nodefilter = FILTER_SHOW_NODES_BY_NAME then
            begin
            if Form2.srchEdit.Text <> '' then
                begin
                ;
                if (MatchesMask(currentdlg.nodes[u].nodename, Form2.srchedit.Text)) and
                    (currentdlg.nodes[u].hidden = false) then
                    begin
                    ;
                    tx := form2.listview1.items.add;
                    tx.Caption := currentdlg.nodes[u].nodename;
                    tx.SubItems.add(currentdlg.nodes[u].npctext);
                    end;

                end
            else
                begin
                ;
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);
                end;

            end
        else
        if (nodefilter = FILTER_VIEW_DIALOGUE_AS_TREE) then
            begin

            end
        else
            begin
            if (currentdlg.nodes[u].hidden = false) then
                begin
                ;
                tx := form2.listview1.items.add;
                tx.Caption := currentdlg.nodes[u].nodename;
                tx.SubItems.add(currentdlg.nodes[u].npctext);
                end;

            end;

        end;

    form2.listview1.items.endupdate;
    form1.combobox1.ItemIndex := 0;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
    modalresult := mrOk;
    if currentdlg.nodecount > 0 then
        begin
        ResolveNodes
        end;
end;




procedure TForm2.Button1Click(Sender: TObject);
var
    t: integer;
begin
    nodeind := currentdlg.nodecount;
    form3.Caption := 'Add node';
    new(currentdlg.nodes[nodeind]);
    currentdlg.nodes[nodeind].optioncnt := 0;
    currentdlg.nodes[nodeind].skillcheckcnt := 0;
    form3.isstartnode.Checked := false;
    Inc(currentdlg.nodecount);
    form3.showmodal;

    if form3.modalresult = mrOk then
        begin
        dlgchanged := true;
        form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
        Form1.Savedialogue2.Enabled := true;

        currentdlg.nodes[nodeind].nodename := form3.Edit1.Text;
        currentdlg.nodes[nodeind].npctext := Form3.npctext.Text;
        currentdlg.nodes[nodeind].hidden := false;
        currentdlg.nodes[nodeind].is_wtg := Form3.isstartnode.Checked;
        if Form3.CheckBox1.Checked = true then
            begin
            currentdlg.nodes[nodeind].npctext_female := Form3.memo1.Text
            end
        else
            begin
            currentdlg.nodes[nodeind].npctext_female := ''
            end;

        currentdlg.nodes[nodeind].notes := Form3.designernotes.Text;
    //  currentdlg.nodes[nodeind].optioncnt := 0;
   (* for t := 0 to Form3.optionsdata.Lines.Count - 1 do
    begin
      newcurrentdlg.nodes[currentdlg.nodecount].options[t]);
      currentdlg.nodes[currentdlg.nodecount].options[t].optiontext :=
        extractword(1, form3.optionsdata.Lines[t], ['|']);
      currentdlg.nodes[currentdlg.nodecount].options[t].nodelink   :=
        extractword(2, form3.optionsdata.Lines[t], ['|']);
      currentdlg.nodes[currentdlg.nodecount].options[t].notes      :=
        extractword(3, form3.optionsdata.Lines[t], ['|']);
      currentdlg.nodes[currentdlg.nodecount].options[t].notes      :=
        stringreplace(ansistring(currentdlg.nodes[currentdlg.nodecount].options[t].notes)
        , '\n', '#13#10', [rfReplaceAll]);

      Inc(currentdlg.nodes[currentdlg.nodecount].optioncnt);
    end; *)
    //Inc(currentdlg.nodecount);

        end;

    form3.Edit1.Text := '';
    form3.npctext.Clear;
    form3.designernotes.Clear;
    form3.optionsdata.Clear;
    form3.Memo1.Clear;
    form3.CheckBox1.Checked := false;

    RefreshNodes;
end;

procedure EditNode(nodex: integer);
var
    t, u: integer;
var
    temp: string;
begin
    ;
  //showmessage('Node = '+currentdlg.nodes[nodeind].nodename);
    nodeind := nodex;
    form3.npctext.Text := currentdlg.nodes[nodeind].npctext;
    form3.Memo1.Text := currentdlg.nodes[nodeind].npctext_female;
    form3.CheckBox1.Checked := (form3.memo1.Text <> '');
    form3.designernotes.Text := currentdlg.nodes[nodeind].notes;
    form3.Edit1.Text := currentdlg.nodes[nodeind].nodename;
    form3.Caption := 'Edit node';
    RefreshPlayerOptions;
    form3.showmodal;

    if form3.modalresult = mrOk then
        begin
        ;
        dlgchanged := true;
        form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
        Form1.Savedialogue2.Enabled := true;

        currentdlg.nodes[nodeind].nodename := form3.Edit1.Text;
        currentdlg.nodes[nodeind].npctext := Form3.npctext.Text;
        currentdlg.nodes[nodeind].notes := Form3.designernotes.Text;
        if Form3.CheckBox1.Checked = true then
            begin
            currentdlg.nodes[nodeind].npctext_female := Form3.memo1.Text
            end;

        refreshnodes;
        end;



    form3.Edit1.Text := '';
    form3.npctext.Clear;
    form3.designernotes.Clear;
    form3.optionsdata.Clear;
    form3.Memo1.Clear;
    form3.CheckBox1.Checked := false;

end;

procedure TForm2.Button2Click(Sender: TObject);

var
    previousind, t, u: integer;
var
    temp: string;
begin
    previousind := 0;
    if listview1.Selected <> nil then
        begin
        nodeind := getnodeindex(listview1.Selected.Caption);
    //showmessage('Node = '+currentdlg.nodes[nodeind].nodename);
        form3.npctext.Text := currentdlg.nodes[nodeind].npctext;
        form3.designernotes.Text := currentdlg.nodes[nodeind].notes;
        form3.Edit1.Text := currentdlg.nodes[nodeind].nodename;

        if currentdlg.nodes[nodeind].npctext_female <> '' then
            begin
            ;
            form3.CheckBox1.Checked := true;
            Form3.memo1.Text := currentdlg.nodes[nodeind].npctext_female;
            end;

        form3.Caption := 'Edit node';
        RefreshPlayerOptions;
        previousind := listview1.ItemIndex;
        Form3.isstartnode.Checked := currentdlg.nodes[nodeind].is_wtg;

        form3.showmodal;

        if form3.modalresult = mrOk then
            begin
            ;
            dlgchanged := true;
            form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
            Form1.Savedialogue2.Enabled := true;
            currentdlg.nodes[nodeind].is_wtg := Form3.isstartnode.Checked;
            currentdlg.nodes[nodeind].nodename := form3.Edit1.Text;
            currentdlg.nodes[nodeind].npctext := Form3.npctext.Text;
            currentdlg.nodes[nodeind].notes := Form3.designernotes.Text;
            if Form3.CheckBox1.Checked = true then
                begin
                currentdlg.nodes[nodeind].npctext_female := Form3.memo1.Text
                end
            else
                begin
                currentdlg.nodes[nodeind].npctext_female := ''
                end;

            refreshnodes;

            end;

        end;
    form3.Edit1.Text := '';
    form3.npctext.Clear;
    form3.designernotes.Clear;
    form3.optionsdata.Clear;
    form3.Memo1.Clear;
    form3.CheckBox1.Checked := false;
    listview1.ItemIndex := previousind;
    listview1.SetFocus;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
    if listview1.selected <> nil then
        begin
        ;
        DeleteNode(GetNodeIndex(listview1.selected.Caption));
        dlgchanged := true;
        form1.Caption := 'Fallout Dialogue Creator - [' + currentfile + '*]';
        Form1.Savedialogue2.Enabled := true;
        RefreshNodes;
        end;
end;

procedure TForm2.ListView1DblClick(Sender: TObject);
begin
    if listview1.Selected = nil then
        begin
        exit
        end;
    button2click(listview1);
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
var
    t: integer;
begin
    nodefilter := combobox1.ItemIndex + 1;

    if nodefilter = FILTER_VIEW_DIALOGUE_AS_TREE then
        begin
        form2.treeview1.Visible := true;
        form2.listview1.Visible := false;
        form2.treeview1.items.Clear;
        for t := 0 to 1000 do
            begin

            nodevisited[t] := false;
            nodevisitcount[t] := 0;
            end;

        GenerateRecursion(nil, 0);
        end
    else
        begin
         form2.treeview1.Visible := false;
        form2.listview1.Visible := true;
        end;

    if nodefilter = FILTER_SHOW_NODES_BY_NAME then
        begin
        lblSearch.Show;
        srchEdit.Show;
        srchBtn.Show;
        end
    else
        begin
        lblSearch.hide;
        srchEdit.hide;
        srchBtn.hide;
        end;


    refreshnodes;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
    z, i, t: integer;
var
    dlg: dlgnode;
begin
    if ListView1.Selected <> nil then
        begin
        ;
        t := GetNodeIndex(listview1.selected.Caption);
        if t <> -1 then
            begin
            ;
            new(currentdlg.nodes[currentdlg.nodecount]);
            dlg := currentdlg.nodes[t]^;
            currentdlg.nodes[currentdlg.nodecount]^.npctext := dlg.npctext;
            currentdlg.nodes[currentdlg.nodecount]^.npctext_female := dlg.npctext_female;
            currentdlg.nodes[currentdlg.nodecount]^.notes := dlg.notes;
            currentdlg.nodes[currentdlg.nodecount].hidden := false;
            currentdlg.nodes[currentdlg.nodecount].is_wtg := false;
            currentdlg.nodes[currentdlg.nodecount].skillcheckcnt := 0;
            currentdlg.nodes[currentdlg.nodecount].optioncnt := 0;
            for z := 0 to dlg.optioncnt - 1 do
                begin
                ;
                new(currentdlg.nodes[currentdlg.nodecount]^.options[
                    currentdlg.nodes[currentdlg.nodecount].optioncnt]);
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].optiontext := dlg.options[z].optiontext;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].nodelink := dlg.options[z].nodelink;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].noderesolved := dlg.options[z].noderesolved;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].reaction := dlg.options[z].reaction;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].genderflags := dlg.options[z].genderflags;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].intcheck := dlg.options[z].intcheck;
                currentdlg.nodes[currentdlg.nodecount]^.options[currentdlg.nodes[
                    currentdlg.nodecount].optioncnt].notes := dlg.options[z].notes;
                currentdlg.nodes[currentdlg.nodecount]^.options[
                    currentdlg.nodes[currentdlg.nodecount].optioncnt].conditioncnt := 0;
                for I := 0 to dlg.options[z].conditioncnt - 1 do
                    begin
                    ;
                    new(currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[i]);
                    currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[i]^.check_type :=
                        dlg.options[z].conditions[i]^.check_type;
                    currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[i]^.check_field :=
                        dlg.options[z].conditions[i]^.check_field;
                    currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[i]^.check_eval :=
                        dlg.options[z].conditions[i]^.check_eval;
                    currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[i]^.check_value :=
                        dlg.options[z].conditions[i]^.check_value;
                    currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditions[
                        i]^.resolved_code :=
                        dlg.options[z].conditions[i]^.resolved_code;
                    Inc(currentdlg.nodes[currentdlg.nodecount]^.options[
                        currentdlg.nodes[currentdlg.nodecount].optioncnt].conditioncnt);
                    end;

                Inc(currentdlg.nodes[currentdlg.nodecount].optioncnt);
                end;

            currentdlg.nodes[currentdlg.nodecount]^.nodename :=
                format(cfg.readstring('Global Config', 'ClonedNodeFormatString', 'Copy_of_%s'),
                [currentdlg.nodes[t]^.nodename]);
            Inc(currentdlg.nodecount);
            Resolvenodes;
            RefreshNodes;
            end;

        end;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
    prev_index: integer;
var
    movenodeind: integer;
var
    movetonodeind: integer;
begin

    if listview1.ItemIndex = 0 then
        begin
        ;
        listview1.SetFocus;
        exit;
        end;

    prev_index := listview1.selected.Index;
    movenodeind := getnodeindex(listview1.Selected.Caption);
    movetonodeind := getnodeindex(listview1.items[listview1.selected.index - 1].Caption);
    listview1.ClearSelection;

    temp_node := currentdlg.nodes[movenodeind]^;
    currentdlg.nodes[movenodeind]^ := currentdlg.nodes[movetonodeind]^;
    currentdlg.nodes[movetonodeind]^ := temp_node;
    RefreshNodesNoClear;
    resolvenodes;

    listview1.ItemIndex := movetonodeind;

    listview1.selected := listview1.items[listview1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
    listview1.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm2.ListView1Click(Sender: TObject);
begin
    if listview1.selected = nil then
        begin
        ;
        button15.Enabled := false;
        Button6.Enabled := false;
        Button7.Enabled := false;
        end
    else
        begin
        ;
        button15.Enabled := true;
        button6.Enabled := true;
        Button7.Enabled := true;
        end;

end;

procedure TForm2.Button7Click(Sender: TObject);
var
    prev_index: integer;
var
    movenodeind: integer;
var
    movetonodeind: integer;
begin

    if listview1.ItemIndex = listview1.Items.Count - 1 then
        begin
        ;
        listview1.SetFocus;
        exit;
        end;

    prev_index := listview1.selected.Index;
    movenodeind := getnodeindex(listview1.Selected.Caption);
    movetonodeind := getnodeindex(listview1.items[listview1.selected.index + 1].Caption);
    listview1.ClearSelection;

    temp_node := currentdlg.nodes[movenodeind]^;
    currentdlg.nodes[movenodeind]^ := currentdlg.nodes[movetonodeind]^;
    currentdlg.nodes[movetonodeind]^ := temp_node;
    RefreshNodesNoClear;
    resolvenodes;
    listview1.ItemIndex := movetonodeind;
    listview1.selected := listview1.items[listview1.ItemIndex];
    ListView1.Repaint;
    listview1.SetFocus;

end;

procedure TForm2.Button8Click(Sender: TObject);
begin
    donodesort;
end;

procedure TForm2.Button11Click(Sender: TObject);
begin
    if listview2.selected <> nil then
        begin
        ;
        DeleteFloaterNode(listview2.selected.index);
        form1.ExecuteScriptConsole('DialogueChangeNotify;');

        RefreshNodes;
        end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
    PageControl1.ActivePage := TabSheet1;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
    form17.edit1.Text := '';
    form17.Memo1.Text := '';
    form17.ListView1.Clear;

    nodeind := currentdlg.floatnodecount;
    new(currentdlg.floatnodes[currentdlg.floatnodecount]);
    currentdlg.floatnodes[nodeind].messagecnt := 0;
    form17.showmodal;
    if form17.ModalResult = mrOk then
        begin
        currentdlg.floatnodes[nodeind].nodename := form17.edit1.Text;
        currentdlg.floatnodes[nodeind].notes := form17.Memo1.Text;
        Inc(currentdlg.floatnodecount);
        form1.ExecuteScriptConsole('DialogueChangeNotify;');

        RefreshNodes;
        end;
    listview2.SetFocus;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
    if listview2.selected <> nil then
        begin
        ;
        nodeind := listview2.Selected.Index;
        refreshfloatmsgs;
        form17.Edit1.Text := currentdlg.floatnodes[nodeind].nodename;
        form17.memo1.Text := currentdlg.floatnodes[nodeind].notes;
        form17.showmodal;
        if form17.modalresult = mrOk then
            begin
            ;
            currentdlg.floatnodes[nodeind].nodename := Form17.edit1.Text;
            currentdlg.floatnodes[nodeind].notes := Form17.Memo1.Text;
            RefreshNodes;
      //form1.ExecuteScriptConsole('DialogueChangeNotify;');
            DialogueChangeNotify;

            end;

        end;
    if form2.Visible = true then
        begin
        listview2.SetFocus
        end;

    form17.Memo2.Text := '';
end;

procedure TForm2.Button12Click(Sender: TObject);
begin
    refreshtimeeventlist;
    form18.showmodal;

    if form18.modalresult = mrOk then
        begin
        DialogueChangeNotify
        end;

  //form1.ExecuteScriptConsole('DialogueChangeNotify;');

end;

procedure TForm2.ListView1Edited(Sender: TObject; Item: TListItem; var S: string);
var
    i: integer;
begin
    debugmsg('On edited: ' + item.Caption + ' string = ' + s);

    i := getnodeindex(item.Caption);
    if i <> -1 then
        begin

        currentdlg.nodes[i].nodename := s;
        debugmsg('Renamed ' + item.Caption + ' to ' + s);

        RemapNodes(item.Caption, s);
        RequestPluginRefresh;
        end;

end;

procedure TForm2.ListView2DblClick(Sender: TObject);
begin
    button10click(listview2);
end;

procedure TForm2.Button14Click(Sender: TObject);
begin
    updatevars;
    form21.showmodal;

    if form21.modalresult = mrOk then
        begin
        ;
        DialogueChangeNotify;
        AddAutoCompleteStuff;
        end;

  //form1.ExecuteScriptConsole('DialogueChangeNotify;');

end;

procedure TForm2.srchBtnClick(Sender: TObject);
begin
    RefreshNodes;
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
    refresh_start_conditions;
    form22.showmodal;
    if form22.modalresult = mrOk then
        begin
        DialogueChangeNotify
        end;
end;

procedure TForm2.Button15Click(Sender: TObject);
var
    t: integer;
var
    nodeind: integer;
var
    start: TListItem;
begin

    if listview1.selcount > 0 then
        begin
        ;
    //listview1.GetNextItem()
        start := listview1.Selected;
        while start <> nil do
            begin
            ;
            debugmsg('adding nodeitem ' + start.Caption + ' to hide_list');
            nodeind := GetNodeIndex(start.Caption);

            if nodeind <> -1 then
                begin
                currentdlg.nodes[nodeind].hidden := true
                end;

            start := listview1.GetNextItem(start, sdBelow, [isSelected]);
            end;
        RefreshNodes;
        button16.Enabled := true;
        end;

end;

procedure TForm2.Button16Click(Sender: TObject);
var
    t: integer;
begin
    for t := 0 to currentdlg.nodecount - 1 do
        begin
        ;
        currentdlg.nodes[t].hidden := false;
        end;

    button16.Enabled := false;
    refreshnodes;
end;

procedure TForm2.Button20Click(Sender: TObject);
var
    skindex, t, x, skcheckind: integer;
var
    nodeindex, the_node: integer;
var
    oldname, newname: string;
begin
    if form2.listview4.selected <> nil then
        begin
        ;
        updatenodelists;
        skcheckind := getskillcheckindex(listview4.selected.Caption, nodeindex);
        form24.ComboBox4.ItemIndex := nodeindex;
        form24.Edit1.Text := currentdlg.nodes[nodeindex].skillchecks[skcheckind].check_proc_name;
        form24.ComboBox1.ItemIndex := currentdlg.nodes[nodeindex].skillchecks[skcheckind].check_what - 1;
        Form24.UpDown1.position := currentdlg.nodes[nodeindex].skillchecks[skcheckind].modifier;
        form24.combobox2.ItemIndex := getnodeindex(currentdlg.nodes[nodeindex].skillchecks[skcheckind].successnode);
        form24.combobox3.ItemIndex := getnodeindex(currentdlg.nodes[nodeindex].skillchecks[skcheckind].failurenode);
        form24.ComboBox2Click(nil);
        form24.ComboBox3Click(nil);
        oldname := listview4.selected.Caption;
        skindex := skcheckind;

        form24.showmodal;
        if form24.modalresult = mrOk then
            begin
            ;
            the_node := form24.combobox4.ItemIndex;
            currentdlg.nodes[the_node].skillchecks[skcheckind].check_proc_name :=
                form24.Edit1.Text;
            newname := form24.edit1.Text;
            currentdlg.nodes[the_node].skillchecks[skcheckind].check_what :=
                form24.combobox1.ItemIndex + 1;
            currentdlg.nodes[the_node].skillchecks[skcheckind].modifier :=
                Form24.UpDown1.position;
            currentdlg.nodes[the_node].skillchecks[skcheckind].successnode :=
                Form24.ComboBox2.Text;
            currentdlg.nodes[the_node].skillchecks[skcheckind].failurenode :=
                Form24.ComboBox3.Text;
      //   RefreshSkillchecks;

            for t := 0 to currentdlg.nodecount - 1 do
                begin
                ;
                for x := 0 to currentdlg.nodes[t].optioncnt - 1 do
                    begin
                    ;
                    if (currentdlg.nodes[t].options[x].nodelink = oldname) then
                        begin
                        ;
                        debugmsg('Remapping player option ' + IntToStr(x) + ' of node ' + currentdlg.nodes[t].nodename +
                            ': ' + oldname + ' => ' + newname);
                        currentdlg.nodes[t].options[x].nodelink := newname;
            //nodes := nodes + 'Node ' + currentdlg.nodes[t].nodename + ', option ' + IntToStr(x) + #13#10;
                        end;
                    end;
                end;


            refreshnodes;
            end;
        end
    else
        begin
        MessageDlg('No skill check selected!', mtError, [mbOK], 0)
        end;

end;

procedure TForm2.ListView4DblClick(Sender: TObject);
begin
    if listview4.selected <> nil then
        begin
        button20click(listview4)
        end;

end;

procedure TForm2.Button19Click(Sender: TObject);
var
    check: string;
var
    the_node: integer;
begin
    form24.Edit1.Text := '';
    form24.Memo1.Clear;
    form24.Memo2.Clear;
    form24.UpDown1.Position := 0;
    updatenodelists;
  //  form24.ComboBox4.ItemIndex := nodeind;
    form24.showmodal;
    if form24.modalresult = mrOk then
        begin
        ;
        the_node := form24.combobox4.ItemIndex;
        new(currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt]);
        currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].check_proc_name :=
            form24.Edit1.Text;
        check := form24.edit1.Text;
        currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].check_what :=
            form24.combobox1.ItemIndex + 1;
        currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].modifier :=
            Form24.UpDown1.position;
        currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].successnode :=
            Form24.ComboBox2.Text;
        currentdlg.nodes[the_node].skillchecks[currentdlg.nodes[the_node].skillcheckcnt].failurenode :=
            Form24.ComboBox3.Text;
        Inc(currentdlg.nodes[the_node].skillcheckcnt);
        refreshnodes;
        end;

end;

procedure TForm2.Button21Click(Sender: TObject);
var
    t, x: integer;
var
    nodeindex, skindex: integer;
var
    nodes: string;
begin
    nodes := '';
    if listview4.selected <> nil then
        begin
        ;
    // check which player options link to this skill check
        skindex := getskillcheckindex(listview4.selected.Caption, nodeindex);
        for t := 0 to currentdlg.nodecount - 1 do
            begin
            ;
            for x := 0 to currentdlg.nodes[t].optioncnt - 1 do
                begin
                ;
                if (currentdlg.nodes[t].options[x].nodelink = listview4.selected.Caption) then
                    begin
                    ;
                    nodes := nodes + 'Node ' + currentdlg.nodes[t].nodename + ', option ' + IntToStr(x) + #13#10;
                    end;
                end;
            end;

        if nodes <> '' then
            begin
            ;
            case MessageDlg(format('Warning:' + #13 + #10 + '' + #13 + #10 + 'The following nodes have player options ' +
                    #13 + #10 + 'with links to this skill check:''' + #13 + #10 + '' + #13 + #10 + '%s' +
                    '' + #13 + #10 + 'Are you sure you wish to delete this item?' + #13 + #10 +
                    '(The player option link will be reset to the' + #13 + #10 + 'success node of the skill check.)', [nodes]),
                    mtWarning, [mbYes, mbNo], 0) of
                mrYes:
                    begin
                    ;

                    for t := 0 to currentdlg.nodecount - 1 do
                        begin
                        ;
                        for x := 0 to currentdlg.nodes[t].optioncnt - 1 do
                            begin
                            ;
                            if (currentdlg.nodes[t].options[x].nodelink = listview4.selected.Caption) then
                                begin
                                currentdlg.nodes[t].options[x].nodelink :=
                                    currentdlg.nodes[nodeindex].skillchecks[skindex].successnode;
                                currentdlg.nodes[t].options[x].link_to_skillcheck := false;
                //  nodes := nodes + 'Node ' + currentdlg.nodes[t].nodename + ', option ' + IntToStr(x) + #13#10;
                                end;
                            end;
                        end;
                    DeleteSkillCheck(listview4.Selected.Caption);
                    resolvenodes;
                    RefreshNodes;
                    end;
                mrNo:
                    begin
                    exit
                    end;
                end;
            end
        else
            begin
            ;
            DeleteSkillCheck(listview4.Selected.Caption);
            RefreshNodes;
            end;

        end;

end;

procedure TForm2.Button23Click(Sender: TObject);
var
    t, u: integer;
begin
    form1.ReplaceDialog1.Execute;

end;

end.

