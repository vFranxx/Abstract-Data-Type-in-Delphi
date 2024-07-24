unit Ej1_Vectores;

interface

Uses
  sysutils;

const
  MaximoDelVector = 2000;

Type
  Vector = Object
    Private
      Elementos: Array of LongInt;
      Size: Integer;
    Public
      Function Crear(aSize: Integer): Boolean;
      Procedure CargarAlAzar(aDesde, aHasta: Integer);
      Function Promedio(): Double;
      Function Maximo(Var aPosicion: Integer): LongInt;
      Function Minimo(Var aPosicion: Integer): LongInt;
      Function Buscar(aValor: LongInt): Integer;
      Function SumarVector(aV: Vector): Vector;
      Function MultiplicarEscalar(aEscalar: Integer): Vector;
      Function GetItem(aPosicion: Integer): LongInt;
      Procedure SetItem(aPosicion, Valor: Integer);
      Function RetornarComoStr(aSep: String): String;
  End;

implementation


Function Vector.Crear(aSize: Integer): Boolean;
Begin
  if aSize > MaximoDelVector then
    Crear := False
  Else Begin
    SetLength(Elementos, aSize);
    Size := aSize;
    Crear := True;
  End;
End;


Procedure Vector.CargarAlAzar(aDesde: Integer; aHasta: Integer);
Var I: Integer;
    Valor: Integer;
Begin
  Randomize;
  for I := 0 to Size-1 do Begin
    Valor := Random(aHasta - aDesde) + aDesde;
    //if Buscar(Valor) = -1 then Elementos[I] := Valor;
    Elementos[I] := Valor;
  End;
End;

Function vector.Promedio: Double;
Var I: Integer;
    Suma: Double;
Begin
  Suma := 0;
  for I := 0 to Size-1 do Begin
    Suma := Suma + Elementos[I];
  End;
  Promedio := (Suma/Size);
End;


Function vector.Maximo(Var aPosicion: Integer): LongInt;
Var I: Integer;
    Max: LongInt;
Begin
  Max := Elementos[0];
  for I := 0 to Size-1 do Begin
    If Elementos[I] > Max Then Begin
      Max := Elementos[I];
      aPosicion := I;
    End;
  End;
  Maximo := Max;
End;


Function vector.Minimo(Var aPosicion: Integer): LongInt;
var I: Integer;
  Min: Longint;
Begin
    Min := Elementos[0];
    aPosicion := 0;
    for I := 0 to size-1 do begin
       if Elementos[I] < MIN then begin
           Min := Elementos[I];
           aPosicion := I;
       end;
    end;
   Minimo := Min;
End;


Function vector.Buscar(aValor: LongInt): Integer;
var
  I,post: Integer;
Begin
   post:= -1;
   for I := 0 to Size - 1 do
      begin
        if aValor = Elementos[I] then
          begin
            post := I;
          end
      end;
    Buscar:= post;
End;


Function vector.SumarVector(aV: Vector): Vector;
Var VS: Vector;
    I: Integer;
Begin
  VS.Crear(Size);
  if Size = aV.Size then Begin
    for I := 0 to Size-1 do Begin
      VS.Elementos[I] := Elementos[I] + aV.Elementos[I];
    End;
  End;
  SumarVector := VS;
End;


Function vector.MultiplicarEscalar(aEscalar: Integer): Vector;
var I,N: integer;
    VM: Vector;
Begin
   VM.Crear(Size);
      for I := 0 to Size-1 do begin
           VM.Elementos[I]:= Elementos[I] * aEscalar;
      end;
  MultiplicarEscalar := VM;
End;


Function vector.GetItem(aPosicion: Integer): LongInt;
Begin
  if aPosicion < Size then
    GetItem := elementos[aPosicion]
  Else
    GetItem := -1;
End;


Procedure vector.SetItem(aPosicion, Valor: Integer);
Begin
  if aPosicion < Size then
    elementos[aPosicion] := Valor;
End;


Function vector.RetornarComoStr(aSep: String): String;
Var S: String;
    I: Integer;
Begin
  S := '';
  for I := 0 to Size-1 do Begin
    S := S + Elementos[I].ToString + aSep;
  End;
  RetornarComoStr := S;
End;

end.
