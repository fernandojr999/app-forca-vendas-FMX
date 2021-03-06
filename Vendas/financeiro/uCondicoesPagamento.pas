unit uCondicoesPagamento;

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
  TfrmCondicaoPagamento = class(TfrmPadrao)
    Label5: TLabel;
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
    Image4: TImage;
    tiCadastro: TTabItem;
    Layout5: TLayout;
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
    Layout7: TLayout;
    Label2: TLabel;
    NumberBox1: TNumberBox;
    fdmCondicoesPagamento: TFDMemTable;
    fdmCondicoesPagamentoID: TIntegerField;
    fdmCondicoesPagamentoNOME: TStringField;
    fdmCondicoesPagamentoQTDPARCELAS: TIntegerField;
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
  frmCondicaoPagamento: TfrmCondicaoPagamento;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmCondicaoPagamento.AtualizaQuery;
begin
  dmConexaoExterna.Rota := 'condicoespagamento';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmCondicoesPagamento, dmConexaoExterna.RestResponse.Content);
  fdmCondicoesPagamento.Open;
  fdmCondicoesPagamento.Refresh;
end;

procedure TfrmCondicaoPagamento.btnExcluirClick(Sender: TObject);
begin
  inherited;
  dmConexaoExterna.Rota := 'condicoespagamento';
  dmConexaoExterna.DeleteRegistro(fdmCondicoesPagamentoID.AsInteger);
  AtualizaQuery;

  tcGeral.Previous();
end;

procedure TfrmCondicaoPagamento.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmCondicoesPagamento.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'condicoespagamento';
    dmConexaoExterna.PostDataSet(fdmCondicoesPagamento);
    AtualizaQuery;
  end;
  tcGeral.Previous();
end;

procedure TfrmCondicaoPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  tcGeral.ActiveTab := tiListView;
  tcGeral.TabPosition := TTabPosition.None;
end;

procedure TfrmCondicaoPagamento.Image1Click(Sender: TObject);
begin
  inherited;
  fdmCondicoesPagamento.Cancel;
  tcGeral.Previous;
end;

procedure TfrmCondicaoPagamento.Image4Click(Sender: TObject);
begin
  inherited;
  tcGeral.Next;
  fdmCondicoesPagamento.Insert;
end;

end.
