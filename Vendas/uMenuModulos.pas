unit uMenuModulos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.MultiView, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation;

type
  TfrmMenuModulos = class(TForm)
    ScrollBox1: TScrollBox;
    ToolBar1: TToolBar;
    btnMultiview: TSpeedButton;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    mvMenu: TMultiView;
    ListBox1: TListBox;
    lbiClientes: TListBoxItem;
    Layout4: TLayout;
    btnVendas: TButton;
    Button1: TButton;
    Button2: TButton;
    lbiFornecedores: TListBoxItem;
    lbiFuncionarios: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    lbiCategorias: TListBoxItem;
    lbiEntradaSaida: TListBoxItem;
    lbghPessoas: TListBoxGroupHeader;
    lbghProdutos: TListBoxGroupHeader;
    lbghParametros: TListBoxGroupHeader;
    lbiEmpresa: TListBoxItem;
    lbiUsuarios: TListBoxItem;
    Button3: TButton;
    lblNome: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure lbiClientesClick(Sender: TObject);
    procedure lbiFornecedoresClick(Sender: TObject);
    procedure lbiCategoriasClick(Sender: TObject);
    procedure lbiUsuariosClick(Sender: TObject);
    procedure lbiEmpresaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuModulos: TfrmMenuModulos;

implementation

{$R *.fmx}

uses uVendas, uCadProdutos, uCadPessoas, uCadCategorias, uCadUsuarios, uEmpresa;

procedure TfrmMenuModulos.btnVendasClick(Sender: TObject);
begin
  frmVendas.Show;
end;

procedure TfrmMenuModulos.FormCreate(Sender: TObject);
begin
  lbiFornecedores.Visible := False;
  lbiFuncionarios.Visible := False;
  mvMenu.Mode := TMultiViewMode.Drawer;
end;

procedure TfrmMenuModulos.lbiCategoriasClick(Sender: TObject);
begin
  if not(Assigned(frmCategorias)) then
     frmCategorias := TfrmCategorias.Create(Self);

  frmCategorias.AtualizaQuery;
  frmCategorias.Show;
end;

procedure TfrmMenuModulos.lbiClientesClick(Sender: TObject);
begin
  if not Assigned(frmCadPessoas) then
    frmCadPessoas := tfrmCadPessoas.Create(Self);

  frmCadPessoas.Origem := ocdClientes;
  frmCadPessoas.AtualizaQuery;
  frmCadPessoas.Show;
end;

procedure TfrmMenuModulos.lbiEmpresaClick(Sender: TObject);
begin
  if not Assigned(frmEmpresa) then
    frmEmpresa := TfrmEmpresa.Create(Self);

  frmEmpresa.Atualiza;
  frmEmpresa.Show;
end;

procedure TfrmMenuModulos.lbiFornecedoresClick(Sender: TObject);
begin
  if not Assigned(frmCadPessoas) then
    frmCadPessoas := tfrmCadPessoas.Create(Self);

  frmCadPessoas.Origem := ocdFornecedores;
  frmCadPessoas.Show;
end;

procedure TfrmMenuModulos.lbiUsuariosClick(Sender: TObject);
begin
  if not(Assigned(frmCadUsuarios)) then
     frmCadUsuarios := TfrmCadUsuarios.Create(Self);

  frmCadUsuarios.AtualizaQuery;
  frmCadUsuarios.Show;
end;

procedure TfrmMenuModulos.ListBoxItem4Click(Sender: TObject);
begin
  if not(Assigned(frmCadProdutos)) then
     frmCadProdutos := TfrmCadProdutos.Create(Self);

  frmCadProdutos.AtualizaQuery;
  frmCadProdutos.Show;
end;

end.
