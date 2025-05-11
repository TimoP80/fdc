unit ext_test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  type

   TExternalRegisterProc = procedure (appname: pchar; name: pchar; desc: pchar; InterfaceVer: shortstring); stdcall;


   var ExternalRegProc: TExternalRegisterProc;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var xhandle: THandle;
var handlestate: pchar;
var appwnd: HWND;
tehmodule: pchar;

begin;
tehmodule := 'fmfdlg.exe';
appwnd := FindWindow(nil,'FMF Dialogue Tool');
xhandle :=  GetWindow(appwnd,GW_HWNDFIRST);
if appwnd<>0 then
begin;
SendMessage(appwnd,WM_CLOSE,0,0);
if xhandle<>0 then
begin;
handlestate := 'ModuleHandle OK';
end else
handlestate := 'ModuleHandle NOT OK!';
//SendMessage(appwnd,WM_ACTIVATEAPP,0,0);
//xhandle := GetModuleHandle('fmfdlg.exe');


@ExternalRegProc := GetProcAddress(xhandle,'DoExternalRegister');
if @ExternalRegProc=nil then
begin;
handlestate := pchar(handlestate + ' ERRORCODE='+inttostr(getlasterror));
label1.caption := 'Dialogue tool found, module HANDLE == '+inttostr(xhandle)+' but PROCADDRESS NIL! '+handlestate

end else
begin;
label1.caption := 'Dialogue tool found, module HANDLE == '+inttostr(xhandle)+' PROCADDRESS OK!'+handlestate;
ExternalRegProc(pchar(extractfilename(paramstr(0))),'Test', 'Test thingie','0.22');
end;

end else
label1.caption := 'Dialogue tool not running. ERRORCODE='+inttostr(getlasterror);

end;

end.
