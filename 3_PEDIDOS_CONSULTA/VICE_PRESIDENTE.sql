USE unifort_prod
GO


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
			p.TXJCD as 'COD_IBGE',
			pa2.MATR_PA as 'MATR PA',
			pa2.ENAME as 'NOME PA'
		FROM (SELECT REGIO, INCO2, FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE ERDAT >= '01/09/2022' and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
		left join (SELECT NETWR, KZWI1, KZWI4, FKIMG, GSBER, VGBEL, AUBEL, MATNR, ARKTX, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= '01/09/2022' ) p ON (p.VBELN = k.VBELN)
		left join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)
		left join (SELECT KUNDE, NAME1, VBELN FROM (SELECT KUNDE, PARVW, VBELN  FROM SAP_DIV.dbo.VAKPA WHERE PARVW = 'SP') pa	
					left join (SELECT * FROM SAP_DIV.dbo.LFA1) a ON (a.LIFNR = pa.KUNDE)) pa ON (p.AUBEL = pa.VBELN)
		left join (SELECT  tp.OV, tp.MATR_PA, pa0.ENAME FROM unifort_prod.dbo.view_nome_trans_pa_OV tp
					left join (SELECT * FROM SAP_DIV.dbo.PA0001) pa0 ON (pa0.PERNR = tp.MATR_PA)) pa2 ON (p.AUBEL = pa2.OV)
		WHERE pa.KUNDE = '0007001761';





(select  tp.OV, tp.MATR_PA, pa0.ENAME from unifort_prod.dbo.view_nome_trans_pa_OV tp
	left join (SELECT * FROM SAP_DIV.dbo.PA0001) pa0 ON (pa0.PERNR = tp.MATR_PA))

