USE query_dw
GO
ALTER PROCEDURE Atualizar_Atendimento_Filial_UPDATE_OV
	@data_rel	DATE

	AS
	DECLARE	@ultimo_dia_mes DATE;

	SET @ultimo_dia_mes = EOMONTH(@data_rel);

	SELECT			ROW_NUMBER() OVER(ORDER BY v1.DT_FAT) LINHA, 
					v1.* INTO t_atendimentofilial 
				FROM (SELECT * FROM view_atendido_filial) v1;

	DECLARE @idx INT;
	DECLARE @ult_lin INT;
	DECLARE @VBELN_K varchar(15);
	DECLARE @REMESSA varchar(15) ;
	DECLARE @OV VARCHAR(15);


	SET @idx = 1;
	SET @ult_lin = (SELECT COUNT(DT_FAT) FROM t_atendimentofilial);

	WHILE @idx <= @ult_lin
	BEGIN

		SELECT	@VBELN_K			=	VBELN_K,
				@REMESSA			=   REMESSA,
				@OV					=   OV
			FROM t_atendimentofilial WHERE LINHA = @idx
	

		-- UPDATE DA TABELA BASE
		UPDATE query_dw.dbo.atendimentofilial
		SET OV = @OV
		WHERE VBELN_K = @VBELN_K AND REMESSA = @REMESSA;

		SET @idx += 1
	END

	DROP TABLE t_atendimentofilial;
GO



DECLARE @dt DATE;
--SET @dt = DATEADD(DAY,1, (SELECT MAX([DT_FAT]) FROM atendimentofilial));
SET @dt = '01/01/2022';
--PRINT @dt
EXEC Atualizar_Atendimento_Filial_UPDATE_OV @dt;
GO



SELECT FORMAT(SUM(VALOR_FAT), 'C', 'pt-br') FROM [atendimentofilial] WHERE DT_FAT >= '01/11/2022';
SELECT * FROM [atendimentofilial] WHERE DT_FAT >= '01/11/2022' AND OV != 0;



