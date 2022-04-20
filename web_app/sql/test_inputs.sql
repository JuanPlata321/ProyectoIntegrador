-- -----------------------------------------------------
-- Database selection
-- -----------------------------------------------------

USE MASHINDATABASE;

-- -----------------------------------------------------
-- Insert into VEHICLE
-- -----------------------------------------------------

SET GLOBAL local_infile = 'ON';

LOAD DATA LOCAL INFILE 'D:/Upload/Vehicle_catalog.txt' INTO TABLE VEHICULOS
FIELDS TERMINATED BY '\t'
(MARCA, MODELO, AÑO, DESCRIPCION, TIPO, IMAGEN_URL, UNIDADES_STOCK, VALOR_UNITARIO);

-- -----------------------------------------------------
-- Insert into CLIENTE
-- -----------------------------------------------------

INSERT INTO CLIENTE (CEDULA, NOMBRE, APELLIDO, CORREO_ELECTRONICO, CONTACTO,DIRECCION)
VALUES ('1125875542', 'Juan Ramiro', 'Acosta Rincon', 'juanAcosta@gmail.com', '3143879432', 'Carrera 20 # 5-70');

INSERT INTO CLIENTE (CEDULA, NOMBRE, APELLIDO, CORREO_ELECTRONICO, CONTACTO,DIRECCION)
VALUES ('27988468', 'Laura Andrea', 'Diaz Soto', 'laura_diazRuiz@gmail.com', '3154902281', 'Calle 45 # 33-50');


INSERT INTO CLIENTE (CEDULA, NOMBRE, APELLIDO, CORREO_ELECTRONICO, CONTACTO,DIRECCION)
VALUES ('1119077205', 'Andres Joaquin', 'Villegas Castro', 'andJoaVillegas@gmail.com', '3019420124', 'Carrera 21 # 55 - 33 Avenida Colón');

-- -----------------------------------------------------
-- Insert into ESTADO_EMPLEADO
-- -----------------------------------------------------

INSERT INTO ESTADO_EMPLEADO (ID_ESTADO_EMPLEADO, DESCRIPCION)
VALUES (1, 'Estado activo dentro del sistema');

INSERT INTO ESTADO_EMPLEADO (ID_ESTADO_EMPLEADO, DESCRIPCION)
VALUES (2, 'Estado inactivo dentro del sistema');

INSERT INTO ESTADO_EMPLEADO (ID_ESTADO_EMPLEADO, DESCRIPCION)
VALUES (3, 'Estado fuera de servicio dentro del sistema');

-- -----------------------------------------------------
-- Insert into DEPARTAMENTO_AREA
-- -----------------------------------------------------

INSERT INTO DEPARTAMENTO_AREA (ID_DEPARTAMENTO_AREA, DESCRIPCION)
VALUES (1,'Departamento de asesoramiento comercial');

INSERT INTO DEPARTAMENTO_AREA (ID_DEPARTAMENTO_AREA, DESCRIPCION)
VALUES (2,'Departamento de direccion o gerencia');

INSERT INTO DEPARTAMENTO_AREA (ID_DEPARTAMENTO_AREA, DESCRIPCION)
VALUES (3,'Departamento o area de caja');

-- -----------------------------------------------------
-- Insert into EMPLEADO
-- -----------------------------------------------------

INSERT INTO EMPLEADO (CEDULA, NOMBRE, APELLIDOS, CORREO_ELECTRONICO, CONTACTO, DIRECCION, CONTRASENA ,DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA, ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO)
VALUES ('7854088', 'Guillermo', 'Vera Ramirez', 'GuillermoVera2022@mashin.com', '3108769241', 'Calle 7 # 1-30 ', 'aaf95ed3e5aa02d08d433ff15772ca4c7e913fdcda8f15c141f50084c42e8d50', 1, 1); -- CONTRASENA: GuillermoVeraSoyYo

INSERT INTO EMPLEADO (CEDULA, NOMBRE, APELLIDOS, CORREO_ELECTRONICO, CONTACTO, DIRECCION, CONTRASENA ,DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA, ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO)
VALUES ('27540732', 'Maria Fernanda', 'Ruiz Ruiz', 'MariaRuiz2022@mashin.com', '3524989994', 'Carrera 27 # 54-60 piso 2', '98ab561f3d355f276faf71a58ae0f476538e5a3f0e25a565818cbf10b7ee52c6', 2, 1); -- CONTRASENA: mafe_Ruiz10

INSERT INTO EMPLEADO (CEDULA, NOMBRE, APELLIDOS, CORREO_ELECTRONICO, CONTACTO, DIRECCION, CONTRASENA ,DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA, ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO)
VALUES ('1102724442', 'Carlos Julian', 'Guevara Serrano', 'CarlosGuevara2022@mashin.com', '3162051264', 'Carrera 15 # 33-55', 'e37f6e4c7a3d3dd7d9a66b7746ab3a2f5a092ad4155221a7579964dfcc173824', 3, 1); -- CONTRASENA: Carlos1102724442*/

-- -----------------------------------------------------
-- Insert and update into VEHICULO
-- -----------------------------------------------------

INSERT INTO VEHICULOS(MARCA, MODELO, AÑO, DESCRIPCION, TIPO, IMAGEN_URL, UNIDADES_STOCK, VALOR_UNITARIO) 
VALUES ("Chevrolet", "Onix", "2018", "Configuration Combustion. Internal Combustion Engine. Displacement 1 l. Displacement 999 – 1389 cc.", "Sedan", "https://s1.cdn.autoevolution.com/images/gallery/CHEVROLETOnix-4681_1.jpg", 2, 50000000);

