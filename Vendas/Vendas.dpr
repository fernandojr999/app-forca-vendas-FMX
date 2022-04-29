program Vendas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uMenuModulos in 'uMenuModulos.pas' {frmMenuModulos},
  uPadrao in 'uPadrao.pas' {frmPadrao},
  uVendas in 'uVendas.pas' {frmVendas},
  uConexaoExterna in 'Conexao\uConexaoExterna.pas' {dmConexaoExterna: TDataModule},
  uCadProdutos in 'Armazem\uCadProdutos.pas' {frmCadProdutos},
  uCadPessoas in 'Pessoas\uCadPessoas.pas' {frmCadPessoas},
  uPedidos in 'Vendas\uPedidos.pas' {frmPedidos},
  uConfiguracao in 'Conexao\uConfiguracao.pas' {frmConfiguracoes},
  uCadCategorias in 'Armazem\uCadCategorias.pas' {frmCategorias},
  uCadUsuarios in 'Pessoas\uCadUsuarios.pas' {frmCadUsuarios},
  uPesquisaPessoa in 'pesquisa\uPesquisaPessoa.pas' {frmPesquisaCliente},
  uCondicoesPagamento in 'financeiro\uCondicoesPagamento.pas' {frmCondicaoPagamento},
  uFormasPagamentos in 'financeiro\uFormasPagamentos.pas' {frmFormasPagamento},
  uPesquisaCondicaoPagamento in 'pesquisa\uPesquisaCondicaoPagamento.pas' {frmPesquisaCondicoesPagamento},
  uPesquisaFormaPagamento in 'pesquisa\uPesquisaFormaPagamento.pas' {frmPadrao4},
  uEmpresa in 'uEmpresa.pas' {frmEmpresa},
  uFMXUtils in 'uFMXUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMenuModulos, frmMenuModulos);
  Application.CreateForm(TfrmPadrao, frmPadrao);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TdmConexaoExterna, dmConexaoExterna);
  Application.CreateForm(TfrmCadProdutos, frmCadProdutos);
  Application.CreateForm(TfrmCadPessoas, frmCadPessoas);
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Application.CreateForm(TfrmCategorias, frmCategorias);
  Application.CreateForm(TfrmCadUsuarios, frmCadUsuarios);
  Application.CreateForm(TfrmPesquisaCliente, frmPesquisaCliente);
  Application.CreateForm(TfrmCondicaoPagamento, frmCondicaoPagamento);
  Application.CreateForm(TfrmFormasPagamento, frmFormasPagamento);
  Application.CreateForm(TfrmPesquisaCondicoesPagamento, frmPesquisaCondicoesPagamento);
  Application.CreateForm(TfrmPadrao4, frmPadrao4);
  Application.CreateForm(TfrmEmpresa, frmEmpresa);
  Application.Run;
end.

