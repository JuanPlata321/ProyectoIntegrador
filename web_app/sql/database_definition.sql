SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Database creation and selection
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `MashinDataBase` ;
CREATE SCHEMA IF NOT EXISTS `MashinDataBase`;
USE `MashinDataBase` ;

-- -----------------------------------------------------
-- Creation table `CLIENTE`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `CLIENTE` ;

CREATE TABLE IF NOT EXISTS `CLIENTE` (
  `ID_CLIENTE` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID permite identificar el indice de un cliente dentro del conjunto de clientes de la concesionaria registrados en el sistema',
  `CEDULA` VARCHAR(15) NOT NULL COMMENT 'Este campo hace referencia al numero de identificacion personal del cliente dentro del territorio nacional',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al nombre o los nombres (En caso de ser mas de uno) de un cliente que hace parte de la concesionaria',
  `APELLIDO` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al apellido (En caso de ser unicamente uno) o apellidos de un cliente que hace parte de la concesionaria',
  `CORREO_ELECTRONICO` VARCHAR(45) NULL COMMENT 'Este campo hace referencia al correo electronico de un cliente que pertenece a la concesionaria',
  `CONTACTO` VARCHAR(15) NULL COMMENT 'Este campo hace referencia al numero de contacto del cliente que hace parte de la concesionaria, este numero de contacto puede ser bien sea numero de telefono fijo o celular',
  `DIRECCION` VARCHAR(70) NOT NULL COMMENT 'Este campo hace referencia a la direccion de residencia de un cliente que hace parte de la concesionaria',
  PRIMARY KEY (`ID_CLIENTE`))
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar los diferentes clientes que hacen parte de la concesionaria';

CREATE UNIQUE INDEX `CEDULA_UNIQUE` ON `CLIENTE` (`CEDULA`);

CREATE UNIQUE INDEX `CORREO_ELECTRONICO_UNIQUE` ON `CLIENTE` (`CORREO_ELECTRONICO`);

CREATE UNIQUE INDEX `CONTACTO_UNIQUE` ON `CLIENTE` (`CONTACTO`);

-- -----------------------------------------------------
-- Creation table `DEPARTAMENTO_AREA`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `DEPARTAMENTO_AREA` ;

CREATE TABLE IF NOT EXISTS `DEPARTAMENTO_AREA` (
  `ID_DEPARTAMENTO_AREA` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID representa un area o departamento especifico de la concesionaria, es decir, si es el area o departamento de asesoramiento comercial, de direccion o gerencia, o si por el contrario es el de caja',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Este campo me permite especificar o exclarecer a que se refiere determinado ID para representar un area o departamento de la concesionaria',
  PRIMARY KEY (`ID_DEPARTAMENTO_AREA`))
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar las diferentes areas o departamentos que se encuentran dentro de la concesionaria';

-- -----------------------------------------------------
-- Creation table `EMPLEADO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `EMPLEADO` (
  `ID_EMPLEADO` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID permite identificar el indice de un empleado dentro del conjunto de empleados o personal de la concesionaria',
  `CEDULA` VARCHAR(15) NOT NULL COMMENT 'Este campo hace referencia al numero de identificacion personal del empleado dentro del territorio nacional',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al nombre o los nombres (En caso de ser mas de uno) de un empleado que hace parte de la concesionaria',
  `APELLIDOS` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al apellido (En caso de ser unicamente uno) o los apellidos de un empleado que hace parte de la concesionaria',
  `CORREO_ELECTRONICO` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al correo electronico de un empleado, este correo pertenece dominio de la concesionaria',
  `CONTACTO` VARCHAR(15) NULL COMMENT 'Este campo hace referencia al numero de contacto del empleado que hace parte de la concesionaria, este numero de contacto puede ser bien sea numero de telefono fijo o celular',
  `DIRECCION` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia a la direccion de residencia del empleado que hace parte del personal de la concesionaria',
  `CONTRASENA` VARCHAR(256) NOT NULL COMMENT 'Este campo hace referencia a la contraseña designada por un empleado para el acceso al sistema de la concesionaria con su perfil',
  `DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA` INT NOT NULL COMMENT 'Este campo ID representa un area o departamento especifico de la concesionaria en el cual este empleado tiene designado para hacer sus labores, es decir, si es el area o departamento de asesoramiento comercial, de direccion o gerencia, o si por el contrario es el de caja',
  `ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO` INT NOT NULL,
  PRIMARY KEY (`ID_EMPLEADO`),
  CONSTRAINT `fk_EMPLEADO_DEPARTAMENTO_AREA1`
    FOREIGN KEY (`DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA`)
    REFERENCES `DEPARTAMENTO_AREA` (`ID_DEPARTAMENTO_AREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_ESTADO_EMPLEADO1`
    FOREIGN KEY (`ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO`)
    REFERENCES `ESTADO_EMPLEADO` (`ID_ESTADO_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar los empleados que hacen parte del personal de la concesionaria';

