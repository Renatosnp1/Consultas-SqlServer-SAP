USE SAP_DIV
GO
ALTER VIEW view_ZSD035
AS
SELECT	  [KUNNR] [Cliente]
		 ,[PERNR] [Nº pess.]
		 ,[ULTIMA_COMPRA] [Data Última compra]
		 ,[NAME1] [Nome 1]
		 ,[STRAS] [Rua]
		 ,[ORT01] [Local]
		 ,[TELF1] [Telefone 1]
		 ,[ORT02] [Bairro]
		 ,[DATA_REL] [DATA_REL]
	 FROM ZSD035;
GO

SELECt * FROM view_ZSD035;								
