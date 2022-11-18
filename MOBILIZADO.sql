USE SAP_DIV
CREATE TABLE MOBILIZADO(
[Imob] VARCHAR(6),
[Sbn] VARCHAR(4),
[Dt_incorp] DATE,
[Denominacao_do_imobilizado] VARCHAR(50),
[ValAquis] numeric(10,2),
[Depreciacaoo_ac] NUMERIC(10,2),
[Valor_contabil] NUMERIC(10,2),
[Moeda] VARCHAR(5),
[Cen] VARCHAR(4),
[Classe] VARCHAR(6),
[Centro_cst] VARCHAR(10));



SELECT [Dt_incorp]
      ,[Denominacao_do_imobilizado]
      ,[ValAquis]
      ,[Depreciacaoo_ac]
      ,[Valor_contabil]
      ,[Cen]
      ,[Classe]
      ,[Centro_cst] FROM IMOBILIZADO;