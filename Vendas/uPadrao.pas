unit uPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,FMX.DialogService,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TfrmPadrao = class(TForm)
    tbControle: TToolBar;
    btnVoltar: TSpeedButton;
    ltGeral: TLayout;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.fmx}

uses uUtils;

procedure TfrmPadrao.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
