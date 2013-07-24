unit UnitRegistroUtils;

interface

uses
  SysUtils,
  StrUtils;

  // Campos que representam n�meros inteiros no leiaute
  // s�o preechidos com zeros a esquerda
  function Formatar(const ACampo: Integer; const ATamanho: Integer): string; overload;

  //  Campos do tipo texto s�o preechidos com espa�os a direita
  function Formatar(const ACampo: string;  const ATamanho: Integer): string; overload;

  //  Campos que representam valores monet�rios devem ser preenchidos com
  //  zeros a esquerda e n�o deve ser inlclu�do o separador decimal
  function Formatar(const ACampo: Currency;  const ATamanho: Integer;
    const ACasasDecimais: Byte): string; overload;

  //  Campos do tipo data s�o representados no formato DDMMAAAA
  function Formatar(const ACampo: TDate): string; overload;

  // Campos do tipo hora s�o representados no formato HHMMSS
  function Formatar(const ACampo: TTime): string; overload;

  function IncluirCaracteresEsq(const AStringOrigem: string;
    const AQuantidadeC: Integer; const ACaractere: Char = ' '): string;

  function IncluirCaracteresDir(const AStringOrigem: string;
    const AQuantidadeC: Integer; const ACaractere: Char = ' '): string;

  function IncluirZerosDir(const AValor: string; AQuantidade: Integer): string;

  function FiltrarNumeros(const ATexto: string): string;

const
  SEPARADOR = '|';

resourcestring
  RSVersaoRegistroNaoDefinida = 'Vers�o do registro %s n�o definida';

implementation

function FiltrarNumeros(const ATexto: string): string;
var
  cChar: Char;
begin
  Result:= '';
  for cChar  in ATexto do
  begin
    if (cChar in ['0'..'9']) then
      Result:= Result + cChar
  end;

end;

function IncluirCaracteresEsq(const AStringOrigem: string;
  const AQuantidadeC: Integer; const ACaractere: Char = ' '): string;
begin
  Result:=
    AStringOrigem + StringOfChar(ACaractere,  AQuantidadeC - Length(AStringOrigem));
end;

function IncluirCaracteresDir(const AStringOrigem: string;
  const AQuantidadeC: Integer; const ACaractere: Char = ' '): string;
begin
  Result:=
    StringOfChar(ACaractere, AQuantidadeC - Length(AStringOrigem)) +
      AStringOrigem;
end;

function IncluirZerosDir(const AValor: string; AQuantidade: Integer): string;
begin
  Result:= IncluirCaracteresDir(AValor, AQuantidade, '0');
end;

function Formatar(const ACampo: Integer; const ATamanho: Integer): string;
begin
  Result:= IncluirZerosDir( IntToStr( ACampo ) , ATamanho);
end;

function Formatar(const ACampo: string; const ATamanho: Integer): string;
begin
  Result:= IncluirCaracteresEsq(ACampo, ATamanho, ' ');
end;

function Formatar(const ACampo: Currency;  const ATamanho: Integer;
  const ACasasDecimais: Byte): string; overload;
begin
  Result:= FiltrarNumeros(IncluirZerosDir(
    FloatToStrF(ACampo, ffFixed, 18, ACasasDecimais), ATamanho));
end;

function Formatar(const ACampo: TDate): string; overload;
begin
  Result:= FormatDateTime('ddmmyyyy', ACampo);
end;

function Formatar(const ACampo: TTime): string; overload;
begin
  Result:= FormatDateTime('hhmmss', ACampo)
end;

end.
