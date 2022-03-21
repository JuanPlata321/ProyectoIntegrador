-- -----------------------------------------------------
-- Database selection
-- -----------------------------------------------------

USE MASHINDATABASE;

-- -----------------------------------------------------
-- Definition of the trigger to calculate subtotal and total for a purchase order
-- -----------------------------------------------------

CREATE TRIGGER CALCULAR_SUBTOTAL_TOTAL_ORDEN_COMPRA AFTER INSERT ON ORDEN_COMPRA_HAS_VEHICULOS FOR EACH ROW
BEGIN
	SELECT VALOR_UNITARIO INTO @VALOR_VEHICULO FROM VEHICULOS WHERE ID_VEHICULOS = NEW.VEHICULOS_ID_VEHICULOS;
	SELECT PORCENTAJE_DESCUENTOS, IMPUESTOS INTO @DESCUENTOS_ORDEN_COMPRA, @IMPUESTOS_ORDEN_COMPRA FROM ORDEN_COMPRA WHERE ID_ORDEN_COMPRA = NEW.ORDEN_COMPRA_ID_ORDEN_COMPRA;
    IF @VALOR_VEHICULO != 0 THEN
        UPDATE ORDEN_COMPRA SET SUBTOTAL = SUBTOTAL + @VALOR_VEHICULO, VALOR_TOTAL = ROUND(SUBTOTAL * (1 - @DESCUENTOS_ORDEN_COMPRA / 100) * (@IMPUESTOS_ORDEN_COMPRA / 100 + 1)) WHERE ID_ORDEN_COMPRA = NEW.ORDEN_COMPRA_ID_ORDEN_COMPRA;	
    END IF;
END;

-- -----------------------------------------------------
-- Generate accounting report 
-- -----------------------------------------------------

SELECT 'TOTAL_INGRESOS' AS 'DESCRIPCIÓN', SUM(VALOR_TOTAL) AS 'VALOR' 
FROM ORDEN_COMPRA, FACTURA 
WHERE ID_ORDEN_COMPRA = ORDEN_COMPRA_ID_ORDEN_COMPRA;