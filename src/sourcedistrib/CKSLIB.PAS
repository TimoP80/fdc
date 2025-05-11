{------------------------------------------------------------------------------
|                               Unit ckSLib                                    |
|------------------------------------------------------------------------------|
| Copyright © 1998 by Cobus Kruger. All rights reserved.                       |
| Programmed by Cobus Kruger                                                   |
| This Version: 10 March 1999                                                  |
|                                                                              |
| Email Me: cobus.kruger@usa.net                                               |
| Look for new versions on Torry's Delphi Pages                                |
|   http://www.torry.ru/index.htm                                              |
|   http://torry.magnitka.ru/                                                  |
|   http://torry.rimini.com/                                                   |
|   http://www.torry.webnorth.com/index.htm                                    |
|   http://bes.trendline.co.il/torry/                                          |
|   http://torry.copystar.com.tw/                                              |
|   http://www.blocks.co.jp/torry/index.html                                   |
|   http://www.snc.ru/~torry/                                                  |
|   http://torry.tsg.edu.ee/                                                   |
|   http://www.torry.css.pl/                                                   |
| Look for new versions on Delphi Super Pages                                  |
|   http://sunsite.icm.edu.pl/delphi/                                          |
|------------------------------------------------------------------------------|
| This unit implements many different procedures and functions that manipulate |
| strings. It is of course never finished, so be on the lookout for new        |
| versions, that should be coming out pretty regular. I don't have a web site  |
| of my own right now, but I intend to have one soon where you can get updates.|
| Until I get one, just look on Torry's or DSP, or drop me an email.           |
|------------------------------------------------------------------------------|
| This unit is freeware so distribute it all you want (please) and use it as   |
| often as you want, commercially or not, it doesn't matter. Just keep the     |
| etire file intact, unmodified, and displaying my copyright notice.           |
|                                                                              |
| If you make modifications to the code, do not distribute. Drop me an email,  |
| and if I include it in an upcoming version, I will add your name and         |
| copyright information to the distribution.                                   |
 ------------------------------------------------------------------------------}

unit CKSLib;

interface

uses
  Classes, DB;

function StringToWords(const s: string; const Token: string): TStringList;
 // The following function returns a stringlist that contains a list of
 // words. Words are considered to be character groups that are separated
 // by a Token
function WordsToString(const sl: TStringList; const Token: string): string;
// The following function takes a string list and turns it into one single string, separating
// words by Token

function StripDuplicates(const s: string; const Token: string): string;
// Replaces multiple consecutive instances of Token with one instance only

function NameCase(s: string): string;
 // Converts a string into the case used to spell names.  It breaks the string up into
 // words, and then convert each word's case separately, keeping in mind names like
 // "McMillan" or "MacDonald"
function TitleCase(s: string): string;
 // Converts a string into a title, keeping in mind words that must be kept in lower case,
 // as opposed to words that need to be capitalized
function SentenceCase(s: string): string;
// First word is capitalized, the rest is lowercase

function StripNonNumeric(s: string): string;
// Strips all characters other than 0 through 9
function StripNumeric(s: string): string;
// Strips only 0 through 9
function StripAlphabetical(s: string): string;
// Strips all characters a though z, and also A through Z
function StripNonAlphabetical(s: string): string;
// Strips all characters other than a though z, and also A through Z
function StripNonFloat(s: string): string;
// Strips all characters other than 0 through 9, and discards all but the first decimal point
function StripAlphaNumeric(s: string): string;
// Strips all characters a through z, A through Z, and 0 through 9
function StripNonAlphaNumeric(s: string): string;
// Strips all characters other than a through z, A through Z, and 0 through 9

function Quoted(s: string): string;
// Encloses a string in double quotes

function StripZeros(s: string): string;
// Removes leading zeros from string s
function PadZeros(s: string; Len: integer): string;
// Pads string s to length Len, by adding zeros to the front

function PosNo(N: integer; Substr: string; S: string): integer;
// Finds the Nth occurence of Substr in S, and returns the index at which it was found

procedure ReplaceToken(var s: string; Token, Value: string);
// Replaces all occurences of Token with Value

type
  TBooleanText = (btYesNo, btTrueFalse);

function CharToBooleanText(bt: TBooleanText; Ch: char): string;
 // Converts a "Y" or "T" to "Yes" or "True" and "N" or "F" to "No" or "False",
 // depending on the value of the bt flag. If Ch is lowercase, the result will
 // also be lowercase. If Ch is uppercase, the result will be in title case.
 // Any other character passed to it will result in either "N/A" or "n/a",
 // depending on the case. If the character is not alphabetical, the result
 // will always be "N/A"

