unit uPedidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, REST.Types, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Objects,
  FMX.EditBox, FMX.NumberBox, FMX.ListBox, FMX.ListView, FMX.Edit,
  FMX.TabControl, FMX.DateTimeCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type TSituacaoPedido = (sitCadastrado, sitConfirmado, sitCancelado);

type
  TfrmPedidos = class(TfrmPadrao)
    Layout1: TLayout;
    Layout2: TLayout;
    tcGeral: TTabControl;
    tiListView: TTabItem;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Edit1: TEdit;
    Layout4: TLayout;
    SpeedButton1: TSpeedButton;
    lvProdutos: TListView;
    tiCadastro: TTabItem;
    lblTela: TLabel;
    tcPedido: TTabControl;
    tiCadastroPedido: TTabItem;
    tiPedidoItens: TTabItem;
    Layout5: TLayout;
    Rectangle2: TRectangle;
    Layout7: TLayout;
    lblNomeProduto: TLabel;
    Layout8: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout9: TLayout;
    lblPrecoCusto: TLabel;
    GridPanelLayout3: TGridPanelLayout;
    Layout11: TLayout;
    Label1: TLabel;
    Image3: TImage;
    Layout12: TLayout;
    Label3: TLabel;
    btnExcluir: TImage;
    Layout13: TLayout;
    Label4: TLabel;
    btnCancelar: TImage;
    GridPanelLayout4: TGridPanelLayout;
    Layout6: TLayout;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
    Layout10: TLayout;
    Label5: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    Layout14: TLayout;
    Label6: TLabel;
    Edit2: TEdit;
    tcItens: TTabControl;
    tiListaItens: TTabItem;
    tiCadastroItens: TTabItem;
    ListView1: TListView;
    ScrollBox2: TScrollBox;
    Rectangle3: TRectangle;
    Layout15: TLayout;
    lblProduto: TLabel;
    Edit3: TEdit;
    Layout16: TLayout;
    GridPanelLayout5: TGridPanelLayout;
    Layout17: TLayout;
    Label8: TLabel;
    GridPanelLayout6: TGridPanelLayout;
    Layout18: TLayout;
    Label9: TLabel;
    Image4: TImage;
    Layout19: TLayout;
    Label10: TLabel;
    Image5: TImage;
    Layout20: TLayout;
    Label11: TLabel;
    Image6: TImage;
    Layout23: TLayout;
    Label14: TLabel;
    Edit4: TEdit;
    Layout24: TLayout;
    Label7: TLabel;
    NumberBox1: TNumberBox;
    NumberBox2: TNumberBox;
    GridPanelLayout7: TGridPanelLayout;
    Layout21: TLayout;
    Label12: TLabel;
    btnConfirmar: TImage;
    Layout22: TLayout;
    Label13: TLabel;
    btnCancelarPedido: TImage;
    Layout25: TLayout;
    fdmPedidos: TFDMemTable;
    fdmItens: TFDMemTable;
    Image9: TImage;
    fdmPedidosID: TIntegerField;
    fdmPedidosPESSOA: TIntegerField;
    fdmPedidosDATAHORA: TDateTimeField;
    fdmPedidosDATA: TDateField;
    fdmPedidosVALORTOTAL: TFloatField;
    fdmPedidosSITUACAO: TIntegerField;
    GridPanelLayout8: TGridPanelLayout;
    Layout26: TLayout;
    Layout27: TLayout;
    edtNomeCliente: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AjustaSituacao;
    function StrToSituacao(value: String): TSituacaoPedido;
  public
    { Public declarations }
    procedure AtualizaQuery;
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.fmx}
uses uConexaoExterna, uPesquisaPessoa;

procedure TfrmPedidos.AjustaSituacao;
begin
  btnExcluir.Enabled := StrToSituacao(fdmPedidos.FieldByName('SITUACAO').AsString) = sitCadastrado;
end;

procedure TfrmPedidos.AtualizaQuery;
begin
  // Get Pedidos
  dmConexaoExterna.Rota := 'pedidos';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmPedidos, dmConexaoExterna.RestResponse.Content);
  fdmPedidos.Refresh;
end;

procedure TfrmPedidos.Button1Click(Sender: TObject);
begin
  inherited;
  if not Assigned(frmPesquisaCliente) then
    frmPesquisaCliente := TfrmPesquisaCliente.Create(Nil);

  frmPesquisaCliente.AtualizaQuery;
  frmPesquisaCliente.Show;
end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.TabPosition := TTabPosition.None;
  tcGeral.ActiveTab   := tiListView;

  tcItens.TabPosition := TTabPosition.None;
  tcItens.ActiveTab   := tiListaItens;
end;

procedure TfrmPedidos.Image3Click(Sender: TObject);
begin
  inherited;
  if fdmPedidos.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'pedidos';
    dmConexaoExterna.PostDataSet(fdmPedidos);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmPedidos.Image9Click(Sender: TObject);
begin
  inherited;
  fdmPedidos.Insert;
  tcGeral.Next;
end;

function TfrmPedidos.StrToSituacao(value: String): TSituacaoPedido;
begin
  if value = '1' then
    Result := sitCadastrado
  else
  if value = '2' then
    Result := sitConfirmado
  else
    Result := sitCancelado;
end;

end.
