USE query_dw
GO

ALTER PROCEDURE Atualizar_historico_atendimento
	@dataInicio DATE

	AS
	SELECT  ROW_NUMBER() OVER(ORDER BY p1.VALOR_FAT) LINHA, 
				p1.* INTO t_atendimentohistorico_2015 
				FROM (SELECT c.MATR as 'MATR_CLIENTE',
				c.CLIENTE as 'CLIENTE',
				p.NETWR+p.KZWI1 as 'VALOR_FAT',
				p.KZWI4 as 'VALOR FRETE',
				p.FKIMG as 'QF',
				p.GSBER as 'CENTRO',
				k.REGIO as 'REGIAO',
				p.VGBEL as 'REMESSA',
				p.AUBEL as 'OV',
				p.MATNR as 'MATERIAL',
				k.INCO2 as 'CIDADE',
				p.ARKTX as 'DESC',
				k.FKDAT as 'DATA_FAT',
				p.TXJCD as 'COD_IBGE'
			FROM (SELECT REGIO, INCO2, FKDAT, FKART, FKSTO, SFAKN, KUNRG, VBELN  FROM unifort_prod.dbo.VBRK WHERE ERDAT >=  @dataInicio and FKART = 'F2B' and FKSTO = '' and SFAKN = '') k
			left join (SELECT NETWR, KZWI1, KZWI4, FKIMG, GSBER, VGBEL, AUBEL, MATNR, ARKTX, TXJCD ,VBELN FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= @dataInicio ) p ON (p.VBELN = k.VBELN)
			left join unifort_prod.dbo.view_dados_cliente_dw c ON (k.KUNRG = c.MATR)) p1

	DECLARE @idx INT;
	DECLARE @qtdeLinha INT;
	SET @idx = 1;
	SET @qtdeLinha = (SELECT COUNT(DATA_FAT) FROM  t_atendimentohistorico_2015);

	DECLARE	@MATR_CLIENTE VARCHAR(50);
	DECLARE	@CLIENTE varchar(50);
	DECLARE	@VALOR_FAT numeric(11, 2);
	DECLARE	@VALOR_FRETE numeric(10, 2);
	DECLARE	@QF numeric(10, 2);
	DECLARE	@CENTRO varchar(9);
	DECLARE	@REGIAO varchar(50);
	DECLARE	@REMESSA varchar(15);
	DECLARE	@OV varchar(15);
	DECLARE	@MATERIAL varchar(19);
	DECLARE	@CIDADE  varchar(50);
	DECLARE	@DESC varchar(45);
	DECLARE	@DATA_FAT date;
	DECLARE	@COD_IBGE varchar(15); 


	SET @idx = 1;
	WHILE @idx <=  @qtdeLinha
	BEGIN
			-- INICIO A SELECÃO DOS DADOS PARA SALVAR NO BANCO
			SELECT			@MATR_CLIENTE			=		MATR_CLIENTE,
							@CLIENTE				=		CLIENTE,
							@VALOR_FAT				=		VALOR_FAT,
							@VALOR_FRETE			=		[VALOR FRETE],
							@QF						=		QF,
							@CENTRO					=		CENTRO,
							@REGIAO					=		REGIAO,
							@REMESSA				=		REMESSA,
							@OV						=		OV,
							@MATERIAL				=		MATERIAL,
							@CIDADE					=		CIDADE,
							@DESC					=		[DESC],
							@DATA_FAT				=		DATA_FAT,
							@COD_IBGE				=		COD_IBGE
					FROM query_dw.dbo.t_atendimentohistorico_2015 WHERE LINHA = @idx

			--COMEÇAR A INSERIR OS DADOS NO BANCO
			INSERT INTO query_dw.dbo.ANALISE_HISTORICA_VENDA (	MATR_CLIENTE,
																CLIENTE ,
																VALOR_FAT,
																VALOR_FRETE,
																QF,
																CENTRO,
																REGIAO,
																REMESSA,
																OV,
																MATERIAL,
																CIDADE,
																DESCR,
																DATA_FAT,
																COD_IBGE ) VALUES (
																@MATR_CLIENTE, 
																@CLIENTE,
																@VALOR_FAT,	
																@VALOR_FRETE,	
																@QF,
																@CENTRO,	
																@REGIAO,
																@REMESSA,
																@OV,
																@MATERIAL,
																@CIDADE,
																@DESC,
																@DATA_FAT,
																@COD_IBGE)
		SET @idx += 1
	END

	DROP TABLE t_atendimentohistorico_2015;

GO
/*
SELECT *  FROM [query_dw].[dbo].[t_atendimentohistorico_2015]
SELECT FORMAT(SUM(VALOR_FAT), 'C', 'pt-br') FROM  t_atendimentohistorico_2015 WHERE DATA_FAT >= '26/11/2022';

DROP TABLE t_atendimentohistorico_2015;


DECLARE @data DATE;
SET @data =  DATEADD(DAY, 1, (SELECT MAX(DATA_FAT)  FROM [query_dw].[dbo].[ANALISE_HISTORICA_VENDA]));
PRINT @data;
*/