function BooleanToBooleanText(bt: TBooleanText; B: boolean): string;
 // Converts True to "Yes" or "True" and False to "No" or "False", depending on
 // the value of the bt flag. The result will always be in title case.

function IntToBooleanText(bt: TBooleanText; I: integer): string;
 // Converts 0 to "No" or "False" and anything else to "Yes" or "True", depending
 // on the value of the bt flag. The result will always be in title case.

implementation

uses
  SysUtils;

function StringToWords;
var
  tmps:   string;         // Holds the string that has remained of s
  posi:   integer;        // Holds the next position of Token
  toklen: integer;        // Holds the length of Token (default 1)
begin
  toklen := Length(Token);
  Result := TStringList.Create;

  tmps := s;

  posi := Pos(Token, tmps);
  while posi <> 0 do
  begin
    Result.Add(Copy(tmps, 1, posi - 1));
    Delete(tmps, 1, posi - 1 + toklen);
    posi := Pos(Token, tmps);
  end;

  Result.Add(tmps);
end;

function WordsToString;
var
  indx: integer;
begin
  Result := '';

  for indx := sl.Count - 1 downto 0 do
    Result := sl[indx] + Token + Result;

  // We now have a string ending in Token. Remove this last instance.
  Delete(Result, Length(Result) - Length(Token) + 1, Length(Token));
end;

function StripDuplicates;
var
  tmps:   string;
  posi:   integer;
  toklen: integer;
begin
  toklen := Length(Token);
  tmps   := s;
  Result := '';

  posi := Pos(Token, tmps);

  if posi = 0 then
  begin
    Result := s;
    Exit;
  end;

  while posi <> 0 do
  begin
    Result := Result + (Copy(tmps, 1, posi - 1));
    Delete(tmps, 1, posi - 1 + toklen);
    posi := Pos(Token, tmps);

    while posi = 1 do
    begin
      Delete(tmps, 1, posi - 1 + toklen);
      posi := Pos(Token, tmps);
    end;

    Result := Result + Token;
  end;

  Result := Result + tmps;
end;

function NameCase;
var
  indx: integer;
  sl:   TStrings;
  tmps: string;
