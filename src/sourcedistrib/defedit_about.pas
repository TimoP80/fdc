unit defedit_about;

interface

uses
  Classes, Controls, Dialogs, DynamicSkinForm, ExtCtrls, Forms,
  Graphics, Messages, SkinCtrls, StdCtrls, SysUtils, Variants, Windows;
type
  TForm2 = class(TForm)
    spDynamicSkinForm1: TspDynamicSkinForm;
    spSkinButton1:      TspSkinButton;
    TeLabel1:           TspSkinLabel;
    TeLabel2:           TspSkinLabel;
    spSkinTextLabel1: TspSkinTextLabel;
    procedure spSkinButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses define_main;
{$R *.dfm}

procedure TForm2.spSkinButton1Click(Sender: TObject);
begin
  form2.hide;

end;

end.

