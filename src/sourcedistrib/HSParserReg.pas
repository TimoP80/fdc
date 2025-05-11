unit HSParserReg;

interface

uses
  DsgnIntf;

type
  THSParserVersionProperty = class(TStringProperty)
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
  HSParser;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string),THSParser,'Version',THSParserVersionProperty);
  RegisterComponents('Coco/R',[THSParser]);
end;

function THSParserVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure THSParserVersionProperty.Edit;
var
  s : string;
begin
  s := 'HSParser' + #13#10#13#10 + 'Version: ';
  s := s + THSParser(GetComponent(0)).Version + #13#10;
  s := s + FormatDateTime('dddddd  tt',THSParser(GetComponent(0)).BuildDate);
  s := s + #13#10 + THSParser(GetComponent(0)).VersionComment;
  MessageDlg(s,mtInformation,[mbOk],0);
end;

end.
