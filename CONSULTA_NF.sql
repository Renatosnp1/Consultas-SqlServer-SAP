USE unifort_prod
GO
SELECT  k.VBELN DOCUM
		,k.FKART TIPO_FAT
		,k.FKDAT DATA_FAT
		,k.XBLNR NF
		,p.MATNR SKU
		,p.LGORT FILIAL
		,p.ARKTX DESCR
		,p.AUBEL OV
	FROM (SELECT VBELN,FKART,FKDAT,XBLNR,ERDAT, VKORG FROM unifort_prod.dbo.VBRK WHERE ERDAT >= '01/01/2021' AND FKART IN ('F2B','ZBRI','ZBON') AND XBLNR = '000011612-1') k --AND XBLNR like '%11612%' ,  
	LEFT JOIN (SELECT VBELN, MATNR, LGORT, ARKTX, AUBEL FROM SAP_VBRP.dbo.VBRP WHERE ERDAT >= '01/01/2021') p ON (k.VBELN = p.VBELN)
GO


