USE query_dw
GO
ALTER PROCEDURE Atualizar_Atendimento_Filial
	@data_rel	DATE

	AS
	DECLARE	@ultimo_dia_mes DATE;

	SET @ultimo_dia_mes = EOMONTH(@data_rel);

	SELECT			ROW_NUMBER() OVER(ORDER BY v1.DT_FAT) LINHA, 
					v1.* INTO t_atendimentofilial 
				FROM (SELECT k.VBELN as 'VBELN_K',
					k.FKDAT as 'DT_FAT',
					o.EBELN as 'EBELN_O',
					p.AUBEL as 'OV',
					p.WERKS as 'CENTRO',
					p.VBELN as 'VBELN_P',
					p.MATNR as 'SKU',
					p.VGBEL as 'REMESSA',
					p.FKIMG as 'QF',
					(p.NETWR+p.KZWI1) as 'VALOR_FAT',
					isnull(e.MENGE, 0) as 'QTDE_TRANSFERIDO',
					isnull(e.BWART, 0) as 'TIPO_MOVIMENTO'
				FROM (SELECT	VBELN, 
								FKDAT, 
								FKSTO, 
								ERDAT,
								SFAKN
							FROM unifort_prod.dbo.VBRK WHERE ERDAT >=  @data_rel and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
			left join (SELECT	WERKS,
								VBELN,
								MATNR,
								VGBEL,
								NETWR,
								FKIMG,
								KZWI1,
								AUBEL
							FROM SAP_VBRP.dbo.VBRP WHERE FBUDA >= @data_rel) p ON (k.VBELN = p.VBELN)
			left join (SELECT	EBELN, 
								MATNR, 
								AFNAM, 
								NETPR, 
								MAX(AEDAT) 
								AEDAT 
							FROM [unifort_prod].[dbo].[EKPO] WHERE LOEKZ != 'L' AND AEDAT BETWEEN '01/10/2022' AND @ultimo_dia_mes 
									GROUP BY EBELN, MATNR, AFNAM, NETPR) o ON (p.AUBEL = o.AFNAM) and (p.MATNR = o.MATNR)
			left join (SELECT DISTINCT * FROM [unifort_prod].[dbo].[EKBE] WHERE BWART = '861' AND BUDAT BETWEEN '01/10/2022' AND @ultimo_dia_mes ) e 
																						ON (o.EBELN = e.EBELN) and (o.MATNR = e.MATNR)) v1;

	DECLARE @idx INT;
	DECLARE @ult_lin INT;
	DECLARE @VBELN_K varchar(15);
	DECLARE @DT_FAT date;
	DECLARE @EBELN_O varchar(15) ;
	DECLARE @OV varchar(15)
	DECLARE @CENTRO varchar(5) ;
	DECLARE @VBELN_P varchar(15);
	DECLARE @SKU varchar(15);
	DECLARE @REMESSA varchar(15) ;
	DECLARE @QF numeric(10, 2) ;
	DECLARE @VALOR_FAT numeric(10, 2);
	DECLARE @QTDE_TRANSFERIDO numeric(12, 2) ;
	DECLARE @TIPO_MOVIMENTO varchar(5);

	SET @idx = 1;
	SET @ult_lin = (SELECT COUNT(DT_FAT) FROM t_atendimentofilial);

	WHILE @idx <= @ult_lin
	BEGIN

		SELECT	@VBELN_K			=	VBELN_K,
				@DT_FAT				=	DT_FAT,
				@EBELN_O			=	EBELN_O,
				@OV					=	OV,
				@CENTRO				=	CENTRO,
				@VBELN_P			=	VBELN_P,
				@SKU				=	SKU,
				@REMESSA			=	REMESSA,
				@QF					=	QF,
				@VALOR_FAT		   	=	VALOR_FAT,
				@QTDE_TRANSFERIDO	= QTDE_TRANSFERIDO,
				@TIPO_MOVIMENTO		= TIPO_MOVIMENTO
			FROM t_atendimentofilial WHERE LINHA = @idx
	
		-- INSERÇÃO NA TABELA 
		INSERT INTO query_dw.dbo.[atendimentofilial] VALUES 
		( @VBELN_K,
		@DT_FAT,
		@EBELN_O,
		@OV,
		@CENTRO,
		@VBELN_P, 
		@SKU, 
		@REMESSA, 
		@QF, 
		@VALOR_FAT, 
		@QTDE_TRANSFERIDO, 	
		@TIPO_MOVIMENTO);

		SET @idx += 1
	END

	DROP TABLE t_atendimentofilial;
GO



DECLARE @dt DATE;
SET @dt = DATEADD(DAY,1, (SELECT MAX([DT_FAT]) FROM atendimentofilial));
--SET @dt = '01/11/2022';
PRINT @dt
--Go
--USE query_dw
--GO
EXEC Atualizar_Atendimento_Filial @dt;
GO



SELECT FORMAT(SUM(VALOR_FAT), 'C', 'pt-br') FROM [atendimentofilial] WHERE DT_FAT >= '01/11/2022';

--DELETE FROM [atendimentofilial] WHERE DT_FAT >= '01/11/2022';