library ThemeLibraryModule;

uses
  Winapi.Windows, VCL.Forms,System.SysUtils, System.IOUtils, System.Classes, Vcl.Styles, Vcl.Themes;
 const
  WM_THEMECHANGED = $031A;
var
  StyleList: TStringList;

{$R VCLStyles.res}

// Callback function to enumerate VCL styles
function EnumResNamesProc(hModule: HMODULE; lpszType, lpszName: PChar;
  lParam: LPARAM): BOOL; stdcall;
begin
  StyleList.Add(lpszName); // Add style name to list
  Result := True;
end;

// Retrieve list of styles inside the DLL
procedure GetVCLStylesInDLL; stdcall;
begin
  StyleList.Clear;
  EnumResourceNames(HInstance, RT_RCDATA, @EnumResNamesProc, 0);
end;

// Exported function to return the style list as a PChar
function GetVCLStyleList: PChar; stdcall;
begin
  GetVCLStylesInDLL;
  Result := PChar(StyleList.Text);
end;

// Exported function to extract and load a VCL Style
function ApplyVCLStyle(StyleName: PChar): Boolean; stdcall;
var
  ResStream: TResourceStream;
  TempFile: string;
  Form: TForm;
  i: integer;
begin
  Result := False;

  if FindResource(HInstance, StyleName, RT_RCDATA) = 0 then
    Exit; // Style not found

  try
    // Save the style to a temp file
    TempFile := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP')) + StyleName + '.vsf';

    ResStream := TResourceStream.Create(HInstance, StyleName, RT_RCDATA);
    try
      ResStream.SaveToFile(TempFile);
    finally
      ResStream.Free;
    end;

    // Apply the new style globally
    TStyleManager.SetStyle(TStyleManager.LoadFromFile(TempFile));

    // Send WM_THEMECHANGED to all open forms
    for i := 0 to Screen.Formcount-1 do
    begin
      screen.Forms[i].Perform(WM_THEMECHANGED, 0, 0);  // Forces controls to update
      Form.Invalidate;  // Redraw the form
      Form.Update;      // Apply pending changes
    end;

    Result := True;
  except
    on E: Exception do
      OutputDebugString(PChar('Error applying VCL Style: ' + E.Message));
  end;
end;

exports
  GetVCLStyleList,
  ApplyVCLStyle;

begin
  StyleList := TStringList.Create;
end.
