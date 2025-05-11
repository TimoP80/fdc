program ExtAppReg;

uses
  ExceptionLog,
  Forms,
  ext_test in 'ext_test.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
