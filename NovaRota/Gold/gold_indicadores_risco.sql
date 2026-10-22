%sql
CREATE TABLE sicredi.novarota.gold_indicadores_risco (
    id_indicador_risco BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    id_estabelecimento BIGINT NOT NULL,
    nome_estabelecimento VARCHAR(255),
    categoria VARCHAR(100),
    cidade VARCHAR(150),
    uf CHAR(2),

    data_referencia DATE NOT NULL,

    -- Indicadores de eventos de risco
    qtd_eventos_risco BIGINT DEFAULT 0,
    qtd_eventos_risco_confirmados BIGINT DEFAULT 0,
    valor_eventos_risco NUMERIC(18,2) DEFAULT 0,

    -- Indicadores de estornos
    qtd_estornos BIGINT DEFAULT 0,
    valor_estornos NUMERIC(18,2) DEFAULT 0,

    -- Indicadores de chargebacks
    qtd_chargebacks BIGINT DEFAULT 0,
    valor_chargebacks NUMERIC(18,2) DEFAULT 0,

    -- Indicadores consolidados
    qtd_transacoes BIGINT DEFAULT 0,
    valor_transacionado NUMERIC(18,2) DEFAULT 0,

    percentual_eventos_risco NUMERIC(10,4) DEFAULT 0,
    percentual_estornos NUMERIC(10,4) DEFAULT 0,
    percentual_chargebacks NUMERIC(10,4) DEFAULT 0,

    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_gold_indicadores_estabelecimento
        FOREIGN KEY (id_estabelecimento)
        REFERENCES estabelecimento (id_estabelecimento),

    CONSTRAINT uk_gold_indicadores_estabelecimento_data
        UNIQUE (id_estabelecimento, data_referencia)
);