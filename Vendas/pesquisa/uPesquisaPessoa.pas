unit uPesquisaPessoa;

interface

uses
  System.SysUtils, REST.Types, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FMX.Edit, FMX.Objects, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmPesquisaCliente = class(TfrmPadrao)
    Label1: TLabel;
    lvPessoas: TListView;
    fdmPessoa: TFDMemTable;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Edit1: TEdit;
    Layout4: TLayout;
    SpeedButton1: TSpeedButton;
    fdmPessoaID: TIntegerField;
    fdmPessoaNOME: TStringField;
    fdmPessoaCNPJCPF: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure lvPessoasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    FMemTable: TFDMemTable;
  public
    { Public declarations }
    procedure AtualizaQuery;

    property MemTable: TFDMemTable read FMemTable write FMemTable;
  end;

var
  frmPesquisaCliente: TfrmPesquisaCliente;

implementation

{$R *.fmx}

uses uConexaoExterna, uPedidos;

{ TfrmPadrao1 }

procedure TfrmPesquisaCliente.AtualizaQuery;
begin
  dmConexaoExterna.Rota := 'clientes';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmPessoa, dmConexaoExterna.RestResponse.Content);
  fdmPessoa.Refresh;
end;

procedure TfrmPesquisaCliente.lvPessoasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  frmPedidos.fdmPedidos.FieldByName('PESSOA').AsInteger := fdmPessoaID.AsInteger;
  frmPedidos.edtNomeCliente.Text := fdmPessoaNOME.AsString;

  Close;
end;

end.
