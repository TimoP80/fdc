unit selectfloatnode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm20 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form20: TForm20;

implementation

{$R *.dfm}

procedure TForm20.Button1Click(Sender: TObject);
begin
modalresult:=mrOk;
end;

procedure TForm20.ListBox1DblClick(Sender: TObject);
begin
modalresult:=mrOk;
end;

procedure TForm20.Button2Click(Sender: TObject);
begin
modalresult:=mrCancel;
end;

end.
