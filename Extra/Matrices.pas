unit Ej1_Matrices;

interface

Uses
  sysutils, Ej1_Vectores, Vcl.Grids;

const
  Min = 0;
  Max = 10;
  cRC = chr(13) + chr(10);

Type
  Matriz = Object
    Private
      Elementos: Array[Min..Max,Min..Max] Of longint;
    Public
      Procedure Inicializar();
      Procedure CargarAlAzar(aDesde, aHasta: Integer);
      Function DiagonalPrincipal(): Vector;
      Function DiagonalOpuesta(): Vector;
      Function SumarMatriz(aM: Matriz): Matriz;
      Function MultiplicarEscalar(aEscalar: Integer): Matriz;
      Function GetItem(afila, aColumna: Integer): LongInt;
      Procedure SetItem(afila, aColumna, Valor: Integer);
      Function RetornarComoStr(): String;
      Procedure Mostrar(var aSG: TStringGrid);
      Function MaximaFila(maxI:integer): Vector;
      Function MaximaColumna(MaxJ:integer): Vector;
  End;

implementation

Procedure Matriz.Inicializar();
Var I,J : Integer;
Begin
  for I := Min to Max do
    for J := Min to Max do
      Elementos[I,J] := 0;
End;

Procedure Matriz.CargarAlAzar(aDesde, aHasta: Integer);
Var I,J : Integer;
Begin
  Randomize;
  for I := Min to Max do
    for J := Min to Max do
      Elementos[I,J] := Random(aHasta-aDesde) + aDesde;
End;

Function Matriz.DiagonalPrincipal(): Vector;
Var I: Integer;
    V: Vector;
Begin
  V.Crear(Max+1);

  for I := min to max do
    V.SetItem(I, Elementos[I,I]);

  DiagonalPrincipal := V;
End;

Function Matriz.DiagonalOpuesta(): Vector;
Var I: Integer;
    V: Vector;
Begin
   V.Crear(max+1);
   for I := min to max do
     V.SetItem(I, Elementos[max-I,I]);
   DiagonalOpuesta := v;
End;

Function Matriz.SumarMatriz(aM: Matriz): matriz;
Var I,J : Integer;
Begin
    for I := min to max do
       for j := min to max do
          Elementos[I,J]:= aM.Elementos[I,J]+Elementos[I,J];
  SumarMatriz.Elementos:=Elementos;
End;

Function Matriz.MultiplicarEscalar(aEscalar: Integer): Matriz;
Var I,J : Integer;
Begin
   for I := min to max do
       for j := min to max do
          Elementos[I,J]:= aEscalar * Elementos[I,J];
  MultiplicarEscalar.Elementos:=Elementos;
End;



Function Matriz.RetornarComoStr(): String;
Var I,J : Integer;
    S: String;
Begin
  S := '';
  for I := Min to Max do  Begin
    for J := Min to Max do
      S :=  S + ' | ' + Elementos[I,J].ToString;
    S := S + cRC;
  End;
  RetornarComoStr := S;
End;


Procedure Matriz.Mostrar(var aSG: TStringGrid);
Var I,J : Integer;
Begin
  aSG.ColCount := Max+1;
  aSG.Rowcount := Max+1;
  for I := Min to Max do  Begin
    for J := Min to Max do
      aSG.Cells[J,I] := Elementos[I,J].ToString;
  End;
End;


Function Matriz.MaximaFila(MaxI:integer): Vector;
Type
VV =array[1..2] of integer;
var I,J,pos,suma:integer;
v:VV;
Begin
   Maximafila.Crear(3);
    for I := min to max do
      begin
      suma:=0;
      for J := min to max do
          begin
          suma:= suma + Elementos[I,J];
          if suma > maxI then
            begin
              maxI := suma;
              pos:=I;
            end;
          end;
      end;
    V[1]:=maxI;
    V[2]:=pos;
    Maximafila.SetItem(1,maxI);
    Maximafila.SetItem(2,pos);
    //maxfila:=maxI;
End;


Function Matriz.MaximaColumna(MaxJ:integer): Vector;
Type
VV =array[1..2] of integer;
var I,J,pos,suma:integer;
v:VV;
Begin
   Maximacolumna.Crear(3);
    for J := min to max do
      begin
      suma:=0;
      for I := min to max do
          begin
          suma:= suma + Elementos[I,J];
          if suma > maxJ then
            begin
              maxJ := suma;
              pos:=J;
            end;
          end;
      end;
    V[1]:=maxJ;
    V[2]:=pos;
    Maximacolumna.SetItem(1,maxJ);
    Maximacolumna.SetItem(2,pos);
    //maxfila:=maxI;
End;

Function Matriz.GetItem(afila, aColumna: Integer): LongInt;
var
I,J : integer;
Begin
  I := afila;
  J := aColumna;
  GetItem := Elementos[I,J] ;
End;

Procedure Matriz.SetItem(afila, aColumna, Valor: Integer);
var
I,J : integer;
Begin
  I := afila;
  J := aColumna;
  Elementos[I,J] := Valor;
End;

end.
