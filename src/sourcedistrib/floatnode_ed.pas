unit floatnode_ed;

interface

uses
  Windows, Messages, SysUtils, SharedDLGData, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;
type
  TForm17 = class(TForm)
    Bevel1:    TBevel;
    Label1:    TLabel;
    Edit1:     TEdit;
    Label2:    TLabel;
    Memo1:     TMemo;
    Label3:    TLabel;
    ListView1: TListView;
    Label4:    TLabel;
    Memo2:     TMemo;
    Button1:   TButton;
    Button2:   TButton;
    Button3:   TButton;
    Button4:   TButton;
    Button5:   TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form17: TForm17;
procedure RefreshFloatMSGS;
implementation

uses poptadd;

{$R *.dfm}

procedure TForm17.Button3Click(Sender: TObject);
var t: integer;
begin
  t := GetNodeIndex(edit1.Text);
  if t <> -1 then
  begin
    MessageDlg(format('%s already exists as a regular node.' + #13 +
      #10 + 'Please pick a unique node name' + #13 + #10 +
      'for this floater node.', [edit1.Text]),
      mtWarning, [mbOK], 0);
    exit;
  end;

  modalresult := mrOk;
end;

procedure TForm17.Button4Click(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure RefreshFloatMSGS;
var
  s: TListItem;
  t: integer;
begin
  form17.ListView1.Clear;
  for t := 0 to currentdlg.floatnodes[nodeind].messagecnt - 1 do
  begin
    s         := Form17.ListView1.Items.Add;
    s.Caption := IntToStr(t);
    s.SubItems.add(currentdlg.floatnodes[nodeind].Messages[t]);
  end;
end;

procedure TForm17.Button1Click(Sender: TObject);
begin
  currentdlg.floatnodes[nodeind].Messages[currentdlg.floatnodes[nodeind].messagecnt] :=
    Memo2.Text;
  Inc(currentdlg.floatnodes[nodeind].messagecnt);
  RefreshFloatMSGS;
  memo2.Clear;
end;

procedure TForm17.Button2Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    DeleteFloatNodeMessage(nodeind, listview1.Selected.index);
    RefreshFloatMSGS;
  end;

end;

procedure TForm17.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    Button5.Enabled := True;
    memo2.Text      := currentdlg.floatnodes[nodeind].Messages[listview1.Selected.index];
  end else
  begin
    Memo2.Text      := '';
    Button5.Enabled := False;
  end;

end;

procedure TForm17.Button5Click(Sender: TObject);
begin
  if listview1.Selected <> nil then
  begin
  currentdlg.floatnodes[nodeind].Messages[listview1.Selected.index] := memo2.text;
  RefreshFloatMSGS;
  end;

end;

end.

