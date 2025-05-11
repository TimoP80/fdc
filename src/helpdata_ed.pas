unit helpdata_ed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls,
  bsSkinData, BusinessSkinForm, bsSkinCtrls, Menus, bsSkinMenus,
  bsSkinBoxCtrls, ExtCtrls, bsSkinUnZip;
type
  TForm1 = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsResourceStrData1: TbsResourceStrData;
    bsSkinPopupMenu1: TbsSkinPopupMenu;
    est1: TMenuItem;
    Hsa1: TMenuItem;
    Esa1: TMenuItem;
    bsSkinMainMenu1: TbsSkinMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    Quit1: TMenuItem;
    Abotu1: TMenuItem;
    bsSkinControlBar1: TbsSkinControlBar;
    bsSkinMainMenuBar1: TbsSkinMainMenuBar;
    bsSkinUnZip1: TbsSkinUnZip;
    bsSkinListBox1: TbsSkinListBox;
    bsSkinLabel1: TbsSkinLabel;
    bsSkinStatusBar1: TbsSkinStatusBar;
    procedure CustomItem7Click(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CustomItem7Click(Sender: TObject);
begin
  halt;
end;

procedure TForm1.Quit1Click(Sender: TObject);
begin
halt;
end;

end.

