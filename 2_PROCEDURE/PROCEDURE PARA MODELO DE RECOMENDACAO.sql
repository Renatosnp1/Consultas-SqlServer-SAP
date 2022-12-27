USE query_dw
GO

ALTER PROCEDURE CRIAR_MODELO_ML
	@dt DATE,
	@OV VARCHAR(8000)
	AS
	SELECT p1.* INTO t_modelo_ML 
			FROM (SELECT ROW_NUMBER() OVER(ORDER BY av.MATERIAL) LINHAS, 
			av.OV, 
			av.MATERIAL 
		FROM ANALISE_HISTORICA_VENDA av WHERE av.DATA_FAT >= @dt AND OV = @OV) p1;

	DECLARE @idx INT;
	DECLARE @linha INT;
	DECLARE @TEXTO VARCHAR(8000);

	SET @OV = CONCAT( FORMAT(@dt, 'dd/MM/yyyy', 'pt-br' ), ',', @OV)
	SET @idx = 1;
	SET @linha = (SELECT COUNT(OV) FROM t_modelo_ML);

	WHILE  @idx <= @linha
	BEGIN

		SELECT @OV = CONCAT(@OV,',' , MATERIAL) 
	FROM t_modelo_ML WHERE LINHAS = @idx;

		SET @idx += 1;
	END
	INSERT INTO MODELO_RECOMENDACAO ( DADOS ) VALUES ( @OV );
	DROP TABLE t_modelo_ML;
GO
--------------------------------------------------------------------
--LOOP PARA PERCORRER TODAS AS OV
DECLARE @dtt DATE;
DECLARE @idxx INT;
DECLARE @linhatt INT;
DECLARE @ovv VARCHAR(15);

SET @dtt = '01/01/2022'
SET @idxx = 1;
SET @linhatt = (SELECT  COUNT(DISTINCT(av.OV)) FROM ANALISE_HISTORICA_VENDA av WHERE av.DATA_FAT >= @dtt)

WHILE @idxx <= @linhatt
BEGIN
	SELECT @ovv = p3.OV FROM (SELECT ROW_NUMBER() OVER(ORDER BY p2.OV) LINHA1,
		p2.OV FROM (SELECT  DISTINCT(av.OV) 
	FROM ANALISE_HISTORICA_VENDA av WHERE av.DATA_FAT >= @dtt) p2 ) p3
												WHERE p3.LINHA1 = @idxx
	EXEC CRIAR_MODELO_ML @dtt, @ovv
	SET @idxx += 1
END

