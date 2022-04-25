-- -----------------------------------------------------
-- Database selection
-- -----------------------------------------------------

USE MASHINDATABASE;

-- -----------------------------------------------------
-- Sentence for search a employee by name
-- -----------------------------------------------------

SET @SQLEMPLEADOPORNOMBRE = 'SELECT * FROM EMPLEADO WHERE NOMBRE=?';

-- -----------------------------------------------------
-- Information entered by the user
-- -----------------------------------------------------

SET @LOGIN_NOMBRE = 'Maria Fernanda';

-- -----------------------------------------------------
-- Execution of the sentence
-- -----------------------------------------------------

PREPARE LOGIN FROM @SQLEMPLEADOPORNOMBRE;
EXECUTE LOGIN USING @LOGIN_NOMBRE;