begin
  Result := '';
  sl     := TStringList.Create;
  try
    s := LowerCase(s);
    if Length(s) < 1 then
      Exit;

    if Length(s) < 2 then
    begin
      Result := UpCase(s[1]);
      Exit;
    end;

    indx := 2;
    while indx <= Length(s) do
    begin
      if (UpCase(s[indx]) in ['A'..'Ö', '''', '0'..'9']) and not
        (UpCase(s[indx - 1]) in ['A'..'Ö', '''', '0'..'9']) then
      begin
        sl.Add(Copy(s, 1, indx - 1));
        Delete(s, 1, indx - 1);
        indx := 2;
        if Length(s) < 2 then
        begin
          sl.Add(s);
          Break;
        end;
      end;
      Inc(indx);
    end;

    if Length(s) > 1 then
      sl.Add(s);

    for indx := 0 to sl.Count - 1 do
    begin
      tmps := sl[indx];
      if Length(tmps) > 0 then
        tmps[1] := UpCase(tmps[1]);
      // if (Length(tmps) > 2) and (Copy(tmps, 1, 2) = 'Mc') then
      //   tmps[3] := UpCase(tmps[3]);
      //  if (Length(tmps) > 3) and (Copy(tmps, 1, 3) = 'Mac') then
      //   tmps[4] := UpCase(tmps[4]);

      Result := Result + tmps;
    end;
  finally
    sl.Free;
  end;
end;

function TitleCase;
var
  indx: integer;
  sl:   TStrings;
  lowcasewords: TStrings;
  tmps: string;
begin
  Result := '';
  sl     := TStringList.Create;
  try
    lowcasewords := TStringList.Create;
    try
      // These are the words that must remain lower case, except where they are at the beginning
      // of the string, i.e. first word
      lowcasewords.Add('the');
      lowcasewords.Add('and');
      lowcasewords.Add('of');
      lowcasewords.Add('before');
      lowcasewords.Add('after');

      // Go on...
      s := LowerCase(s);
      if Length(s) < 1 then
        Exit;

      s[1] := UpCase(s[1]);
      if Length(s) < 2 then
      begin
        Result := s;
        Exit;
      end;

      indx := 2;
      while indx <= Length(s) do
      begin
        if (UpCase(s[indx]) in ['A'..'Z', '''']) and not
          (UpCase(s[indx - 1]) in ['A'..'Z', '''']) then
        begin
          sl.Add(Copy(s, 1, indx - 1));
          Delete(s, 1, indx - 1);
          indx := 1;
          if Length(s) < 2 then
          begin
            sl.Add(s);
            Break;
          end;
        end;
        Inc(indx);
      end;
      sl.Add(s);

      for indx := 0 to sl.Count - 1 do
      begin
        // Only capitalize if not one of the lowercase words...
        tmps := sl[indx];
        if lowcasewords.IndexOf(tmps) <> -1 then
          if Length(tmps) > 1 then
            tmps[1] := UpCase(tmps[1]);

        Result := Result + tmps;
      end;
    finally
      lowcasewords.Free;
    end;
  finally
    sl.Free;
  end;
end;

function SentenceCase;
begin
  Result := LowerCase(s);

  if Length(Result) < 1 then
    Exit;

  Result[1] := UpCase(Result[1]);
end;

function StripNonNumeric;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if (s[indx] in ['0'..'9']) then
      Result := Result + s[indx];
  end;
end;

function StripNumeric;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if not (s[indx] in ['0'..'9']) then
      Result := Result + s[indx];
  end;
end;

function StripAlphabetical;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if not (s[indx] in ['A'..'Z', 'a'..'z']) then
      Result := Result + s[indx];
  end;
end;

function StripNonAlphabetical;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if (s[indx] in ['A'..'Z', 'a'..'z']) then
      Result := Result + s[indx];
  end;
end;

function StripNonFloat;
var
  indx: integer;
  dpt:  boolean;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;
  dpt := False;

  for indx := 1 to Length(s) do
  begin
    if (s[indx] in ['0'..'9']) then
      Result := Result + s[indx]
    else if (s[indx] = DecimalSeparator) and not dpt then
    begin
      dpt    := True;
      Result := Result + s[indx];
    end;
  end;
end;

function StripAlphaNumeric;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if not (s[indx] in ['0'..'9', 'a'..'z', 'A'..'Z']) then
      Result := Result + s[indx];
  end;
end;

function StripNonAlphaNumeric;
var
  indx: integer;
begin
  Result := '';
  if Length(s) < 1 then
    Exit;

  for indx := 1 to Length(s) do
  begin
    if (s[indx] in ['0'..'9', 'a'..'z', 'A'..'Z']) then
      Result := Result + s[indx];
  end;
end;

function Quoted;
begin
  Result := '"' + s + '"';
end;

function StripZeros;
begin
  Result := s;
  while (Length(Result) > 0) and (Result[1] = '0') do
    Delete(Result, 1, 1);
end;

function PadZeros;
begin
  Result := s;
  while Length(Result) < Len do
    Result := '0' + Result;
end;

function PosNo;
var
  sl:    TStringList;
  indx:  integer;
  found: boolean;
begin
  Result := 0;
  found  := False;

  sl := StringToWords(s, Substr);
  try
    try
      if sl.Count = 1 then
        Abort;

      for indx := 0 to sl.Count - 1 do
      begin
        Result := Result + Length(sl[indx]);

        if indx + 1 = N then
        begin
          found := True;
          Abort;
        end;

        Result := Result + Length(SubStr);
      end;
    finally
      sl.Free;
    end;
  except
  end;

  Inc(Result, 1);

  if not found then
    Result := 0;

  if Result > Length(s) then
    Result := 0;
end;

procedure ReplaceToken;
var
  sl: TStringList;
begin
  sl := StringToWords(s, Token);
  try
    s := WordsToString(sl, Value);
  finally
    sl.Free;
  end;
end;

function CharToBooleanText;
begin
  Result := 'N/A';

  if (UpCase(Ch) in ['Y', 'T']) and (bt = btYesNo) then
    Result := 'Yes'
  else if (UpCase(Ch) in ['N', 'F']) and (bt = btYesNo) then
    Result := 'No'
  else if (UpCase(Ch) in ['Y', 'T']) and (bt = btTrueFalse) then
    Result := 'True'
  else if (UpCase(Ch) in ['N', 'F']) and (bt = btTrueFalse) then
    Result := 'False';

  if Ch in ['a'..'z'] then
    Result := LowerCase(Result);
end;

function BooleanToBooleanText;
begin
  if boolean(integer(B) and integer(bt)) then
    Result := 'True'
  else if boolean(integer(B) xor integer(bt)) and (bt = btTrueFalse) then
    Result := 'False'
  else if boolean(integer(B) xor integer(bt)) and (bt = btYesNo) then
    Result := 'Yes'
  else if not boolean(integer(B) or integer(bt)) then
    Result := 'No';
end;

function IntToBooleanText;
begin
  if (bt = btYesNo) and (I <> 0) then
    Result := 'Yes'
  else if (bt = btYesNo) and (I = 0) then
    Result := 'No'
  else if (bt <> btYesNo) and (I <> 0) then
    Result := 'True'
  else if (bt <> btYesNo) and (I = 0) then
    Result := 'False';
end;

end.
