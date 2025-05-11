program DefineEditor;

uses
  Forms,
  define_main in 'define_main.pas' {Form1},
  defedit_about in 'defedit_about.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FMF Dialogue Tool Defines Editor';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
