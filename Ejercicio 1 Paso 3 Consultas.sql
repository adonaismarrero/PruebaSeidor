/*a.Indicar cuales arrendatarios sus arriendos vencen el pr�ximo mes.*/
EXECUTE Ejercicios.dbo.pa_SelectArriendos30Dias;

/*b. Indicar cuales propietarios tienen al menos una propiedad sin arrendar.*/
EXECUTE Ejercicios.dbo.pa_SelectPropiedadSinArriendo;

/*c.Indicar cuantas propiedades tiene cada propietario por cada pa�s*/
EXECUTE Ejercicios.dbo.pa_SelectPropiedadPorPais;

/*d.Indicar cuales propietarios tambi�n arrendatarios.*/
EXECUTE Ejercicios.dbo.pa_SelectPropietariosArrendatarios;

/*e.Indicar cuales arrendatarios arriendan fuera de chile.*/
EXECUTE Ejercicios.dbo.pa_SelectArriendosFueraChile;

/*f.Indicar cuales son los 3 pa�ses que el monto promedio de arriendo son los m�s altos.*/
EXECUTE Ejercicios.dbo.pa_SelectPromedioArriendos;

/*g.Indicar el monto promedio, m�nimo y m�ximo que pagan arrendatarios que tambi�n son propietarios*/
EXECUTE Ejercicios.dbo.pa_SelectPromedioArriendos

