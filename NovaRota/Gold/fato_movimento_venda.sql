CREATE TABLE IF NOT EXISTS main.gold.fato_movimento_venda (
    evento_id STRING NOT NULL,
    transacao_id STRING NOT NULL,
    pedido_id BIGINT,
    item_id BIGINT,

    tipo_evento STRING NOT NULL,
    status_validacao STRING NOT NULL,

    data_evento TIMESTAMP NOT NULL,
    data_ingestao TIMESTAMP NOT NULL,

    valor_bruto DECIMAL(18,2),
    valor_estorno DECIMAL(18,2),
    valor_devolucao DECIMAL(18,2),
    impacto_receita DECIMAL(18,2),

    evento_original_id STRING,
    motivo STRING,
    lote_id STRING
)
USING DELTA;