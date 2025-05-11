unit FMFReg;

interface

uses
  DesignIntf,RTLConsts,VCLEditors,DesignEditors;

type
  TFMFVersionProperty = class(TStringProperty)
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
  FMF;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string),TFMF,'Version',TFMFVersionProperty);
  RegisterComponents('Coco/R',[TFMF]);
end;

function TFMFVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TFMFVersionProperty.Edit;
var
  s : string;
begin
  s := 'FMF' + #13#10#13#10 + 'Version: ';
  s := s + TFMF(GetComponent(0)).Version + #13#10;
  s := s + FormatDateTime('dddddd  tt',TFMF(GetComponent(0)).BuildDate);
  s := s + #13#10 + TFMF(GetComponent(0)).VersionComment;
  MessageDlg(s,mtInformation,[mbOk],0);
end;

end.
