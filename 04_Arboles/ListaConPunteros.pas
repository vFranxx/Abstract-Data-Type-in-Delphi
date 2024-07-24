unit ListaConPunteros;

interface

Uses
  Tipos, SysUtils;

Const
  Nulo = NIL;      // Abstraccion de una posicion NO valida de la lista
  Min = 1;
  Max = 2000;

Type

  PosicionLista = ^NodoLista;

  NodoLista = Object          // Puntero a crear en memoria
    Datos: TipoElemento;
    Ante,Prox: PosicionLista;
  End;

  Lista = Object
    Private
      Inicio, Final: PosicionLista;     // Las banderas de Inicio y Fin de la lista
      Size: Integer;
      Cantidad: Integer;
      TDC: TipoDatosClave;
      Function Ordinal(PosOrdinal: Integer): PosicionLista;
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
Var Q: PosicionLista;
Begin
  if EsLlena() then Agregar := LLena
  Else Begin
    if X.TipoDatoClave(X.Clave) = TDC then Begin
      New(Q);   // Creo el Nodo en la memoria.  Q tiene la direccion de memoria del Nodo
      Q^.Prox	:= Nulo;
      Q^.Datos := X;
      Q^.Ante := Final;   //Encadena el anteior con el final actual
      // Controlo si esta vacia, era el primer nodo, inicializado el Inicio
      if EsVacia() then Inicio := Q
      Else Final^.Prox := Q; // Sino conecta al final actual con Q
      Final := Q; // Paso al final al nuevo Final (Q).
      Inc(cantidad);
      Agregar := OK;
    End
    Else Agregar := ClaveIncompatible;
  End;
End;


// Funcion Interna que saca la direccion de Memoria del Ordinal (Posicion Logica)
Function Lista.Ordinal(PosOrdinal: Integer): PosicionLista;
Var Q: PosicionLista;
    I: Integer;
Begin
  // Asuno x defecto nulo
  Ordinal := Nulo;

  // Controlo lo que recibo
  if PosOrdinal > cantidad then exit;
  if PosOrdinal <= 0 then exit;

  // recorro para sacar el ordinal
  I := 1;
  Q := Inicio;
  while Q <> Nulo do Begin
    if PosOrdinal = I then Begin   // Si es la posicion la retorno y me voy
      Ordinal := Q;
      Exit;
    End;
    // Paso al proximo e incremeto I
    Q := Siguiente(Q);
    Inc(I);
  End;
End;

Function Lista.Insertar(X: TipoElemento; PosOrdinal: Integer): RdoOperaciones;
Var I: Integer;
    P, Q: PosicionLista;
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

  // Recupero la Posicion de memoria de la posicion ordinal
  P := Ordinal(PosOrdinal);
  if P = Nulo Then Begin
    Insertar := PosicionInvalida;
    Exit;
  End;

  // Ahora si lo podemos insertar
  New(Q);   //creo el nuevo nodo en memoria
  // Conecto a Q con la lista
  Q^.Prox := P;
  Q^.Ante := P^.Ante;
  Q^.Datos := X;
  // Ahora a la lista con Q
  if P = Inicio then Inicio := Q   // Si justo era el primero hay nuevo inicio
  Else P^.Ante.Prox := Q;  // sino conecta el anteior de P con Q
  P^.Ante := Q;  // Conecto a P con Q (anterior)
  Inc(Cantidad);
  Insertar := OK;
End;


Function Lista.Eliminar(PosOrdinal: Integer):RdoOperaciones;
Var I: Integer;
    P: PosicionLista;
Begin
  // Lista Vacia
  if EsVacia() then Begin
    Eliminar := Vacia;
    Exit;
  End;

  // Controlo que exista la direccion de memoria de la posicion ordinal
  P := Ordinal(PosOrdinal);
  if P = Nulo Then Begin
    Eliminar := PosicionInvalida;
    Exit;
  End;

  // Ahora si lo podemos eliminar pero debemos verificar varias cosas
  // 1. Si es el unico nodo de la lista
  if (P = Inicio) And (P = Final) then Begin
    Crear(TDC, Size);  // La creo vacia de nuevo
  End
  Else Begin
    // 2. Controlo sino es el primero
    if P = Inicio then Begin
      Inicio := P^.Prox;
      Inicio^.Ante := Nulo;
    End
    Else Begin
      // 3. Controlo si no es el final
      if P = Final then Begin
        Final := P^.Ante;
        Final.Prox := Nulo;
      End
      Else Begin
        // 4. Ultimo cualquier otro lado de la lista (medio)
        P^.Ante^.Prox := P^.Prox;
        P^.Prox^.Ante := P^.Ante;
      End;
    End;

    Dec(cantidad);
  End;

  Dispose(P);  // Libero el espacio de memoria
  Eliminar := OK;
End;

Function Lista.Recuperar(PosOrdinal: Integer):TipoElemento;
Var X: TipoElemento;
    P: PosicionLista;
Begin
  P := Ordinal(PosOrdinal);
  X := X.TipoElementoVacio();
  if P <> Nulo then Begin
    X := P^.Datos;
  End;
  Recuperar := X;
End;

Function Lista.RtnAsString(): String;
Var S: String;
  Q: PosicionLista;
Begin
  S := '';
  Q := Inicio;
  while Q <> Nulo do Begin
    S := S + Q^.Datos.ArmarString + cCRLF;
    Q := Siguiente(Q);
  End;
  RtnAsString := S;
End;

Function Lista.Buscar(aClave: Variant): Integer;
Var I: Integer;
    X: TipoElemento;
    Q: PosicionLista;
Begin
  Buscar := 0;

  // Clave se compatible
  if X.TipoDatoClave(aClave) <> TDC then Begin
    Exit;
  End;

  // Ahora la busco
  I := 1;
  Q := Inicio;
  while Q <> Nulo do Begin
    if aClave = Q^.Datos.clave then Begin
      Buscar := I;
      Exit;
    End;
    Inc(I);
    Q := Siguiente(Q);
  End;
End;

Function Lista.CantidadElementos(): Integer;
Begin
  CantidadElementos := Cantidad;
End;

Function Lista.Anterior(P: PosicionLista): PosicionLista;
Begin
  Anterior := Nulo;
  if P <> Nulo then Begin
    Anterior := P^.Ante;
  End;
End;

Function Lista.Siguiente(P: PosicionLista): PosicionLista;
Begin
  Siguiente := Nulo;
  if P <> Nulo then Begin
    Siguiente := P^.Prox;
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