CREATE INDEX `fk_EMPLEADO_DEPARTAMENTO_AREA1_idx` ON `EMPLEADO` (`DEPARTAMENTO_AREA_ID_DEPARTAMENTO_AREA`);

CREATE UNIQUE INDEX `CEDULA_UNIQUE` ON `EMPLEADO` (`CEDULA`);

CREATE UNIQUE INDEX `CORREO_ELECTRONICO_UNIQUE` ON `EMPLEADO` (`CORREO_ELECTRONICO`);

CREATE UNIQUE INDEX `CONTACTO_UNIQUE` ON `EMPLEADO` (`CONTACTO`);

CREATE INDEX `fk_EMPLEADO_ESTADO_EMPLEADO1_idx` ON `EMPLEADO` (`ESTADO_EMPLEADO_ID_ESTADO_EMPLEADO`);

-- -----------------------------------------------------
-- Creation table `ESTADO_EMPLEADO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ESTADO_EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `ESTADO_EMPLEADO` (
  `ID_ESTADO_EMPLEADO` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID representa el estado actual de un usario dentro del sistema, es decir, si se encuentra activo, inactivo o fuera de servicio',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Este campo me permite especificar o exclarecer a que se refiere determinado ID para representar un estado de un empleado dentro del sistema',
  PRIMARY KEY (`ID_ESTADO_EMPLEADO`))
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar los diferentes estados de los empleados  dentro del sistema de la concesionaria';


-- -----------------------------------------------------
-- Creation table `FACTURA`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `FACTURA` ;

CREATE TABLE IF NOT EXISTS `FACTURA` (
  `ID_FACTURA` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID hace referencia al indice de la factura de todo el conjunto de facturas generadas dentro del sistema',
  `FECHA_EMISION_FACTURA` TIMESTAMP NOT NULL COMMENT 'Este campo hace referencia a la fecha exacta en que se emite la factura de venta',
  `DATOS_EMPRESA` VARCHAR(250) NOT NULL COMMENT 'Este campo hace referencia a toda la informacion en general que se incluye dentro de la factura de venta acerca de la concesionaria',
  `ORDEN_COMPRA_ID_ORDEN_COMPRA` INT NOT NULL COMMENT 'Este campo ID hace referencia al indice de una orden de compra dentro del conjunto de las mismas registrados en el sistema de la concesionaria con la cual se genero la factura de venta',
  PRIMARY KEY (`ID_FACTURA`),
  CONSTRAINT `fk_FACTURA_ORDEN_COMPRA1`
    FOREIGN KEY (`ORDEN_COMPRA_ID_ORDEN_COMPRA`)
    REFERENCES `ORDEN_COMPRA` (`ID_ORDEN_COMPRA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar las diferentes facturas que se generan dentro del sistema de la concesionaria';

CREATE INDEX `fk_FACTURA_ORDEN_COMPRA1_idx` ON `FACTURA` (`ORDEN_COMPRA_ID_ORDEN_COMPRA`);


-- -----------------------------------------------------
-- Creation table `GARANTIAS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `GARANTIAS` ;

CREATE TABLE IF NOT EXISTS `GARANTIAS` (
  `ID_GARANTIA` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID hace referencia al indice de una garantia de todo el conjunto de garantias solicitadas y generadas dentro del sistema',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Este campo hace referencia a la descripcion de la garantia en especifico, es decir, porque se genera la garantia, que fallas esta teniendo el vehiculo adquirido, etc',
  `FACTURA_ID_FACTURA` INT NOT NULL COMMENT 'Este campo ID hace referencia al indice de la factura de todo el conjunto de facturas generadas dentro del sistema con la cual se da soporte o se establece a la garantia',
  PRIMARY KEY (`ID_GARANTIA`),
  CONSTRAINT `fk_GARANTIAS_FACTURA1`
    FOREIGN KEY (`FACTURA_ID_FACTURA`)
    REFERENCES `FACTURA` (`ID_FACTURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar las diferentes garantias que se generan a base de la compra un vehiculo dentro del sistema de la concesionaria';

