CREATE TABLE IF NOT EXISTS sicredi.novarota.gold_cliente_mes (
    id_cliente                  VARCHAR(100) NOT NULL,
    mes_referencia              DATE NOT NULL,

    qtd_transacoes              BIGINT DEFAULT 0,
    qtd_dias_ativos             INTEGER DEFAULT 0,

    valor_entradas              NUMERIC(18,2) DEFAULT 0,
    valor_saidas                NUMERIC(18,2) DEFAULT 0,
    valor_movimentado           NUMERIC(18,2) DEFAULT 0,
    ticket_medio                NUMERIC(18,2),

    qtd_compras_cartao          BIGINT DEFAULT 0,
    valor_compras_cartao        NUMERIC(18,2) DEFAULT 0,

    data_ultima_transacao       DATE,
    dias_desde_ultima_transacao INTEGER,

    variacao_mensal_gastos_pct  NUMERIC(10,2),

    data_processamento          TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_cliente, mes_referencia)
)
TBLPROPERTIES ('delta.feature.allowColumnDefaults' = 'supported');