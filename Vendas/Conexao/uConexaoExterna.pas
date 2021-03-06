unit uConexaoExterna;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.IOUtils,
  Rest.Response.Adapter,

  Data.DB,
  Datasnap.DBClient,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs;

type
  TdmConexaoExterna = class(TDataModule)
    restClient:   TRESTClient;
    restRequest:  TRESTRequest;
    restResponse: TRESTResponse;
    conexaoSQLite: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FHost:  String;
    FPorta: String;
    FRota:  String;

    FMetodo: TRESTRequestMethod;
  public
    { Public declarations }
    property Host:  String read FHost  write FHost;
    property Porta: String read FPorta write FPorta;
    property Rota:  String read FRota  write FRota;
    property Metodo: TRestRequestMethod read FMetodo write FMetodo;

    function ConexaoValida: Boolean;
    procedure Conexao(var DataSet: TClientDataSet);
    procedure executar;
    procedure AddParametro(pContentType: TRestContentType; pKind: TRESTRequestParameterKind; Chave: String; Valor: String);
    procedure PostDataSet(dataset: TDataSet);
    procedure DeleteRegistro(ID: Integer);
    function JSONToDataSet(DataSet: TDataSet; pJSON: String): TFDMemTable;
  end;

var
  dmConexaoExterna: TdmConexaoExterna;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uFMXUtils;

{$R *.dfm}

{ TdmConexaoExterna }

procedure TdmConexaoExterna.AddParametro(pContentType: TRestContentType;
  pKind: TRESTRequestParameterKind; Chave, Valor: String);
begin
  with restRequest.Params.AddItem do
  begin
    ContentType := pContentType;
    Kind        := pKind;
    Name        := Chave;
    Value       := valor;
  end;
end;

procedure TdmConexaoExterna.Conexao(var DataSet: TClientDataSet);
begin

end;

function TdmConexaoExterna.ConexaoValida: Boolean;
begin

end;

procedure TdmConexaoExterna.DataModuleCreate(Sender: TObject);
begin
  Host := 'localhost';
  Porta := '4000';

  {$IF DEFINED (ANDROID)}
  conexaoSQLite.Params.Values['DriverID'] := 'SQLite';
  conexaoSQLite.LoginPrompt := False;

  conexaoSQLite.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.s3db');
  conexaoSQLite.Connected := True;
  {$ENDIF}
end;

procedure TdmConexaoExterna.DeleteRegistro(ID: Integer);
begin
  restRequest.Params.Clear;
  Rota := Rota;
  dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED, pkGETorPOST, 'id', ID.ToString);
  Metodo := rmDelete;
  Executar;

  ToastExclusao;
end;

procedure TdmConexaoExterna.executar;
begin
  // Configura??es do CLIENT
  restClient.BaseURL     := 'http://'+host+':'+porta+'/admin/'+rota;
  restClient.ContentType := 'application/json';

  // Configura??es do REQUEST
  restRequest.Method     := Metodo;
  restRequest.Client     := restClient;
  restRequest.Response   := restResponse;

  restRequest.Execute;

  if restResponse.Content.Contains('Ocorreu um erro') then
    raise Exception.Create(restResponse.Content);
end;

function TdmConexaoExterna.JSONToDataSet(DataSet: TDataSet; pJSON: String): TFDMemTable;
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  while DataSet.Fields.Count > 0 do
   DataSet.Fields.Remove(DataSet.Fields[0]);

  if (pJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(pJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := DataSet;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;

  Result := TFDMemTable(DataSet);
end;

procedure TdmConexaoExterna.PostDataSet(dataset: TDataSet);
var
  I: Integer;
begin
  Rota := Rota;
  Metodo := rmPost;
  restRequest.Params.Clear;

  if dataset.State = dsInsert then
    dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED, pkGETorPOST, 'id', '0')
  else
    dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED, pkGETorPOST, 'id', dataset.FieldByName('ID').AsString);

  for I := 0 to dataset.FieldCount - 1 do
  begin
    if dataset.Fields[i].FieldName <> 'ID' then
    begin
      dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED,
                                    pkGETorPOST,
                                    LowerCase(dataset.Fields[i].FieldName),
                                    dataset.FieldByName(dataset.Fields[i].FieldName).AsString);
    end;
  end;
  dmConexaoExterna.Executar;
end;

end.
