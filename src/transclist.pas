unit transclist;

interface

uses
  fmfmain, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;
type
  TForm14 = class(TForm)
    Panel1:    TPanel;
    ListView1: TListView;
    Button1:   TButton;
    Label1:    TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses dlgtrans;

{$R *.dfm}

procedure TForm14.Button1Click(Sender: TObject);
begin
  form14.hide;
end;

procedure TForm14.ListView1DblClick(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    form13.Show;
    displaytranscript(listview1.selected.index);
  end;

end;

end.

