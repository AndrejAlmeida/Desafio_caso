%sql
CREATE OR REPLACE VIEW sicredi.novarota.vw_cliente AS
SELECT
    id_cliente,
    nome,
    CASE
        WHEN cpf IS NOT NULL
        THEN CONCAT('***.***.***-', RIGHT(cpf, 2))
        ELSE NULL
    END AS cpf_mascarado,
    cidade,
    data_atualizacao
FROM sicredi.novarota.clientes;