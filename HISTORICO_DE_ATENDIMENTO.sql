
/*
-------------------------------------- CRIAÇÃO DE QUERY -----------------------------------------------
   QUERY ANALISE VENDIA DIARIA 2022
*/

USE unifort_prod
GO
CREATE VIEW dbo.vbrk_vbrp_faturamento_dia
AS 
	SELECT  k.VBELN as 'DOC',
		p.FKIMG as 'QF',
		ap.KWMENG as 'Quantidade da Ordem',
		p.NETWR+p.KZWI1 as 'VALOR FAT',
		p.KZWI4 as 'VALOR FRETE',
		p.GSBER as 'CENTRO',
		k.REGIO as 'REGIAO',
		p.MATNR as 'MATERIAL',
		p.VGBEL as 'REMESSA',
        k.INCO2 as 'CIDADE',
		p.ARKTX as 'DESC',]
		p.TXJC as 'COD_IBGE',
		k.FKDAT as 'DATA FAT'
	FROM unifort_prod.dbo.VBRK k
		left join SAP_VBRP.dbo.VBRP p ON (p.VBELN = k.VBELN)
		left join unifort_prod.dbo.VBAP ap ON (p.AUBEL = ap.VBELN) and (p.VGPOS = ap.POSNR)
		WHERE k.FKDAT between '01/01/2022' and '31/12/2022' and
		k.FKART = 'F2B' and k.FKSTO = '' and k.SFAKN = '' 
GO


/*
____________________________________________________________________________________________________________________________________________________________________
-- QUERY ANALISE DESDE DE 2015
*/

USE unifort_prod
GO
ALTER VIEW view_analise_historico_vendas_2015
AS 
SELECT  
			c.MATR as 'MATR_CLIENTE',
			c.CLIENTE as 'CLIENTE',
			p.NETWR+p.KZWI1 as 'VALOR FAT',
			p.KZWI4 as 'VALOR FRETE',
			p.FKIMG as 'QF',
			p.GSBER as 'CENTRO',
			k.REGIO as 'REGIAO',
			p.VGBEL as 'REMESSA',
			p.AUBEL as 'OV',
			p.MATNR as 'MATERIAL',
			k.INCO2 as 'CIDADE',
			p.ARKTX as 'DESC',
			k.FKDAT as 'DATA FAT',
			p.TXJCD as 'COD_IBGE'
		FROM (SELECT REGIO, INCO2, FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE FKDAT BETWEEN '01/01/2015' AND '31/12/2022' and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
		left join (SELECT NETWR, KZWI1, KZWI4, FKIMG, GSBER, VGBEL, AUBEL, MATNR, ARKTX, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE FBUDA BETWEEN '01/01/2015' AND '31/12/2022' ) p ON (p.VBELN = k.VBELN)
		left join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)
GO
select * from unifort_prod.dbo.view_analise_historico_vendas_2015;


--FOI CRIADO A TABELA A BAIXO PARA ANALISE HISTORICA DE VENDA PARA USO SIMPLIFICADO DA TABELA A CIMA, ASSIM REDUZINHO O TEMPO DOS CALCULOS NA VIEW
USE query_dw
GO
CREATE TABLE dbo.ANALISE_HISTORICA_VENDA (
	MATR_CLIENTE VARCHAR(15),
	CLIENTE VARCHAR(40),
	VALOR_FAT VARCHAR(13),
	VALOR_FRETE VARCHAR(12),
	QF VARCHAR(13),
	CENTRO VARCHAR(9),
	REGIAO VARCHAR(7),
	REMESSA VARCHAR(15),
	OV VARCHAR(15),
	MATERIAL VARCHAR(19),
	CIDADE VARCHAR(33),
	DESCR VARCHAR(45),
	DATA_FAT VARCHAR(15),
	COD_IBGE VARCHAR(15));
GO


USE query_dw
GO
SELECT YEAR(DATA_FAT) ANO,
		MONTH(DATA_FAT) MES,
		--DAY(DATA_FAT) as MES,
		COUNT(DATA_FAT) QTDE
	FROM ANALISE_HISTORICA_VENDA
	WHERE DATA_FAT >= '01/01/2015'
	GROUP BY YEAR(DATA_FAT), MONTH(DATA_FAT)--, DAY(DATA_FAT)
	ORDER BY 1, 2--, 3;

/*
____________________________________________________________________________________________________________________________________________________________________
*/
USE unifort_prod
GO
ALTER VIEW dbo.vbrk_vbrp_faturamento_dia
AS 
	SELECT  k.VBELN as 'DOC',
		p.FKIMG as 'QF',
		ap.KWMENG as 'Quantidade da Ordem',
		p.NETWR+p.KZWI1 as 'VALOR FAT',
		p.KZWI4 as 'VALOR FRETE',
		p.GSBER as 'CENTRO',
		k.REGIO as 'REGIAO',
		p.MATNR as 'MATERIAL',
		p.VGBEL as 'REMESSA',
        k.INCO2 as 'CIDADE',
		p.ARKTX as 'DESC',
		k.FKDAT as 'DATA FAT'
	FROM (SELECT VBELN, REGIO, INCO2, FKDAT FROM unifort_prod.dbo.VBRK WHERE FKDAT > '01/01/2022' AND FKART = 'F2B' AND FKSTO = '' AND SFAKN = '' ) k
		left join (SELECT FKIMG, NETWR, KZWI1, KZWI4, GSBER, MATNR, VGBEL, ARKTX, AUBEL, VGPOS, VBELN  FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= '01/01/2022') p ON (p.VBELN = k.VBELN)
		left join unifort_prod.dbo.VBAP ap ON (p.AUBEL = ap.VBELN) and (p.VGPOS = ap.POSNR);
