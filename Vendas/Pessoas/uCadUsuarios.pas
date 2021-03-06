unit uCadUsuarios;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  REST.Types,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.EditBox,
  FMX.NumberBox, FMX.ListBox, FMX.Objects, FMX.ListView, FMX.Edit,
  FMX.TabControl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmCadUsuarios = class(TfrmPadrao)
    Label5: TLabel;
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
    Layout5: TLayout;
    lblCategoria: TLabel;
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
    fdmUsuarios: TFDMemTable;
    fdmUsuariosID: TIntegerField;
    fdmUsuariosAPELIDO: TStringField;
    fdmUsuariosSENHA: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Layout7: TLayout;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    LinkControlToField2: TLinkControlToField;
    fdmUsuariosNOME: TStringField;
    LinkControlToField1: TLinkControlToField;
    procedure FormCreate(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure lvProdutosItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaQuery;
  end;

var
  frmCadUsuarios: TfrmCadUsuarios;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmCadUsuarios.AtualizaQuery;
begin
  // Get Produtos
  dmConexaoExterna.Rota := 'usuarios/usuarios';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmUsuarios, dmConexaoExterna.RestResponse.Content);
  fdmUsuarios.Refresh;
end;

procedure TfrmCadUsuarios.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmUsuarios.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'usuarios';
    dmConexaoExterna.PostDataSet(fdmUsuarios);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmCadUsuarios.btnVoltarClick(Sender: TObject);
begin
  //inherited;
  if tcGeral.ActiveTab = tiCadastro then
    tcGeral.Previous()
  else
    Close;
end;

procedure TfrmCadUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.ActiveTab := tiListView;
  tcGeral.TabPosition := TTabPosition.None;
end;

procedure TfrmCadUsuarios.Image4Click(Sender: TObject);
begin
  inherited;
  tcGeral.Next;
  fdmUsuarios.Insert;
end;

procedure TfrmCadUsuarios.lvProdutosItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  tcGeral.Next;
end;

end.
