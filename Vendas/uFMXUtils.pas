unit uFMXUtils;

interface

procedure ToastGravacao;
procedure ToastExclusao;

implementation

procedure ToastGravacao;
begin
  {$IFDEF MSWINDOWS }

  {$ELSE}
    TfgToast.Show('Grava��o conclu�da');
  {$ENDIF}
end;

procedure ToastExclusao;
begin
  {$IFDEF MSWINDOWS }

  {$ELSE}
    TfgToast.Show('Exclus�o conclu�da');
  {$ENDIF}
end;
end.
