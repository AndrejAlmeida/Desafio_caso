CREATE TABLE IF NOT EXISTS sicredi.novarota.cartoes (
    id_cartao         BIGINT         NOT NULL,
    id_conta          BIGINT         NOT NULL,
    tipo_cartao       STRING,
    limite            DECIMAL(15,2),
    status_cartao     STRING,
    data_atualizacao  TIMESTAMP,
    operacao          STRING
)
USING DELTA;