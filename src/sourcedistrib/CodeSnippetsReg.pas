unit CodeSnippetsReg;

interface

uses
  DsgnIntf;

type
  TCodeSnippetsVersionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

procedure Register;

implementation

uses
  SysUtils,
  Classes,
  Dialogs,
  CodeSnippets;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string),TCodeSnippets,'Version',TCodeSnippetsVersionProperty);
  RegisterComponents('Coco/R',[TCodeSnippets]);
end;

function TCodeSnippetsVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TCodeSnippetsVersionProperty.Edit;
var
  s : string;
begin
  s := 'CodeSnippets' + #13#10#13#10 + 'Version: ';
  s := s + TCodeSnippets(GetComponent(0)).Version + #13#10;
  s := s + FormatDateTime('dddddd  tt',TCodeSnippets(GetComponent(0)).BuildDate);
  s := s + #13#10 + TCodeSnippets(GetComponent(0)).VersionComment;
  MessageDlg(s,mtInformation,[mbOk],0);
end;

end.
