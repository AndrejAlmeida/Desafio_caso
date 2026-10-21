CREATE TABLE IF NOT EXISTS sicredi.novarota.transacoes (
    id_transacao   BIGINT         NOT NULL,
    id_cartao      BIGINT         NOT NULL,
    data_transacao TIMESTAMP,
    valor          DECIMAL(15,2),
    mcc            STRING,
    estabelecimento STRING,
    canal          STRING,
    pais           STRING,
    moeda          STRING
)
USING DELTA;