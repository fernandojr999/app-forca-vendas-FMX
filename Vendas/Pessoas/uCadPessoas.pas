unit uCadPessoas;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,

  uPadrao,
  REST.Types,

  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  FMX.EditBox,
  FMX.NumberBox,
  FMX.ListBox,
  FMX.ListView,
  FMX.Edit,
  FMX.TabControl,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type TOrigem = (ocdClientes, ocdFornecedores);

type
  TfrmCadPessoas = class(TfrmPadrao)
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
    tiCadastro: TTabItem;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    Layout5: TLayout;
    lblTela: TLabel;
    Layout15: TLayout;
    Label7: TLabel;
    edtNome: TEdit;
    GridPanelLayout3: TGridPanelLayout;
    Layout9: TLayout;
    Label1: TLabel;
    btnSalvar: TImage;
    Layout10: TLayout;
    Label3: TLabel;
    Image2: TImage;
    Layout11: TLayout;
    Label4: TLabel;
    Image1: TImage;
    Layout7: TLayout;
    Label2: TLabel;
    edtCNPJCPF: TEdit;
    Layout13: TLayout;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Rectangle3: TRectangle;
    Label6: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    Layout6: TLayout;
    Label8: TLabel;
    Edit2: TEdit;
    Layout12: TLayout;
    Label10: TLabel;
    Edit4: TEdit;
    Layout8: TLayout;
    Label9: TLabel;
    Edit3: TEdit;
    ScrollBox1: TScrollBox;
    fdmPessoas: TFDMemTable;
    fdmPessoasID: TIntegerField;
    fdmPessoasNOME: TStringField;
    fdmPessoasTIPO: TIntegerField;
    fdmPessoasCNPJCPF: TStringField;
    fdmPessoasLOGRADOURO: TStringField;
    fdmPessoasCOMPLEMENTO: TStringField;
    fdmPessoasBAIRRO: TStringField;
    fdmPessoasNUMERO: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure lvProdutosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnSalvarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
    FOrigem: TOrigem;
    procedure setOrigem(const Value: TOrigem);
  public
    { Public declarations }
    property Origem: TOrigem read FOrigem write setOrigem;

    procedure AtualizaQuery;
  end;

var
  frmCadPessoas: TfrmCadPessoas;

implementation

{$R *.fmx}

uses uConexaoExterna;

{ TfrmCadPessoas }

procedure TfrmCadPessoas.AtualizaQuery;
begin
  dmConexaoExterna.Rota := 'pessoas/getClientes';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmPessoas, dmConexaoExterna.RestResponse.Content);
  fdmPessoas.Refresh;
end;

procedure TfrmCadPessoas.btnSalvarClick(Sender: TObject);
begin
  inherited;

  fdmPessoasTIPO.AsInteger := 1;

  if fdmPessoas.State in dsEditModes then
  begin
    if Origem = ocdClientes then
      dmConexaoExterna.Rota := 'clientes'
    else
      dmConexaoExterna.Rota := 'fornecedores';

    dmConexaoExterna.PostDataSet(fdmPessoas);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmCadPessoas.btnVoltarClick(Sender: TObject);
begin
  if tcGeral.ActiveTab = tiCadastro then
    tcGeral.Previous()
  else
    Close;
end;

procedure TfrmCadPessoas.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.TabPosition := TTabPosition.None;
  tcGeral.ActiveTab   := tiListView;
end;

procedure TfrmCadPessoas.Image2Click(Sender: TObject);
begin
  inherited;
  dmConexaoExterna.Rota := 'pessoas/deleteCliente';
  dmConexaoExterna.DeleteRegistro(fdmPessoas.FieldByName('ID').AsInteger);
  AtualizaQuery;

  tcGeral.Previous();
end;

procedure TfrmCadPessoas.Image4Click(Sender: TObject);
begin
  inherited;
  tcGeral.Next();
  fdmPessoas.Insert;
end;

procedure TfrmCadPessoas.lvProdutosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  tcGeral.Next;
end;

procedure TfrmCadPessoas.setOrigem(const Value: TOrigem);
begin
  FOrigem := Value;

  if FOrigem = ocdClientes then
    lblTela.Text := 'CLIENTES'
  else
  if FOrigem = ocdFornecedores then
    lblTela.Text := 'FORNECEDORES';
end;

end.
