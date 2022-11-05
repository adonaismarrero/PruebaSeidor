/*a. Indicar cuales arrendatarios sus arriendos vencen el próximo mes.*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectArriendos30Dias

AS

SELECT 
	 dbo.Arrendatario.rutArrendatario
	,dbo.Arrendatario.Nombre
	,CONCAT('Calle: ',dbo.Propiedad.calle,' Nro: ',dbo.Propiedad.numero, ' Comuna: ',dbo.Propiedad.comuna,' Región: ', dbo.Propiedad.region) AS Propiedad 
	,dbo.Propiedad.pais
	,CONVERT(VARCHAR(10),dbo.Arriendos.fechaFin,103) AS fechaFin
	,DATEDIFF(DAY,GETDATE(),dbo.Arriendos.fechaFIN) AS DiasxVencer
FROM 
	dbo.Propiedad
INNER JOIN 
	dbo.Arriendos
ON
	dbo.Propiedad.idPropiedad = dbo.Arriendos.idPropiedad
INNER JOIN 
	dbo.Arrendatario	
ON
	dbo.Arriendos.idArrendatario = dbo.Arrendatario.idArrendatario
WHERE
	DATEDIFF(DAY,EOMONTH(GETDATE()),EOMONTH(dbo.Arriendos.fechaFIN)) <= 30
GO

/*b. Indicar cuales propietarios tienen al menos una propiedad sin arrendar.*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectPropiedadSinArriendo

AS

SELECT 
	 dbo.Propietarios.rutPropietario
	,dbo.Propietarios.Nombre
	,CONCAT('Calle: ',dbo.Propiedad.calle,' Nro. ',dbo.Propiedad.numero) AS Propiedad
FROM 
	dbo.Propietarios 
INNER JOIN 
	dbo.Propiedad	
ON
	dbo.Propietarios.idPropietarios =  dbo.Propiedad.idPropietario
LEFT JOIN 
	dbo.Arriendos
ON
	dbo.Propiedad.idPropiedad = dbo.Arriendos.idPropiedad
WHERE
	dbo.Arriendos.idPropiedad IS NULL
ORDER BY
	 dbo.Propietarios.rutPropietario
GO

/*c.Indicar cuantas propiedades tiene cada propietario por cada país*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectPropiedadPorPais

AS

SELECT 
	 dbo.Propietarios.rutPropietario
	,dbo.Propietarios.Nombre
	,dbo.Propiedad.Pais
	,COUNT(dbo.Propiedad.idPropiedad) AS Propiedad
FROM 
	dbo.Propietarios 
INNER JOIN 
	dbo.Propiedad	
ON
	dbo.Propietarios.idPropietarios =  dbo.Propiedad.idPropietario
GROUP BY
	 dbo.Propietarios.rutPropietario
	,dbo.Propietarios.Nombre
	,dbo.Propiedad.Pais
ORDER BY
	 dbo.Propietarios.rutPropietario
GO

/*d.Indicar cuales propietarios también arrendatarios.*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectPropietariosArrendatarios

AS

SELECT 
	 dbo.Propietarios.rutPropietario
	,dbo.Propietarios.Nombre
FROM 
	dbo.Propietarios 
INNER JOIN 
	dbo.Arrendatario	
ON
	dbo.Propietarios.rutPropietario =  dbo.Arrendatario.rutArrendatario
GO

/*e.Indicar cuales arrendatarios arriendan fuera de chile.*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectArriendosFueraChile

AS

SELECT 
	 dbo.Arrendatario.rutArrendatario
	,dbo.Arrendatario.Nombre
	,CONCAT('Calle: ',calle,' Nro: ',numero, ' Comuna: ',comuna,' Región: ', region) AS Propiedad 
	,dbo.Propiedad.pais
FROM 
	dbo.Propiedad
INNER JOIN 
	dbo.Arriendos
ON
	dbo.Propiedad.idPropiedad = dbo.Arriendos.idPropiedad
INNER JOIN 
	dbo.Arrendatario	
ON
	dbo.Arriendos.idArrendatario = dbo.Arrendatario.idArrendatario
WHERE
	dbo.Propiedad.pais <> 'Chile'
GO

/*f.Indicar cuales son los 3 países que el monto promedio de arriendo son los más altos.*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectPromedioArriendos

AS

SELECT TOP 3
	 dbo.Propiedad.pais
	,AVG(dbo.Arriendos.Monto) AS PromedioArriendo
FROM 
	dbo.Arriendos
INNER JOIN 
	dbo.Propiedad
ON
	dbo.Propiedad.idPropiedad = dbo.Arriendos.idPropiedad
GROUP BY
	dbo.Propiedad.pais
ORDER BY 
	PromedioArriendo DESC
GO

/*g.Indicar el monto promedio, mínimo y máximo que pagan arrendatarios que también son propietarios*/
CREATE OR ALTER PROCEDURE dbo.pa_SelectPromedioArriendos

AS

SELECT 
	 AVG(dbo.Arriendos.Monto) AS PromedioArriendo
	,MIN(dbo.Arriendos.Monto) AS MinimoArriendo
	,MAX(dbo.Arriendos.Monto) AS MaximoArriendo
FROM 
	dbo.Arriendos
INNER JOIN 
	dbo.Propietarios
ON
	dbo.Arriendos.idPropietarios = dbo.Propietarios.idPropietarios
INNER JOIN 
	dbo.Arrendatario
ON
	dbo.Propietarios.rutPropietario = dbo.Arrendatario.rutArrendatario

GO
