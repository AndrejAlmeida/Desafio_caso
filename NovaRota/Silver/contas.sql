CREATE TABLE IF NOT EXISTS sicredi.novarota.contas (
    id_conta         BIGINT    NOT NULL,
    id_cliente       BIGINT    NOT NULL,
    tipo_conta       STRING,
    status_conta     STRING,
    data_abertura    DATE,
    data_atualizacao TIMESTAMP,
    operacao         STRING
)
USING DELTA;