unit uCadProdutos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.JSON,
  System.Classes,
  System.Variants,
  REST.JSON,
  REST.Types,

  FMX.DialogService,

  REST.Response.Adapter,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Objects, FMX.Edit,
  FMX.ListView, FMX.TabControl, FMX.EditBox, FMX.NumberBox, FMX.ListBox, Data.DB,
  Datasnap.DBClient,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.DBScope;

type
  TfrmCadProdutos = class(TfrmPadrao)
    tcGeral: TTabControl;
    tiListView: TTabItem;
    tiCadastro: TTabItem;
    Layout1: TLayout;
    lvProdutos: TListView;
    Edit1: TEdit;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Layout2: TLayout;
    SpeedButton1: TSpeedButton;
    Layout3: TLayout;
    Layout4: TLayout;
    edtNome: TEdit;
    Rectangle2: TRectangle;
    lblNomeProduto: TLabel;
    Layout5: TLayout;
    lblCategoria: TLabel;
    cmbCategoria: TComboBox;
    Layout6: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    lblPrecoCusto: TLabel;
    Label2: TLabel;
    edtPrecoCusto: TNumberBox;
    edtPrecoVenda: TNumberBox;
    GridPanelLayout3: TGridPanelLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    btnExcluir: TImage;
    btnSalvar: TImage;
    Label5: TLabel;
    fdmProdutos: TFDMemTable;
    fdmProdutosID: TIntegerField;
    fdmProdutosNOME: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    fdmCategorias: TFDMemTable;
    fdmCategoriasID: TIntegerField;
    fdmCategoriasNOME: TStringField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    Image4: TImage;
    ScrollBox1: TScrollBox;
    Layout12: TLayout;
    Label6: TLabel;
    edtSaldo: TNumberBox;
    fdmProdutosCATEGORIA: TIntegerField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvProdutosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnVoltarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private

  public
    { Public declarations }
    procedure AtualizaQuery;
  end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmCadProdutos.AtualizaQuery;
begin
  // Get Produtos
  dmConexaoExterna.Rota := 'produtos/produtos';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmProdutos, dmConexaoExterna.RestResponse.Content);
  fdmProdutos.Refresh;

  // Get Categorias
  dmConexaoExterna.Rota := 'produtos/categoriasprodutos';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmCategorias, dmConexaoExterna.RestResponse.Content);
  fdmCategorias.Open;
  fdmCategorias.Refresh;
end;

procedure TfrmCadProdutos.btnExcluirClick(Sender: TObject);
begin
  inherited;
  dmConexaoExterna.Rota := 'produtos/produtodelete';
  dmConexaoExterna.DeleteRegistro(fdmProdutos.FieldByName('ID').AsInteger);
  AtualizaQuery;

  tcGeral.Previous();
end;

procedure TfrmCadProdutos.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmProdutos.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'produtos/salvar';
    dmConexaoExterna.PostDataSet(fdmProdutos);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmCadProdutos.btnVoltarClick(Sender: TObject);
begin
  //inherited;
  if tcGeral.ActiveTab = tiCadastro then
    tcGeral.Previous()
  else
    Close;
end;

procedure TfrmCadProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.TabPosition := TTabPosition.None;
  tcGeral.ActiveTab   := tiListView;
end;

procedure TfrmCadProdutos.Image4Click(Sender: TObject);
begin
  inherited;
  tcGeral.Next();
  fdmProdutos.Insert;
end;

procedure TfrmCadProdutos.lvProdutosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  tcGeral.Next;
end;

procedure TfrmCadProdutos.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  AtualizaQuery;
end;

end.
