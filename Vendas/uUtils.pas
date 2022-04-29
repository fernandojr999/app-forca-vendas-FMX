unit uUtils;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,

  FMX.ImgList,
  FMX.Types,
  FMX.Controls, Vcl.ImgList, Vcl.Controls;

procedure Toast;

type
  TDataModule1 = class(TDataModule)
    imagens: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DataModule1: TDataModule1;

implementation

procedure Toast;
begin

end;
{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.

