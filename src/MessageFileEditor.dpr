program MessageFileEditor;

uses
  Forms,
  MSGEditor in 'MSGEditor.pas' {Form1},
  MSGPreview in 'MSGPreview.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
