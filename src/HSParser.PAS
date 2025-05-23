unit HSParser;



{.$DEFINE HOLOCMP_BUILD}

{ HSParser
  Version: 1.0 Release 0 Build 201
  Interplay SSL Parser
  Date of Generation: 2.8.2005 16:09
  Author: T. Pitk�nen
  (c) 2003 Dj Unique

  This unit was generated by Coco/R for Delphi (www.tetzel.com)  Any code in
  this file that you edit manually will be over-written when the file is
  regenerated.
}

interface
uses  arcmsg, Classes, CocoBase, jclStrings, mwStringHashList, parseholodisk, SysUtils, Variants;
const
  maxT      = 16;
  maxP      = 17;

var       pipboydata:    mesfile;
    current_title_id: integer;
type
  SymbolSet = array[0..maxT div setsize] of TBitSet;

  EHSParser        = class(Exception);
  THSParser        = class;

  THSParserScanner = class(TCocoRScanner)
  private
    FOwner:    THSParser;
    fHashList: TmwStringHashList;
    procedure CheckLiteral(var Sym: integer);
    function GetNextSymbolString: string;
    function Comment: boolean;
  protected
    procedure NextCh; override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Get(var sym: integer); override; // Gets next symbol from source file

    property CurrentSymbol;
    property NextSymbol;
    property OnStatusUpdate;
    property Owner: THSParser Read fOwner Write fOwner;
    property ScannerError;
    property SrcStream;
  end;  { THSParserScanner }

  THSParser = class(TCocoRGrammar)
  private
        { strictly internal variables }
    symSet: array[0..0] of SymbolSet; // symSet[0] = allSyncSyms

    function GetMajorVersion: integer;
    function GetMinorVersion: integer;
    function GetRelease: integer;
    function GetBuild: integer;
    function GetBuildDate: TDateTime;
    function GetVersionComment: string;
    function GetGrammarAuthor: string;
    function GetGrammarCopyright: string;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function _In(var s: SymbolSet; x: integer): boolean;
    procedure InitSymSet;

    {Production methods}
    procedure _AuthorInfo;
    procedure _HoloDisk;
    procedure _Main;
    procedure _HSParser;

  private
    fOutputStream:   TMemoryStream;
    fSubSelectDepth: integer;
    fInNaturalJoin:  boolean;

    procedure Init;
    procedure Final;
    procedure WriteStr(S: string);
    property OutputStream: TMemoryStream Read fOutputStream Write fOutputStream;
    property SubSelectDepth: integer Read fSubSelectDepth Write fSubSelectDepth;
    property InNaturalJoin: boolean Read fInNaturalJoin Write fInNaturalJoin;

  protected
    { Protected Declarations }
    procedure Get; override;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ErrorStr(const ErrorCode: integer; const Data: string): string; override;
    procedure Execute;
    function GetScanner: THSParserScanner;
    procedure Parse;

    property ErrorList;
    property ListStream;
    property SourceStream;
    property Successful;
    property MajorVersion: integer Read GetMajorVersion;
    property MinorVersion: integer Read GetMinorVersion;
    property Release: integer Read GetRelease;
    property Build: integer Read GetBuild;
    property BuildDate: TDateTime Read GetBuildDate;
    property VersionComment: string Read GetVersionComment;
    property GrammarAuthor: string Read GetGrammarAuthor;
    property GrammarCopyright: string Read GetGrammarCopyright;

  public

  published
    { Published Declarations }
    property AfterParse;
    property AfterGenList;
    property BeforeGenList;
    property BeforeParse;
    property ClearSourceStream;
    property GenListWhen;
    property SourceFileName;
    property Version: string Read GetVersion Write SetVersion;

    property OnCustomError;
    property OnError;
    property OnFailure;
    property OnStatusUpdate;
    property OnSuccess;
  end; { THSParser }

implementation





