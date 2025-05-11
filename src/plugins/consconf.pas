unit consconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Inifiles, JvExStdCtrls, JvCombobox, JvColorCombo;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    JvFontComboBox1: TJvFontComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
   cfg: TInifile;
implementation

uses scriptconswnd;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin

form1.Memo1.font.name := JvFontComboBox1.FontName;
form1.Memo2.font.name := JvFontComboBox1.FontName;

form1.edit1.font.name := JvFontComboBox1.FontName;

form1.Memo1.Color := ColorBox1.Selected;
form1.Edit1.Color := ColorBox1.selected;
form1.Memo2.Color := ColorBox1.selected;
form1.memo1.Font.Color := colorbox2.selected;
form1.memo2.Font.Color := colorbox2.selected;
form1.edit1.Font.Color := colorbox2.selected;
cfg.WriteString('Color configuration','Font',jvfontcombobox1.fontname);
cfg.WriteString('Color configuration','Color1',ColorToString(colorbox1.selected));
cfg.WriteString('Color configuration','Color2',ColorToString(colorbox2.selected));
form2.ModalResult:=mrOk;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
form2.ModalResult := mrCancel;
end;

end.
