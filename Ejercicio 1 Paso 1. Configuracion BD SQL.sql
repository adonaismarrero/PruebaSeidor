IF OBJECT_ID('Ejercicios.dbo.Arriendos') IS NOT NULL
BEGIN
	DROP TABLE Ejercicios.dbo.Arriendos
END
GO

IF OBJECT_ID('Ejercicios.dbo.Propiedad') IS NOT NULL
BEGIN
	DROP TABLE Ejercicios.dbo.Propiedad
END
GO

IF OBJECT_ID('Ejercicios.dbo.Arrendatario') IS NOT NULL
BEGIN
	DROP TABLE Ejercicios.dbo.Arrendatario
END
GO

IF OBJECT_ID('Ejercicios.dbo.Propietarios') IS NOT NULL
BEGIN
	DROP TABLE Ejercicios.dbo.Propietarios
END
GO

CREATE TABLE Ejercicios.dbo.Arrendatario(
	 idArrendatario		INT			NOT NULL IDENTITY
	,rutArrendatario	VARCHAR(45)	NOT NULL
	,nombre				VARCHAR(45) NOT NULL
	,fechaNacimiento	DATETIME	NOT NULL
	,CONSTRAINT PK_ArrendatarioId 
		PRIMARY KEY(IdArrendatario)
	,CONSTRAINT PK_ArrendatarioRut
		UNIQUE(rutArrendatario)
)
GO

CREATE TABLE Ejercicios.dbo.Propietarios(
	 idPropietarios		INT			NOT NULL IDENTITY
	,rutPropietario		VARCHAR(45)	NOT NULL
	,nombre				VARCHAR(45) NOT NULL
	,fechaNacimiento	DATETIME	NOT NULL
	,CONSTRAINT PK_PropietariosId 
		PRIMARY KEY(idPropietarios)
	,CONSTRAINT PK_PropietariosRut
		UNIQUE(rutPropietario)
)
GO

CREATE TABLE Ejercicios.dbo.Propiedad(
	 idPropiedad		INT			NOT NULL IDENTITY
	,idPropietario		INT			NOT NULL
	,calle				VARCHAR(45) NOT NULL
	,numero				VARCHAR(45) NOT NULL
	,comuna				VARCHAR(45) NOT NULL
	,region				VARCHAR(45) NOT NULL
	,pais				VARCHAR(45) NOT NULL
	,CONSTRAINT PK_PropiedadId 
		PRIMARY KEY(idPropiedad)
	,CONSTRAINT FK_PropiedadPropietario
		FOREIGN KEY(idPropietario)
		REFERENCES Ejercicios.dbo.Propietarios(idPropietarios)
)
GO

CREATE TABLE Ejercicios.dbo.Arriendos(
	 idArriendos		INT			NOT NULL IDENTITY
	,idArrendatario		INT			NOT NULL
	,idPropietarios		INT			NOT NULL
	,idPropiedad		INT			NOT NULL
	,monto				INT			NOT NULL
	,fechaIni			DATETIME	NOT NULL
	,fechaFin			DATETIME	NOT NULL
	,CONSTRAINT PK_ArriendosId 
		PRIMARY KEY(idArriendos)
	,CONSTRAINT FK_ArriendosPropietario
		FOREIGN KEY(idPropietarios)
		REFERENCES Ejercicios.dbo.Propietarios(idPropietarios)
	,CONSTRAINT FK_ArriendosPropiedad
		FOREIGN KEY(idPropiedad)
		REFERENCES Ejercicios.dbo.Propiedad(idPropiedad)
	,CONSTRAINT FK_ArriendosArrendatario
		FOREIGN KEY(idArrendatario)
		REFERENCES Ejercicios.dbo.Arrendatario(idArrendatario)
)
GO

