SELECT *  FROM [SAP_DIV].[dbo].[HEADCOUNT] WHERE CADASTRO = 'Rela??o de Colaboradores'


SELECT DATA_REL, COUNT(DATA_REL)  FROM [SAP_DIV].[dbo].[HEADCOUNT]
		GROUP BY DATA_REL;



USE query_dw
GO
CREATE VIEW view_HC
AS
SELECT *  FROM [SAP_DIV].[dbo].[HEADCOUNT]

SELECT * FROM view_HC;
