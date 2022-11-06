
/*a.Top de empresas que sus trabajadores presentan más licencias.*/
SElECT 
	 emp.RutEmpresa
	,emp.NombreEmpresa
	,COUNT(lic.LicenciaId) AS CantidadLicencia
FROM
	Ejercicios.Ejer2.Licencia AS lic
INNER JOIN
	Ejercicios.Ejer2.Empresa AS emp
ON
	lic.EmpresaID = emp.EmpresaID
GROUP BY
	 emp.RutEmpresa
	,emp.NombreEmpresa
ORDER BY
	CantidadLicencia DESC

/*b.Las sucursales que reciben más documentación, segmentados por región o comuna, así como sucursales que no están aptas para recibir documentación.*/
SELECT 
	 lic.SucursalId
	,suc.NombreSucursal
	,comu.NombreComuna
	,reg.NombreRegion
	,CASE WHEN suc.AceptaDocumento = 0 THEN 'No Acepta Documentación' ELSE CONCAT('Cantidad de Documentos Recibidos: ',COUNT(doc.DocumentoId)) END AS CantidadDocumentos
FROM 
	Ejercicios.Ejer2.Licencia AS lic
INNER JOIN
	Ejercicios.Ejer2.Sucursal AS suc
ON
	suc.SucursalId = lic.SucursalId
INNER JOIN	
	Ejercicios.Ejer2.Comuna AS comu
ON	
	suc.ComunaId = comu.ComunaId
INNER JOIN
	Ejercicios.Ejer2.Region AS reg
ON
	comu.RegionId = reg.RegionId
LEFT JOIN 
	Ejercicios.Ejer2.LicenciaDocumento AS doc
ON
	lic.LicenciaId = doc.LicenciaId
AND
	doc.EstadoDocumentoId = 1
GROUP BY
	 lic.SucursalId
	,suc.NombreSucursal
	,comu.NombreComuna
	,reg.NombreRegion
	,suc.AceptaDocumento
ORDER BY 
	COUNT(doc.DocumentoId) DESC

/*c.Top de documentos que hacen que la licencia reinicie su flujo.*/
SELECT 
	 DocumentoId
	,COUNT(DocumentoId) AS CantidadEstado
FROM
	Ejercicios.Ejer2.LicenciaDocumento AS licDoc
INNER JOIN 
	Ejercicios.Ejer2.EstadoDocumento AS est
ON
	licDoc.EstadoDocumentoId = est.EstadoDocumentoId
AND
	est.ReiniciaProceso = 1
GROUP BY 
	DocumentoId
	
/*d.Tiempos promedios, mínimos y máximos, desde el inicio del proceso hasta el cálculo del monto a pagar por cada licencia*/
SELECT 
	 licMov.LicenciaId
	,MIN(licMov.FechaMovimiento)		AS FechaInicioProceso
	,MAX(licMovPago.FechaMovimiento)	AS FechaPago	
	,DATEDIFF(day,MIN(licMov.FechaMovimiento),MAX(licMovPago.FechaMovimiento)) AS TiempoTranscurridoEnDias
FROM
	Ejercicios.Ejer2.LicenciaMovimiento AS licMov
INNER JOIN 
	Ejercicios.Ejer2.EstadoLicencia AS est
ON
	licMov.EstadoLicenciaId = est.EstadoLicenciaId
AND
	est.GeneraPago = 0
INNER JOIN
	Ejercicios.Ejer2.LicenciaMovimiento AS licMovPago
ON
	licMov.LicenciaId = licMovPago.LicenciaId
INNER JOIN 
	Ejercicios.Ejer2.EstadoLicencia AS estPago
ON
	licMovPago.EstadoLicenciaId = estPago.EstadoLicenciaId
AND
	estPago.GeneraPago = 1
GROUP BY
	 licMov.LicenciaId
ORDER BY
	licMov.LicenciaId

/*e.Estadísticas de licencias manuales vs electrónicas vs mixtas*/
SELECT 
	 DescripcionTipoLicencia
	,CASE 
		WHEN EsManual = 1 AND EsDigital = 1 THEN 'Mixta'  
		WHEN EsManual = 1 AND EsDigital = 0 THEN 'Manual'
		WHEN EsManual = 0 AND EsDigital = 1 THEN 'Electrónica'
		ELSE 'N/D' END						AS TipodeLicencia
	,COUNT(lic.TipoLicenciaId)				AS CantidadPorTipoLicencia
FROM 
	Ejercicios.Ejer2.Licencia AS lic
INNER JOIN
	Ejercicios.Ejer2.TipoLicencia AS tipLic
ON
	lic.TipoLicenciaId = tipLic.TipoLicenciaId
GROUP BY
	DescripcionTipoLicencia
	,CASE 
		WHEN EsManual = 1 AND EsDigital = 1 THEN 'Mixta'  
		WHEN EsManual = 1 AND EsDigital = 0 THEN 'Manual'
		WHEN EsManual = 0 AND EsDigital = 1 THEN 'Electrónica'
		ELSE 'N/D' END 
ORDER BY 
	DescripcionTipoLicencia

/*f.Los estados del proceso que almacenan la mayor cantidad de licencias así como los cambios de estado que tardan más tiempo en ser modificados*/
SELECT 
	 est.DescripcionEstadoLicencia
	,COUNT(licMov.EstadoLicenciaId)		AS CantidadLicencia
	,MIN(licMov.FechaMovimiento)		AS FechaInicioProceso
	,MAX(licMov.FechaMovimiento)		AS FechaPago	
	,DATEDIFF(day,MIN(licMov.FechaMovimiento),MAX(licMov.FechaMovimiento)) AS TiempoTranscurridoEnDias
FROM
	Ejercicios.Ejer2.LicenciaMovimiento AS licMov
INNER JOIN 
	Ejercicios.Ejer2.EstadoLicencia AS est
ON
	licMov.EstadoLicenciaId = est.EstadoLicenciaId
GROUP BY
	 est.DescripcionEstadoLicencia
ORDER BY
	CantidadLicencia DESC

/*g.Trabajadores que tienen licencia y son desafiliados*/
SELECT
	 empresa.RutEmpresa
	,empresa.NombreEmpresa
	,emp.RutEmpleado
	,emp.NombreEmpleado	
FROM 
	Ejercicios.Ejer2.Licencia AS lic
INNER JOIN
	Ejercicios.Ejer2.EmpresaEmpleado AS empre
ON
	lic.EmpresaId = empre.EmpresaId
AND
	lic.EmpleadoID = empre.EmpleadoID
AND
	empre.FechaDesafiliacion IS NOT NULL
INNER JOIN
	Ejercicios.Ejer2.Empleado AS emp
ON
	empre.EmpleadoID = emp.EmpleadoId
INNER JOIN 
	Ejercicios.Ejer2.Empresa AS empresa
ON
	empre.EmpresaId = empresa.EmpresaId  
GROUP BY	
	 empresa.RutEmpresa
	,empresa.NombreEmpresa
	,emp.RutEmpleado
	,emp.NombreEmpleado	
ORDER BY 
	 empresa.RutEmpresa
	,empresa.NombreEmpresa
	,emp.RutEmpleado
	,emp.NombreEmpleado	
