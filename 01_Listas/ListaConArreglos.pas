unit ListaConArreglos;

interface

Uses
  Tipos, SysUtils;

Const
  Nulo = 0;      // Abstraccion de una posicion NO valida de la lista
  Min = 1;
  Max = 2000;

Type

  PosicionLista = Integer;

  Lista = Object
    Private
      Items: Array Of TipoElemento;     // Dinamico
      Inicio, Final: PosicionLista;     // Las banderas de Inicio y Fin de la lista
      Size: Integer;
      Cantidad: Integer;
      TDC: TipoDatosClave;
    Public
      Function Crear(aTDC:TipoDatosClave; aSize:Integer):RdoOperaciones;
      Function Agregar(X: TipoElemento):RdoOperaciones;
      Function Insertar(X: TipoElemento; PosOrdinal: Integer): RdoOperaciones;
      Function Eliminar(PosOrdinal: Integer):RdoOperaciones;
      Function EsVacia(): Boolean;
      Function EsLlena(): Boolean;
      Function Recuperar(PosOrdinal: Integer):TipoElemento;
      Function RtnAsString(): String;
      Function Anterior(P: PosicionLista): PosicionLista;
      Function Siguiente(P: PosicionLista): PosicionLista;
      Function Buscar(aClave: Variant): Integer;  // retorna la posicion Ordinal de la primer ocurrencia
      Function nSize(): Integer;
      Function TipoDatoClave():TipoDatosClave;
      Function Comienzo(): PosicionLista;
      Function Fin(): PosicionLista;
      Function CantidadElementos(): Integer;
  End;


implementation

Function Lista.Crear(aTDC:TipoDatosClave; aSize:Integer):RdoOperaciones;
Begin
  if (aSize >= Min) And (aSize <= Max) then Begin
    SetLength(Items, aSize + 1);
    Size := aSize;
    TDC := aTDC;
    Cantidad := 0;
    Inicio := Nulo;
    Final :=  NUlo;
    Crear := OK;
  End
  Else
    Crear := CError;
End;

Function Lista.EsVacia(): Boolean;
Begin
  EsVacia := (Inicio = Nulo);
End;

Function Lista.EsLlena(): Boolean;
Begin
  EsLlena := (Cantidad = Size);
End;

Function Lista.Agregar(X: TipoElemento):RdoOperaciones;
Begin
  if EsLlena() then Agregar := LLena
  Else Begin
    if X.TipoDatoClave(X.Clave) = TDC then Begin
      Inc(Final);
      Items[Final] := X;
      Inc(cantidad);
      if EsVacia() then Inicio := Final;
      Agregar := OK;
    End
    Else Agregar := ClaveIncompatible;
  End;
End;

Function Lista.Insertar(X: TipoElemento; PosOrdinal: Integer): RdoOperaciones;
Var I: Integer;
Begin
  // Lista llena
  if EsLlena() then Begin
    Insertar := LLena;
    Exit;
  End;
  // Clave compatible
  if X.TipoDatoClave(X.Clave) <> TDC Then Begin
    Insertar := ClaveIncompatible;
    Exit;
  End;
  // Posicion Validad
  if (PosOrdinal < Inicio) Or (PosOrdinal > Final) Then Begin
    Insertar := PosicionInvalida;
    Exit;
  End;

  // Ahora si lo podemos insertar
  for I := Final Downto PosOrdinal do Begin
    Items[I+1] := Items[I];
  End;

  // Asigno el Dato
  Items[PosOrdinal] := X;
  Inc(Cantidad);
  Inc(Final);
  Insertar := OK;
End;


Function Lista.Eliminar(PosOrdinal: Integer):RdoOperaciones;
Var I: Integer;
Begin
  // Lista Vacia
  if EsVacia() then Begin
    Eliminar := Vacia;
    Exit;
  End;
  // Posicion Validad
  if (PosOrdinal < Inicio) Or (PosOrdinal > Final) Then Begin
    Eliminar := PosicionInvalida;
    Exit;
  End;

  // Ahora si lo podemos eliminar
  for I := PosOrdinal To (Final-1) do Begin
    Items[I] := Items[I+1];
  End;

  Dec(Final);
  if Final < Inicio then Crear(TDC, Size);

  Dec(cantidad);
  Eliminar := OK;
End;

Function Lista.Recuperar(PosOrdinal: Integer):TipoElemento;
Var X: TipoElemento;
Begin
  X := X.TipoElementoVacio();
  if Not EsVacia() then Begin
    if (PosOrdinal >= Inicio) And (PosOrdinal <= Final) then
      X := Items[PosOrdinal];
  End;
  Recuperar := X;
End;

Function Lista.RtnAsString(): String;
Var S: String;
  I: PosicionLista;
Begin
  S := '';
  for I := Inicio to Final do Begin
    S := S + Items[I].ArmarString + cCRLF;
  End;
  RtnAsString := S;
End;

Function Lista.Buscar(aClave: Variant): Integer;
Var I: Integer;
    X: TipoElemento;
Begin
  Buscar := 0;

  // Clave se compatible
  if X.TipoDatoClave(aClave) <> TDC then Begin
    Exit;
  End;

  // Ahora la busco
  for I := Inicio to Final do Begin
    if aClave = Items[I].clave then Begin
      Buscar := I;
      Exit;
    End;
 End;
End;

Function Lista.CantidadElementos(): Integer;
Begin
  CantidadElementos := Cantidad;
End;

Function Lista.Anterior(P: PosicionLista): PosicionLista;
Begin
  Anterior := Nulo;
  if (P > Inicio) And (P <= Final) then Begin
    Anterior := (P - 1);
  End;
End;

Function Lista.Siguiente(P: PosicionLista): PosicionLista;
Begin
  Siguiente := Nulo;
  if (P >= Inicio) And (P < Final) then Begin
    Siguiente := (P + 1);
  End;
End;

Function Lista.nSize(): Integer;
Begin
  nSize := Size;
End;

Function Lista.TipoDatoClave():TipoDatosClave;
Begin
  TipoDatoClave := TDC;
End;

Function Lista.Comienzo(): PosicionLista;
Begin
  Comienzo := Inicio;
End;

Function Lista.Fin(): PosicionLista;
Begin
  Fin := Final;
End;

end.
