USE query_dw
GO
ALTER VIEW view_venda_cliente_PA_VE
AS
	SELECT  
				c.MATR as 'MATR_CLIENTE',
				c.CLIENTE as 'CLIENTE',
				p.NETWR+p.KZWI1 as 'VALOR FAT',
				p.FKIMG as 'QF',
				p.GSBER as 'CENTRO',
				k.REGIO as 'REGIAO',
				p.AUBEL as 'OV',
				p.MATNR as 'MATERIAL',
				k.INCO2 as 'CIDADE',
				p.ARKTX as 'DESC',
				k.FKDAT as 'DATA FAT',
				p.TXJCD as 'COD_IBGE',
				pa.MATR_VE,
				pa.NOME_VE,
				pa.MATR_PA,
				pa.NOME_PA
			FROM (SELECT REGIO, INCO2, FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE FKDAT >= '01/11/2020' AND FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
			left join (SELECT NETWR, KZWI1, KZWI4, FKIMG, GSBER, VGBEL, AUBEL, MATNR, ARKTX, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE FBUDA >= '01/11/2020' ) p ON (p.VBELN = k.VBELN)
			left join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)
			left join query_dw.dbo.view_OV_VE_PA pa ON (p.AUBEL = pa.VBELN)
	GO


SELECT *, 
	CASE 
		 WHEN DATEDIFF(DAY, ULTIMA_COMPRA, GETDATE()) <= 120 THEN 'ATIVO'
		 ELSE 'INATIVO'
	END  [ATIVO-INATIVO]
	FROM view_venda_cliente_PA_VE ve
	LEFT JOIN (SELECT [KUNNR],[ULTIMA_COMPRA] FROM [SAP_DIV].[dbo].[ZSD035]) zs ON (ve. MATR_CLIENTE = zs.KUNNR)



	SELECT *, 
	CASE 
		 WHEN DATEDIFF(DAY, ULTIMA_COMPRA, GETDATE()) <= 120 THEN 'ATIVO'
		 ELSE 'INATIVO'
	END  [ATIVO-INATIVO]
	FROM view_venda_cliente_PA_VE ve
	LEFT JOIN (SELECT [KUNNR],[ULTIMA_COMPRA] FROM [SAP_DIV].[dbo].[ZSD035]) zs ON (ve. MATR_CLIENTE = zs.KUNNR)

--Deixamos de usar todas as consultas acima para usar uma consulta mais otimizada

SELECT ve.MATR_CLIENTE, ve.CLIENTE, ve.VALOR_FAT,
      ve.QF, ve.CENTRO, ve.REGIAO, ve.REMESSA,
      ve.OV, ve.MATERIAL, ve.CIDADE, ve.DESCR,
      ve.DATA_FAT, ve.COD_IBGE,
	   CASE 
		 WHEN DATEDIFF(DAY, zs.ULTIMA_COMPRA, GETDATE()) <= 120 THEN 'ATIVO'
		 ELSE 'INATIVO'
		END  [ATIVO-INATIVO]
  FROM (SELECT * FROM [query_dw].[dbo].[ANALISE_HISTORICA_VENDA]  WHERE [DATA_FAT] > '01/01/2020') ve
  LEFT JOIN (SELECT [KUNNR],[ULTIMA_COMPRA] FROM [SAP_DIV].[dbo].[ZSD035]) zs ON (ve.MATR_CLIENTE = zs.KUNNR)