GO



/*
____________________________________________________________________________________________________________________________________________________________________
-- QUERY ANALISE USADO PARA APURAÇÃO DO FRETE 
*/
USE unifort_prod
GO
ALTER VIEW dbo.analise_historico_vendas_transporte
AS 
SELECT  
			c.MATR as 'MATR_CLIENTE',
			c.CLIENTE as 'CLIENTE',
			p.NETWR+p.KZWI1 as 'VALOR FAT',
			p.KZWI4 as 'VALOR FRETE',
			p.FKIMG as 'QF',
			p.GSBER as 'CENTRO',
			k.REGIO as 'REGIAO',
			p.VGBEL as 'REMESSA',
			p.AUBEL as 'OV',
			p.MATNR as 'MATERIAL',
			k.INCO2 as 'CIDADE',
			p.ARKTX as 'DESC',
			k.FKDAT as 'DATA FAT',
			pa.KUNDE as 'COD_TRANSPORTADOR',
			pa.NAME1 as 'NOME_TRANSPRTADOR',
			p.TXJCD as 'COD_IBGE'
		FROM (SELECT REGIO, INCO2, FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE ERDAT >= '01/01/2020' and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
		left join (SELECT NETWR, KZWI1, KZWI4, FKIMG, GSBER, VGBEL, AUBEL, MATNR, ARKTX, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= '01/01/2020' ) p ON (p.VBELN = k.VBELN)
		left join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)
		left join (SELECT KUNDE, NAME1, VBELN FROM (SELECT KUNDE, PARVW, VBELN  FROM SAP_DIV.dbo.VAKPA WHERE PARVW = 'SP') pa
		left join (SELECT * FROM SAP_DIV.dbo.LFA1) a ON (a.LIFNR = pa.KUNDE)) pa ON (p.AUBEL = pa.VBELN)
GO



USE unifort_prod
GO
ALTER VIEW dbo.view_analise_historico_vendas_transporte_sem_material_OV
AS 
SELECT		OV,
			MATR_CLIENTE,
			CLIENTE,
			CENTRO,
			COD_TRANSPORTADOR,
			NOME_TRANSPRTADOR,
			--REGIAO,
			--CIDADE,
			[DATA FAT],
			COD_IBGE,
			SUM(QF) 'QF',
			SUM([VALOR FRETE]) [VALOR FRETE],
			SUM([VALOR FAT]) [VALOR FAT]
		FROM unifort_prod.dbo.analise_historico_vendas_transporte
		GROUP BY	OV, MATR_CLIENTE, CLIENTE, CENTRO, [DATA FAT], COD_IBGE, COD_TRANSPORTADOR, NOME_TRANSPRTADOR;
GO

USE unifort_prod
GO
SELECT * FROM dbo.view_analise_historico_vendas_transporte_sem_material_OV

/*
____________________________________________________________________________________________________________________________________________________________________
-- QUERY ANALISE ULTIMA COMPRA DO CLIENTE 
*/
USE unifort_prod
GO
ALTER VIEW view_analise_ultima_compra_cliente
AS 
SELECT	
			c.MATR as 'MATR_CLIENTE',
			c.CLIENTE as 'CLIENTE',
			p.TXJCD as 'COD_IBGE',
			MAX(k.FKDAT) as 'DATA FAT',
			DATEDIFF(DAY, MAX(k.FKDAT), GETDATE()) DIAS_ULT_COMPRA
		FROM (SELECT FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE FKDAT >= '01/01/2020' and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
		left join (SELECT GSBER, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= '01/01/2020' ) p ON (p.VBELN = k.VBELN)
		inner join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)
		GROUP BY c.MATR, c.CLIENTE, p.TXJCD;
GO


SELECT	FKDAT, 
		FKART, 
		KUNRG, 
		VBELN,
		MONTH(FKDAT)
		FROM VBRK
		WHERE MONTH(FKDAT) = 1;





-- CONSULTA CRIADA PARA ANALISAR A CURVA ABC 
USE query_dw
GO
SELECT * FROM ANALISE_HISTORICA_VENDA WHERE DATA_FAT >= '01/01/2022'
GO

USE query_dw
GO
select y.* FROM (SELECT DATENAME(MONTH ,DATA_FAT) NOME_MES,
		MATERIAL,
		DESCR,
		SUM(VALOR_FAT) VALOR_FAT
	FROM ANALISE_HISTORICA_VENDA WHERE DATA_FAT >= '01/01/2022'
	GROUP BY DATENAME(MONTH ,DATA_FAT), MATERIAL, DESCR, DATA_FAT) y
	ORDER BY y.VALOR_FAT DESC
GO



USE query_dw
GO
SELECT	OV,
		MATERIAL,
		DESCR,
		SUM(VALOR_FAT) VALOR_FAT
		--SUM(VALOR_FAT)/1000 VALOR_FAT_D
	FROM ANALISE_HISTORICA_VENDA WHERE DATA_FAT BETWEEN DATEADD(DAY,-365, (SELECT MAX(DATA_FAT) FROM ANALISE_HISTORICA_VENDA))  AND
														(SELECT MAX(DATA_FAT) FROM ANALISE_HISTORICA_VENDA) AND 
	VALOR_FAT >= 0
	GROUP BY OV, MATERIAL, DESCR
GO


(SELECT MAX(DATA_FAT) FROM ANALISE_HISTORICA_VENDA)