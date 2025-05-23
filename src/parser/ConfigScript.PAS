unit ConfigScript;




{ ConfigScript
  Date of Generation: 26.5.2009 19:12

  This unit was generated by Coco/R for Delphi (www.tetzel.com)  Any code in
  this file that you edit manually will be over-written when the file is
  regenerated.
}

interface
uses  SysUtils,Classes,CocoBase;



const
maxT = 13;
type
  SymbolSet = array[0..maxT div setsize] of TBitSet;

  EConfigScript = class(Exception);
  TConfigScript = class;

  TConfigScriptScanner = class(TCocoRScanner)
  private
    FOwner : TConfigScript;
procedure CheckLiteral(var Sym : integer);
function Equal(s : string) : boolean;
    function Comment : boolean;
  protected
    procedure NextCh; override;
  public
    constructor Create;

    procedure Get(var sym : integer); override; // Gets next symbol from source file

    property CurrentSymbol;
    property NextSymbol;
    property OnStatusUpdate;
    property Owner : TConfigScript read fOwner write fOwner;
    property ScannerError;
    property SrcStream;
  end;  { TConfigScriptScanner }

  TConfigScript = class(TCocoRGrammar)
  private
    { strictly internal variables }
    symSet : array[0..0] of SymbolSet; // symSet[0] = allSyncSyms

    function _In(var s : SymbolSet; x : integer) : boolean;
    procedure InitSymSet;

    {Production methods}
    procedure _ConfigScript;
    procedure _NameSpaceEntry;
    procedure _configkey;

  private
    fOutputStream : TMemoryStream;
    fSubSelectDepth : integer;
    fInNaturalJoin : boolean;
            
    procedure Init;
    procedure Final;
                
    property OutputStream : TMemoryStream read fOutputStream write fOutputStream;
    
  protected
    { Protected Declarations }
    procedure Get; override;
  public
    { Public Declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function ErrorStr(const ErrorCode : integer; const Data : string) : string; override;
    procedure Execute;
    function GetScanner : TConfigScriptScanner;
    procedure Parse;

    property ErrorList;
    property ListStream;
    property SourceStream;
    property Successful;

  published
    { Published Declarations }
    property AfterParse;
    property AfterGenList;
    property BeforeGenList;
    property BeforeParse;
    property ClearSourceStream;
    property GenListWhen;
    property SourceFileName;

    property OnCustomError;
    property OnError;
    property OnFailure;
    property OnStatusUpdate;
    property OnSuccess;
  end; { TConfigScript }

implementation



const

  EOFSYMB = 0;  identifierSym = 1;  numberSym = 2;  hexnumberSym = 3;
  _stringSym = 4;  charSym = 5;  _librarySym = 6;  _equalSym = 7;  TRUESym = 8;
  FALSESym = 9;  _semicolonSym = 10;  _lbraceSym = 11;  _rbraceSym = 12;
  NOSYMB = 13;  _noSym = NOSYMB;   {error token code}

{ --------------------------------------------------------------------------- }
{ Arbitrary Code from ATG file }
const
  PadLen = 20;
                        
function PadR(S : string; Ch : char; L : integer) : string;
var
  i : integer;
begin
  for i := 1 to L - (Length(s)) do
    s := s + Ch;
  Result := s;
end;

procedure TConfigScript.Init;
begin
  OutputStream.Clear;

 end;

procedure TConfigScript.Final;
begin
   OutputStream.Position := 0;
  OutputStream.SaveToStream(ListStream);
  OutputStream.Clear;
end;
                                 
function parse_string(zstr: string): string;
var t:    integer;
var temp: string;
var len:  integer;
begin;
  len := 0;
  temp:='';
  //writeln ('Parsing string: ',zstr);
  t   := pos('"', zstr) + 1;
  len := length(zstr);
  while (zstr[t] <> '"') do
  begin;
    //writeln (zstr[t]);
    if (zstr[t] = '\') and (zstr[t + 1] = '"') then
    begin;
      temp := temp + '"';
      Inc(t, 1);
    end else
    if (zstr[t] = '\') and (zstr[t + 1] = 't') then
    begin;
      temp := temp + #9;
      Inc(t, 1);
    end else
    if (zstr[t] = '\') and (zstr[t + 1] = 'n') then
    begin;
      temp := temp + #13#10;
      Inc(t, 1);
    end else

      temp := temp + zstr[t];

    Inc(t);
  end;
  Result := temp;
end;



(* End of Arbitrary Code *)



{ --------------------------------------------------------------------------- }
{ ---- implementation for TConfigScriptScanner ---- }

procedure TConfigScriptScanner.NextCh;
{ Return global variable ch }
begin
  LastInputCh := CurrInputCh;
  BufferPosition := BufferPosition + 1;
  SrcStream.Seek(BufferPosition,soFromBeginning);
  CurrInputCh := CurrentCh(BufferPosition);
  if (CurrInputCh = _EL) OR ((CurrInputCh = _LF) AND (LastInputCh <> _EL)) then
  begin
    CurrLine := CurrLine + 1;
    if Assigned(OnStatusUpdate) then
      OnStatusUpdate(Owner,IntToStr(CurrLine),CurrLine);
    StartOfLine := BufferPosition;
  end
end;  {NextCh}

function TConfigScriptScanner.Comment : boolean;
var
  level : integer;
  oldLineStart : longint;
  CommentStr : string;
begin
  level := 1;
  oldLineStart := StartOfLine;
  CommentStr := CharAt(BufferPosition);
Result := false;
if (CurrInputCh = '/') then
  begin
NextCh;
CommentStr := CommentStr + CharAt(BufferPosition);
if (CurrInputCh = '*') then
begin
NextCh;
CommentStr := CommentStr + CharAt(BufferPosition);
while true do
begin
if (CurrInputCh = '*') then
begin
NextCh;
CommentStr := CommentStr + CharAt(BufferPosition);
if (CurrInputCh = '/') then
begin
level := level - 1;
NextCh;
CommentStr := CommentStr + CharAt(BufferPosition);
if level = 0 then
begin
  Result := true;
  Exit;
end
end
end
else if CurrInputCh = _EF then
begin
  Result := false;
  Exit;
end
else
begin
  NextCh;
  CommentStr := CommentStr + CharAt(BufferPosition);
end;
end; { WHILE TRUE }
end
else
begin
if (CurrInputCh = _CR) OR (CurrInputCh = _LF) then
begin
CurrLine := CurrLine - 1;
StartOfLine := oldLineStart
end;
BufferPosition := BufferPosition - 1;
CurrInputCh := LastInputCh;
Result := false;
end;
end;
end;  { Comment }

function TConfigScriptScanner.Equal(s : string) : boolean;
var
  i : integer;
  q : longint;
begin
  if NextSymbol.Len <> Length(s) then
  begin
    Result := false;
    EXIT
  end;
  i := 1;
  q := bpCurrToken;
  while i <= NextSymbol.Len do
  begin
    if CurrentCh(q) <> s[i] then
    begin
      Result := false;
      EXIT;
    end;
    inc(i);
    inc(q);
  end;
  Result := true
end;  {Equal}

procedure TConfigScriptScanner.CheckLiteral(var Sym : integer);
begin
case CurrentCh(bpCurrToken) of
  'F': if Equal('FALSE') then
begin
sym := FALSESym;
end;

  'T': if Equal('TRUE') then
begin
sym := TRUESym;
end;

else
begin
end
end
end; {CheckLiteral}


procedure TConfigScriptScanner.Get(var sym : integer);
var
  state : integer;
begin   {Get}
while (CurrInputCh = ' ') OR
((CurrInputCh >= CHR(1)) AND (CurrInputCh <= ' ')) do
  NextCh;
if ((CurrInputCh = '/')) AND Comment then
begin
  Get(sym);
  exit;
  end;
  CurrentSymbol.pos := NextSymbol.Pos;
  NextSymbol.Pos := BufferPosition;
  CurrentSymbol.col := NextSymbol.Col;
  NextSymbol.Col := BufferPosition - StartOfLine;
  CurrentSymbol.line := NextSymbol.Line;
  NextSymbol.Line := CurrLine;
  CurrentSymbol.Len := NextSymbol.Len;
  NextSymbol.Len := 0;
  ContextLen := 0;
  state := StartState[ORD(CurrInputCh)];
  bpCurrToken := BufferPosition;
  while true do
  begin
    NextCh;
    NextSymbol.Len := NextSymbol.Len + 1;
    if BufferPosition > SrcStream.Size then
    begin
      sym := EOFSYMB;
      CurrInputCh := _EF;
      BufferPosition := BufferPosition - 1;
      exit
    end;
    case state of
   1: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9') OR
(CurrInputCh >= 'A') AND (CurrInputCh <= 'Z') OR
(CurrInputCh = '_')) then
begin
 
end
else
begin
sym := identifierSym;
CheckLiteral(sym);
exit;
end;
   2: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9')) then
begin
 
end
else if ((CurrInputCh = 'L') OR
(CurrInputCh = 'U')) then
begin
state := 15; 
end
else if (CurrInputCh = '.') then
begin
state := 3; 
end
else
begin
sym := numberSym;
exit;
end;
   3: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9')) then
begin
 
end
else if ((CurrInputCh = 'L') OR
(CurrInputCh = 'U')) then
begin
state := 15; 
end
else
begin
sym := numberSym;
exit;
end;
   4: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9') OR
(CurrInputCh >= 'A') AND (CurrInputCh <= 'F')) then
begin
state := 5; 
end
else
begin
  sym := _noSym;
exit;
end;
   5: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9') OR
(CurrInputCh >= 'A') AND (CurrInputCh <= 'F')) then
begin
 
end
else if ((CurrInputCh = 'L') OR
(CurrInputCh = 'U')) then
begin
state := 16; 
end
else
begin
sym := hexnumberSym;
exit;
end;
   6: if ((CurrInputCh >= ' ') AND (CurrInputCh <= '!') OR
(CurrInputCh >= '#')) then
begin
 
end
else if (CurrInputCh = '"') then
begin
state := 7; 
end
else
begin
  sym := _noSym;
exit;
end;
   7: begin
sym := _stringSym;
exit;
end;
   8: if ((CurrInputCh >= ' ') AND (CurrInputCh <= '&') OR
(CurrInputCh >= '(') AND (CurrInputCh <= '[') OR
(CurrInputCh >= ']')) then
begin
state := 9; 
end
else if (CurrInputCh = '\') then
begin
state := 17; 
end
else
begin
  sym := _noSym;
exit;
end;
   9: if (CurrInputCh = CHR(39)) then
begin
state := 10; 
end
else
begin
  sym := _noSym;
exit;
end;
  10: begin
sym := charSym;
exit;
end;
  11: if ((CurrInputCh = '.') OR
(CurrInputCh >= '0') AND (CurrInputCh <= ':') OR
(CurrInputCh >= 'A') AND (CurrInputCh <= 'Z') OR
(CurrInputCh = '\')) then
begin
state := 12; 
end
else
begin
  sym := _noSym;
exit;
end;
  12: if ((CurrInputCh = '.') OR
(CurrInputCh >= '0') AND (CurrInputCh <= ':') OR
(CurrInputCh >= 'A') AND (CurrInputCh <= 'Z') OR
(CurrInputCh = '\')) then
begin
 
end
else if (CurrInputCh = '>') then
begin
state := 13; 
end
else
begin
  sym := _noSym;
exit;
end;
  13: begin
sym := _librarySym;
exit;
end;
  14: if ((CurrInputCh >= '0') AND (CurrInputCh <= '9')) then
begin
state := 2; 
end
else if ((CurrInputCh = 'L') OR
(CurrInputCh = 'U')) then
begin
state := 15; 
end
else if (CurrInputCh = '.') then
begin
state := 3; 
end
else if (CurrInputCh = 'X') then
begin
state := 4; 
end
else
begin
sym := numberSym;
exit;
end;
  15: begin
sym := numberSym;
exit;
end;
  16: begin
sym := hexnumberSym;
exit;
end;
  17: if ((CurrInputCh >= ' ') AND (CurrInputCh <= '&') OR
(CurrInputCh >= '(')) then
begin
state := 9; 
end
else if (CurrInputCh = CHR(39)) then
begin
state := 10; 
end
else
begin
  sym := _noSym;
exit;
end;
  18: begin
sym := _equalSym;
exit;
end;
  19: begin
sym := _semicolonSym;
exit;
end;
  20: begin
sym := _lbraceSym;
exit;
end;
  21: begin
sym := _rbraceSym;
exit;
end;
  22: begin
sym := EOFSYMB;
CurrInputCh := #0;
BufferPosition := BufferPosition - 1;
exit
end;
    else
      begin
        sym := _noSym;
        EXIT;          // NextCh already done
      end;
    end;
  end;
end;  {Get}

constructor TConfigScriptScanner.Create;
begin
  inherited;
CurrentCh := CapChAt;
fStartState[  0] := 22; fStartState[  1] := 23; fStartState[  2] := 23; fStartState[  3] := 23; 
fStartState[  4] := 23; fStartState[  5] := 23; fStartState[  6] := 23; fStartState[  7] := 23; 
fStartState[  8] := 23; fStartState[  9] := 23; fStartState[ 10] := 23; fStartState[ 11] := 23; 
fStartState[ 12] := 23; fStartState[ 13] := 23; fStartState[ 14] := 23; fStartState[ 15] := 23; 
fStartState[ 16] := 23; fStartState[ 17] := 23; fStartState[ 18] := 23; fStartState[ 19] := 23; 
fStartState[ 20] := 23; fStartState[ 21] := 23; fStartState[ 22] := 23; fStartState[ 23] := 23; 
fStartState[ 24] := 23; fStartState[ 25] := 23; fStartState[ 26] := 23; fStartState[ 27] := 23; 
fStartState[ 28] := 23; fStartState[ 29] := 23; fStartState[ 30] := 23; fStartState[ 31] := 23; 
fStartState[ 32] := 23; fStartState[ 33] := 23; fStartState[ 34] :=  6; fStartState[ 35] := 23; 
fStartState[ 36] := 23; fStartState[ 37] := 23; fStartState[ 38] := 23; fStartState[ 39] :=  8; 
fStartState[ 40] := 23; fStartState[ 41] := 23; fStartState[ 42] := 23; fStartState[ 43] := 23; 
fStartState[ 44] := 23; fStartState[ 45] := 23; fStartState[ 46] := 23; fStartState[ 47] := 23; 
fStartState[ 48] := 14; fStartState[ 49] :=  2; fStartState[ 50] :=  2; fStartState[ 51] :=  2; 
fStartState[ 52] :=  2; fStartState[ 53] :=  2; fStartState[ 54] :=  2; fStartState[ 55] :=  2; 
fStartState[ 56] :=  2; fStartState[ 57] :=  2; fStartState[ 58] := 23; fStartState[ 59] := 19; 
fStartState[ 60] := 11; fStartState[ 61] := 18; fStartState[ 62] := 23; fStartState[ 63] := 23; 
fStartState[ 64] := 23; fStartState[ 65] :=  1; fStartState[ 66] :=  1; fStartState[ 67] :=  1; 
fStartState[ 68] :=  1; fStartState[ 69] :=  1; fStartState[ 70] :=  1; fStartState[ 71] :=  1; 
fStartState[ 72] :=  1; fStartState[ 73] :=  1; fStartState[ 74] :=  1; fStartState[ 75] :=  1; 
fStartState[ 76] :=  1; fStartState[ 77] :=  1; fStartState[ 78] :=  1; fStartState[ 79] :=  1; 
fStartState[ 80] :=  1; fStartState[ 81] :=  1; fStartState[ 82] :=  1; fStartState[ 83] :=  1; 
fStartState[ 84] :=  1; fStartState[ 85] :=  1; fStartState[ 86] :=  1; fStartState[ 87] :=  1; 
fStartState[ 88] :=  1; fStartState[ 89] :=  1; fStartState[ 90] :=  1; fStartState[ 91] := 23; 
fStartState[ 92] := 23; fStartState[ 93] := 23; fStartState[ 94] := 23; fStartState[ 95] :=  1; 
fStartState[ 96] := 23; fStartState[ 97] := 23; fStartState[ 98] := 23; fStartState[ 99] := 23; 
fStartState[100] := 23; fStartState[101] := 23; fStartState[102] := 23; fStartState[103] := 23; 
fStartState[104] := 23; fStartState[105] := 23; fStartState[106] := 23; fStartState[107] := 23; 
fStartState[108] := 23; fStartState[109] := 23; fStartState[110] := 23; fStartState[111] := 23; 
fStartState[112] := 23; fStartState[113] := 23; fStartState[114] := 23; fStartState[115] := 23; 
fStartState[116] := 23; fStartState[117] := 23; fStartState[118] := 23; fStartState[119] := 23; 
fStartState[120] := 23; fStartState[121] := 23; fStartState[122] := 23; fStartState[123] := 20; 
fStartState[124] := 23; fStartState[125] := 21; fStartState[126] := 23; fStartState[127] := 23; 
fStartState[128] := 23; fStartState[129] := 23; fStartState[130] := 23; fStartState[131] := 23; 
fStartState[132] := 23; fStartState[133] := 23; fStartState[134] := 23; fStartState[135] := 23; 
fStartState[136] := 23; fStartState[137] := 23; fStartState[138] := 23; fStartState[139] := 23; 
fStartState[140] := 23; fStartState[141] := 23; fStartState[142] := 23; fStartState[143] := 23; 
fStartState[144] := 23; fStartState[145] := 23; fStartState[146] := 23; fStartState[147] := 23; 
fStartState[148] := 23; fStartState[149] := 23; fStartState[150] := 23; fStartState[151] := 23; 
fStartState[152] := 23; fStartState[153] := 23; fStartState[154] := 23; fStartState[155] := 23; 
fStartState[156] := 23; fStartState[157] := 23; fStartState[158] := 23; fStartState[159] := 23; 
fStartState[160] := 23; fStartState[161] := 23; fStartState[162] := 23; fStartState[163] := 23; 
fStartState[164] := 23; fStartState[165] := 23; fStartState[166] := 23; fStartState[167] := 23; 
fStartState[168] := 23; fStartState[169] := 23; fStartState[170] := 23; fStartState[171] := 23; 
fStartState[172] := 23; fStartState[173] := 23; fStartState[174] := 23; fStartState[175] := 23; 
fStartState[176] := 23; fStartState[177] := 23; fStartState[178] := 23; fStartState[179] := 23; 
fStartState[180] := 23; fStartState[181] := 23; fStartState[182] := 23; fStartState[183] := 23; 
fStartState[184] := 23; fStartState[185] := 23; fStartState[186] := 23; fStartState[187] := 23; 
fStartState[188] := 23; fStartState[189] := 23; fStartState[190] := 23; fStartState[191] := 23; 
fStartState[192] := 23; fStartState[193] := 23; fStartState[194] := 23; fStartState[195] := 23; 
fStartState[196] := 23; fStartState[197] := 23; fStartState[198] := 23; fStartState[199] := 23; 
fStartState[200] := 23; fStartState[201] := 23; fStartState[202] := 23; fStartState[203] := 23; 
fStartState[204] := 23; fStartState[205] := 23; fStartState[206] := 23; fStartState[207] := 23; 
fStartState[208] := 23; fStartState[209] := 23; fStartState[210] := 23; fStartState[211] := 23; 
fStartState[212] := 23; fStartState[213] := 23; fStartState[214] := 23; fStartState[215] := 23; 
fStartState[216] := 23; fStartState[217] := 23; fStartState[218] := 23; fStartState[219] := 23; 
fStartState[220] := 23; fStartState[221] := 23; fStartState[222] := 23; fStartState[223] := 23; 
fStartState[224] := 23; fStartState[225] := 23; fStartState[226] := 23; fStartState[227] := 23; 
fStartState[228] := 23; fStartState[229] := 23; fStartState[230] := 23; fStartState[231] := 23; 
fStartState[232] := 23; fStartState[233] := 23; fStartState[234] := 23; fStartState[235] := 23; 
fStartState[236] := 23; fStartState[237] := 23; fStartState[238] := 23; fStartState[239] := 23; 
fStartState[240] := 23; fStartState[241] := 23; fStartState[242] := 23; fStartState[243] := 23; 
fStartState[244] := 23; fStartState[245] := 23; fStartState[246] := 23; fStartState[247] := 23; 
fStartState[248] := 23; fStartState[249] := 23; fStartState[250] := 23; fStartState[251] := 23; 
fStartState[252] := 23; fStartState[253] := 23; fStartState[254] := 23; fStartState[255] := 23; 
end; {Create}


{ --------------------------------------------------------------------------- }
{ ---- implementation for TConfigScript ---- }

constructor TConfigScript.Create(AOwner : TComponent);
begin
  inherited;
  Scanner := TConfigScriptScanner.Create;
  GetScanner.Owner := self;
fOutputStream := TMemoryStream.Create;
  
  InitSymSet;
end; {Create}

destructor TConfigScript.Destroy;
begin
  Scanner.Free;
fOutputStream.Free;
  
  inherited;
end; {Destroy}

function TConfigScript.ErrorStr(const ErrorCode : integer; const Data : string) : string;
begin
  case ErrorCode of
       0 : Result := 'EOF expected';
   1 : Result := 'identifier expected';
   2 : Result := 'number expected';
   3 : Result := 'hexnumber expected';
   4 : Result := '_string expected';
   5 : Result := 'char expected';
   6 : Result := '_library expected';
   7 : Result := '"=" expected';
   8 : Result := '"TRUE" expected';
   9 : Result := '"FALSE" expected';
  10 : Result := '";" expected';
  11 : Result := '"{" expected';
  12 : Result := '"}" expected';
  13 : Result := 'not expected';
  14 : Result := 'invalid configkey';


  else
    if Assigned(OnCustomError) then
      Result := OnCustomError(Self, ErrorCode, Data)
    else
    begin
      Result := 'Error: ' + IntToStr(ErrorCode);
      if Trim(Data) > '' then
        Result := Result + ' (' + Data + ')';
    end;
  end;  {case nr}
end; {ErrorStr}

procedure TConfigScript.Execute;
begin
  ClearErrors;
  ListStream.Clear;
  Extra := 1;

  { if there is a file name then load the file }
  if Trim(SourceFileName) <> '' then
  begin
    GetScanner.SrcStream.Clear;
    GetScanner.SrcStream.LoadFromFile(SourceFileName);
  end;

  { install error reporting procedure }
  GetScanner.ScannerError := StoreError;

  if Assigned(OnStatusUpdate) then
    OnStatusUpdate(Self,'parsing source',-1);

  { instigate the compilation }
  if Assigned(BeforeParse) then
    BeforeParse(Self);
  Parse;
  if Assigned(AfterParse) then
    AfterParse(Self);

  { generate the source listing to the ListStream }
  if (GenListWhen = glAlways) OR ((GenListWhen = glOnError) AND (ErrorList.Count > 0)) then
    GenerateListing;
  if ClearSourceStream then
    GetScanner.SrcStream.Clear;
  ListStream.Position := 0;  // goto the beginning of the stream
  if Successful AND Assigned(OnSuccess) then
    OnSuccess(Self);
  if (NOT Successful) AND Assigned(OnFailure) then
    OnFailure(Self, ErrorList.Count);
end;  {Execute}

procedure TConfigScript.Get;
begin
  repeat


    GetScanner.Get(fCurrentInputSymbol);
    if fCurrentInputSymbol <= maxT then
      errDist := errDist + 1
    else
    begin
    end;
  until fCurrentInputSymbol <= maxT;
end;  {Get}

function TConfigScript.GetScanner : TConfigScriptScanner;
begin
  Result := Scanner AS TConfigScriptScanner;
end; {GetScanner}

function TConfigScript._In(var s : SymbolSet; x : integer) : boolean;
begin
  _In := x mod setsize in s[x div setsize];
end;  {_In}

procedure TConfigScript._ConfigScript;begin
_NameSpaceEntry;
while (fCurrentInputSymbol = identifierSym) do begin
_NameSpaceEntry;
end;
end;

procedure TConfigScript._NameSpaceEntry;begin
Expect(identifierSym);
Expect(_stringSym);
Expect(_lbraceSym);
_configkey;
while (fCurrentInputSymbol = identifierSym) do begin
_configkey;
end;
Expect(_rbraceSym);
end;

procedure TConfigScript._configkey;begin
Expect(identifierSym);
Expect(_equalSym);
if (fCurrentInputSymbol = _stringSym) then begin
Get;
end else if (fCurrentInputSymbol = numberSym) then begin
Get;
end else if (fCurrentInputSymbol = TRUESym) then begin
Get;
end else if (fCurrentInputSymbol = FALSESym) then begin
Get;
end else begin SynError(14);
end;
Expect(_semicolonSym);
end;


procedure TConfigScript.Parse;
begin
  errDist := minErrDist;
GetScanner._Reset;
Get;
_ConfigScript;
end;  {Parse}

procedure TConfigScript.InitSymSet;
begin
symSet[ 0, 0] := [EOFSYMB];
end; {InitSymSet}

end { ConfigScript }.    
