program HelpSystemEdit;

uses
  Forms,
  helpdata_ed in 'helpdata_ed.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
