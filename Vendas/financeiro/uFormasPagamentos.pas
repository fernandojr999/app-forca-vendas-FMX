unit uFormasPagamentos;

interface

uses
  System.SysUtils, System.Types, REST.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.EditBox,
  FMX.NumberBox, FMX.Objects, FMX.ListView, FMX.Edit, FMX.TabControl,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmFormasPagamento = class(TfrmPadrao)
    Label5: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    tcGeral: TTabControl;
    tiListView: TTabItem;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Edit1: TEdit;
    Layout5: TLayout;
    SpeedButton1: TSpeedButton;
    lvProdutos: TListView;
    Image4: TImage;
    tiCadastro: TTabItem;
    Layout6: TLayout;
    Rectangle2: TRectangle;
    Layout7: TLayout;
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
    Layout8: TLayout;
    Label2: TLabel;
    NumberBox1: TNumberBox;
    fdmFormasPagamento: TFDMemTable;
    fdmFormasPagamentoID: TIntegerField;
    fdmFormasPagamentoNOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaQuery;
  end;

var
  frmFormasPagamento: TfrmFormasPagamento;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmFormasPagamento.AtualizaQuery;
begin
  dmConexaoExterna.Rota := 'formaspagamento';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmFormasPagamento, dmConexaoExterna.RestResponse.Content);
  fdmFormasPagamento.Open;
  fdmFormasPagamento.Refresh;
end;

procedure TfrmFormasPagamento.btnExcluirClick(Sender: TObject);
begin
  inherited;
  dmConexaoExterna.Rota := 'formaspagamento';
  dmConexaoExterna.DeleteRegistro(fdmFormasPagamentoID.AsInteger);
  AtualizaQuery;

  tcGeral.Previous();
end;

procedure TfrmFormasPagamento.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmFormasPagamento.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'formaspagamento';
    dmConexaoExterna.PostDataSet(fdmFormasPagamento);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmFormasPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.ActiveTab := tiListView;
  tcGeral.TabPosition := TTabPosition.None;
end;

procedure TfrmFormasPagamento.Image1Click(Sender: TObject);
begin
  inherited;
  fdmFormasPagamento.Cancel;
  tcGeral.Previous;
end;

procedure TfrmFormasPagamento.Image4Click(Sender: TObject);
begin
  inherited;
  fdmFormasPagamento.Insert;
  tcGeral.Next;
end;

end.
