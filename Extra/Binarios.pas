unit Ej3_NroBinario;

interface

Uses
  SysUtils, system.Math, Strutils;

Const
  Min = 1;
  Max = 32;

Type
  PunteroBinario = ^NroBinario;
  NroBinario = Object
    Private
      Nro: Array[Min..Max] of byte;
      Function PasarDecimal(): LongInt;
    public
      Procedure CargarNro(aNB: String);
      Function Sumar(aNB: NroBinario): NroBinario;
      Function CambiarBase(Base: Integer): String;
      Function yAnd(aNB: NroBinario): NroBinario;
      Function oOr(aNB: NroBinario): NroBinario;
      Function xXOR(aNB: NroBinario): NroBinario;
      Function RtnStr(): String;
  End;

implementation

Function NroBinario.PasarDecimal(): LongInt;
Var N: Extended;
    I: Integer;
    Base, J: Extended;
    EX: Extended;
Begin
  N:= 0;
  J := 0;
  Base := 2;
  for I := max downto min do begin
    EX := Nro[I];
    N := N + (EX * Power(Base, J));
    J := J + 1;
  end;
  PasarDecimal := N.ToString.ToInteger;
End;


Procedure NroBinario.CargarNro(aNB: String);
Var I, J: Integer;
Begin
  // blanqueo
  for I := Max downto Min do Begin
    Nro[I] := 0;
  End;
  // recorro el string al reves
  I := (aNB.Length);
  J := Max;
  while (I > 0) do Begin
    Nro[J] := StrToInt(aNB[I]);
    Dec(J);
    Dec(I);
  End;
End;

Function NroBinario.Sumar(aNB: NroBinario): NroBinario;
Var  N,N2,Suma: Extended;
Negative:boolean;
s:shortstring;
    I,sumaint: Integer;
    Base, J,J2: Extended;
    EX: Extended;
Begin
  N:= 0;
  J := 0;
  Base := 2;
  for I := max downto min do begin
    EX := Nro[I];
    N := N + (EX * Power(Base, J));
    J := J + 1;
  end;

  N2 := 0;
  J2 := 0;
  Base := 2;
  for I := max downto min do begin
    EX := aNB.Nro[I];
    N2 := N2 + (EX * Power(Base, J2));
    J2 := J2 + 1;
  end;

Suma := N + N2;
  sumaint:= Trunc(suma);
  if sumaint<0 then Negative:=True;
  sumaint:=Abs(sumaint);
  for i:=1 to SizeOf(sumaint)*8 do
  begin
    if sumaint<0 then S:=S+'1'
    else S:=S+'0';
    sumaint:=sumaint shl 1;
  end;
  Delete(S,1,Pos('1',S)-1);
  if Negative = true then S:='-'+S;
  Sumar.CargarNro(S);

End;


// Funcion interna a la implementacion
Function Hexa(S: String): String;
Begin
  if S.ToInteger() < 10 then
    Hexa := S
  Else
    Hexa := chr(55 + S.ToInteger());
End;

Function NroBinario.CambiarBase(Base: Integer): String;
Var ND: LongInt;
    S: String;
  // Hace el cambio de base
  Function CB(aNDec: LongInt; aBase:Integer): String;
  Begin
    if aNdec <  Base then
      CB :=  Hexa(aNdec.ToString)
    Else
      CB := CB((aNdec Div Base), aBase) + Hexa((aNdec Mod Base).ToString);
  End;
// Mascara para llamar a la interna
Begin
  ND := PasarDecimal();
  S := CB(ND, Base);
  CambiarBase := S;
End;


Function NroBinario.yAnd(aNB: NroBinario): NroBinario;
Var I: Integer;
    B: NroBinario;
Begin
   for I := 1 to 32 do Begin
      if (Nro[I] = 1) And (aNB.Nro[I] = 1) then
        B.Nro[I] := 1
      Else
        B.Nro[I] := 0;
  End;
  YAnd := B;
End;

Function NroBinario.oOr(aNB: NroBinario): NroBinario;
Var I: Integer;
    B: NroBinario;
Begin
   for I := 1 to 32 do Begin
    if (Nro[I] = 1) Or (aNB.Nro[I] = 1) then
      B.Nro[I] := 1
    Else
      B.Nro[I] := 0;
  End;
  oOr := B;
End;

Function NroBinario.xXOR(aNB: NroBinario): NroBinario;
Var I: Integer;
    B: NroBinario;
Begin
   for I := 1 to 32 do Begin
    if (Nro[I] = 1) And (aNB.Nro[I] = 1) then
      B.Nro[I] := 0
    else
    if (Nro[I] = 1) Or (aNB.Nro[I] = 1) then
      B.Nro[I] := 1
    Else
      B.Nro[I] := 0;
  End;
  xXor := B;
End;

Function NroBinario.RtnStr(): String;
Var I: Integer;
    S: String;
Begin
  S := '';
  for I := Min to Max do Begin
    S := S + IntToStr(Nro[I]);
  End;
  RtnStr := S;
End;

end.