CREATE INDEX `fk_GARANTIAS_FACTURA1_idx` ON `GARANTIAS` (`FACTURA_ID_FACTURA`);


-- -----------------------------------------------------
-- Creation table `HISTORICO_PRECIO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `HISTORICO_PRECIO` ;

CREATE TABLE IF NOT EXISTS `HISTORICO_PRECIO` (
  `ID_HISTORICO` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID representa el indice del historico de precios de un vehiculo',
  `VALOR_UNITARIO_INSERTADO` INT UNSIGNED NOT NULL COMMENT 'Este campo representa el valor unitario o precio nuevo que se inserta o se modifica para un vehiculo que hace parte del catalogo de la concesionaria ',
  `VALOR_UNITARIO_REEMPLAZADO` INT UNSIGNED NULL COMMENT 'Este campo representa el valor unitario o precio anterior que tenia un vehiculo que hace parte del catalogo de la concesionaria antes de ser reemplazado',
  `FECHA_MODIFICACION` DATE NOT NULL COMMENT 'Este campo representa la fecha en la que se realizo la insercion o modificacion de un precio para un vehiculo que hace parte del catalogo',
  `VEHICULOS_ID_VEHICULOS` INT NOT NULL COMMENT 'Este campo ID representa el indice de un vehiculo del catalogo de la concesionaria',
  PRIMARY KEY (`ID_HISTORICO`),
  CONSTRAINT `fk_HISTORICO_PRECIO_VEHICULOS1`
    FOREIGN KEY (`VEHICULOS_ID_VEHICULOS`)
    REFERENCES `VEHICULOS` (`ID_VEHICULOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite llevar un registro del historico de precios de los vehiculos dentro de la concesionaria';

CREATE INDEX `fk_HISTORICO_PRECIO_VEHICULOS1_idx` ON `HISTORICO_PRECIO` (`VEHICULOS_ID_VEHICULOS`);


-- -----------------------------------------------------
-- Creation table `LOGS_SISTEMA`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `LOGS_SISTEMA` ;

CREATE TABLE IF NOT EXISTS `LOGS_SISTEMA` (
  `ID_LOG` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID permite identificar el indice de determinado log o registro dentro del conjunto de logs o registros del sistema',
  `FECHA` TIMESTAMP NOT NULL COMMENT 'Este campo permite almacenar la fecha exacta en que se realizo determinada accion o peticion dentro del sistema por un usuario',
  `ACCION` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia a la accion en concreto que realizo un usuario dentro del sistema',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Este campo permite tener una informacion mas detallada de la accion o peticion que se realizo, es decir, en este campo por ejemplo si se elimino un item de un inventario, aqui podria conocer que item en concreto fue eliminado, mientras que en la accion simplemente sabria que se elimino un item',
  `TIPO_USUARIO` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al tipo de usuario dentro del sistema, bien sea empleado o cliente que realizo determinada accion o peticion dentro del sistema',
  `ID_USUARIO` INT NOT NULL COMMENT 'Este campo hace referencia al ID bien sea de un cliente o de un empleado el cual realizo determinada accion o peticion dentro del sistema',
  PRIMARY KEY (`ID_LOG`))
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar la trazabilidad de los usuarios en el sistema, bien sean clientes o empleados';


