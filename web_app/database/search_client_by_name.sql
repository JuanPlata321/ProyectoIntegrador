-- -----------------------------------------------------
-- Database selection
-- -----------------------------------------------------

USE MASHINDATABASE;

-- -----------------------------------------------------
-- Sentence for client a employee by name
-- -----------------------------------------------------

SET @SQLCLIENTEPORNOMBRE = 'SELECT * FROM CLIENTE WHERE NOMBRE=?';

-- -----------------------------------------------------
-- Information entered by the user
-- -----------------------------------------------------

SET @LOGIN_NOMBRE = 'Juan Ramiro';

-- -----------------------------------------------------
-- Execution of the sentence
-- -----------------------------------------------------

PREPARE LOGIN FROM @SQLCLIENTEPORNOMBRE;
EXECUTE LOGIN USING @LOGIN_NOMBRE;