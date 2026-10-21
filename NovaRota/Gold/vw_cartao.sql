%sql
CREATE OR REPLACE VIEW sicredi.novarota.vw_cartao AS
SELECT
    id_cartao,
    id_conta,
    tipo_cartao,
    tipo_cartao,
    status_cartao,
    limite,
    data_atualizacao
FROM sicredi.novarota.cartoes_cdc_bronze;