USE BDRESERVA_WEBAPI_REACT
GO

CREATE OR ALTER PROCEDURE PA_USUARIO_ALL
AS
	SELECT U.codusuario, U.nomusuario, U.anio_ingreso,
		C.nomcat, D.nomdis, U.eliminado
	FROM Usuario U INNER JOIN Distritos D
		ON U.coddis = D.coddis INNER JOIN Categoria C
			ON U.codcat = C.codcat
GO

EXECUTE PA_USUARIO_ALL
GO
----------------------------------------------------------

CREATE OR ALTER PROCEDURE PA_USUARIOS_CATEGORIA
@CODCAT CHAR(3)
AS
	SELECT U.codusuario, U.nomusuario, U.anio_ingreso,
		C.nomcat, D.nomdis, U.eliminado
	FROM Usuario U INNER JOIN Distritos D
		ON U.coddis = D.coddis INNER JOIN Categoria C
			ON U.codcat = C.codcat
		WHERE U.codcat = @CODCAT
GO

EXECUTE PA_USUARIOS_CATEGORIA 'E02'
GO
--------------------------------------------------
CREATE OR ALTER PROCEDURE PA_RESERVAS_ANIO
@ANIO INT
AS
	SELECT R.nroreservas, 
	       convert(varchar(10), R.fecha, 103) as fecha, 
	       C.codcliente, C.nomcliente,
			R.pago, U.codusuario, U.nomusuario, R.descrip
	FROM Reservas R INNER JOIN Clientes C
		ON R.codcliente = C.codcliente INNER JOIN Usuario U
			ON R.codusuario = U.codusuario
	WHERE YEAR(R.fecha) = @ANIO
GO

EXECUTE PA_RESERVAS_ANIO 2022
GO