unit SSLImportMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TSSLForm = class(TForm)
    Label1: TLabel;
    CheckListBox1: TCheckListBox;
    opendlgssl: TOpenDialog;
    opendlgmsg: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SSLForm: TSSLForm;

implementation

{$R *.dfm}

end.
