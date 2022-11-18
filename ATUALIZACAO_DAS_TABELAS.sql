-------------------------------------- VBRK -----------------------------------------------
USE unifort_prod -- 09/11/2022
GO
SELECT		YEAR(ERDAT) as ANO,
			MONTH(ERDAT) as MES,
			DAY(ERDAT) as DIA,
			COUNT(ERDAT) as QTDE
		FROM unifort_prod.dbo.VBRK
		WHERE ERDAT >= '01/10/2022' 
		GROUP BY YEAR(ERDAT), MONTH(ERDAT), DAY(ERDAT)
		ORDER BY 1, 2, 3;
-------------------------------------- VBRP -----------------------------------------------
USE SAP_VBRP -- 01/01/2015 - 07/11/2022
GO
SELECT		YEAR(ERDAT) as ANO,
			MONTH(ERDAT) as MES,
			DAY(ERDAT) as DIA,
			COUNT(ERDAT) as QTDE
		FROM VBRP
		WHERE ERDAT BETWEEN '01/10/2022' AND '31/12/2022'
		GROUP BY YEAR(ERDAT), MONTH(ERDAT), DAY(ERDAT)
		ORDER BY 1, 2, 3;
-------------------------------------- VBAP -----------------------------------------------
USE unifort_prod -- 09/10/2022
GO
SELECT		YEAR(ERDAT) as ANO,
			MONTH(ERDAT) as MES,
			DAY(ERDAT) as DIA,
			COUNT(ERDAT) as QTDE
		FROM VBAP
		WHERE ERDAT >= '01/11/2022' 
		GROUP BY YEAR(ERDAT), MONTH(ERDAT), DAY(ERDAT)
		ORDER BY 1, 2, 3;
-------------------------------------- EKBE -----------------------------------------------
USE unifort_prod -- 09/11/2022
GO
SELECT		YEAR(BUDAT) as ANO,
			MONTH(BUDAT) as MES,
			DAY(BUDAT) as MES,
			COUNT(BUDAT) as QTDE
		FROM EKBE
		WHERE BUDAT >= '01/11/2022'
		GROUP BY YEAR(BUDAT), MONTH(BUDAT), DAY(BUDAT)
		ORDER BY 1, 2, 3;
-------------------------------------- EKPO -----------------------------------------------
USE unifort_prod -- 09/11/2022
GO
SELECT		YEAR(AEDAT) as ANO,
			MONTH(AEDAT) as MES,
			DAY(AEDAT) as MES,
			COUNT(AEDAT) as QTDE
		FROM unifort_prod.dbo.EKPO
		WHERE AEDAT >= '01/11/2022'
		GROUP BY YEAR(AEDAT), MONTH(AEDAT), DAY(AEDAT) 
		ORDER BY 1, 2, 3;
-------------------------------------- VAKPA -----------------------------------------------
USE SAP_DIV -- 09/11/2022
GO
SELECT YEAR(AUDAT) ANO,
		MONTH(AUDAT) MES,
		DAY(AUDAT) as MES,
		COUNT(AUDAT) QTDE
	FROM SAP_DIV.dbo.VAKPA
	WHERE AUDAT >= '01/11/2022'
	GROUP BY YEAR(AUDAT), MONTH(AUDAT), DAY(AUDAT)
	ORDER BY 1, 2, 3;
-------------------------------------- ZMMT_CONHEC_NOTA -----------------------------------------------
USE SAP_DIV -- 01/01/2021  - 09/11/2022
GO
SELECT YEAR(DATA_EMISS_CON) ANO,
		MONTH(DATA_EMISS_CON) MES,
		DAY(DATA_EMISS_CON) as DIA,
		COUNT(DATA_EMISS_CON) QTDE
	FROM ZMMT_CONHEC_NOTA
	WHERE DATA_EMISS_CON >= '01/11/2022'
	GROUP BY YEAR(DATA_EMISS_CON), MONTH(DATA_EMISS_CON), DAY(DATA_EMISS_CON)
	ORDER BY 1, 2, 3;
-------------------------------------- ZMM020 OCORRENCIAS -----------------------------------------------
USE SAP_DIV -- 01/01/2020  - 09/11/2022
GO
SELECT YEAR(DT_LIG) ANO,
		MONTH(DT_LIG) MES,
		DAY(DT_LIG) as MES,
		COUNT(DT_LIG) QTDE
	FROM  ZMM020
	WHERE DT_LIG >= '01/10/2022'
	GROUP BY YEAR(DT_LIG), MONTH(DT_LIG), DAY(DT_LIG)
	ORDER BY 1, 2, 3;

--SELECT MIN(DT_LIG) FROM ZMM020 WHERE STATUS = '@09@';
--DELETE ZMM020 WHERE DT_LIG >= '01/09/2022' ;
-------------------------------------- ZMMT014 -----------------------------------------------
USE [unifort_prod] -- 03/01/2020  - 09/11/2022
GO
SELECT		FORMAT(DTCAD,  'dd/MM/yyyy', 'pt-BR') AS 'DATA', 
			COUNT(DTCAD) AS 'QTDE'
		FROM [unifort_prod].[dbo].[ZMMT014]
		WHERE DTCAD >= '01/11/2022'
		GROUP BY DTCAD;
