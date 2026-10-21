CREATE OR REPLACE VIEW catalog.gold.vw_conta AS
SELECT
    id_conta,
    id_cliente,
    tipo_conta,
    status_conta,
    data_abertura,
    saldo_atual,
    data_atualizacao
FROM catalog.silver.conta;