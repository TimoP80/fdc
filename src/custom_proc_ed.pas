unit custom_proc_ed;

interface

uses
  Classes, CodeSnippets, VCL.Controls, debugwnd, VCL.Dialogs, VCL.ExtCtrls, VCL.Forms,
  VCL.Graphics, Messages, poptadd, SharedDLGData, VCL.StdCtrls, SynEdit, SynMemo, SysUtils, TE_DataEd, Variants, Windows;
type
  TForm23 = class(TForm)
    Bevel1:    TBevel;
    SynMemo1:  TSynMemo;
    Label1:    TLabel;
    Label2:    TLabel;
    Edit1:     TEdit;
    Button1:   TButton;
    Button2:   TButton;
    Label3:    TLabel;
    ListBox1:  TListBox;
    Button3:   TButton;
    Label4:    TLabel;
    ComboBox1: TComboBox;
    Delete:    TButton;
    Label5:    TLabel;
    ComboBox2: TComboBox;
    Button4:   TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure DeleteClick(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form23:           TForm23;
  selected_proc:    integer;
  set_current_node: boolean;

implementation

uses fmfmain, Math, var_inputpage;

{$R *.dfm}

procedure TForm23.FormCreate(Sender: TObject);
begin
  Form1.SynCompletionProposal1.AddEditor(Form23.SynMemo1);
  Form1.SynCompletionProposal2.AddEditor(Form23.SynMemo1);

end;

procedure refreshprocs;
var t: integer;
begin
  form23.ComboBox1.Clear;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    form23.combobox1.Items.add(currentdlg.nodes[t].nodename);
  end;


  Form23.ListBox1.Clear;
  for t := 0 to currentdlg.customproccnt - 1 do
    form23.ListBox1.Items.add(currentdlg.customprocs[t].Name);

end;

procedure TForm23.FormShow(Sender: TObject);
var t: integer;
begin
  ComboBox2.Clear;
  for t := 0 to codesnippetcnt - 1 do
  begin
    combobox2.items.add(codesnippetdata[t].DisplayName);
  end;

  form1.syncompletionproposal1.Editor := form23.synmemo1;

  form1.syncompletionproposal2.Editor := form23.synmemo1;
  refreshprocs;
  if set_current_node = True then
    ComboBox1.ItemIndex := nodeind;

end;

procedure TForm23.Button3Click(Sender: TObject);
begin
  new(currentdlg.customprocs[currentdlg.customproccnt]);
  currentdlg.customprocs[currentdlg.customproccnt].Name := Edit1.Text;
  currentdlg.customprocs[currentdlg.customproccnt].Lines := synmemo1.Text;
  currentdlg.customprocs[currentdlg.customproccnt].associatewithnode := combobox1.ItemIndex;
  Inc(currentdlg.customproccnt);
  synmemo1.Clear;
  Edit1.Clear;

  DialogueChangeNotify;
  refreshprocs;

end;

procedure TForm23.Button1Click(Sender: TObject);
begin
  if listbox1.ItemIndex <> -1 then
  begin
    selected_proc := listbox1.ItemIndex;
    currentdlg.customprocs[selected_proc].Lines := synmemo1.Lines.Text;
    currentdlg.customprocs[selected_proc].Name := edit1.Text;
    currentdlg.customprocs[selected_proc].associatewithnode := combobox1.ItemIndex;
  end;

  synmemo1.Clear;
  Edit1.Clear;

end;

procedure TForm23.ListBox1Click(Sender: TObject);
begin
  if listbox1.ItemIndex <> -1 then
  begin


    Edit1.Text          := currentdlg.customprocs[listbox1.ItemIndex].Name;
    SynMemo1.Lines.Text := currentdlg.customprocs[listbox1.ItemIndex].Lines;
    selected_proc       := listbox1.ItemIndex;
    combobox1.ItemIndex := currentdlg.customprocs[listbox1.ItemIndex].associatewithnode;
  end else
  begin

    edit1.Text := '';
    synmemo1.Clear;

  end;

end;

procedure TForm23.ListBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var position: TPoint;
begin
  position.X := x;
  position.Y := y;
  if listbox1.ItemAtPos(position, True) = -1 then
  begin
    if listbox1.ItemIndex <> -1 then
    begin
      currentdlg.customprocs[selected_proc].Lines := synmemo1.Lines.Text;
      currentdlg.customprocs[selected_proc].Name  := edit1.Text;
      currentdlg.customprocs[selected_proc].associatewithnode := combobox1.ItemIndex;
    end;

    selected_proc := -1;
    refreshprocs;
    synmemo1.Clear;
    edit1.Clear;

    listbox1.ItemIndex := -1;
  end;

end;

procedure TForm23.DeleteClick(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    deletecustomproc(listbox1.ItemIndex);
    refreshprocs;
    DialogueChangeNotify;
  end;

end;

procedure TForm23.ComboBox1Click(Sender: TObject);
begin
  DialogueChangeNotify;

end;

procedure TForm23.Button4Click(Sender: TObject);

var t: integer;
begin
  if (listbox1.ItemIndex = -1) then
  begin
    MessageDlg('Create a new procedure or select an existing one first.', mtInformation, [mbOK], 0);
    exit;
  end;

  if (combobox2.ItemIndex <> -1) and (listbox1.ItemIndex <> -1) then
  begin
    current_code  := combobox2.ItemIndex;
    current_param := 0;
    // form26.CurrentParamCaption.Caption := codesnippetdata[current_code].params[current_param].paramdesc;
    updateparams;
    code_string   := codesnippetdata[current_code].Lines;
    form26.Showmodal;
    if form26.modalresult = mrOk then
    begin
   //   debugmsg('TEXT == ' + codesnippetdata[current_code].Lines);
      SynMemo1.Text := code_string;
    end;

  end;

end;

end.