UPDATE VEHICULOS
SET MARCA = "Chevrolet", MODELO = "Onix", AÑO = "2018", DESCRIPCION = "Configuration Combustion. Internal Combustion Engine. Displacement 1 l. Displacement 999 – 1389 cc.", TIPO = "Sedan", IMAGEN_URL = "https://s1.cdn.autoevolution.com/images/gallery/CHEVROLETOnix-4681_1.jpg", UNIDADES_STOCK = 7, VALOR_UNITARIO = 50000000
WHERE ID_VEHICULOS = 128;

-- -----------------------------------------------------
-- Insert into ORDEN_COMPRA
-- -----------------------------------------------------

INSERT INTO ORDEN_COMPRA (FECHA_EMISION_ORDEN, NOMBRE_RESPONSABLE, PORCENTAJE_DESCUENTOS, IMPUESTOS, SUBTOTAL, VALOR_TOTAL, CLIENTE_ID_CLIENTE, EMPLEADO_ID_EMPLEADO)
VALUES ( Now(), 'Cristian Julian Muñoz Buenahora', 0, 19, 0, 0, 1, 3);

INSERT INTO ORDEN_COMPRA (FECHA_EMISION_ORDEN, NOMBRE_RESPONSABLE, PORCENTAJE_DESCUENTOS, IMPUESTOS, SUBTOTAL, VALOR_TOTAL, CLIENTE_ID_CLIENTE, EMPLEADO_ID_EMPLEADO)
VALUES ( Now(), 'Cristian Julian Muñoz Buenahora', 20, 7, 0, 0, 2, 3);

INSERT INTO ORDEN_COMPRA (FECHA_EMISION_ORDEN, NOMBRE_RESPONSABLE, PORCENTAJE_DESCUENTOS, IMPUESTOS, SUBTOTAL, VALOR_TOTAL, CLIENTE_ID_CLIENTE, EMPLEADO_ID_EMPLEADO)
VALUES ( Now(), 'Cristian Julian Muñoz Buenahora', 20, 19, 0, 0, 2, 3);

-- -----------------------------------------------------
-- Insert into ORDEN_COMPRA_HAS_VEHICULOS
-- -----------------------------------------------------

INSERT INTO ORDEN_COMPRA_HAS_VEHICULOS(ORDEN_COMPRA_ID_ORDEN_COMPRA, VEHICULOS_ID_VEHICULOS) 
VALUES (1, 100);

INSERT INTO ORDEN_COMPRA_HAS_VEHICULOS(ORDEN_COMPRA_ID_ORDEN_COMPRA, VEHICULOS_ID_VEHICULOS) 
VALUES (1, 101);

INSERT INTO ORDEN_COMPRA_HAS_VEHICULOS(ORDEN_COMPRA_ID_ORDEN_COMPRA, VEHICULOS_ID_VEHICULOS) 
VALUES (2, 50);

INSERT INTO ORDEN_COMPRA_HAS_VEHICULOS(ORDEN_COMPRA_ID_ORDEN_COMPRA, VEHICULOS_ID_VEHICULOS) 
VALUES (2, 70);

INSERT INTO ORDEN_COMPRA_HAS_VEHICULOS(ORDEN_COMPRA_ID_ORDEN_COMPRA, VEHICULOS_ID_VEHICULOS) 
VALUES (3, 5);

-- -----------------------------------------------------
-- Insert into FACTURA
-- -----------------------------------------------------

INSERT INTO FACTURA(FECHA_EMISION_FACTURA, DATOS_EMPRESA, ORDEN_COMPRA_ID_ORDEN_COMPRA)
VALUES (NOW(), "NIT: 7445722532, Direccion: Km. 7 vía Piedecuesta", 1);

INSERT INTO FACTURA(FECHA_EMISION_FACTURA, DATOS_EMPRESA, ORDEN_COMPRA_ID_ORDEN_COMPRA)
VALUES (NOW(), "NIT: 7445722532, Direccion: Km. 7 vía Piedecuesta", 2);

-- -----------------------------------------------------
-- Some useful sentences for debugging
-- -----------------------------------------------------

-- DELETE FROM orden_compra WHERE 1=1;
-- DELETE FROM ORDEN_COMPRA_HAS_VEHICULOS WHERE 1=1;
-- ALTER TABLE ORDEN_COMPRA AUTO_INCREMENT=1;

-- SELECT * FROM orden_compra_has_vehiculos;
-- SELECT * FROM orden_compra;
-- SELECT * FROM vehiculos;
-- SELECT * FROM REGISTRO_MOVIMIENTO_VEHICULOS;

-- SELECT VALOR_UNITARIO FROM vehiculos WHERE ID_VEHICULOS = 2;

-- UPDATE ORDEN_COMPRA SET SUBTOTAL=78509716, VALOR_TOTAL=74741250 WHERE ID_ORDEN_COMPRA = 3;
-- DELETE FROM ORDEN_COMPRA_HAS_VEHICULOS WHERE VEHICULOS_ID_VEHICULOS = 115;

USE MASHINDATABASE;

SELECT * FROM CLIENTE WHERE CORREO_ELECTRONICO = 'GuillermoVera2022@mashin.com';


ALTER TABLE EMPLEADO MODIFY CONTRASENA varchar(256);
UPDATE EMPLEADO SET CONTRASENA = 'e37f6e4c7a3d3dd7d9a66b7746ab3a2f5a092ad4155221a7579964dfcc173824' WHERE CORREO_ELECTRONICO = 'CarlosGuevara2022@mashin.com';