unit uLogin;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.JSON,

  REST.JSON,

  FMX.DialogService,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts, FMX.Effects,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmLogin = class(TForm)
    BackgroundImage: TImage;
    BlurEffect1: TBlurEffect;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    LockImage: TImage;
    edtSenha: TEdit;
    Image1: TImage;
    edtLogin: TEdit;
    Button1: TButton;
    Layout4: TLayout;
    lblCadastro: TLabel;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure lblCadastroClick(Sender: TObject);
  private
    { Private declarations }
    const FCNPJCPF: String = '102.363.079-67';
    procedure AjustarConexao;
    procedure ValidarLicenca;
  public
    { Public declarations }
  end;
var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uMenuModulos, uConexaoExterna, uConfiguracao;

procedure TfrmLogin.AjustarConexao;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(Nil);
  try
    Q.Connection := dmConexaoExterna.conexaoSQLite;
    Q.SQL.Add('SELECT * FROM CONFIGURACOES');
    Q.Open;

    dmConexaoExterna.Host := Q.FieldByName('HOST').AsString;
    dmConexaoExterna.Porta := Q.FieldByName('PORT').AsString;
  finally
    Q.Free;
  end;
end;

procedure TfrmLogin.Button1Click(Sender: TObject);
var
  ArrJSON: TJSONArray;
  UsuarioObj: TJSONObject;
  aux: String;
begin
  AjustarConexao;

  dmConexaoExterna.Rota := 'server/login';
  dmconexaoExterna.Metodo := rmPost;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED, pkGETorPOST, 'login', edtLogin.Text);
  dmConexaoExterna.AddParametro(ctAPPLICATION_X_WWW_FORM_URLENCODED, pkGETorPOST, 'senha', edtSenha.Text);
  dmConexaoExterna.Executar;

  if dmConexaoExterna.RestResponse.Content = 'Usuário ou senha inválidos' then
    raise Exception.Create('Usuário ou senha inválidos.');

  ArrJSON := TJSONObject.ParseJSONValue(dmConexaoExterna.RestResponse.Content) as TJSONArray;

  UsuarioObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ArrJSON.Items[0].ToString), 0) as TJSONObject;
  try
    if UsuarioObj.TryGetValue('login', aux) and UsuarioObj.TryGetValue('senha', aux) then
    begin
      if not Assigned(frmMenuModulos) then
        frmMenuModulos := TfrmMenuModulos.Create(Self);

      ValidarLicenca;

      frmMenuModulos.Show;
    end else
    begin
      TDialogService.ShowMessage('Usuário ou senha inválidos.');
    end;
  finally
    UsuarioObj.Free;
  end;
end;

procedure TfrmLogin.lblCadastroClick(Sender: TObject);
begin
  if not Assigned(frmConfiguracoes) then
    frmConfiguracoes := TfrmConfiguracoes.Create(Self);

  frmConfiguracoes.Show;
end;

procedure TfrmLogin.ValidarLicenca;
var
  LicencaObj: TJSONObject;
  aux: String;
begin
  dmConexaoExterna.Rota := 'server/licenca';
  dmconexaoExterna.Metodo := rmGet;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;

  LicencaObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(dmConexaoExterna.RestResponse.Content), 0) as TJSONObject;
  try
    if LicencaObj.GetValue('CNPJCPF').Value = FCNPJCPF then
    begin
      frmMenuModulos.lblNome.Text := LicencaObj.GetValue('EMPRESA').Value;
    end else
    begin
      raise Exception.Create('Sistema não licenciado, entre em contato com o desenvolvedor.');
    end;
  finally
    LicencaObj.Free;
  end;
end;

end.
