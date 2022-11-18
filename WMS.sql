SELECT * FROM mlov_produtseparador
WHERE TERMINO > to_date('01/08/2022','DD/MM/YYYY');


SELECT      INICIO,
            TERMINO,
            NOMEREDUZ,
            LINHA, 
            SUM(PESO) as PESO,
            SUM(LOTE) as QTDE_LOTE 
    FROM mlov_produtseparador
    WHERE TERMINO > to_date('01/08/2022','DD/MM/YYYY') 
    GROUP BY INICIO, TERMINO, NOMEREDUZ, LINHA;