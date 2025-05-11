unit expcfg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, ExtCtrls;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    JvFilenameEdit1: TJvFilenameEdit;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
modalresult := mrOk;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
modalresult := mrCancel;
end;

end.
