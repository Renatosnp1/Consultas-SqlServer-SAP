USE query_dw
GO
CREATE TABLE RECOMENDACAO_VENDA(
antecedents VARCHAR(15),
consequents VARCHAR(15),
consequent_support real,
support real,
confidence real,
lift real,
DATA_REL DATE,
CATEGORIA VARCHAR(30));


SELECT DISTINCT [antecedents]
      ,[consequents]
      ,[confidence]
      ,[lift]
      ,[DATA_REL]
      ,[CATEGORIA]
  FROM [query_dw].[dbo].[RECO.aMENDACAO_VENDA]


DELETE FROM [query_dw].[dbo].[RECOMENDACAO_VENDA]

