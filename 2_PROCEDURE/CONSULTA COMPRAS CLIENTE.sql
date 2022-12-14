USE query_dw
GO
SELECT		FORMAT(MAX([DATA_FAT]), 'dd/MM/yyyy') ULTIMA_COMPRA
			,[MATERIAL]
			,[DESCR]
			,[MATR_CLIENTE]
			,[CLIENTE]
		FROM ANALISE_HISTORICA_VENDA 
	WHERE DATA_FAT >= '01/01/2021' AND 
	MATR_CLIENTE != ''
	GROUP BY 
				[MATERIAL]
			,[DESCR]
			,[MATR_CLIENTE]
			,[CLIENTE]
