object dmConexaoExterna: TdmConexaoExterna
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 244
  Width = 417
  object restClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:3000/admin/produtosApp'
    ContentType = 'application/json'
    Params = <>
    Left = 40
    Top = 16
  end
  object restRequest: TRESTRequest
    Client = restClient
    Params = <>
    Response = restResponse
    SynchronizedEvents = False
    Left = 160
    Top = 16
  end
  object restResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 40
    Top = 80
  end
  object conexaoSQLite: TFDConnection
    Params.Strings = (
      'Database=C:\Delphi\Projetos\Vendas\database\banco.s3db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 160
    Top = 80
  end
end
