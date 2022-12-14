SELECT YEAR(AUDAT) ANO,
		MONTH(AUDAT) MES,
		COUNT(AUDAT) 
	FROM SAP_DIV.dbo.VAKPA
	GROUP BY YEAR(AUDAT), MONTH(AUDAT)
	ORDER BY YEAR(AUDAT), MONTH(AUDAT);

--VE == PE
--VP == PA
--SP == AGENTE DE FRETE
--AG == EMISSOR

(SELECT KUNDE,NAME1 FROM (SELECT * FROM SAP_DIV.dbo.VAKPA WHERE PARVW = 'SP') pa
	left join (SELECT * FROM SAP_DIV.dbo.LFA1) a ON (a.LIFNR = pa.KUNDE));

SELECT * FROM SAP_DIV.dbo.VAKPA


SELECT	
			v.VBELN 'OV',
			v.KUNDE 'MATR VE',
		FROM 
	(SELECT VBELN, KUNDE FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'VE') v
	left join (SELECT KUNDE, VBELN FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'SP') a ON (v.VBELN = a.VBELN)
	left join (SELECT KUNDE, VBELN FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'VP') p ON (v.VBELN = a.VBELN)
	left join (SELECT KUNDE, VBELN FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'AG') g ON (v.VBELN = a.VBELN)




USE unifort_prod
GO
ALTER VIEW view_nome_trans_pa_OV
AS
SELECT	
			v.VBELN 'OV',
			v.KUNDE 'MATR_PA',
			a.KUNDE 'MATR_SP'
		FROM 
	(SELECT VBELN, KUNDE FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'VP') v
	left join (SELECT KUNDE, VBELN FROM SAP_DIV.dbo.VAKPA WHERE AUDAT >= '01/09/2022' AND PARVW = 'SP') a ON (v.VBELN = a.VBELN)



SELECT v.VBELN 'OV', v.KUNDE 'MATR VE' FROM SAP_DIV.dbo.VAKPA v



USE query_dw
GO
CREATE VIEW view_OV_VE_PA
AS
	SELECT  vv.VBELN,
			vv.AUDAT,
			vv.MATR_VE,
			p1.ENAME NOME_VE,
			v2.MATR_PA,
			p2.ENAME NOME_PA
		FROM (SELECT v.VBELN, v.KUNDE 'MATR_VE', v.AUDAT FROM SAP_DIV.dbo.VAKPA v WHERE v.PARVW = 'VE') vv
			LEFT JOIN (SELECT v.VBELN, v.KUNDE 'MATR_PA' FROM SAP_DIV.dbo.VAKPA v WHERE v.PARVW = 'VP') v2 ON (vv.VBELN = v2.VBELN)
			LEFT JOIN (SELECT PERNR, ENAME FROM SAP_DIV.dbo.PA0001) p1 ON (vv.MATR_VE = p1.PERNR)
			LEFT JOIN (SELECT PERNR, ENAME FROM SAP_DIV.dbo.PA0001) p2 ON (v2.MATR_PA = p2.PERNR)
GO


SELECT pa.VBELN, pa.MATR_PA, pa.NOME_PA FROM view_OV_VE_PA pa WHERE pa.AUDAT >= '01/01/2020' 



select * from view_nome_trans_pa_OV