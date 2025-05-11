unit updform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvProgressBar, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    curver: TLabel;
    availver: TLabel;
    status: TLabel;
    Bevel1: TBevel;
    JvGradientProgressBar1: TJvGradientProgressBar;
    progress: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  thepath: string;
implementation

uses updunit;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
modalresult := mrOk;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
datamodule1.mxWebUpdate1.CheckForAnUpdate;
timer1.Enabled := false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
Timer1.enabled:=true;

end;

end.
