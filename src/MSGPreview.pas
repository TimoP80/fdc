unit MSGPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SynEdit, SynEditHighlighter, SynHighlighterGeneral;

type
  TForm2 = class(TForm)
    SynEdit1:       TSynEdit;
    Button1:        TButton;
    SynGeneralSyn1: TSynGeneralSyn;
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form2: TForm2;

procedure SynAddLine(str: String);

implementation

{$R *.dfm}

procedure SynAddLine(str: String);
begin
//showmessage('line being added == '+str);
  form2.synedit1.Lines.add(str);
end;

end.
