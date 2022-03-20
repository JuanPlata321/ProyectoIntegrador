-- -----------------------------------------------------
-- Database selection
-- -----------------------------------------------------

USE MASHINDATABASE;

-- -----------------------------------------------------
-- Sentence for the search for a vehicle by brand
-- -----------------------------------------------------

SET @SQLVEHICULOPORMARCA = 'SELECT * FROM VEHICULOS WHERE MARCA=?';

-- -----------------------------------------------------
-- Information entered by the user
-- -----------------------------------------------------

SET @LOGIN_MARCA = 'BMW';

-- -----------------------------------------------------
-- Execution of the sentence
-- -----------------------------------------------------

PREPARE LOGIN FROM @SQLVEHICULOPORMARCA;
EXECUTE LOGIN USING @LOGIN_MARCA;