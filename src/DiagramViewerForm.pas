unit DiagramViewerForm;

interface

uses
  Windows,
  Inifiles,
  condcheck,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  FMF,
  SharedDLGData,
  atDiagram,
  Menus,
  StdCtrls,
  FlowchartBlocks;

type
  TDiagramMain = class(TForm)
    MainMenu1 :     TMainMenu;
    File1 :         TMenuItem;
    LoadDialogue1 : TMenuItem;
    N1 :            TMenuItem;
    Quit1 :         TMenuItem;
    OpenDialog1 :   TOpenDialog;
    Memo1 :         TMemo;
    atDiagram1: TatDiagram;
    procedure LoadDialogue1Click(Sender: TObject);
    procedure BuildDialogueDiagram;
    procedure Quit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiagramMain: TDiagramMain;
  FMFParser:   TFMF;

implementation

{$R *.dfm}

procedure AddMessage(msg: string);
begin
  Diagrammain.memo1.Lines.add(msg);
end;

procedure TDiagramMain.BuildDialogueDiagram;
var
  block:         TFlowActionBlock;
  num_rows_done: integer;
  t:             integer;
  textCell:      TTextCell;
  _left:         integer;

  _top:          integer;
begin
  _left         := 20;
  _top          := 0;
  num_rows_done := 0;
  for t := 0 to currentdlg.nodecount - 1 do
  begin
    block := TFlowActionblock.Create(self);
    with block do
    begin
        Name := currentdlg.nodes[t].nodename;
      Width   := 150;
      Height  := 90;
      Diagram := atDiagram1;
      top     := _top;
      left    := _left;
      
      if num_rows_done = 5 then
      begin
        _left := left + (Width + 55);
        _top := 0;
        num_rows_done := 0;
      end
      else
      begin
        _top          := _top + (block.Height + 55);

      end;

      Shape := bsRoundRect;

      Strings.Add(currentdlg.nodes[t].nodename);
      AddMessage('numrows: ' + IntToStr(num_rows_done) + ' Top = ' + IntToStr(top) + ' Left = ' + IntToStr(left));
      Strings.Add('');
      strings.add(copy(currentdlg.nodes[t].npctext, 1, 80) + ' ... ');
    end;

    Inc(num_rows_done);
  end;

end;

procedure TDiagramMain.LoadDialogue1Click(Sender: TObject);
begin

  if opendialog1.Execute then
  begin
    atDiagram1.Clear;
    FMFParser := TFMF.Create(NIL);
    FMFparser.SourceFileName := opendialog1.filename;
    FMFParser.Execute;
    if fmfparser.successful = True then
    begin
      AddMEssage('Parse successful.');
      addmessage('Node count: ' + IntToStr(currentdlg.nodecount));
      BuildDialogueDiagram;
    end
    else
    begin
      MessageDlg('Dialogue load failed!', mtError, [mbOK], 0);
    end;

  end;

end;

procedure TDiagramMain.Quit1Click(Sender: TObject);
begin
  diagrammain.Close;

end;

procedure TDiagramMain.FormCreate(Sender: TObject);
begin
  condcfg := Tinifile.Create('.\conditions.ini');

end;

end.

