unit timeevent_editor;

interface

uses
  Windows, sharedDLGData, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm18 = class(TForm)
    Panel1:    TPanel;
    Button1:   TButton;
    ListView1: TListView;
    Label1:    TLabel;
    Button2:   TButton;
    Button3:   TButton;
    Label2:    TLabel;
    ComboBox1: TComboBox;
    Button4:   TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form18: TForm18;

procedure RefreshTimeEventList;

implementation

uses TE_DataEd;

{$R *.dfm}

procedure TForm18.Button1Click(Sender: TObject);
begin
  if form18.combobox1.ItemIndex <> -1 then
  begin
    currentdlg.start_time_event := form18.combobox1.ItemIndex;
  end;
  modalresult := mrOk;
end;

procedure RefreshTimeEventList;
var
  tx: TListItem;
var
  i:  Integer;
begin
  form18.ListView1.Clear;
  form18.ComboBox1.Clear;
  for I := 0 to currentdlg.timedeventcnt - 1 do
  begin
    tx := Form18.ListView1.Items.add;
    form18.ComboBox1.Items.add(currentdlg.timedevents[i].FixedParamName);
    tx.Caption := currentdlg.timedevents[i].FixedParamName;
    tx.SubItems.add(IntToStr(currentdlg.timedevents[i].actioncnt));
    tx.subitems.add(booltostr(currentdlg.timedevents[i].israndom, True));
    if currentdlg.timedevents[i].israndom = True then
      tx.SubItems.add(format('%d-%d', [currentdlg.timedevents[i].mininterval, currentdlg.timedevents[i].maxinterval]))
    else
      tx.SubItems.add(format('%d', [currentdlg.timedevents[i].interval]));

  end;
  if (form18.combobox1.ItemIndex = -1) and (form18.combobox1.Items.Count > 0) then
    form18.combobox1.ItemIndex := 0;
end;

procedure TForm18.Button2Click(Sender: TObject);
var
  x: Integer;
begin
  form19.Edit1.Clear;
  Form19.UpDown1.Position := 0;
  Form19.UpDown2.Position := 0;
  Form19.UpDown3.Position := 0;
  Form19.SynMemo1.Clear;
  form19.showmodal;
  if form19.modalresult = mrOk then
  begin
    new(currentdlg.timedevents[currentdlg.timedeventcnt]);
    currentdlg.timedevents[currentdlg.timedeventcnt].actioncnt := 0;
    currentdlg.timedevents[currentdlg.timedeventcnt].FixedParamName := Form19.Edit1.Text;
    currentdlg.timedevents[currentdlg.timedeventcnt].FixedParamEnumIndex :=
      Form19.UpDown1.position;
    currentdlg.timedevents[currentdlg.timedeventcnt].israndom  :=
      (form19.ComboBox1.ItemIndex = 1);
    if currentdlg.timedevents[currentdlg.timedeventcnt].israndom = False then
      currentdlg.timedevents[currentdlg.timedeventcnt].interval :=
        form19.UpDown2.Position
    else
    begin
      currentdlg.timedevents[currentdlg.timedeventcnt].mininterval :=
        form19.UpDown2.position;
      currentdlg.timedevents[currentdlg.timedeventcnt].maxinterval :=
        form19.UpDown3.position;
    end;
    for x := 0 to form19.SynMemo1.Lines.Count - 1 do
    begin
      new(currentdlg.timedevents[currentdlg.timedeventcnt].actionlines[x]);
      currentdlg.timedevents[currentdlg.timedeventcnt].actionlines[x].linedata :=
        form19.synmemo1.Lines[x];
      Inc(currentdlg.timedevents[currentdlg.timedeventcnt].actioncnt);
    end;
    Inc(currentdlg.timedeventcnt);
    RefreshTimeEventList;
  end;
end;

procedure TForm18.Button4Click(Sender: TObject);
var
  x, te_index: Integer;
begin
  if ListView1.selected <> nil then
  begin
    te_index := listview1.selected.index;
    Form19.Edit1.Text := currentdlg.timedevents[te_index].FixedParamName;
    case currentdlg.timedevents[te_index].israndom of
      True:
      begin
        Form19.ComboBox1.ItemIndex := 1;
        form19.UpDown2.position := currentdlg.timedevents[te_index].mininterval;
        form19.UpDown3.position := currentdlg.timedevents[te_index].maxinterval;

      end;
      False:
      begin
        Form19.ComboBox1.ItemIndex := 0;
        form19.UpDown2.position := currentdlg.timedevents[te_index].interval;
      end;
    end;
    form19.UpDown1.Position := currentdlg.timedevents[te_index].FixedParamEnumIndex;
    form19.synmemo1.Clear;
    for x := 0 to currentdlg.timedevents[te_index].actioncnt - 1 do
    begin
      form19.SynMemo1.Lines.Add(currentdlg.timedevents[te_index].actionlines[x].linedata);
    end;

    Form19.showmodal;


    currentdlg.timedevents[te_index].actioncnt := 0;
    currentdlg.timedevents[te_index].FixedParamName := Form19.Edit1.Text;
    currentdlg.timedevents[te_index].FixedParamEnumIndex :=
      Form19.UpDown1.position;
    currentdlg.timedevents[te_index].israndom  :=
      (form19.ComboBox1.ItemIndex = 1);
    if currentdlg.timedevents[te_index].israndom = False then
      currentdlg.timedevents[te_index].interval :=
        form19.UpDown2.Position
    else
    begin
      currentdlg.timedevents[te_index].mininterval :=
        form19.UpDown2.position;
      currentdlg.timedevents[te_index].maxinterval :=
        form19.UpDown3.position;
    end;
    currentdlg.timedevents[te_index].actioncnt := 0;
    for x := 0 to form19.SynMemo1.Lines.Count - 1 do
    begin
      new(currentdlg.timedevents[te_index].actionlines[x]);
      currentdlg.timedevents[te_index].actionlines[x].linedata :=
        form19.synmemo1.Lines[x];
      Inc(currentdlg.timedevents[te_index].actioncnt);
    end;

    RefreshTimeEventList;

  end;

end;

procedure TForm18.ListView1DblClick(Sender: TObject);
begin
  button4click(listview1);
end;

procedure TForm18.Button3Click(Sender: TObject);
begin
  if (listview1.selected <> nil) then
  begin
    DeleteTimedEvent(ListView1.Selected.index);
    RefreshTimeEventList;
  end;

end;

end.