const

  EOFSYMB       = 0;  identifierSym = 1;  integer_Sym = 2;  _floatSym = 3;
  _stringSym    = 4;  HexLiteralSym = 5;  holodiskSym = 6;  gvarSym = 7;
  _equalSym     = 8;  _lbraceSym = 9;  _commaSym = 10;  _rbraceSym = 11;
  authorinfoSym = 12;  authorSym = 13;  _semicolonSym = 14;  timestampSym = 15;
  NOSYMB        = 16;  PreProcessorSym = 17;  _noSym = NOSYMB;   {error token code}

 { --------------------------------------------------------------------------- }
 { Arbitrary Code from ATG file }
var holotext: TStrings;


const
  PadLen = 20;

procedure generateholodata;
var ind, u: integer;
var x:      integer;
var target: integer;
begin

  ind := holos[holocnt].Text;
  if (is_valid_mes_ind(holos[holocnt].Text, pipboydata) = False) then
  begin;
    for u := 0 to holotext.Count - 1 do
    begin;
      add_mes_entry(holotext[u], '', ind, pipboydata);
      Inc(ind);
    end;

  end else
  begin;
    for u := 0 to holotext.Count - 1 do
    begin;
      set_mes_string(holotext[u], '', ind, pipboydata);
      Inc(ind);
    end;

  end;
  // clear rest of the lines
  x := ind;
  while (is_valid_mes_ind(x, pipboydata)) and (get_mes_string(x, pipboydata) <> '') do
  begin;
    DeleteMSG(x, pipboydata);
    break;
  end;

holotext.clear;
end;


function PadR(S: string; Ch: char; L: integer): string;
var
  i: integer;
begin
  for i := 1 to L - (Length(s)) do
    s := s + Ch;
  Result := s;
end;

procedure THSParser.Init;
begin
  holotext       := TStringList.Create;
  OutputStream.Clear;
  SubSelectDepth := 0;
end;

procedure THSParser.Final;
begin
  OutputStream.Position := 0;
  OutputStream.SaveToStream(ListStream);
  OutputStream.Clear;
  holotext.Free;
end;



procedure THSParser.WriteStr(S: string);
begin
  S := S + #13#10;
  OutputStream.WriteBuffer(S[1], length(S));
end;

function parse_string(zstr: string): string;
var t:    integer;
var temp: string;
var len:  integer;
begin;
  len := 0;
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
 { ---- implementation for THSParserScanner ---- }

procedure THSParserScanner.NextCh;
 { Return global variable ch }
begin
  LastInputCh    := CurrInputCh;
  BufferPosition := BufferPosition + 1;
  SrcStream.Seek(BufferPosition, soFromBeginning);
  CurrInputCh    := CurrentCh(BufferPosition);
  if (CurrInputCh = _EL) or ((CurrInputCh = _LF) and (LastInputCh <> _EL)) then
  begin
    CurrLine := CurrLine + 1;
    if Assigned(OnStatusUpdate) then
      OnStatusUpdate(Owner, IntToStr(CurrLine), CurrLine);
    StartOfLine := BufferPosition;
  end;
end;  {NextCh}

function THSParserScanner.Comment: boolean;
var
  level:        integer;
  startLine:    integer;
  oldLineStart: longint;
  CommentStr:   string;
