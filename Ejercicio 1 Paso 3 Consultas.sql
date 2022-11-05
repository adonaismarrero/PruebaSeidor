/*a.Indicar cuales arrendatarios sus arriendos vencen el próximo mes.*/
EXECUTE Ejercicios.dbo.pa_SelectArriendos30Dias;

/*b. Indicar cuales propietarios tienen al menos una propiedad sin arrendar.*/
EXECUTE Ejercicios.dbo.pa_SelectPropiedadSinArriendo;

/*c.Indicar cuantas propiedades tiene cada propietario por cada país*/
EXECUTE Ejercicios.dbo.pa_SelectPropiedadPorPais;

/*d.Indicar cuales propietarios también arrendatarios.*/
EXECUTE Ejercicios.dbo.pa_SelectPropietariosArrendatarios;

/*e.Indicar cuales arrendatarios arriendan fuera de chile.*/
EXECUTE Ejercicios.dbo.pa_SelectArriendosFueraChile;

/*f.Indicar cuales son los 3 países que el monto promedio de arriendo son los más altos.*/
EXECUTE Ejercicios.dbo.pa_SelectPromedioArriendos;

/*g.Indicar el monto promedio, mínimo y máximo que pagan arrendatarios que también son propietarios*/
EXECUTE Ejercicios.dbo.pa_SelectPromedioArriendos

