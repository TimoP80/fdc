unit devfunced;

interface

uses
  Windows, fmfmain, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
type
  TForm12 = class(TForm)
    Panel1:   TPanel;
    ListBox1: TListBox;
    Label1:   TLabel;
    Memo1:    TMemo;
    Label2:   TLabel;
    Button1:  TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.Button1Click(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TForm12.ListBox1Click(Sender: TObject);
begin
  if listbox1.ItemIndex <> -1 then
  begin
    Memo1.Text := funcdesc.ReadString('Functions', listbox1.items[listbox1.ItemIndex], '');
    memo1.Text := Stringreplace(memo1.Text, '\n', #13#10, [rfReplaceAll]);
  end;

end;

procedure TForm12.Memo1Change(Sender: TObject);
var temp: string;
begin
  temp := memo1.Text;
  funcdesc.WriteString('Functions', listbox1.items[listbox1.ItemIndex], '');
  temp := StringReplace(temp, #13#10, '\n', [rfReplaceAll]);
  funcdesc.WriteString('Functions', listbox1.items[listbox1.ItemIndex], temp);
end;

end.

