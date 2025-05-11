program GenerateVCLStylesRC;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Types,
  System.Classes,
  System.IOUtils;

const
  OUTPUT_RC_FILE = 'VCLStyles.rc';  // The generated .rc file

var
  SearchPath, VclStyleFile, RCEntry: string;
  FileList: TStringDynArray;
  RCFile: TextFile;
  I: Integer;

begin
  try
    // Ask user for the folder containing .vsf files
    Write('Enter the path to the folder containing .vsf files: ');
    ReadLn(SearchPath);

    // Validate path
    if not TDirectory.Exists(SearchPath) then
    begin
      Writeln('Error: The specified folder does not exist.');
      Exit;
    end;

    // Get all .vsf files in the folder
    FileList := TDirectory.GetFiles(SearchPath, '*.vsf');
    if Length(FileList) = 0 then
    begin
      Writeln('No .vsf files found in the specified directory.');
      Exit;
    end;

    // Create and open the .rc file for writing
    AssignFile(RCFile, OUTPUT_RC_FILE);
    Rewrite(RCFile);

    try
      Writeln(RCFile, '// Generated VCL Styles Resource File');
      Writeln(RCFile, '// ----------------------------------');

      for I := 0 to High(FileList) do
      begin
        VclStyleFile := ExtractFileName(FileList[I]);
        RCEntry := Format('%s VCLSTYLE "%s"', [ChangeFileExt(VclStyleFile, ''), VclStyleFile]);
        Writeln(RCFile, RCEntry);
        Writeln('Added: ' + RCEntry);
      end;

      Writeln('Resource file "' + OUTPUT_RC_FILE + '" created successfully!');
    finally
      CloseFile(RCFile);
    end;

  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;

  Writeln('Press Enter to exit...');
  ReadLn;
end.
