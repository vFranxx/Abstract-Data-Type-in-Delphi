unit Ej4_Fechas;

interface

Uses
  SysUtils,System.DateUtils;

Type
  // Subrango
  Dias = 1..31;
  Meses = 1..12;

  // Enumerado
  ResultadoComparacion = (ANTERIOR, POSTERIOR, IGUAL);


  Fecha = Object
    Private
      dia: Dias;
      mes: Meses;
      anio: Integer;
    Public
      Function Verificar(aFecha: Fecha): Boolean;
      Function CalcularFecha(NroEnDias: Integer): Fecha;
      Function DiferenciaEntreFechas(aFecha: Fecha): Integer;
      Function Comparar(aFecha: Tdate): ResultadoComparacion;
      Function SetValueOfDate(d: dias; m:meses; a:integer): Boolean;
      Function EsBisiesto(aFecha: Fecha):Boolean;
      Function RtnFecha(): String;
  End;

implementation

Function Fecha.Verificar(aFecha: Fecha): Boolean;
Var D: TDate;
fechastring: string;
Begin
  fechastring:= aFecha.RtnFecha;
   try
    D := StrToDateTime(fechastring);
    Verificar := TRUE;
  except
    on E: EConvertError do
    Verificar := FALSE;
  end;
End;

Function Fecha.CalcularFecha(NroEnDias: Integer): Fecha;
var
  TempDate: TDateTime;

begin
    TempDate := StrToDateTime(RtnFecha);
    TempDate := IncDay(TempDate, NroEnDias);
    CalcularFecha.dia := Dayof(TempDate);
    CalcularFecha.mes := Monthof(TempDate);
    CalcularFecha.anio := Yearof(TempDate);
    dia := Dayof(TempDate);
    mes := Monthof(TempDate);
    anio := Yearof(TempDate);
End;

Function Fecha.DiferenciaEntreFechas(aFecha: Fecha): Integer;
var
TempDate1,TempDate2: TDateTime;
Begin
    TempDate1 := StrToDateTime(RtnFecha);
    TempDate2 := StrToDateTime(aFecha.RtnFecha);
    DiferenciaEntreFechas:= DaysBetween(TempDate1, TempDate2);
End;

Function Fecha.Comparar(aFecha: TDate):ResultadoComparacion;
Var D: TDate;

Begin
 D:= StrtoDateTime(RtnFecha);
 if IntToStr(CompareDateTime(D,aFecha)) = '0' then
 Comparar := ResultadoComparacion.IGUAL;
  if IntToStr(CompareDateTime(D,aFecha)) = '-1' then
 Comparar := ResultadoComparacion.ANTERIOR;
  if IntToStr(CompareDateTime(D,aFecha)) = '1' then
 Comparar := ResultadoComparacion.POSTERIOR;
 End;

Function Fecha.EsBisiesto(aFecha: Fecha):Boolean;
Begin
  EsBisiesto := IsInLeapYear(StrtoDateTime(aFecha.RtnFecha));
End;

Function Fecha.SetValueOfDate(d: dias; m:meses; a:integer): Boolean;
begin
    dia := d;
    mes := m;
    anio := a;
    SetValueOfDate := TRUE;
End;

Function Fecha.RtnFecha(): String;
Begin
      RtnFecha:= Inttostr(dia)+'/'+Inttostr(mes)+'/'+Inttostr(anio);
End;

end.
