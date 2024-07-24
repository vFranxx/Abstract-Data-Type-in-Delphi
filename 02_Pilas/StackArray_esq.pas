unit StackArray;

interface

Uses
  Tipos, stdctrls, SysUtils, Variants;

Const
  MIN = 1;  // Base de la Pila
  MAX = 10; // Maximo de la Pila
  Nulo= 0;  // Posicion NO valida del TOPE de la Pila

Type
  PosicionPila = Integer;

  Pila = Object
    Private
      Elementos: Array [MIN .. MAX] Of TipoElemento;
      Inicio: PosicionPila;   // manejo del tope
      Q_Items: Integer;       // cantidad de elementos. Solo de uso interno.
      TDatoDeLaClave: TipoDatosClave;
      Function CantidadElementos(): LongInt;
    Public
      Procedure Crear(avTipoClave: TipoDatosClave);
      Function EsVacia(): Boolean;
      Function EsLlena(): Boolean;
      Function Apilar(X:TipoElemento): Errores;
      Function DesApilar(): Errores;
      Function Recuperar(): TipoElemento;
      Function RetornarClaves(): String;
      Procedure InterCambiar(Var PAux: Pila; bCrearVacia: Boolean);
      Procedure LlenarClavesRandom(RangoDesde, RangoHasta: LongInt);
      Function Tope():PosicionPila;
      Function DatoDeLaClave: TipoDatosClave;
  End;

implementation

// Crea la pila vacia
Procedure Pila.Crear(avTipoClave: TipoDatosClave);
Begin
	// COMPLETAR EL CODIGO DEL PROCEDIMIENTO
End;

// Control de pila vacia
Function Pila.EsVacia(): Boolean;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// Control de pila llena
Function Pila.EsLlena(): Boolean;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// Agrega un Items a la Pila
Function Pila.Apilar(X:TipoElemento): Errores;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// Elimina un item de la Pila. Siempre del Tope
Function Pila.DesApilar(): Errores;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// retorna por referencia en X el item de la Pila. Siempre el Tope
Function Pila.Recuperar(): TipoElemento;
Var X: TipoElemento;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// Pasa los Items de una Pila Auxiliar a la Pila "Pila"
Procedure Pila.InterCambiar(Var PAux: Pila; bCrearVacia: Boolean);
Var X: TipoElemento;
Begin
	// COMPLETAR EL CODIGO DEL PROCEDIMIENTO
End;

// Retorna un string con todos los elementos de Pila
// Cada Item separado por Retorno de Carro + Final de Linea
Function Pila.RetornarClaves():String;
Var X: TipoElemento;
    S, SS: String;
    PAux: Pila;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

// Llena la pila con valores random en el atributo DI
// desde 0 (cero) hasta <RangoHasta>
Procedure Pila.LlenarClavesRandom(RangoDesde, RangoHasta: LongInt);
Var X: TipoElemento;
Begin
	// COMPLETAR EL CODIGO DEL PROCEDIMIENTO
End;

// retorno la Posicion del Tope
Function Pila.Tope():PosicionPila;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

Function Pila.CantidadElementos(): LongInt;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

Function Pila.DatoDeLaClave: TipoDatosClave;
Begin
	// COMPLETAR EL CODIGO DE LA FUNCION
End;

end.





























