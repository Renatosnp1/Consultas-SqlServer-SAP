USE ZMM1237
GO

SELECT Material, Descrição, CATEGORIA FROM ZMM1237 WHERE DATA_REL = (SELECT MAX(DATA_REL) FROM ZMM1237);


--USO NA CLSUTERIAZAÇÃO
USE query_dw
GO
SELECT			h.OV,
                h.MATERIAL,
                h.DESCR,
				zm.CATEGORIA
            FROM (SELECT OV,MATERIAL,DESCR,VALOR_FAT FROM ANALISE_HISTORICA_VENDA WHERE DATA_FAT BETWEEN DATEADD(DAY,-10, (SELECT MAX(DATA_FAT) FROM ANALISE_HISTORICA_VENDA))  AND
                                                                (SELECT MAX(DATA_FAT) FROM ANALISE_HISTORICA_VENDA) AND VALOR_FAT >= 0) h
			left join (SELECT Material, CATEGORIA FROM ZMM1237.dbo.ZMM1237 WHERE DATA_REL = '14/11/2022') zm ON (h.MATERIAL = zm.Material)




SELECT * FROM ZMM1237 WHERE DATA_REL = '25/10/2022';



ALTER VIEW [dbo].[view_zmm1237_mensal]
AS
SELECT		YEAR(MAX(DATA_REL)) AS ANO,
			MONTH(MAX(DATA_REL)) AS MES,
			[CATEGORIA],
			[Compr],
			[Cod For],
			[Nome],
			[Material],
			[Descrição],
			[Ref For],
			[CL],
			[LC],
			[12 M],
			[6 M],
			[3 M],
			[PBE],
			[CMA],
			[%R],
			[ZCAA],
			[PrzEnt],
			[VlrArred],
			MAX(DATA_REL) as DATA
		FROM ZMM1237
	WHERE  DATA_REL in ('31/01/2022', '28/02/2022', '31/03/2022', '30/04/2022', '31/05/2022', '30/06/2022', '31/07/2022', '31/08/2022', '30/09/2022', '27/10/2022', '22/11/2022') 
	GROUP BY YEAR(DATA_REL), MONTH(DATA_REL), 
	[CATEGORIA],
	[Compr],
      [Cod For],
      [Nome],
      [Material],
      [Descrição],
      [Ref For],
      [CL],
      [LC],
      [12 M],
      [6 M],
      [3 M],
      [PBE],
      [CMA],
      [%R],
	  [ZCAA],
	  [PrzEnt],
	  [VlrArred];
GO



USE ZMM1237
GO
SELECT 
			DATA, 
			COUNT(DATA) AS QTDE
		FROM view_zmm1237_mensal
		GROUP BY DATA
		ORDER BY DATA;




USE ZMM1237
GO


SELECT		EOMONTH(DATA_REL), 
			MONTH( DATA_REL),
			COUNT(DATA_REL)
			FROM ZMM1237
		GROUP BY EOMONTH(DATA_REL), MONTH( DATA_REL)
		ORDER BY 1, 2;




SELECT [PBE] FROM ZMM1237 WHERE [Material] = '99BR.348.003' AND MONTH(DATA_REL) = 10;



USE ZMM1237
GO
SELECT * FROM ZMM1237 WHERE DATA_REL = '10/11/2022'
GO

USE ZMM1237
GO
DELETE FROM ZMM1237 WHERE DATA_REL = '10/11/2022'
GO