INSERT INTO Ejercicios.dbo.Propietarios(
 rutPropietario
,nombre
,fechaNacimiento
)
VALUES
	 ('123456789','Pedro Perez','19770131')
	,('987654321','Jose Ramirez','19850815')
	,('789456123','María Molina','19901126')
	,('321654987','Paulina Rubio','19670827')
	,('741852963','Natalia Araneda','19951212')

INSERT INTO Ejercicios.dbo.Arrendatario(
	 rutArrendatario
	,nombre
	,fechaNacimiento)
VALUES
	 ('123456789','Pedro Perez','19770131')
	,('987654321','Jose Ramirez','19850815')
	,('789456123','María Molina','19901126')
	,('270077978','Adonais Marrero','19770519')
	,('270078583','Liliana Caraballo','19850915')

INSERT INTO Ejercicios.dbo.Propiedad(
	 idPropietario
	,calle
	,numero
	,comuna
	,region
	,pais)
SELECT 
	 idPropietarios
	,CONCAT('AV Santa Isabel Depto ',idPropietarios)
	,'747'
	,'Santiago'
	,'Metropolitana'
	,'Chile'
FROM 
	Ejercicios.dbo.Propietarios

INSERT INTO Ejercicios.dbo.Propiedad(
	 idPropietario
	,calle
	,numero
	,comuna
	,region
	,pais)
SELECT TOP 4
	 idPropietarios
	,CONCAT('Quinta Normal Depto ',idPropietarios)
	,'4050'
	,'Santiago'
	,'Metropolitana'
	,'Chile'
FROM 
	Ejercicios.dbo.Propietarios

INSERT INTO Ejercicios.dbo.Propiedad(
	 idPropietario
	,calle
	,numero
	,comuna
	,region
	,pais)
SELECT TOP 3
	 idPropietarios
	,CONCAT('AV San Martin Casa Nro ',idPropietarios)
	,'949'
	,'Caracas'
	,'Región Metropoltana'
	,'Venezuela'
FROM 
	Ejercicios.dbo.Propietarios

INSERT INTO Ejercicios.dbo.Propiedad(
	 idPropietario
	,calle
	,numero
	,comuna
	,region
	,pais)
SELECT TOP 2
	 idPropietarios
	,CONCAT('Calle Arriendos Nro. ',idPropietarios)
	,'850'
	,'Eje Cafetero'
	,'Bogota'
	,'Colombia'
FROM 
	Ejercicios.dbo.Propietarios
ORDER BY 
	idPropietarios DESC

INSERT INTO Ejercicios.dbo.Propiedad(
	 idPropietario
	,calle
	,numero
	,comuna
	,region
	,pais)
SELECT
	 idPropietarios
	,CONCAT('Doral Casa Freelance Nro ',idPropietarios)
	,'85240'
	,'Florida'
	,'Miami'
	,'Estados Unidos'
FROM 
	Ejercicios.dbo.Propietarios
ORDER BY 
	idPropietarios DESC

INSERT INTO Ejercicios.dbo.Arriendos(
	 idArrendatario
	,idPropietarios
	,idPropiedad
	,monto
	,fechaIni
	,fechaFin)
SELECT TOP 1
	 (SELECT TOP 1 idArrendatario FROM Arrendatario WHERE rutArrendatario = '123456789')
	,idPropietario
	,idPropiedad
	,CAST(ABS(FLOOR(RAND()*(20000-1000000)+100)) * idPropiedad AS INT) AS Monto
	,'20200201'
	,'20221231'
FROM 
	Ejercicios.dbo.Propiedad

INSERT INTO Ejercicios.dbo.Arriendos(
	 idArrendatario
	,idPropietarios
	,idPropiedad
	,monto
	,fechaIni
	,fechaFin)
SELECT TOP 2
	 (SELECT TOP 1 idArrendatario FROM Arrendatario WHERE rutArrendatario = '987654321')
	,Ejercicios.dbo.Propiedad.idPropietario
	,Ejercicios.dbo.Propiedad.idPropiedad
	,CAST(ABS(FLOOR(RAND()*(20000-1000000)+100)) * Ejercicios.dbo.Propiedad.idPropiedad AS INT) AS Monto
	,'20200201'
	,'20221115'
