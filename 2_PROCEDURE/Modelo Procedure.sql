USE SAP_VBRP
GO
SELECT		ROW_NUMBER() OVER(ORDER BY v1.ERDAT) LINHA, 
			v1.* INTO  t_venda FROM (SELECT		
			rp.ERDAT,
			rp.VBELN,
			rp.AUBEL,
			COUNT(rp.MATNR) QTDE
	FROM VBRP rp
	WHERE ERDAT >= '01/01/2022'
	GROUP BY rp.ERDAT, rp.VBELN, rp.AUBEL) v1



DECLARE @id INT;
DECLARE @fim INT;
DECLARE @erdat DATE;
DECLARE @vbeln VARCHAR(15);
DECLARE @aubel VARCHAR(15);
DECLARE @qtde INT;

SET @fim = (SELECT COUNT(ERDAT) FROM t_venda)
SET @id = 1;


WHILE @id <= @fim
BEGIN

	SELECT  @erdat =  ERDAT,
			@vbeln =  VBELN,
			@aubel = AUBEL,
			@qtde = QTDE
		FROM t_venda WHERE LINHA = @id;

		INSERT INTO SAP_DIV.dbo.TESTE VALUES (@erdat, @vbeln, @aubel, @qtde)

	SET @id +=1
END


DROP TABLE t_venda;