-- -----------------------------------------------------
-- Creation table `ORDEN_COMPRA`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ORDEN_COMPRA` ;

CREATE TABLE IF NOT EXISTS `ORDEN_COMPRA` (
  `ID_ORDEN_COMPRA` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID permite identificar el indice de una orden de compra dentro del conjunto de las mismas registrados en el sistema de la concesionaria ',
  `FECHA_EMISION_ORDEN` TIMESTAMP NOT NULL COMMENT 'Este campo hace referencia a la fecha exacta en que el empleado de la concesionaria genera la orden de compra en base a la peticion del cliente ',
  `NOMBRE_RESPONSABLE` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al empleado o gerente de la concesionaria que se encarga de llevar a cabo o resolver una dicha orden de compra generada',
  `PORCENTAJE_DESCUENTOS` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia al porcentaje de descuento al valor total que tiene el cliente por los productos que desea adquirir',
  `IMPUESTOS` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia al valor de los impuestos generados por los productos descritos en la orden de compra, teniendo en cuenta el porcentaje que define el estado colombiano para este apartado',
  `SUBTOTAL` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia al valor parcial de la orden de compra, en este se suman el valor de todos los items de los productos que se ordenaron y se la aplican los impuestos definidos',
  `VALOR_TOTAL` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia al valor total que el cliente debe cancelar a la concesionaria por los productos descritos en la orden de compra. El valor total es el resultado de aplicarle al valor subtotal el porcentaje de descuentos y otra serie de impuestos en casos de ser necesarios',
  `CLIENTE_ID_CLIENTE` INT NOT NULL COMMENT 'Este campo ID hace referencia al ID del cliente que solicita la orden de compra',
  `EMPLEADO_ID_EMPLEADO` INT NOT NULL COMMENT 'Este campo ID hace referencia al ID del empleado que genera la orden de compra',
  PRIMARY KEY (`ID_ORDEN_COMPRA`),
  CONSTRAINT `fk_ORDEN_COMPRA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_ID_CLIENTE`)
    REFERENCES `CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDEN_COMPRA_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_ID_EMPLEADO`)
    REFERENCES `EMPLEADO` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar las diferentes ordenes de compra que se generan dentro del sistema';

CREATE INDEX `fk_ORDEN_COMPRA_CLIENTE1_idx` ON `ORDEN_COMPRA` (`CLIENTE_ID_CLIENTE`);

CREATE INDEX `fk_ORDEN_COMPRA_EMPLEADO1_idx` ON `ORDEN_COMPRA` (`EMPLEADO_ID_EMPLEADO`);


-- -----------------------------------------------------
-- Creation table `ORDEN_COMPRA_has_VEHICULOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `ORDEN_COMPRA_has_VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `ORDEN_COMPRA_has_VEHICULOS` (
  `ORDEN_COMPRA_ID_ORDEN_COMPRA` INT NOT NULL COMMENT 'Este campo ID permite identificar el indice de una orden de compra dentro del conjunto de las mismas registrados en el sistema de la concesionaria ',
  `VEHICULOS_ID_VEHICULOS` INT NOT NULL COMMENT 'Este campo ID representa el indice de un vehiculo del catalogo de la concesionaria el cual esta incluido en la orden de compra generada',
  PRIMARY KEY (`ORDEN_COMPRA_ID_ORDEN_COMPRA`, `VEHICULOS_ID_VEHICULOS`),
  CONSTRAINT `fk_ORDEN_COMPRA_has_VEHICULOS_ORDEN_COMPRA1`
    FOREIGN KEY (`ORDEN_COMPRA_ID_ORDEN_COMPRA`)
    REFERENCES `ORDEN_COMPRA` (`ID_ORDEN_COMPRA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDEN_COMPRA_has_VEHICULOS_VEHICULOS1`
    FOREIGN KEY (`VEHICULOS_ID_VEHICULOS`)
    REFERENCES `VEHICULOS` (`ID_VEHICULOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite la interaccion entre una orden de compra y un vehiculo de tal forma de que una orden de compra pueda estar compuesta por mas de un vehiculo y no necesariamente de uno solo';

CREATE INDEX `fk_ORDEN_COMPRA_has_VEHICULOS_VEHICULOS1_idx` ON `ORDEN_COMPRA_has_VEHICULOS` (`VEHICULOS_ID_VEHICULOS`);

CREATE INDEX `fk_ORDEN_COMPRA_has_VEHICULOS_ORDEN_COMPRA1_idx` ON `ORDEN_COMPRA_has_VEHICULOS` (`ORDEN_COMPRA_ID_ORDEN_COMPRA`);