begin
  level        := 1;
  startLine    := CurrLine;
  oldLineStart := StartOfLine;
  CommentStr   := CharAt(BufferPosition);
  Result       := False;
  if (CurrInputCh = '/') then
  begin
    NextCh;
    CommentStr := CommentStr + CharAt(BufferPosition);
    if (CurrInputCh = '/') then
    begin
      NextCh;
      CommentStr := CommentStr + CharAt(BufferPosition);
      while True do
      begin
        if (CurrInputCh = CHR(13)) then
        begin
          level           := level - 1;
          NumEOLInComment := CurrLine - startLine;
          NextCh;
          CommentStr      := CommentStr + CharAt(BufferPosition);
          if level = 0 then
          begin
            Result := True;
            Exit;
          end;
        end
        else if CurrInputCh = _EF then
        begin
          Result := False;
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
      if (CurrInputCh = _CR) or (CurrInputCh = _LF) then
      begin
        CurrLine    := CurrLine - 1;
        StartOfLine := oldLineStart;
      end;
      BufferPosition := BufferPosition - 1;
      CurrInputCh := LastInputCh;
      Result := False;
    end;
  end;
  Result := False;
  if (CurrInputCh = '/') then
  begin
    NextCh;
    CommentStr := CommentStr + CharAt(BufferPosition);
    if (CurrInputCh = '*') then
    begin
      NextCh;
      CommentStr := CommentStr + CharAt(BufferPosition);
      while True do
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
              Result := True;
              Exit;
            end;
          end;
        end
        else if CurrInputCh = _EF then
        begin
          Result := False;
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
      if (CurrInputCh = _CR) or (CurrInputCh = _LF) then
      begin
        CurrLine    := CurrLine - 1;
        StartOfLine := oldLineStart;
      end;
      BufferPosition := BufferPosition - 1;
      CurrInputCh := LastInputCh;
      Result := False;
    end;
  end;
end;  { Comment }

function THSParserScanner.GetNextSymbolString: string;
var
  i: integer;
  q: integer;
begin
  Result := '';
  i      := 1;
  q      := bpCurrToken;
  while i <= NextSymbol.Len do
  begin
    Result := Result + CurrentCh(q);
    Inc(q);
    Inc(i);
  end;
end; {GetNextSymbolString}

procedure THSParserScanner.CheckLiteral(var Sym: integer);
var
  SymId:        integer;
  DefaultSymId: integer;
  aToken:       string;
begin
  aToken := GetNextSymbolString;
  if fHashList.Hash(aToken, SymId, DefaultSymId) then
  begin
    sym := SymId;
  end;
end; {CheckLiteral}


procedure THSParserScanner.Get(var sym: integer);
var
  state: integer;
