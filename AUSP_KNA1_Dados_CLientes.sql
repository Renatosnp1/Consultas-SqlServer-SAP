USE SAP_DIV
GO
CREATE VIEW view_dados_cliente_dw as
SELECT  n.KUNNR as 'MATR',
        n.NAME1 as 'CLIENTE',
        coalesce(sp.ATWRT, 'SEM ANÁLISE') as 'CLASSIFICAÇÃO',
        n.ORT01 as 'CIDADE', 
        REGIO as 'UF',
        MCOD1 as 'NOME FANTASIA',
        STRAS as 'ENDEREÇO',
        ORT02 as 'BAIRRO',
        PSTLZ as 'CEP',
        STCD1 as 'CNPJ',
        TELF1 as 'TELEFONE1',
        TELF2 as 'TELEFONE2',
        TELFX as 'TELEFONE_FAX'
    from KNA1 n
    LEFT JOIN AUSP sp ON (n.KUNNR = sp.OBJEK);


SELECT * FROM view_dados_cliente_dw;