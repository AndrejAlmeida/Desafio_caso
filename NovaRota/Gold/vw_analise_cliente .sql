
CREATE OR REPLACE VIEW catalog.gold.vw_analise_cliente AS

WITH transacoes_base AS (
    -- 1. Seleciona transações aprovadas no período
    SELECT
        id_transacao,
        id_cartao,
        id_estabelecimento,
        data_transacao,
        valor_transacao
    FROM catalog.silver.transacao
    WHERE status_transacao = 'APROVADA'
      AND data_transacao >= DATE '2026-01-01'
      AND data_transacao <  DATE '2027-01-01'
      AND id_transacao IS NOT NULL
),

transacoes_enriquecidas AS (
    -- 2. Relaciona transações aos estabelecimentos
    SELECT
        t.id_transacao,
        t.id_cartao,
        t.id_estabelecimento,
        t.data_transacao,
        t.valor_transacao,
        e.categoria,
        e.uf
    FROM transacoes_base t
    LEFT JOIN catalog.gold.vw_estabelecimento e
        ON t.id_estabelecimento = e.id_estabelecimento
),

metricas_estabelecimento AS (
    -- 3. Consolida métricas por estabelecimento
    SELECT
        id_estabelecimento,
        COUNT(DISTINCT id_transacao) AS qtd_transacoes,
        SUM(valor_transacao) AS valor_total
    FROM transacoes_enriquecidas
    GROUP BY id_estabelecimento
),

metricas_cartao AS (
    -- 4. Calcula métricas por cartão
    SELECT
        id_cartao,
        COUNT(DISTINCT id_transacao) AS qtd_transacoes,
        SUM(valor_transacao) AS valor_total
    FROM transacoes_base
    GROUP BY id_cartao
),

metricas_conta AS (
    -- 5. Agrega métricas dos cartões por conta
    SELECT
        c.id_conta,
        COUNT(DISTINCT c.id_cartao) AS qtd_cartoes,
        SUM(COALESCE(m.qtd_transacoes, 0))
            AS qtd_transacoes,
        SUM(COALESCE(m.valor_total, 0))
            AS valor_total_transacionado
    FROM catalog.gold.vw_cartao c
    LEFT JOIN metricas_cartao m
        ON c.id_cartao = m.id_cartao
    GROUP BY c.id_conta
),

analise_cliente AS (
    -- 6. Consolida a análise na granularidade do cliente
    SELECT
        cl.id_cliente,
        cl.nome_cliente,
        cl.status_cliente,
        COUNT(DISTINCT co.id_conta) AS qtd_contas,
        SUM(COALESCE(mc.qtd_cartoes, 0)) AS qtd_cartoes,
        SUM(COALESCE(mc.qtd_transacoes, 0))
            AS qtd_transacoes,
        SUM(COALESCE(mc.valor_total_transacionado, 0))
            AS valor_total_transacionado
    FROM catalog.gold.vw_cliente cl
    LEFT JOIN catalog.gold.vw_conta co
        ON cl.id_cliente = co.id_cliente
    LEFT JOIN metricas_conta mc
        ON co.id_conta = mc.id_conta
    GROUP BY
        cl.id_cliente,
        cl.nome_cliente,
        cl.status_cliente
)

SELECT
    id_cliente,
    nome_cliente,
    status_cliente,
    qtd_contas,
    qtd_cartoes,
    qtd_transacoes,
    valor_total_transacionado
FROM analise_cliente;
