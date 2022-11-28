/* 
-------------------------------------- CRIAÇÃO DE QUERY -----------------------------------------------
*/
-- QUERY ANALISE DE QUAIS FILIAIS TINHA O PRODUTO PARA ATENDER O CLIENTE
USE query_dw
GO
ALTER VIEW view_atendido_filial as
	SELECT		k.VBELN as 'VBELN_K',
				k.FKDAT as 'DT_FAT',
				isnull(o.EBELN, 0) as 'EBELN_O',
				p.AUBEL as 'OV',
				p.WERKS as 'CENTRO',
				p.VBELN as 'VBELN_P',
				p.MATNR as 'SKU',
				p.VGBEL as 'REMESSA',
				p.FKIMG as 'QF',
				(p.NETWR+p.KZWI1) as 'VALOR_FAT',
				isnull(e.EBELN, 0) as 'PEDIDO_TRANSFE',
				isnull(e.MENGE, 0) as 'QTDE_TRANSFERIDO',
				isnull(e.BWART, 0) as 'TIPO_MOVIMENTO'
			FROM (SELECT	VBELN, FKDAT, FKSTO, ERDAT, SFAKN FROM unifort_prod.dbo.VBRK WHERE ERDAT >= '01/01/2022' and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
		left join (SELECT	WERKS, VBELN, MATNR, VGBEL, NETWR, FKIMG, KZWI1, AUBEL FROM SAP_VBRP.dbo.VBRP WHERE FBUDA >= '01/01/2022') p ON (k.VBELN = p.VBELN)
		left join (SELECT	EBELN, MATNR, AFNAM, NETPR, MAX(AEDAT)	AEDAT FROM [unifort_prod].[dbo].[EKPO] WHERE LOEKZ != 'L'	GROUP BY EBELN, MATNR, AFNAM, NETPR) o ON (p.AUBEL = o.AFNAM) and (p.MATNR = o.MATNR)
		left join (SELECT DISTINCT ee.MENGE, ee.BWART, ee.EBELN, ee.MATNR, ee.BUDAT FROM [unifort_prod].[dbo].[EKBE] ee 
					WHERE BWART = '861' AND ee.BUDAT > '01/01/2022') e ON (o.EBELN = e.EBELN) and (o.MATNR = e.MATNR)
GO

SELECT * FROM view_atendido_filial

--alter table atendimentofilial add [OV] varchar(15);

/*
    ANALISE FILIAL
	PARA GANHAR TEMPO NAS ATUALIZCOES ESTOU CRIANDO TABELAS COM AS CONSULTAS PRONTAS  VIEW --> unifort_prod.dbo.view_atendido_filial
-------------------------------------- CRIAÇÃO DE QUERY -----------------------------------------------
*/
-- QUERY ANALISE DE QUAIS FILIAIS FORAM TINHA O PRODUTO PARA ATENDER O CLIENTE - BASE COM OS DADOS CONSOLIDADOS
-- E CRIANDO COLUNAS ADICIONAIS

USE query_dw
GO
alter VIEW view_atendimentofilial
AS
	SELECT [VBELN_K],
		  [DT_FAT],
		  [EBELN_O] EBELN_O,
		  [CENTRO],
		  [VBELN_P],
		  [SKU],
		  [REMESSA],
		  [QF],
		  [VALOR_FAT],
		  [PEDIDO_TRANSFE],
		  [QTDE_TRANSFERIDO],
		  [TIPO_MOVIMENTO],
		  ([VALOR_FAT]/[QF]) * [QTDE_TRANSFERIDO] as 'VALOR_TRANSFERIDO',
		  OV
	  FROM [query_dw].[dbo].[atendimentofiliall]
GO


select * from view_atendimentofilial

--DELETE FROM [atendimentofilial] WHERE OV = '0001187697' AND TIPO_MOVIMENTO = 0
