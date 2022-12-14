USE ZMM1237
GO
SELECT		zt.AEDAT
			,zt.MATNR
			,COALESCE(qm.QTDE_CLIENTE, 0) QTDE_CLIENTE
			,zt.MAABC
			,zt.LABOR
			,zt.QTDE_EMBALAGEM_A
			,zt.QTDE_EMBALAGEM_M
			,zt.QTDE_EMBALAGEM_P
			,zt.PERC_EMBALAGEM_A
			,zt.PERC_EMBALAGEM_M
			,zt.PERC_EMBALAGEM_P
			FROM ZMMT017  zt
		LEFT JOIN query_dw.dbo.view_qtde_cliente_por_material qm ON (zt.MATNR = qm.MATERIAL)
GO


USE query_dw
GO
CREATE VIEW view_qtde_cliente_por_material
AS
	SELECT		[MATERIAL]
				,COUNT(DISTINCT([MATR_CLIENTE])) QTDE_CLIENTE
			FROM query_dw.dbo.ANALISE_HISTORICA_VENDA 
		WHERE DATA_FAT >= DATEADD(DAY,-365, (SELECT MAX(DATA_FAT) FROM query_dw.dbo.ANALISE_HISTORICA_VENDA WHERE DATA_FAT >= '01/10/2022'))
		GROUP BY [MATERIAL]
GO

USE ZMM1237
GO

SELECT		DAY(AEDAT) DIA,
			MONTH(AEDAT) MES,
			YEAR(AEDAT) ANO, 
			COUNT(AEDAT) QTDE
	FROM ZMMT017
	GROUP BY DAY(AEDAT), MONTH(AEDAT), YEAR(AEDAT)
	ORDER BY 2, 1


DELETE FROM ZMMT017 WHERE AEDAT = '13/12/2022' 


SELECT		zt.AEDAT
			,zt.MATNR
			,COALESCE(zt.QTDE_KUNNR, 0) QTDE_CLIENTE
			,zt.MAABC
			,zt.LABOR
			,zt.QTDE_EMBALAGEM_A
			,zt.QTDE_EMBALAGEM_M
			,zt.QTDE_EMBALAGEM_P
			,zt.PERC_EMBALAGEM_A
			,zt.PERC_EMBALAGEM_M
			,zt.PERC_EMBALAGEM_P
			FROM ZMMT017  zt


USE query_dw
GO
CREATE VIEW view_zmmt017_mais_recente
AS
	SELECT		zt.AEDAT
				,zt.MATNR
				,COALESCE(qm.QTDE_CLIENTE, 0) QTDE_CLIENTE
				,zt.MAABC
				,zt.LABOR
				,zt.QTDE_EMBALAGEM_A
				,zt.QTDE_EMBALAGEM_M
				,zt.QTDE_EMBALAGEM_P
				,zt.PERC_EMBALAGEM_A
				,zt.PERC_EMBALAGEM_M
				,zt.PERC_EMBALAGEM_P
				FROM ZMM1237.dbo.ZMMT017  zt
			LEFT JOIN query_dw.dbo.view_qtde_cliente_por_material qm ON (zt.MATNR = qm.MATERIAL)
			WHERE AEDAT = (SELECT MAX(AEDAT) FROM ZMM1237.dbo.ZMMT017 WHERE AEDAT >= GETDATE() - 5)
GO

SELECT * FROM view_zmmt017_mais_recente