-------------------------------------- CORTE -----------------------------------------------
USE WMS_DIV  -- 01/01/2020  - 09/11/2022
GO
SELECT		FORMAT(DATA_CORTE,  'dd/MM/yyyy', 'pt-BR') AS 'DATA',
			COUNT(DATA_CORTE) AS 'QTDE CORTE'
			FROM CORTE
		WHERE DATA_CORTE >= '01/11/2022'
		GROUP BY FORMAT(DATA_CORTE,  'dd/MM/yyyy', 'pt-BR')
		ORDER BY 1;
-------------------------------------- KSB1 -----------------------------------------------
USE SAP_DIV -- 04/11/2022
GO
SELECT YEAR([Data de lançamento]) ANO,
		MONTH([Data de lançamento]) MES,
		DAY([Data de lançamento]) DIA,
		COUNT([Data de lançamento]) QTDE
	FROM KSB1
	WHERE [Data de lançamento] >= '01/11/2022'
	GROUP BY YEAR([Data de lançamento]), MONTH([Data de lançamento]), DAY([Data de lançamento])
	ORDER BY 1, 2, 3;
-------------------------------------- MCE7 -----------------------------------------------
USE SAP_DIV -- 09/11/2022
GO
SELECT YEAR(DATA_REL) ANO,
		MONTH(DATA_REL) MES,
		FORMAT(SUM([MontFatDataLanç]),'C', 'pt-br') VLR_RECEBIDO
	FROM MCE7
	WHERE DATA_REL >= '01/01/2022'
	GROUP BY YEAR(DATA_REL), MONTH(DATA_REL)
	ORDER BY 1, 2;
GO
-------------------------------------- WMS TEMPO DE ARMAZENAGEM -----------------------------------------------
USE WMS_DIV -- 09/11/2022
GO
SELECT		YEAR(DATAARMAZ) as ANO,
			MONTH(DATAARMAZ) as MES,
			DAY(DATAARMAZ) as DIA,
			COUNT(DATAARMAZ) as QTDE
		FROM TEMPO_ARMAZENAGEM
		WHERE DATAARMAZ BETWEEN '01/11/2022' AND '31/12/2022'
		GROUP BY YEAR(DATAARMAZ), MONTH(DATAARMAZ), DAY(DATAARMAZ)
		ORDER BY 1, 2, 3;
GO
-------------------------------------- WMS TEMPO DE RECEBIMENTO -----------------------------------------------
USE WMS_DIV -- 09/11/2022
GO
SELECT		YEAR(DATACONF) as ANO,
			MONTH(DATACONF) as MES,
			DAY(DATACONF) as DIA,
			COUNT(DATACONF) as QTDE
		FROM TEMPO_RECEBIMENTO
		WHERE DATACONF BETWEEN '01/11/2022' AND '31/12/2022'
		GROUP BY YEAR(DATACONF), MONTH(DATACONF), DAY(DATACONF)
		ORDER BY 1, 2, 3;
GO
-------------------------------------- view_analise_historico_vendas_2015 -----------------------------------------------
USE query_dw -- 01/01/2020  - 04/11/2022
GO
SELECT YEAR(DATA_FAT) ANO,
		MONTH(DATA_FAT) MES,
		--DAY(DATA_FAT) as MES,
		FORMAT(COUNT(DATA_FAT), 'N', 'pt-br') QTDE,
		FORMAT(SUM(VALOR_FAT), 'C', 'pt-br') VLR_FAT
	FROM ANALISE_HISTORICA_VENDA
	GROUP BY YEAR(DATA_FAT), MONTH(DATA_FAT)--, DAY(DATA_FAT)
	ORDER BY 1, 2--, 3;

-------------------------------------- view_analise_historico_vendas_transporte_sem_material_OV -----------------------------------------------
USE unifort_prod  -- 01/01/2020  - 04/11/2022
GO
SELECT YEAR([DATA FAT]) ANO,
		MONTH([DATA FAT]) MES,
		DAY([DATA FAT]) as MES,
		COUNT([DATA FAT]) QTDE
	FROM dbo.view_analise_historico_vendas_transporte_sem_material_OV
	WHERE [DATA FAT] >= '01/01/2022'
	GROUP BY YEAR([DATA FAT]), MONTH([DATA FAT]), DAY([DATA FAT])
	ORDER BY 1, 2, 3;
-------------------------------------- VBRK -----------------------------------------------
USE query_dw -- 09/11/2022
GO
SELECT		YEAR(DATA_FAT) as ANO,
			MONTH(DATA_FAT) as MES,
			DAY(DATA_FAT) as DIA,
			COUNT(DATA_FAT) as QTDE
		FROM ANALISE_HISTORICA_VENDA
		WHERE DATA_FAT >= '01/10/2022' 
		GROUP BY YEAR(DATA_FAT), MONTH(DATA_FAT), DAY(DATA_FAT)
		ORDER BY 1, 2, 3;