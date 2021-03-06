unit uCadCategorias;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  uPadrao,
  Data.DB,

  REST.Types,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  FMX.ListView,
  FMX.Edit,
  FMX.TabControl,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TfrmCategorias = class(TfrmPadrao)
    Layout1: TLayout;
    tcGeral: TTabControl;
    tiListView: TTabItem;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Edit1: TEdit;
    Layout3: TLayout;
    SpeedButton1: TSpeedButton;
    lvProdutos: TListView;
    Image4: TImage;
    tiCadastro: TTabItem;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    Layout6: TLayout;
    lblNomeProduto: TLabel;
    edtNome: TEdit;
    GridPanelLayout3: TGridPanelLayout;
    Layout10: TLayout;
    Label1: TLabel;
    btnSalvar: TImage;
    Layout11: TLayout;
    Label3: TLabel;
    btnExcluir: TImage;
    Layout12: TLayout;
    Label4: TLabel;
    Image1: TImage;
    Label5: TLabel;
    fdmCategorias: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure lvProdutosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaQuery;
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmCategorias.AtualizaQuery;
begin
  // Get Categorias
  dmConexaoExterna.Rota := 'produtos/categoriasprodutos';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmCategorias, dmConexaoExterna.RestResponse.Content);
  fdmCategorias.Open;
  fdmCategorias.Refresh;
end;

procedure TfrmCategorias.btnExcluirClick(Sender: TObject);
begin
  inherited;
  dmConexaoExterna.Rota := 'categoriasprodutos';
  dmConexaoExterna.DeleteRegistro(fdmCategorias.FieldByName('ID').AsInteger);
  AtualizaQuery;

  tcGeral.Previous();
end;

procedure TfrmCategorias.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmCategorias.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'categoriasprodutos';
    dmConexaoExterna.PostDataSet(fdmCategorias);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmCategorias.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.ActiveTab := tiListView;
  tcGeral.TabPosition := TTabPosition.None;
end;

procedure TfrmCategorias.Image4Click(Sender: TObject);
begin
  inherited;
  tcGeral.Next();
  fdmCategorias.Insert;
end;

procedure TfrmCategorias.lvProdutosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  tcGeral.Next();
end;

end.
