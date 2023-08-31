USE master
go

SET NOCOUNT ON
GO
SET  DATEFORMAT DMY
GO
SET LANGUAGE SPANISH
GO

IF EXISTS(SELECT * FROM sys.sysdatabases 
           WHERE name='BDRESERVA_WEBAPI_REACT')
Begin
	Alter Database BDRESERVA_WEBAPI_REACT
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	
	DROP DATABASE BDRESERVA_WEBAPI_REACT
End
GO

CREATE DATABASE BDRESERVA_WEBAPI_REACT
COLLATE MODERN_SPANISH_CI_AI
go

USE BDRESERVA_WEBAPI_REACT
GO

create table Distritos
(
	coddis char(3) not null constraint pkDistritos_coddis primary key,
	nomdis varchar(40) not null,
	eliminado	char(2) default('No')
)
go

insert into Distritos 
values('D01', 'Lima-Cercado','No'),
('D02', 'Jesus Maria','No'),
('D03', 'Rimac','No'),
('D04', 'Magdalena','No'),
('D05', 'Pueblo Libre','No'),
('D06', 'Miraflores','No'),
('D07', 'San Isidro','No'),
('D08', 'Surquillo','No'),
('D09', 'San Martin de Porres','No'),
('D10', 'San Juan de Miraflores','No'),
('D11', 'Lince','No'),
('D12', 'La Victoria','No'),
('D13', 'La Molina','No'),
('D14', 'San Luis','No'),
('D15', 'San Borja','No'),
('D16', 'Los Olivos','No'),
('D17', 'San Juan de Lurigancho','No'),
('D18', 'Villa El Salvador','No'),
('D19', 'Villa Maria del Triunfo','No'),
('D20', 'Chorrillos','No'),
('D21', 'Ate','No'),
('D22', 'San Miguel','No'),
('D23', 'Surco','No'),
('D24', 'Lince','No'),
('D25', 'Ancon','No'),
('D26', 'Barranco','No'),
('D27', 'Carabayllo','No'),
('D28', 'Breña','No'),
('D29', 'Chorrillos','No'),
('D30', 'Santa Anita','No'),
('D31', 'Chaclacayo','No'),
('D32', 'Lurin','No')
go

create table Categoria
(
	codcat char(3) not null constraint pkCategoria_codcat primary key,
	nomcat varchar(50) not null,
	costo decimal(6,2),
	eliminado char(2) default('No')
)
go

insert into Categoria 
values('E01', 'Hamburguesas', 8.00, 'No'),
('E02', 'Parrillas', 25.00, 'No'),
('E03', 'Anticuchos', 15.00, 'No'),
('E04', 'Gaseosas 1/2Lt.', 4.00, 'No'),
('E05', 'Gaseosas 1Lt.', 10.00, 'No'),
('E06', 'Chicha', 9.00, 'No'),
('E07', 'Jugos', 12.00, 'No'),
('E08', 'Infusiones', 4.00, 'No')
go

create table Usuario
(
	codusuario char(5) not null constraint pkUsuario_codusuario primary key,
	nomusuario varchar(40),
	anio_ingreso  int,
	codcat char(3) constraint fk_Usuarios_codcat references Categoria,
	coddis	char(3) constraint fkUsuarios_coddis references Distritos,
	eliminado	char(2) default('No')
)          
go

insert into Usuario values('M0001','ANALI' ,2022,'E01','D01','No') 
insert into Usuario values('M0002','CLAUDIA' ,2022,'E02','D04','No') 
insert into Usuario values('M0003','MILAGROS' ,2023,'E01','D08','No') 
insert into Usuario values('M0004','ROSA' ,2022,'E03','D02','No') 
insert into Usuario values('M0005','YOSI' ,2022,'E02','D06','No') 
insert into Usuario values('M0006','JESÚS',2023,'E05','D17','No')
insert into Usuario values('M0007','ARLET',2023,'E04','D18','No') 
GO
---------------------------------------------------------------------------

create table Clientes
(
	codcliente	char(6)	not null constraint pkClientes_codcliente primary key,
	nomcliente	varchar(50)		not null,
	dnicliente	char(8)	,
	tel_cel	varchar(10),
	dircliente	varchar(50),
	coddis	char(3) constraint fkClientes_coddis references Distritos,
	eliminado	char(2) default('No')
)
go