-- -----------------------------------------------------
-- Creation table `VEHICULOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `VEHICULOS` (
  `ID_VEHICULOS` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID representa el indice de un vehiculo del catalogo de la concesionaria',
  `MARCA` VARCHAR(45) NOT NULL COMMENT 'Este campo representa la marca del vehiculo que hace parte del catalogo de la concesionaria',
  `MODELO` VARCHAR(10) NOT NULL COMMENT 'Este campo hace referencia al modelo del vehiculo que hace parte del catálogo',
  `AÑO` VARCHAR(10) NOT NULL COMMENT 'Este campo hace referencia al año de lanzamiento del vehiculo',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Este campo hace referencia a la descripcion completa del vehiculo que hace parte del catalogo, es decir, por ejemplo “Citroën C4 5P BlueHDi 150 Shine”.',
  `TIPO` VARCHAR(45) NOT NULL COMMENT 'Este campo hace referencia al tipo de vehiculo o grupo del cual hace parte un vehiculo del catalogo de la concesionaria, es decir, por ejemplo si es de tipo deportiivo, sedan, crossover, etc.',
  `IMAGEN_URL` VARCHAR(250) NOT NULL COMMENT 'Este campo hace referencia a la imagen representativa de un vehiculo que hace parte del catalogo de la concesionaria',
  `UNIDADES_STOCK` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia a las unidades disponibles o en stock de determinado vehiculo que hace parte del catologo de la concesionaria',
  `VALOR_UNITARIO` INT UNSIGNED NOT NULL COMMENT 'Este campo hace referencia al valor unitario o precio de determinado vehiculo que hace parte del catalogo de la concesionaria',
  PRIMARY KEY (`ID_VEHICULOS`))
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar los vehiculos que hacen parte del catalogo de la concesionaria';

-- -----------------------------------------------------
-- Creation table `REGISTRO_MOVIMIENTO_VEHICULOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `REGISTRO_MOVIMIENTO_VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `MashinDataBase`.`REGISTRO_MOVIMIENTO_VEHICULOS` (
  `ID_REGISTRO_MOVIMIENTO_VEHICULOS` INT NOT NULL AUTO_INCREMENT COMMENT 'Este campo ID hacce referenncia al identificador del registro del movimiento realizaod en la base de datos del vehículo',
  `FECHA_REGISTRO` TIMESTAMP NOT NULL COMMENT 'Este campo hace referencia a la fecha en que realizó la acción y se generó el registro',
  `DESCRIPCION` VARCHAR(250) NOT NULL COMMENT 'Estte campo ID hace referencia a  la descripción de lo que se realizó con el vehículo dentro del inventario',
  `VEHICULOS_ID_VEHICULOS` INT NOT NULL,
  PRIMARY KEY (`ID_REGISTRO_MOVIMIENTO_VEHICULOS`),
  CONSTRAINT `fk_REGISTRO_MOVIMIENTO_VEHICULOS_VEHICULOS1`
    FOREIGN KEY (`VEHICULOS_ID_VEHICULOS`)
    REFERENCES `MashinDataBase`.`VEHICULOS` (`ID_VEHICULOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite almacenar la trazabilidad de los vehiculos dentro del inventario del sistetma';

CREATE INDEX `fk_REGISTRO_MOVIMIENTO_VEHICULOS_VEHICULOS1_idx` ON `MashinDataBase`.`REGISTRO_MOVIMIENTO_VEHICULOS` (`VEHICULOS_ID_VEHICULOS`);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Definition of triggers to store historical prices
-- -----------------------------------------------------

CREATE TRIGGER HISTORICO_PRECIOS_INSERT AFTER INSERT ON VEHICULOS FOR EACH ROW
INSERT INTO HISTORICO_PRECIO(VALOR_UNITARIO_INSERTADO, VALOR_UNITARIO_REEMPLAZADO, VEHICULOS_ID_VEHICULOS, FECHA_MODIFICACION)
VALUES (NEW.VALOR_UNITARIO, NULL, NEW.ID_VEHICULOS, CURRENT_DATE );

DELIMITER $$
CREATE TRIGGER HISTORICO_PRECIOS_UPDATE BEFORE UPDATE ON VEHICULOS FOR EACH ROW
BEGIN
    IF NEW.VALOR_UNITARIO != OLD.VALOR_UNITARIO THEN
        INSERT INTO HISTORICO_PRECIO(VALOR_UNITARIO_INSERTADO, VALOR_UNITARIO_REEMPLAZADO, VEHICULOS_ID_VEHICULOS, FECHA_MODIFICACION)
        VALUES (NEW.VALOR_UNITARIO, OLD.VALOR_UNITARIO, NEW.ID_VEHICULOS, CURRENT_DATE );
    END IF;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Definition of the trigger to calculate subtotal and total for a purchase order and to reserve a vehicle after generate a purchase order, besides, register vehicle action after associate with a purchase order
-- -----------------------------------------------------