begin   {Get}
  while (CurrInputCh = ' ') or ((CurrInputCh >= CHR(1)) and (CurrInputCh <= ' ')) do
    NextCh;
  if ((CurrInputCh = '/') or (CurrInputCh = '/')) and Comment then
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
  ContextLen  := 0;
  state       := StartState[Ord(CurrInputCh)];
  bpCurrToken := BufferPosition;
  while True do
  begin
    NextCh;
    NextSymbol.Len := NextSymbol.Len + 1;
    if BufferPosition > SrcStream.Size then
    begin
      sym            := EOFSYMB;
      CurrInputCh    := _EF;
      BufferPosition := BufferPosition - 1;
      exit;
    end;
    case state of
      1: if ((CurrInputCh >= '0') and (CurrInputCh <= '9') or (CurrInputCh >= 'A') and
          (CurrInputCh <= 'Z') or (CurrInputCh = '_') or (CurrInputCh >= 'a') and (CurrInputCh <= 'z') or
          (CurrInputCh >= CHR(196)) and (CurrInputCh <= CHR(197)) or (CurrInputCh = CHR(214)) or
          (CurrInputCh >= CHR(228)) and (CurrInputCh <= CHR(229)) or (CurrInputCh = CHR(246))) then
        begin

        end
        else
        begin
          sym := identifierSym;
          CheckLiteral(sym);
          exit;
        end;
      2: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin
          state := 3;
        end
        else
        begin
          sym   := _noSym;
          exit;
        end;
      3: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin

        end
        else
        begin
          sym := integer_Sym;
          exit;
        end;
      4: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin
          state := 5;
        end
        else
        begin
          sym   := _noSym;
          exit;
        end;
      5: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin

        end
        else if (CurrInputCh = 'f') then
        begin
          state := 6;
        end
        else
        begin
          sym   := _floatSym;
          exit;
        end;
      6: begin
        sym := _floatSym;
        exit;
      end;
      7: if ((CurrInputCh <= CHR(12)) or (CurrInputCh >= CHR(14)) and (CurrInputCh <= '!') or
          (CurrInputCh >= '#') and (CurrInputCh <= '[') or (CurrInputCh >= ']')) then
        begin

        end
        else if (CurrInputCh = '"') then
        begin
          state := 8;
        end
        else if (CurrInputCh = '\') then
        begin
          state := 13;
        end
        else
        begin
          sym   := _noSym;
          exit;
        end;
      8: begin
        sym := _stringSym;
        exit;
      end;
      9: if ((CurrInputCh >= '0') and (CurrInputCh <= '9') or (CurrInputCh >= 'A') and
          (CurrInputCh <= 'Z') or (CurrInputCh = '_') or (CurrInputCh >= 'a') and (CurrInputCh <= 'z') or
          (CurrInputCh >= CHR(196)) and (CurrInputCh <= CHR(197)) or (CurrInputCh = CHR(214)) or
          (CurrInputCh >= CHR(228)) and (CurrInputCh <= CHR(229)) or (CurrInputCh = CHR(246))) then
        begin

        end
        else
        begin
          sym := HexLiteralSym;
          exit;
        end;
      10: if not ((CurrInputCh = CHR(13))) then
        begin

        end
        else
        begin
          sym := PreProcessorSym;
          exit;
        end;
      11: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin

        end
        else if (CurrInputCh = '.') then
        begin
          state := 4;
        end
        else
        begin
          sym   := integer_Sym;
          exit;
        end;
      12: if ((CurrInputCh >= '0') and (CurrInputCh <= '9')) then
        begin
          state := 11;
        end
        else
        begin
          sym   := _noSym;
          exit;
        end;
      13: if ((CurrInputCh <= CHR(12)) or (CurrInputCh >= CHR(14)) and (CurrInputCh <= '!') or
          (CurrInputCh >= '#') and (CurrInputCh <= '[') or (CurrInputCh >= ']')) then
        begin
          state := 7;
        end
        else if (CurrInputCh = '"') then
        begin
          state := 14;
        end
        else if (CurrInputCh = '\') then
        begin

        end
        else
        begin
          sym := _noSym;
          exit;
        end;
      14: if ((CurrInputCh <= CHR(12)) or (CurrInputCh >= CHR(14)) and (CurrInputCh <= '!') or
          (CurrInputCh >= '#') and (CurrInputCh <= '[') or (CurrInputCh >= ']')) then
        begin
          state := 7;
        end
        else if (CurrInputCh = '"') then
        begin
          state := 8;
        end
        else if (CurrInputCh = '\') then
        begin
          state := 13;
        end
        else
        begin
          sym   := _stringSym;
          exit;
        end;
      15: begin
        sym := _equalSym;
        exit;
      end;
      16: begin
        sym            := _lbraceSym;
        exit;
      end;
      17: begin
        sym            := _commaSym;
        exit;
      end;
      18: begin
        sym            := _rbraceSym;
        exit;
      end;
      19: begin
        sym            := _semicolonSym;
        exit;
      end;
      20: begin
        sym            := EOFSYMB;
        CurrInputCh    := #0;
        BufferPosition := BufferPosition - 1;
        exit;
      end;
      else
      begin
        sym := _noSym;
        EXIT;          // NextCh already done
      end;
    end;
  end;
end;  {Get}

constructor THSParserScanner.Create;
begin
  inherited;
  fHashList := TmwStringHashList.Create(SmallCrcHash, HashSecondaryTwo, HashCompare);
  fHashList.AddString('author', authorSym, authorSym);
  fHashList.AddString('authorinfo', authorinfoSym, authorinfoSym);
  fHashList.AddString('gvar', gvarSym, gvarSym);
  fHashList.AddString('holodisk', holodiskSym, holodiskSym);
  fHashList.AddString('timestamp', timestampSym, timestampSym);
  CurrentCh        := CharAt;
  fStartState[0]   := 20; fStartState[1] := 21; fStartState[2] := 21; fStartState[3] := 21;
  fStartState[4]   := 21; fStartState[5] := 21; fStartState[6] := 21; fStartState[7] := 21;
  fStartState[8]   := 21; fStartState[9] := 21; fStartState[10] := 21; fStartState[11] := 21;
  fStartState[12]  := 21; fStartState[13] := 21; fStartState[14] := 21; fStartState[15] := 21;
  fStartState[16]  := 21; fStartState[17] := 21; fStartState[18] := 21; fStartState[19] := 21;
  fStartState[20]  := 21; fStartState[21] := 21; fStartState[22] := 21; fStartState[23] := 21;
  fStartState[24]  := 21; fStartState[25] := 21; fStartState[26] := 21; fStartState[27] := 21;
  fStartState[28]  := 21; fStartState[29] := 21; fStartState[30] := 21; fStartState[31] := 21;
  fStartState[32]  := 21; fStartState[33] := 21; fStartState[34] := 7; fStartState[35] := 10;
  fStartState[36]  := 9; fStartState[37] := 21; fStartState[38] := 21; fStartState[39] := 21;
  fStartState[40]  := 21; fStartState[41] := 21; fStartState[42] := 21; fStartState[43] := 2;
  fStartState[44]  := 17; fStartState[45] := 12; fStartState[46] := 4; fStartState[47] := 21;
  fStartState[48]  := 11; fStartState[49] := 11; fStartState[50] := 11; fStartState[51] := 11;
  fStartState[52]  := 11; fStartState[53] := 11; fStartState[54] := 11; fStartState[55] := 11;
  fStartState[56]  := 11; fStartState[57] := 11; fStartState[58] := 21; fStartState[59] := 19;
  fStartState[60]  := 21; fStartState[61] := 15; fStartState[62] := 21; fStartState[63] := 21;
  fStartState[64]  := 21; fStartState[65] := 1; fStartState[66] := 1; fStartState[67] := 1;
  fStartState[68]  := 1; fStartState[69] := 1; fStartState[70] := 1; fStartState[71] := 1;
  fStartState[72]  := 1; fStartState[73] := 1; fStartState[74] := 1; fStartState[75] := 1;
  fStartState[76]  := 1; fStartState[77] := 1; fStartState[78] := 1; fStartState[79] := 1;
  fStartState[80]  := 1; fStartState[81] := 1; fStartState[82] := 1; fStartState[83] := 1;
  fStartState[84]  := 1; fStartState[85] := 1; fStartState[86] := 1; fStartState[87] := 1;
  fStartState[88]  := 1; fStartState[89] := 1; fStartState[90] := 1; fStartState[91] := 21;
  fStartState[92]  := 21; fStartState[93] := 21; fStartState[94] := 21; fStartState[95] := 1;
  fStartState[96]  := 21; fStartState[97] := 1; fStartState[98] := 1; fStartState[99] := 1;
  fStartState[100] := 1; fStartState[101] := 1; fStartState[102] := 1; fStartState[103] := 1;
  fStartState[104] := 1; fStartState[105] := 1; fStartState[106] := 1; fStartState[107] := 1;
  fStartState[108] := 1; fStartState[109] := 1; fStartState[110] := 1; fStartState[111] := 1;
  fStartState[112] := 1; fStartState[113] := 1; fStartState[114] := 1; fStartState[115] := 1;
  fStartState[116] := 1; fStartState[117] := 1; fStartState[118] := 1; fStartState[119] := 1;
  fStartState[120] := 1; fStartState[121] := 1; fStartState[122] := 1; fStartState[123] := 16;
  fStartState[124] := 21; fStartState[125] := 18; fStartState[126] := 21; fStartState[127] := 21;
  fStartState[128] := 21; fStartState[129] := 21; fStartState[130] := 21; fStartState[131] := 21;
  fStartState[132] := 21; fStartState[133] := 21; fStartState[134] := 21; fStartState[135] := 21;
  fStartState[136] := 21; fStartState[137] := 21; fStartState[138] := 21; fStartState[139] := 21;
  fStartState[140] := 21; fStartState[141] := 21; fStartState[142] := 21; fStartState[143] := 21;
  fStartState[144] := 21; fStartState[145] := 21; fStartState[146] := 21; fStartState[147] := 21;
  fStartState[148] := 21; fStartState[149] := 21; fStartState[150] := 21; fStartState[151] := 21;
  fStartState[152] := 21; fStartState[153] := 21; fStartState[154] := 21; fStartState[155] := 21;
  fStartState[156] := 21; fStartState[157] := 21; fStartState[158] := 21; fStartState[159] := 21;
  fStartState[160] := 21; fStartState[161] := 21; fStartState[162] := 21; fStartState[163] := 21;
  fStartState[164] := 21; fStartState[165] := 21; fStartState[166] := 21; fStartState[167] := 21;
  fStartState[168] := 21; fStartState[169] := 21; fStartState[170] := 21; fStartState[171] := 21;
  fStartState[172] := 21; fStartState[173] := 21; fStartState[174] := 21; fStartState[175] := 21;
  fStartState[176] := 21; fStartState[177] := 21; fStartState[178] := 21; fStartState[179] := 21;
  fStartState[180] := 21; fStartState[181] := 21; fStartState[182] := 21; fStartState[183] := 21;
  fStartState[184] := 21; fStartState[185] := 21; fStartState[186] := 21; fStartState[187] := 21;
  fStartState[188] := 21; fStartState[189] := 21; fStartState[190] := 21; fStartState[191] := 21;
  fStartState[192] := 21; fStartState[193] := 21; fStartState[194] := 21; fStartState[195] := 21;
  fStartState[196] := 1; fStartState[197] := 1; fStartState[198] := 21; fStartState[199] := 21;
  fStartState[200] := 21; fStartState[201] := 21; fStartState[202] := 21; fStartState[203] := 21;
  fStartState[204] := 21; fStartState[205] := 21; fStartState[206] := 21; fStartState[207] := 21;
  fStartState[208] := 21; fStartState[209] := 21; fStartState[210] := 21; fStartState[211] := 21;
  fStartState[212] := 21; fStartState[213] := 21; fStartState[214] := 1; fStartState[215] := 21;
  fStartState[216] := 21; fStartState[217] := 21; fStartState[218] := 21; fStartState[219] := 21;
  fStartState[220] := 21; fStartState[221] := 21; fStartState[222] := 21; fStartState[223] := 21;
  fStartState[224] := 21; fStartState[225] := 21; fStartState[226] := 21; fStartState[227] := 21;
  fStartState[228] := 1; fStartState[229] := 1; fStartState[230] := 21; fStartState[231] := 21;
  fStartState[232] := 21; fStartState[233] := 21; fStartState[234] := 21; fStartState[235] := 21;
  fStartState[236] := 21; fStartState[237] := 21; fStartState[238] := 21; fStartState[239] := 21;
  fStartState[240] := 21; fStartState[241] := 21; fStartState[242] := 21; fStartState[243] := 21;
  fStartState[244] := 21; fStartState[245] := 21; fStartState[246] := 1; fStartState[247] := 21;
  fStartState[248] := 21; fStartState[249] := 21; fStartState[250] := 21; fStartState[251] := 21;
  fStartState[252] := 21; fStartState[253] := 21; fStartState[254] := 21; fStartState[255] := 21;
end; {Create}

destructor THSParserScanner.Destroy;
begin
  fHashList.Free;
  fHashList := NIL;
  inherited;
end;

 { --------------------------------------------------------------------------- }
 { ---- implementation for THSParser ---- }

constructor THSParser.Create(AOwner: TComponent);
begin
  inherited;
  Scanner          := THSParserScanner.Create;
  GetScanner.Owner := self;
  fOutputStream    := TMemoryStream.Create;

  InitSymSet;
end; {Create}

destructor THSParser.Destroy;
begin
  Scanner.Free;
  fOutputStream.Free;

  inherited;
end; {Destroy}

function THSParser.ErrorStr(const ErrorCode: integer; const Data: string): string;
begin
  case ErrorCode of
    0: Result  := 'EOF expected';
    1: Result  := 'identifier expected';
    2: Result  := 'integer value expected';
    3: Result  := '_float expected';
    4: Result  := 'string constant expected';
    5: Result  := 'HexLiteral expected';
    6: Result  := '"holodisk" expected';
    7: Result  := '"gvar" expected';
    8: Result  := '"=" expected';
    9: Result  := '"{" expected';
    10: Result := '"," expected';
    11: Result := '"}" expected';
    12: Result := '"authorinfo" expected';
    13: Result := '"author" expected';
    14: Result := '";" expected';
    15: Result := '"timestamp" expected';
    16: Result := 'not expected';
    17: Result := 'invalid Main';


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

procedure THSParser.Execute;
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
    OnStatusUpdate(Self, 'parsing source', -1);

  { instigate the compilation }
  if Assigned(BeforeParse) then
    BeforeParse(Self);
  Parse;
  if Assigned(AfterParse) then
    AfterParse(Self);

  { generate the source listing to the ListStream }
  if (GenListWhen = glAlways) or ((GenListWhen = glOnError) and (ErrorList.Count > 0)) then
    GenerateListing;
  if ClearSourceStream then
    GetScanner.SrcStream.Clear;
  ListStream.Position := 0;  // goto the beginning of the stream
  if Successful and Assigned(OnSuccess) then
    OnSuccess(Self);
  if (not Successful) and Assigned(OnFailure) then
    OnFailure(Self, ErrorList.Count);
end;  {Execute}

procedure THSParser.Get;
begin
  repeat


    GetScanner.Get(fCurrentInputSymbol);
    if fCurrentInputSymbol <= maxT then
      errDist := errDist + 1
    else
    begin
      case fCurrentInputSymbol of
        PreProcessorSym: begin
        end;
      end;
      GetScanner.NextSymbol.Pos  := GetScanner.CurrentSymbol.Pos;
      GetScanner.NextSymbol.Col  := GetScanner.CurrentSymbol.Col;
      GetScanner.NextSymbol.Line := GetScanner.CurrentSymbol.Line;
      GetScanner.NextSymbol.Len  := GetScanner.CurrentSymbol.Len;
    end;
  until fCurrentInputSymbol <= maxT;
end;  {Get}

function THSParser.GetScanner: THSParserScanner;
begin
  Result := Scanner as THSParserScanner;
end;  {GetScanner}

function THSParser._In(var s: SymbolSet; x: integer): boolean;
begin
  _In := x mod setsize in s[x div setsize];
end;  {_In}

procedure THSParser._AuthorInfo;begin
  Expect(authorinfoSym);
  Expect(_lbraceSym);
  Expect(authorSym);
  Expect(_equalSym);
  Expect(_stringSym);
  Expect(_semicolonSym);
  Expect(timestampSym);
  Expect(_equalSym);
  Expect(_stringSym);
  Expect(_semicolonSym);
  Expect(_rbraceSym);
end;

procedure THSParser._HoloDisk;begin
  Expect(holodiskSym);
  Expect(_stringSym);
  new(holos[holocnt]);  holos[holocnt].title := current_title_id;
    {$IFDEF HOLOCMP_BUILD}
    writeln('Generating holodisk "',parse_string(lexstring)+'"');
    {$ENDIF}

  if holocnt = 0 then
  begin;
    holos[holocnt].Text := 1000;
    holos[holocnt].title := 400;
    if is_valid_mes_ind(400, pipboydata) then
      set_mes_string(parse_string(lexstring), '',
        400, pipboydata)  else
      insertmsg(400, pipboydata, holos[holocnt].title,
        parse_string(lexstring));

  end else
  begin;
    holos[holocnt].title := holos[holocnt - 1].title + 1;
    holos[holocnt].Text  := holos[holocnt - 1].Text + 1000;
    if is_valid_mes_ind(holos[holocnt - 1].title + 1, pipboydata) then
      set_mes_string(parse_string(lexstring), '',
        get_mes_ind(holos[holocnt - 1].title, pipboydata) + 1, pipboydata)  else

      insertmsg(get_mes_ind(holos[holocnt - 1].title, pipboydata) + 1, pipboydata, holos[holocnt - 1].title + 1,
        parse_string(lexstring));


    holos[holocnt].title := holos[holocnt - 1].title + 1;

  end;

  ;
  Expect(gvarSym);
  Expect(_equalSym);
  Expect(integer_Sym);
  holos[holocnt].gvar := StrToInt(lexstring);;
  Expect(_lbraceSym);
  Expect(_stringSym);
  holotext.add(parse_string(lexstring));;
  while (fCurrentInputSymbol = _commaSym) do begin
    Get;
    Expect(_stringSym);
    holotext.add(parse_string(lexstring));;
  end;
  Expect(_rbraceSym);
  current_title_id := current_title_id + 1;  generateholodata;  Inc(holocnt);;
end;

procedure THSParser._Main;begin
  if (fCurrentInputSymbol = holodiskSym) then begin
    _HoloDisk;
  end else if (fCurrentInputSymbol = authorinfoSym) then begin
    _AuthorInfo;
  end else
  begin SynError(17);
  end;
end;

procedure THSParser._HSParser;begin
  Init;;
  _Main;
  while (fCurrentInputSymbol = holodiskSym) or (fCurrentInputSymbol = authorinfoSym) do begin
    _Main;
  end;
  Final;;
end;

function THSParser.GetMajorVersion: integer;
begin
  Result := 1;
end;

function THSParser.GetMinorVersion: integer;
begin
  Result := 0;
end;

function THSParser.GetRelease: integer;
begin
  Result := 0;
end;

function THSParser.GetBuild: integer;
begin
  Result := 201;
end;

function THSParser.GetBuildDate: TDateTime;
const
  BDate = 38566;
  Hour  = 16;
  Min   = 09;
begin
  Result := BDate + EncodeTime(Hour, Min, 0, 0);
end;

function THSParser.GetVersion: string;
var
  MinorVersionStr: string;
begin
  MinorVersionStr := IntToStr(MinorVersion);
  if (length(MinorVersionStr) > 0) and (MinorVersion > 0) then
    MinorVersionStr := '0' + MinorVersionStr;
  Result          := 'Version: ' + IntToStr(MajorVersion) + '.' + MinorVersionStr + ' Release ' +
    IntToStr(Release) + ' Build ' + IntToStr(Build);
end;

function THSParser.GetVersionComment: string;
begin
  Result := 'Holodisk data compiler';
end;

function THSParser.GetGrammarAuthor: string;
begin
  Result := 'T. Pitk�nen';
end;

function THSParser.GetGrammarCopyright: string;
begin
  Result := '(c) 2005 Dj Unique';
end;

procedure THSParser.SetVersion(const Value: string);
begin
  // This is a read only property. However, we want the value
  // to appear in the Object Inspector during design time.
end;

procedure THSParser.Parse;
begin
  errDist := minErrDist;
  GetScanner._Reset;
  Get;
  _HSParser;
end;  {Parse}

procedure THSParser.InitSymSet;
begin
  symSet[0, 0] := [EOFSYMB];
  symSet[0, 1] := [];
end; {InitSymSet}

end { HSParser }.
        
