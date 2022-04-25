-- -----------------------------------------------------
-- Sentence to calculate the size of the database
-- -----------------------------------------------------

SELECT
	COUNT(*) AS Total_Table_Count
	,table_schema
	,CONCAT(SUM(table_rows)/1000,'M') AS Total_Row_Count
	,CONCAT(SUM(data_length)/(1024*1024),'M') AS Total_Table_Size
	,CONCAT(SUM(index_length)/(1024*1024),'M') AS Total_Table_Index
	,CONCAT(SUM(data_length+index_length)/(1024*1024),'M') Total_Size
FROM information_schema.TABLES
WHERE table_schema = "mashindatabase";