%sql
CREATE TABLE IF NOT EXISTS sicredi.novarota.gold_fato_transacao (
    id_transacao          STRING NOT NULL,
    id_cliente            STRING,
    id_conta              STRING,
    id_cartao             STRING,

    data_transacao        TIMESTAMP NOT NULL,
    data_referencia       DATE NOT NULL,
    tipo_movimento        STRING NOT NULL,
    canal                 STRING,

    valor                 DECIMAL(18,2) NOT NULL,
    moeda                 STRING,
    status_transacao      STRING,

    arquivo_origem        STRING,
    batch_id              STRING,
    hash_linha            STRING,
    schema_version        STRING,
    timestamp_ingestao    TIMESTAMP,

    data_processamento    TIMESTAMP
)
USING DELTA;