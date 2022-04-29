unit uConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Edit, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmConfiguracoes = class(TfrmPadrao)
    Label5: TLabel;
    Rectangle2: TRectangle;
    Layout6: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    Layout7: TLayout;
    lblPrecoCusto: TLabel;
    Layout8: TLayout;
    Label2: TLabel;
    GridPanelLayout3: TGridPanelLayout;
    Layout9: TLayout;
    Label1: TLabel;
    Image3: TImage;
    Layout10: TLayout;
    Layout11: TLayout;
    Label4: TLabel;
    Image1: TImage;
    edtHost: TEdit;
    edtPorta: TEdit;
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.fmx}

uses uConexaoExterna;

procedure TfrmConfiguracoes.Image3Click(Sender: TObject);
var
  Q: TFDQuery;
begin
  inherited;
  Q := TFDQuery.Create(Nil);
  try
    dmConexaoExterna.Host := edtHost.Text;
    dmConexaoExterna.Porta := edtPorta.Text;

    Q.Connection := dmConexaoExterna.conexaoSQLite;
    Q.SQL.Add('SELECT * FROM CONFIGURACOES');
    Q.Open;

    Q.Edit;
    Q.FieldByName('HOST').AsString := edtHost.Text;
    Q.FieldByName('PORT').AsString := edtPorta.Text;
    Q.Post;
  finally
    Q.Free;
  end;
end;

end.