FROM 
	Ejercicios.dbo.Propiedad
LEFT JOIN 
	Ejercicios.dbo.Arriendos
ON
	Ejercicios.dbo.Propiedad.idPropiedad = Ejercicios.dbo.Arriendos.idPropiedad
WHERE
	Ejercicios.dbo.Arriendos.idPropiedad IS NULL
GO

INSERT INTO Ejercicios.dbo.Arriendos(
	 idArrendatario
	,idPropietarios
	,idPropiedad
	,monto
	,fechaIni
	,fechaFin)
SELECT TOP 1
	 (SELECT TOP 1 idArrendatario FROM Arrendatario WHERE rutArrendatario = '270077978')
	,Ejercicios.dbo.Propiedad.idPropietario
	,Ejercicios.dbo.Propiedad.idPropiedad
	,CAST(ABS(FLOOR(RAND()*(20000-1000000)+100)) * Ejercicios.dbo.Propiedad.idPropiedad AS INT) AS Monto
	,'20200201'
	,'20221031'
FROM 
	Ejercicios.dbo.Propiedad
LEFT JOIN 
	Ejercicios.dbo.Arriendos
ON
	Ejercicios.dbo.Propiedad.idPropiedad = Ejercicios.dbo.Arriendos.idPropiedad
WHERE
	Ejercicios.dbo.Arriendos.idPropiedad IS NULL
AND
	Ejercicios.dbo.Propiedad.pais = 'Chile'

INSERT INTO Ejercicios.dbo.Arriendos(
	 idArrendatario
	,idPropietarios
	,idPropiedad
	,monto
	,fechaIni
	,fechaFin)
SELECT TOP 5
	 (SELECT TOP 1 idArrendatario FROM Arrendatario WHERE rutArrendatario = '789456123')
	,Ejercicios.dbo.Propiedad.idPropietario
	,Ejercicios.dbo.Propiedad.idPropiedad
	,CAST(ABS(FLOOR(RAND()*(20000-1000000)+100)) * Ejercicios.dbo.Propiedad.idPropiedad AS INT) AS Monto
	,'20200201'
	,'20221126'
FROM 
	Ejercicios.dbo.Propiedad
LEFT JOIN 
	Ejercicios.dbo.Arriendos
ON
	Ejercicios.dbo.Propiedad.idPropiedad = Ejercicios.dbo.Arriendos.idPropiedad
WHERE
	Ejercicios.dbo.Arriendos.idPropiedad IS NULL
AND
	Ejercicios.dbo.Propiedad.pais <> 'Chile'	

INSERT INTO Ejercicios.dbo.Arriendos(
	 idArrendatario
	,idPropietarios
	,idPropiedad
	,monto
	,fechaIni
	,fechaFin)
SELECT TOP 2
	 (SELECT TOP 1 idArrendatario FROM Arrendatario WHERE rutArrendatario = '270078583')
	,Ejercicios.dbo.Propiedad.idPropietario
	,Ejercicios.dbo.Propiedad.idPropiedad
	,CAST(ABS(FLOOR(RAND()*(20000-1000000)+100)) * Ejercicios.dbo.Propiedad.idPropiedad AS INT) AS Monto
	,'20200201'
	,'20221130'
FROM 
	Ejercicios.dbo.Propiedad
LEFT JOIN 
	Ejercicios.dbo.Arriendos
ON
	Ejercicios.dbo.Propiedad.idPropiedad = Ejercicios.dbo.Arriendos.idPropiedad
WHERE
	Ejercicios.dbo.Arriendos.idPropiedad IS NULL
AND
	Ejercicios.dbo.Propiedad.pais <> 'Chile'	
--SELECT * FROM Ejercicios.dbo.Propiedad ORDER BY idPropiedad
--SELECT * FROM Ejercicios.dbo.Arriendos ORDER BY idPropiedad