insert into Clientes values('P00001','SEDANO MANTILLA, RANDY DANILO','10233234','985745280','Jr. Trujillo 290', 'D03','No')
insert into Clientes values('P00002','SILVERA SIANCAS, ISAAC','45203678','998530045','Jr. Lopez Pasos 852', 'D01','No')
insert into Clientes values('P00003','VASQUEZ FERRE, FRANK JUNIOR','41526389','987421895','Av. Uruguay 587', 'D01','No')
insert into Clientes values('P00004','VEGA FLORES, MARIA LUISA','40477308','896526344','', 'D05','No')
insert into Clientes values('P00005','VENTURA PEREZ, JOSE ANTONIO','45698712','998563241','', 'D15','No')
insert into Clientes values('P00006','DONAYRE RAMOS, PAOLA','5918596','983474523','', 'D15','No')
--
insert into Clientes values('P00007','CAMPOS BALLESTEROS MARITZA','25456389','988526304','', 'D10','No')
insert into Clientes values('P00008','VERA CHIHUAN, CARLOS ALBERTO','21369874','898552417','', 'D02','No')
insert into Clientes values('P00009','ALMONTE RIVERA, DENNIS OBED','20356380','981063857','', 'D01','No')
insert into Clientes values('P00010','BRICEÑO PORTILLA, WALTER ALFONSO','41526302','984123505','', 'D03','No')
insert into Clientes values('P00011','CARDENAS ZEGARRA, EMILIO YANG','48752360','997500246','', 'D03','No')
insert into Clientes values('P00012','VIDAL ORBEGOZO, JESUS JOEL','40525063','975863408','', 'D02','No')
insert into Clientes values('P00013','CAMPOS CASTILLO, CARLA HELIN','28967314','977741288','', 'D09','No')
insert into Clientes values('P00014','VILCHEZ GALAN, PEDRO CARLOS','23410808','999526441','', 'D08','No')
insert into Clientes values('P00015','ANDRADE ZUASNABAR, DANIELA','40015285','980042347','', 'D12','No')
go

create table Reservas
(
	nroreservas int not null constraint pkReservas_nroreservas primary key,
	codusuario  char(5) not null,
	codcliente  char(6) not null,
	pago    decimal(8,2),
	fecha	datetime default getdate()+1,
	estado int default 0,
	descrip	varchar(400)
		constraint fkReservas_codusuario 
				  foreign key(codusuario) 
				  references Usuario(codusuario),
		constraint fkReservas_codcliente 
				  foreign key(codcliente) 
				  references Clientes(codcliente) 				   
) 
go

SET LANGUAGE SPANISH
GO

