unit uEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FMX.Edit, REST.Types, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmEmpresa = class(TfrmPadrao)
    sbGeral: TScrollBox;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Layout4: TLayout;
    lblCategoria: TLabel;
    Layout5: TLayout;
    lblNomeProduto: TLabel;
    edtNome: TEdit;
    Layout6: TLayout;
    GridPanelLayout3: TGridPanelLayout;
    Layout9: TLayout;
    Label1: TLabel;
    btnSalvar: TImage;
    Layout11: TLayout;
    Label4: TLabel;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label5: TLabel;
    fdmEmpresa: TFDMemTable;
    fdmEmpresaNOME: TStringField;
    fdmEmpresaCNPJCPF: TStringField;
    fdmEmpresaID: TIntegerField;
    fdmEmpresaAPELIDO: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

    procedure Atualiza;
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

{$R *.fmx}

uses uConexaoExterna;

{ TfrmEmpresa }

procedure TfrmEmpresa.Atualiza;
begin
  // Get Empresa
  dmConexaoExterna.Rota := 'empresa/empresa';
  dmconexaoExterna.Metodo := rmGET;
  dmConexaoExterna.restRequest.Params.Clear;
  dmConexaoExterna.Executar;
  dmConexaoExterna.JSONToDataSet(fdmEmpresa, dmConexaoExterna.RestResponse.Content);
  fdmEmpresa.Refresh;
end;

procedure TfrmEmpresa.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if fdmEmpresa.State in dsEditModes then
  begin
    dmConexaoExterna.Rota := 'empresa/salvar';
    dmConexaoExterna.PostDataSet(fdmEmpresa);
    Atualiza;
  end;
end;

end.
