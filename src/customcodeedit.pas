unit customcodeedit;

interface

uses
  Classes, Controls, Dialogs, Forms,
  Graphics, Messages, StdCtrls, SynEdit,CodeSnippets,var_inputpage, SynMemo, SysUtils, te_dataed, Variants, Windows;
type
  TForm25 = class(TForm)
    Label1:   TLabel;
    SynMemo1: TSynMemo;
    Button1:  TButton;
    Button2:  TButton;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

uses fmfmain;


{$R *.dfm}

procedure TForm25.FormShow(Sender: TObject);
  var t: integer;
begin
  form1.SynCompletionProposal1.Editor := Form25.SynMemo1;
  form1.syncompletionproposal2.Editor := form25.synmemo1;
  ComboBox1.Clear;
  for t := 0 to codesnippetcnt - 1 do
  begin
    combobox1.items.add(codesnippetdata[t].DisplayName);
  end;

end;

procedure TForm25.FormCreate(Sender: TObject);
begin
  Form1.SynCompletionProposal1.AddEditor(Form25.SynMemo1);
  Form1.SynCompletionProposal2.AddEditor(Form25.SynMemo1);

end;

procedure TForm25.Button1Click(Sender: TObject);
begin
     DialogueChangeNotify;

end;

procedure TForm25.Button3Click(Sender: TObject);
var t: integer;
begin


  if (combobox1.ItemIndex <> -1) then
  begin
    current_code  := combobox1.ItemIndex;
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

