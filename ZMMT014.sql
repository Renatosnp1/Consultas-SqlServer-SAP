USE [unifort_prod]
GO
SELECT		FORMAT(DTCAD,  'dd/MM/yyyy', 'pt-BR') AS 'DATA', 
			COUNT(DTCAD) AS 'QTDE'
		FROM [unifort_prod].[dbo].[ZMMT014]
		WHERE DTCAD >= '01/10/2022'
		GROUP BY DTCAD;