INSERT INTO Reservas VALUES(10001,'M0001','P00001',50,'12/03/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10002,'M0003','P00002',50,'10/04/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10003,'M0004','P00003',30,'23/05/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10004,'M0001','P00004',20,'03/06/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10005,'M0002','P00005',40,'14/10/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10006,'M0005','P00001',50,'18/11/2020',0,'Sin Descripcion') 
GO
select*from reservas
INSERT INTO Reservas VALUES(10007,'M0003','P00007',60,'14/12/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10008,'M0004','P00008',40,'21/12/2020',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10009,'M0005','P00012',10,'16/01/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10010,'M0007','P00014',20,'16/01/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10011,'M0008','P00009',40,'18/01/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10012,'M0007','P00015',60,'18/02/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10013,'M0002','P00010',60,'20/02/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10014,'M0003','P00013',70,'20/02/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10015,'M0004','P00011',50,'23/03/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10016,'M0005','P00006',70,'26/03/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10017,'M0004','P00008',60,'26/03/2021',0,'Sin Descripcion')
INSERT INTO Reservas VALUES(10018,'M0002','P00002',60,'29/03/2021',0,'Sin Descripcion')
INSERT INTO Reservas VALUES(10019,'M0007','P00015',80,'31/03/2021',0,'Sin Descripcion')
GO

INSERT INTO Reservas VALUES(10020,'M0005','P00002',50,'02/04/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10021,'M0006','P00009',30,'02/04/2021',0,'Sin Descripcion')
INSERT INTO Reservas VALUES(10022,'M0006','P00001',40,'06/05/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10023,'M0006','P00002',50,'06/05/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10024,'M0003','P00003',30,'10/05/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10025,'M0007','P00004',40,'10/06/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10026,'M0007','P00005',60,'10/06/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10027,'M0004','P00006',50,'14/07/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10028,'M0007','P00007',60,'14/07/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10029,'M0007','P00008',70,'19/08/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10030,'M0003','P00012',55,'19/08/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10031,'M0002','P00014',45,'19/08/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10032,'M0003','P00009',50,'22/09/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10033,'M0005','P00015',50,'22/09/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10034,'M0001','P00010',50,'25/09/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10035,'M0007','P00013',50,'25/10/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10036,'M0005','P00011',50,'25/10/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10037,'M0007','P00006',50,'27/11/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10038,'M0001','P00008',50,'27/11/2021',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10039,'M0002','P00012',50,'28/12/2021',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10040,'M0001','P00013',50,'29/12/2021',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10041,'M0006','P00014',50,'30/12/2021',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10042,'M0007','P00010',50,'30/12/2021',0,'Sin Descripcion')  
go

INSERT INTO Reservas VALUES(10043,'M0001','P00002',40,'02/01/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10044,'M0003','P00003',50,'02/01/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10045,'M0005','P00008',30,'05/01/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10046,'M0007','P00005',40,'05/01/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10047,'M0007','P00006',60,'05/02/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10048,'M0006','P00004',50,'08/02/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10049,'M0003','P00007',60,'08/02/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10050,'M0005','P00010',70,'12/03/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10051,'M0007','P00014',55,'12/03/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10052,'M0007','P00013',45,'13/03/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10053,'M0002','P00012',50,'15/03/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10054,'M0003','P00011',50,'15/04/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10055,'M0002','P00015',50,'18/04/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10056,'M0004','P00002',50,'18/04/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10057,'M0006','P00010',50,'20/05/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10058,'M0006','P00004',50,'20/05/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10059,'M0001','P00003',50,'22/05/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10060,'M0007','P00013',50,'24/06/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10061,'M0006','P00015',50,'24/06/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10062,'M0006','P00007',50,'27/06/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10063,'M0007','P00001',50,'27/07/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10064,'M0002','P00006',50,'29/07/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10065,'M0002','P00004',50,'30/07/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10066,'M0003','P00001',50,'30/07/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10067,'M0001','P00001',50,'31/08/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10068,'M0003','P00002',50,'31/08/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10069,'M0005','P00003',30,'31/08/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10070,'M0001','P00004',20,'02/09/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10071,'M0002','P00005',40,'02/09/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10072,'M0004','P00006',50,'04/09/2022',0,'Sin Descripcion') 
INSERT INTO Reservas VALUES(10073,'M0003','P00013',50,'07/10/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10074,'M0005','P00008',30,'07/10/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10075,'M0007','P00015',40,'10/10/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10076,'M0007','P00014',60,'10/11/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10077,'M0005','P00004',50,'10/11/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10078,'M0005','P00002',60,'15/11/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10079,'M0005','P00007',70,'15/12/2022',2,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10080,'M0007','P00008',55,'19/12/2022',0,'Sin Descripcion')  
INSERT INTO Reservas VALUES(10081,'M0004','P00003',45,'19/12/2022',0,'Sin Descripcion')
GO

SET NOCOUNT OFF
GO

UPDATE Reservas
	SET estado=0,
	    descrip='Hamburguesas+Queso'
GO	

UPDATE Reservas
	SET estado=0,
	    descrip='Parrilla Personal'
WHERE nroreservas%3=0 
GO	

UPDATE Reservas
	SET estado=0,
	    descrip='Hamburguesas Clasicas'
WHERE nroreservas%2=0
GO	

PRINT 'BASE DE DATOS: BDRESERVA_WEBAPI_REACT, CREADA CORRECTAMENTE'
PRINT 'FECHA:'+CONVERT(VARCHAR(20),GETDATE())
GO
SELECT MENSAJE='BASE DE DATOS: BDRESERVA_WEBAPI_REACT CREADA CORRECTAMENTE '
UNION ALL
SELECT 'FECHA:'+CONVERT(VARCHAR(20),GETDATE())
GO

select*from Reservas