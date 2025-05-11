
{**********************************************************************}
{                                                                      }
{                           XML Data Binding                           }
{                                                                      }
{         Generated on: 6.5.2018 12:51:44                              }
{       Generated from: C:\CodeProjects\SpotifyHelper\SpotifyXML.xml   }
{   Settings stored in: C:\CodeProjects\SpotifyHelper\SpotifyXML.xdb   }
{                                                                      }
{**********************************************************************}

unit SpotifyXML;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLSpotifyXMLDBType = interface;
  IXMLTracklistType = interface;
  IXMLTrackType = interface;
  IXMLTrackTypeList = interface;

{ IXMLSpotifyXMLDBType }

  IXMLSpotifyXMLDBType = interface(IXMLNode)
    ['{10FF98A5-0415-4FB3-9217-119BEFFDB302}']
    { Property Accessors }
    function Get_Artist: WideString;
    function Get_Title: WideString;
    function Get_Recordlabel: WideString;
    function Get_OutputFolder: WideString;
    function Get_Tracklist: IXMLTracklistType;
    procedure Set_Artist(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Recordlabel(Value: WideString);
    procedure Set_OutputFolder(Value: WideString);
    { Methods & Properties }
    property Artist: WideString read Get_Artist write Set_Artist;
    property Title: WideString read Get_Title write Set_Title;
    property Recordlabel: WideString read Get_Recordlabel write Set_Recordlabel;
    property OutputFolder: WideString read Get_OutputFolder write Set_OutputFolder;
    property Tracklist: IXMLTracklistType read Get_Tracklist;
  end;

{ IXMLTracklistType }

  IXMLTracklistType = interface(IXMLNodeCollection)
    ['{EE048F7F-1AE3-45D3-81AF-584FCDDDDB9D}']
    { Property Accessors }
    function Get_Track(Index: Integer): IXMLTrackType;
    { Methods & Properties }
    function Add: IXMLTrackType;
    function Insert(const Index: Integer): IXMLTrackType;
    property Track[Index: Integer]: IXMLTrackType read Get_Track; default;
  end;

{ IXMLTrackType }

  IXMLTrackType = interface(IXMLNode)
    ['{4B93C4E7-68B4-4C08-AF18-F2BC69FB0468}']
    { Property Accessors }
    function Get_Dur: Integer;
    function Get_Num: Integer;
    function Get_Disc: Integer;
    function Get_Artist: WideString;
    function Get_Title: WideString;
    function Get_Remixtitle: WideString;
    function Get_SourceFilename: WideString;
    function Get_TargetFilename: WideString;
    procedure Set_Dur(Value: Integer);
    procedure Set_Num(Value: Integer);
    procedure Set_Disc(Value: Integer);
    procedure Set_Artist(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Remixtitle(Value: WideString);
    procedure Set_SourceFilename(Value: WideString);
    procedure Set_TargetFilename(Value: WideString);
    { Methods & Properties }
    property Dur: Integer read Get_Dur write Set_Dur;
    property Num: Integer read Get_Num write Set_Num;
    property Disc: Integer read Get_Disc write Set_Disc;
    property Artist: WideString read Get_Artist write Set_Artist;
    property Title: WideString read Get_Title write Set_Title;
    property Remixtitle: WideString read Get_Remixtitle write Set_Remixtitle;
    property SourceFilename: WideString read Get_SourceFilename write Set_SourceFilename;
    property TargetFilename: WideString read Get_TargetFilename write Set_TargetFilename;
  end;

{ IXMLTrackTypeList }

  IXMLTrackTypeList = interface(IXMLNodeCollection)
    ['{3382E274-83FA-4686-AF82-68A2A43F0EC1}']
    { Methods & Properties }
    function Add: IXMLTrackType;
    function Insert(const Index: Integer): IXMLTrackType;
    function Get_Item(Index: Integer): IXMLTrackType;
    property Items[Index: Integer]: IXMLTrackType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLSpotifyXMLDBType = class;
  TXMLTracklistType = class;
  TXMLTrackType = class;
  TXMLTrackTypeList = class;

{ TXMLSpotifyXMLDBType }

  TXMLSpotifyXMLDBType = class(TXMLNode, IXMLSpotifyXMLDBType)
  protected
    { IXMLSpotifyXMLDBType }
    function Get_Artist: WideString;
    function Get_Title: WideString;
    function Get_Recordlabel: WideString;
    function Get_OutputFolder: WideString;
    function Get_Tracklist: IXMLTracklistType;
    procedure Set_Artist(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Recordlabel(Value: WideString);
    procedure Set_OutputFolder(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTracklistType }

  TXMLTracklistType = class(TXMLNodeCollection, IXMLTracklistType)
  protected
    { IXMLTracklistType }
    function Get_Track(Index: Integer): IXMLTrackType;
    function Add: IXMLTrackType;
    function Insert(const Index: Integer): IXMLTrackType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTrackType }

  TXMLTrackType = class(TXMLNode, IXMLTrackType)
  protected
    { IXMLTrackType }
    function Get_Dur: Integer;
    function Get_Num: Integer;
    function Get_Disc: Integer;
    function Get_Artist: WideString;
    function Get_Title: WideString;
    function Get_Remixtitle: WideString;
    function Get_SourceFilename: WideString;
    function Get_TargetFilename: WideString;
    procedure Set_Dur(Value: Integer);
    procedure Set_Num(Value: Integer);
    procedure Set_Disc(Value: Integer);
    procedure Set_Artist(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Remixtitle(Value: WideString);
    procedure Set_SourceFilename(Value: WideString);
    procedure Set_TargetFilename(Value: WideString);
  end;

{ TXMLTrackTypeList }

  TXMLTrackTypeList = class(TXMLNodeCollection, IXMLTrackTypeList)
  protected
    { IXMLTrackTypeList }
    function Add: IXMLTrackType;
    function Insert(const Index: Integer): IXMLTrackType;
    function Get_Item(Index: Integer): IXMLTrackType;
  end;

{ Global Functions }

function GetSpotifyXMLDB(Doc: IXMLDocument): IXMLSpotifyXMLDBType;
function LoadSpotifyXMLDB(const FileName: WideString): IXMLSpotifyXMLDBType;
function NewSpotifyXMLDB: IXMLSpotifyXMLDBType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetSpotifyXMLDB(Doc: IXMLDocument): IXMLSpotifyXMLDBType;
begin
  Result := Doc.GetDocBinding('SpotifyXMLDB', TXMLSpotifyXMLDBType, TargetNamespace) as IXMLSpotifyXMLDBType;
end;

function LoadSpotifyXMLDB(const FileName: WideString): IXMLSpotifyXMLDBType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('SpotifyXMLDB', TXMLSpotifyXMLDBType, TargetNamespace) as IXMLSpotifyXMLDBType;
end;

function NewSpotifyXMLDB: IXMLSpotifyXMLDBType;
begin
  Result := NewXMLDocument.GetDocBinding('SpotifyXMLDB', TXMLSpotifyXMLDBType, TargetNamespace) as IXMLSpotifyXMLDBType;
end;

{ TXMLSpotifyXMLDBType }

procedure TXMLSpotifyXMLDBType.AfterConstruction;
begin
  RegisterChildNode('Tracklist', TXMLTracklistType);
  inherited;
end;

function TXMLSpotifyXMLDBType.Get_Artist: WideString;
begin
  Result := ChildNodes['Artist'].Text;
end;

procedure TXMLSpotifyXMLDBType.Set_Artist(Value: WideString);
begin
  ChildNodes['Artist'].NodeValue := Value;
end;

function TXMLSpotifyXMLDBType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLSpotifyXMLDBType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLSpotifyXMLDBType.Get_Recordlabel: WideString;
begin
  Result := ChildNodes['Recordlabel'].Text;
end;

procedure TXMLSpotifyXMLDBType.Set_Recordlabel(Value: WideString);
begin
  ChildNodes['Recordlabel'].NodeValue := Value;
end;

function TXMLSpotifyXMLDBType.Get_OutputFolder: WideString;
begin
  Result := ChildNodes['OutputFolder'].Text;
end;

procedure TXMLSpotifyXMLDBType.Set_OutputFolder(Value: WideString);
begin
  ChildNodes['OutputFolder'].NodeValue := Value;
end;

function TXMLSpotifyXMLDBType.Get_Tracklist: IXMLTracklistType;
begin
  Result := ChildNodes['Tracklist'] as IXMLTracklistType;
end;

{ TXMLTracklistType }

procedure TXMLTracklistType.AfterConstruction;
begin
  RegisterChildNode('Track', TXMLTrackType);
  ItemTag := 'Track';
  ItemInterface := IXMLTrackType;
  inherited;
end;

function TXMLTracklistType.Get_Track(Index: Integer): IXMLTrackType;
begin
  Result := List[Index] as IXMLTrackType;
end;

function TXMLTracklistType.Add: IXMLTrackType;
begin
  Result := AddItem(-1) as IXMLTrackType;
end;

function TXMLTracklistType.Insert(const Index: Integer): IXMLTrackType;
begin
  Result := AddItem(Index) as IXMLTrackType;
end;

{ TXMLTrackType }

function TXMLTrackType.Get_Dur: Integer;
begin
  Result := AttributeNodes['dur'].NodeValue;
end;

procedure TXMLTrackType.Set_Dur(Value: Integer);
begin
  SetAttribute('dur', Value);
end;

function TXMLTrackType.Get_Num: Integer;
begin
  Result := AttributeNodes['num'].NodeValue;
end;

procedure TXMLTrackType.Set_Num(Value: Integer);
begin
  SetAttribute('num', Value);
end;

function TXMLTrackType.Get_Disc: Integer;
begin
  Result := AttributeNodes['disc'].NodeValue;
end;

procedure TXMLTrackType.Set_Disc(Value: Integer);
begin
  SetAttribute('disc', Value);
end;

function TXMLTrackType.Get_Artist: WideString;
begin
  Result := ChildNodes['Artist'].Text;
end;

procedure TXMLTrackType.Set_Artist(Value: WideString);
begin
  ChildNodes['Artist'].NodeValue := Value;
end;

function TXMLTrackType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLTrackType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLTrackType.Get_Remixtitle: WideString;
begin
  Result := ChildNodes['Remixtitle'].Text;
end;

procedure TXMLTrackType.Set_Remixtitle(Value: WideString);
begin
  ChildNodes['Remixtitle'].NodeValue := Value;
end;

function TXMLTrackType.Get_SourceFilename: WideString;
begin
  Result := ChildNodes['SourceFilename'].Text;
end;

procedure TXMLTrackType.Set_SourceFilename(Value: WideString);
begin
  ChildNodes['SourceFilename'].NodeValue := Value;
end;

function TXMLTrackType.Get_TargetFilename: WideString;
begin
  Result := ChildNodes['TargetFilename'].Text;
end;

procedure TXMLTrackType.Set_TargetFilename(Value: WideString);
begin
  ChildNodes['TargetFilename'].NodeValue := Value;
end;

{ TXMLTrackTypeList }

function TXMLTrackTypeList.Add: IXMLTrackType;
begin
  Result := AddItem(-1) as IXMLTrackType;
end;

function TXMLTrackTypeList.Insert(const Index: Integer): IXMLTrackType;
begin
  Result := AddItem(Index) as IXMLTrackType;
end;
function TXMLTrackTypeList.Get_Item(Index: Integer): IXMLTrackType;
begin
  Result := List[Index] as IXMLTrackType;
end;

end. 