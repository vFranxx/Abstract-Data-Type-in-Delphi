unit QueuesArrayNC;

interface
Uses
  Tipos, stdctrls, SysUtils;

Const
  MIN = 1;  // Frente de la cola
  MAX = 10; // Final de la cola
  Nulo= 0;  // Posicion NO Valida de frente o final

Type
  PosicionCola = LongInt;

  Cola = Object
    Private
      Elementos: Array[MIN..MAX] Of TipoElemento;
      Inicio, Fin: PosicionCola;
      Q_Items: Integer;
      TDatoDeLaClave: TipoDatosClave;
      Function CantidadItems(): LongInt;
    Public
      Procedure Crear(avTipoClave: TipoDatosClave);
      Function EsVacia(): Boolean;
      Function EsLlena(): Boolean;
      Function Encolar(X:TipoElemento): Errores;
      Function DesEncolar(): Errores;
      Function Recuperar(): TipoElemento;
      Function RetornarClaves(): String;
      Procedure InterCambiar(Var CAux: Cola; bCrearVacia: Boolean);
      Procedure LLenarClavesRandom(RangoDesde, RangoHasta:LongInt);
      Function Frente(): PosicionCola;
      Function Final(): PosicionCola;
      Function DatoDeLaClave: TipoDatosClave;
  End;

implementation

// Creo la cola vacia
Procedure Cola.Crear(avTipoClave: TipoDatosClave);
Begin
	// COMPLETAR
End;

// control de cola vacia
Function Cola.EsVacia(): Boolean;
Begin
	// COMPLETAR
End;

// control de cola llena
Function Cola.EsLLena(): Boolean;
Begin
	// COMPLETAR
End;

// Agrega un elemento a la Cola al Final
Function Cola.Encolar(X:TipoElemento): Errores;
Begin
	// COMPLETAR
End;

// Elimina un elemento de la Cola. Siempre del Frente
Function Cola.DesEncolar(): Errores;
Var P, Q: PosicionCola;
Begin
	// COMPLETAR
End;

// retorna el elemento del frente de la cola
Function Cola.Recuperar(): TipoElemento;
Var X: TipoElemento;
Begin
	// COMPLETAR
End;

// Pasa los elementos de una Cola Auxiliar a la Cola "Cola"
Procedure Cola.InterCambiar(Var CAux: Cola; bCrearVacia: Boolean);
Var X: TipoElemento;
Begin
	// COMPLETAR
End;

// Retorna un string con todos los elementos de Cola
// Cada Item separado por Retorno de Carro + Final de Linea
Function Cola.RetornarClaves():String;
Var X: TipoElemento;
  S, SS: String;
  CAux: Cola;
Begin
	// COMPLETAR
End;

// Llena la cola con valores aletarios en el atributo DI
// desde <RangoDesde> hasta <RangoHasta>
Procedure Cola.LLenarClavesRandom(RangoDesde, RangoHasta:LongInt);
Var X: TipoElemento;
Begin
	// COMPLETAR
End;

// retorno posicion del frente
Function Cola.Frente(): PosicionCola;
Begin
	// COMPLETAR
End;

// retorno posicion del final
Function Cola.Final(): PosicionCola;
Begin
	// COMPLETAR
End;

// Retorno la cantidad de elementos
Function Cola.CantidadItems(): LongInt;
Begin
	// COMPLETAR
End;

Function Cola.DatoDeLaClave: TipoDatosClave;
Begin
	// COMPLETAR
End;

end.
