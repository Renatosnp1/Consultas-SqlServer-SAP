DECLARE @h INT;
DECLARE @m INT;
DECLARE @b INT;

SET @h = (SELECT  DATEPART (hour ,GETDATE()));
SET @m = (SELECT  DATEPART (minute ,GETDATE()));
SET @b = 1;

WHILE @b = 1
BEGIN

	IF @h = 5 AND @m >= 30
	BEGIN
		PRINT GETDATE()
		
			BACKUP DATABASE [query_dw]		TO  DISK = N'C:\Users\BKP\query_dw.bak' 	WITH INIT,  NAME = N'query_dw-Completo Banco de Dados Backup'
			BACKUP DATABASE [SAP_BSEG]		TO  DISK = N'C:\Users\BKP\SAP_BSEG.bak'		WITH INIT,  NAME = N'SAP_BSEG-Completo Banco de Dados Backup'
			BACKUP DATABASE [SAP_DIV]		TO  DISK = N'C:\Users\BKP\SAP_DIV.bak'		WITH INIT,  NAME = N'SAP_DIV-Completo Banco de Dados Backup'
			BACKUP DATABASE [SAP_ESTOQUE]	TO  DISK = N'C:\Users\BKP\SAP_ESTOQUE.bak'	WITH INIT,  NAME = N'SAP_ESTOQUE-Completo Banco de Dados Backup'
			BACKUP DATABASE [SAP_KONV]		TO  DISK = N'C:\Users\BKP\SAP_KONV.bak'		WITH INIT,  NAME = N'SAP_KONV-Completo Banco de Dados Backup'
			BACKUP DATABASE [SAP_VBRP]		TO  DISK = N'C:\Users\BKP\SAP_VBRP.bak'		WITH INIT,  NAME = N'SAP_VBRP-Completo Banco de Dados Backup'
			BACKUP DATABASE [unifort_prod]	TO  DISK = N'C:\Users\BKP\unifort_prod.bak' WITH INIT,  NAME = N'unifort_prod-Completo Banco de Dados Backup'
			BACKUP DATABASE [WMS_DIV]		TO  DISK = N'C:\Users\BKP\WMS_DIV.bak'		WITH INIT,  NAME = N'WMS_DIV-Completo Banco de Dados Backup'
			BACKUP DATABASE [ZMM1237]		TO  DISK = N'C:\Users\BKP\ZMM1237.bak'		WITH INIT,  NAME = N'ZMM1237-Completo Banco de Dados Backup'
			--BACKUP DATABASE [ZMM1237] TO  DISK = N'C:\Users\BKP\ZMM1237.bak' WITH NOFORMAT, NOINIT,  NAME = N'ZMM1237-Completo Banco de Dados Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10

		PRINT GETDATE()
		BREAK
	END

	SET @h = (SELECT  DATEPART (hour ,GETDATE()));
	SET @m = (SELECT  DATEPART (minute ,GETDATE()));
	WAITFOR DELAY '00:10:00'

END