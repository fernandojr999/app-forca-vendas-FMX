unit uFMXUtils;

interface

procedure ToastGravacao;
procedure ToastExclusao;

implementation

procedure ToastGravacao;
begin
  {$IFDEF MSWINDOWS }

  {$ELSE}
    TfgToast.Show('Gravação concluída');
  {$ENDIF}
end;

procedure ToastExclusao;
begin
  {$IFDEF MSWINDOWS }

  {$ELSE}
    TfgToast.Show('Exclusão concluída');
  {$ENDIF}
end;
end.
