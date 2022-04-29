unit uPesquisaCondicaoPagamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Layouts, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.Objects,
  FMX.ListView;

type
  TfrmPesquisaCondicoesPagamento = class(TfrmPadrao)
    Layout1: TLayout;
    lvPessoas: TListView;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Edit1: TEdit;
    Layout4: TLayout;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaCondicoesPagamento: TfrmPesquisaCondicoesPagamento;

implementation

{$R *.fmx}

end.
