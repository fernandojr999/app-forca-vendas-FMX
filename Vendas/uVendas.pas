unit uVendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.TabControl, uUtils,
  FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Chart, FMX.ListBox;

type
  TfrmVendas = class(TfrmPadrao)
    ListBox1: TListBox;
    lbiPedidos: TListBoxItem;
    lbiOrcamentos: TListBoxItem;
    lbiEmissorNFCe: TListBoxItem;
    lblTela: TLabel;
    procedure lbiPedidosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.fmx}

uses uPedidos;

procedure TfrmVendas.lbiPedidosClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmPedidos) then
    frmPedidos := TfrmPedidos.Create(Self);

  frmPedidos.AtualizaQuery;
  frmPedidos.Show;
end;

end.
