%sql
   CREATE TABLE sicredi.novarota.gold_features_cliente (
    id_feature_cliente BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    -- Identificação
    id_cliente BIGINT NOT NULL,
    data_referencia DATE NOT NULL,

    -- Perfil do cliente
    tempo_relacionamento_dias INTEGER,
    categoria_cliente VARCHAR(50),
    uf CHAR(2),

    -- Comportamento transacional
    qtd_transacoes_30d BIGINT DEFAULT 0,
    qtd_transacoes_90d BIGINT DEFAULT 0,
    valor_transacionado_30d NUMERIC(18,2) DEFAULT 0,
    valor_transacionado_90d NUMERIC(18,2) DEFAULT 0,
    ticket_medio_30d NUMERIC(18,2) DEFAULT 0,

    -- Indicadores de risco
    qtd_eventos_risco_30d BIGINT DEFAULT 0,
    qtd_eventos_risco_90d BIGINT DEFAULT 0,
    qtd_estornos_30d BIGINT DEFAULT 0,
    qtd_estornos_90d BIGINT DEFAULT 0,
    qtd_chargebacks_30d BIGINT DEFAULT 0,
    qtd_chargebacks_90d BIGINT DEFAULT 0,

    valor_estornos_30d NUMERIC(18,2) DEFAULT 0,
    valor_chargebacks_30d NUMERIC(18,2) DEFAULT 0,

    -- Features derivadas
    taxa_estorno_30d NUMERIC(10,4) DEFAULT 0,
    taxa_chargeback_30d NUMERIC(10,4) DEFAULT 0,
    taxa_eventos_risco_30d NUMERIC(10,4) DEFAULT 0,

    -- Controle
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uk_gold_features_cliente_data
        UNIQUE (id_cliente, data_referencia)
);

CREATE INDEX idx_gold_features_cliente_referencia
    ON gold_features_cliente (data_referencia);

CREATE INDEX idx_gold_features_cliente_id
    ON gold_features_cliente (id_cliente);