unit skillcheck_eval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvMarkupLabel;

type
  TForm27 = class(TForm)
    JvMarkupLabel1: TJvMarkupLabel;
    Button1:        TButton;
    Button2:        TButton;
    Button3:        TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  STATE_GO_SUCCESS = 1;
  STATE_GO_FAILURE = 2;
  STATE_GO_EVAL    = 3;

var
  Form27: TForm27;
  state:  integer;

implementation

{$R *.dfm}

procedure TForm27.Button1Click(Sender: TObject);
begin
  state := STATE_GO_SUCCESS;
end;

procedure TForm27.Button3Click(Sender: TObject);
begin
  state := STATE_GO_FAILURE;
end;

procedure TForm27.Button2Click(Sender: TObject);
begin
  state := STATE_GO_EVAL;
end;

end.
