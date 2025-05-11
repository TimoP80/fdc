unit SplashScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, GR32_Image;

type
  TSplashForm = class(TForm)
    LogoImage: TImage32;
    statuslabel: TLabel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashForm: TSplashForm;
procedure UpdateSplashLabel (msg: string);

implementation

{$R *.dfm}
procedure UpdateSplashLabel (msg: string);
begin
splashform.statuslabel.caption := msg;
splashform.update;
splashform.statuslabel.update;
end;
end.
