USE query_dw
GO
-- ATUALIZA RELATORIO ONDE FOI FATURADO A OV
DECLARE @dt DATE;
SET @dt = DATEADD(DAY, 1, (SELECT MAX([DT_FAT]) FROM atendimentofiliall));
EXEC Atualizar_Atendimento_Filial '20/11/2022', @dt;
GO

-- ATUALIZA ANALISE DE DIAS DE ESTOQUE 
EXEC Atualizar_dias_de_venda_material_estoque '01/11/2022', '30/11/2022';
GO

--ATUALIZA HISTORICO DE ATENDIMENTO
DECLARE @dt DATE;
SET @dt = DATEADD(DAY, 1, (SELECT MAX([DATA_FAT]) FROM [ANALISE_HISTORICA_VENDA]));
EXEC Atualizar_historico_atendimento @dt;
GO

SELECT FORMAT(SUM([VALOR_FAT]), 'C', 'pt-br') FROM [query_dw].[dbo].[ANALISE_HISTORICA_VENDA] WHERE [DATA_FAT] BETWEEN '01/11/2022' AND '30/11/2022'

