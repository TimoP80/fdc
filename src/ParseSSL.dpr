program ParseSSL;

uses
  Forms,
  ParseSSLTest in 'ParseSSLTest.pas' {Form1},
  SimpleSSLParser in 'SimpleSSLParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
