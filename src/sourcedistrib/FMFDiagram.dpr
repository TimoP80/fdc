program FMFDiagram;

uses
  Forms,
  DiagramViewerForm in 'DiagramViewerForm.pas' {DiagramMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDiagramMain, DiagramMain);
  Application.Run;
end.
