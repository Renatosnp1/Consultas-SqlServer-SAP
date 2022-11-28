USE SAP_DIV
GO
ALTER VIEW view_ksb1_422645 AS
	SELECT [Data de lançamento]
		  ,[Valor/MR]
		  ,[Centro]
		  ,[Divisão]
		  ,[Descrição da conta de contrapartida]
		  ,[Denomin.da conta de contrapartida]
		  ,[Classe de custo]
		  ,[Nº documento]
	  FROM KSB1
	  WHERE [Classe de custo] = '422645';

SELECT * FROM view_ksb1_422645;


USE SAP_DIV
GO
ALTER VIEW view_ksb1_all_classes AS
	SELECT [Data de lançamento]
		  ,[Valor/MR]
		  ,[Divisão]
		  ,[Descrição da conta de contrapartida]
		  ,[Denomin.da conta de contrapartida]
		  ,[Classe de custo]
		  ,[Centro custo]
		  ,[Denom.classe custo]
		  ,[Denominação de objeto]
	  FROM KSB1 WHERE [Valor/MR] <> 0;
GO


--DELETE FROM [SAP_DIV].[dbo].KSB1 WHERE [Nº documento] = '';
--DELETE [SAP_DIV].[dbo].KSB1 WHERE [Data de lançamento] BETWEEN  '01/05/2022' and '31/05/2022';

USE SAP_DIV
GO
SELECT *  FROM KSB1 WHERE [Data de lançamento] BETWEEN '01/10/2022' AND '31/10/2022';
GO

DELETE  FROM KSB1 WHERE [Data de lançamento] BETWEEN '01/10/2022' AND '31/10/2022';
GO