DELIMITER $$
CREATE TRIGGER CALCULAR_SUBTOTAL_TOTAL_ORDEN_COMPRA AFTER INSERT ON ORDEN_COMPRA_has_VEHICULOS FOR EACH ROW
BEGIN
    SELECT UNIDADES_STOCK INTO @UNIDADES_STOCK FROM VEHICULOS WHERE ID_VEHICULOS = NEW.VEHICULOS_ID_VEHICULOS;
    IF @UNIDADES_STOCK > 0 THEN
        BEGIN
	        SELECT VALOR_UNITARIO INTO @VALOR_VEHICULO FROM VEHICULOS WHERE ID_VEHICULOS = NEW.VEHICULOS_ID_VEHICULOS;
	        SELECT PORCENTAJE_DESCUENTOS, IMPUESTOS INTO @DESCUENTOS_ORDEN_COMPRA, @IMPUESTOS_ORDEN_COMPRA FROM ORDEN_COMPRA WHERE ID_ORDEN_COMPRA = NEW.ORDEN_COMPRA_ID_ORDEN_COMPRA;
          UPDATE ORDEN_COMPRA SET SUBTOTAL = SUBTOTAL + @VALOR_VEHICULO, VALOR_TOTAL = ROUND(SUBTOTAL * (1 - @DESCUENTOS_ORDEN_COMPRA / 100) * (@IMPUESTOS_ORDEN_COMPRA / 100 + 1)) WHERE ID_ORDEN_COMPRA = NEW.ORDEN_COMPRA_ID_ORDEN_COMPRA;	
          UPDATE VEHICULOS SET UNIDADES_STOCK = UNIDADES_STOCK - 1 WHERE ID_VEHICULOS = NEW.VEHICULOS_ID_VEHICULOS;
          INSERT INTO REGISTRO_MOVIMIENTO_VEHICULOS(FECHA_REGISTRO, DESCRIPCION, VEHICULOS_ID_VEHICULOS) VALUES (Now(), "Se descontó una unidad en stock para el vehículo asociado", NEW.VEHICULOS_ID_VEHICULOS);
        END;
    ELSE
        DELETE FROM ORDEN_COMPRA_HAS_VEHICULOS WHERE ORDEN_COMPRA_ID_ORDEN_COMPRA = NEW.ORDEN_COMPRA_ID_ORDEN_COMPRA AND VEHICULOS_ID_VEHICULOS = NEW.VEHICULOS_ID_VEHICULOS;
    END IF;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Definition of the trigger to register vehicle action after update or insert at the inventory
-- -----------------------------------------------------

DELIMITER $$
CREATE TRIGGER REGISTRAR_VEHICULOS_INSERT AFTER INSERT ON VEHICULOS FOR EACH ROW
BEGIN
    SELECT ID_VEHICULOS INTO @ID_VEHICULOS FROM VEHICULOS WHERE MARCA = NEW.MARCA AND MODELO = NEW.MODELO AND AÑO = NEW.AÑO AND DESCRIPCION = NEW.DESCRIPCION AND TIPO = NEW.TIPO AND IMAGEN_URL = NEW.IMAGEN_URL AND UNIDADES_STOCK = NEW.UNIDADES_STOCK AND VALOR_UNITARIO = NEW.VALOR_UNITARIO;
    INSERT INTO REGISTRO_MOVIMIENTO_VEHICULOS(FECHA_REGISTRO, DESCRIPCION, VEHICULOS_ID_VEHICULOS) VALUES (Now(), "Se insertó un nuevo vehículo al inventario", @ID_VEHICULOS);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER REGISTRAR_VEHICULOS_UPDATE AFTER UPDATE ON VEHICULOS FOR EACH ROW
BEGIN
    SELECT ID_VEHICULOS INTO @ID_VEHICULOS FROM VEHICULOS WHERE MARCA = NEW.MARCA AND MODELO = NEW.MODELO AND AÑO = NEW.AÑO AND DESCRIPCION = NEW.DESCRIPCION AND TIPO = NEW.TIPO AND IMAGEN_URL = NEW.IMAGEN_URL AND UNIDADES_STOCK = NEW.UNIDADES_STOCK AND VALOR_UNITARIO = NEW.VALOR_UNITARIO;
    INSERT INTO REGISTRO_MOVIMIENTO_VEHICULOS(FECHA_REGISTRO, DESCRIPCION, VEHICULOS_ID_VEHICULOS) VALUES (Now(), CONCAT("Se establecieron ", NEW.UNIDADES_STOCK, " unidades al inventario para el vehículo asociado"), @ID_VEHICULOS);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Insert the vehicle catalog
-- -----------------------------------------------------

SET GLOBAL local_infile = 'ON';

LOAD DATA LOCAL INFILE '/media/USB/Mashin/vehicleCatalog.txt' INTO TABLE VEHICULOS 
FIELDS TERMINATED BY '\t'
(MARCA, MODELO, AÑO, DESCRIPCION, TIPO, IMAGEN_URL, UNIDADES_STOCK, VALOR_UNITARIO);
