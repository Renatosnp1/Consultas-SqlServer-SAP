USE query_dw
GO

ALTER PROCEDURE Atualizar_dias_de_venda_material_estoque
	@dtInicio DATE,
	@dtFim DATE

	AS
	--SET @dtInicio = '01/11/2022';
	--SET @dtFim = (SELECT MAX(DATA_REL) FROM ZMM1237.dbo.ZMM1237 WHERE DATA_REL > @dtInicio);
	SELECT ROW_NUMBER() OVER(ORDER BY p1.MATERIAL) LINHA,
			p1.* INTO t_estoque 
		FROM (SELECT [MATERIAL] FROM ZMM1237.dbo.ZMM1237 WHERE DATA_REL = @dtFim AND CL != 'DS') p1;

	DECLARE @qtde_linha INT;
	SET @qtde_linha = (SELECT COUNT([Material]) FROM t_estoque)

	DECLARE @idx INT;
	SET @idx = 1

	DECLARE @material VARCHAR(15);

	DECLARE @material1 VARCHAR(15);
	DECLARE @dti DATE;
	DECLARE @dtf DATE;
	DECLARE @diasEstoque INT;
	DECLARE @mediaEstoque INT;
	DECLARE @estoqueMin INT;
	DECLARE @estoqueMax INT;

	DELETE FROM DIAS_ESTOQUE_ZMM1237;

	WHILE  @idx <= @qtde_linha
	BEGIN
		-- leitura do material na tabela zmm1237 atualizada
		SELECT @material = MATERIAL FROM query_dw.dbo.t_estoque WHERE LINHA = @idx;


		-- função de pegar dados analisados por material
		SELECT	@material1		=	p1.MATERIAL,
				@dti			=	@dtInicio,
				@dtf			=	@dtFim,
				@diasEstoque	=	COUNT(p1.MATERIAL),
				@mediaEstoque	=	AVG(p1.ESTOQUE_TOTAL),
				@estoqueMin		=	MIN(p1.ESTOQUE_TOTAL),
				@estoqueMax		=	MAX(p1.ESTOQUE_TOTAL)
				FROM (SELECT  DATA_rel,
					MATERIAL, 
					SUM(ESTOQUE_TOTAL) ESTOQUE_TOTAL
					FROM SAP_ESTOQUE.dbo.SQVI_ESTOQUE WHERE DATA_rel >= @dtInicio AND MATERIAL = @material
					GROUP BY DATA_rel, MATERIAL) p1
				GROUP BY p1.MATERIAL;

		-- Começo a inserção no banco
		INSERT INTO query_dw.dbo.DIAS_ESTOQUE_ZMM1237 (
		  [MATERIAL],
		  [DATA INICIO],
		  [DATA FIM],
		  [DIAS DE ESTOQUE],
		  [MEDIAESTOQUE DIA],
		  [ESTOQUE MIN],
		  [ESTOQUE MAX] ) VALUES (
		  @material1,
			@dti,
			@dtf,
			@diasEstoque,
			@mediaEstoque,
			@estoqueMin,
			@estoqueMax);

		SET @idx += 1
	END 

	DROP TABLE t_estoque;
GO


EXEC Atualizar_dias_de_venda_material_estoque '01/11/2022', '30/11/2022'