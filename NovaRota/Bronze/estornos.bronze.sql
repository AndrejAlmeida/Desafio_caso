CREATE TABLE IF NOT EXISTS sicredi.novarota.estornos.bronze (
    id_estorno    BIGINT    NOT NULL,
    id_transacao  BIGINT    NOT NULL,
    data_estorno  TIMESTAMP,
    motivo        STRING
)
USING DELTA;



INSERT INTO sicredi.novarota.estornos_bronze (
    id_estorno,
    id_transacao,
    data_estorno,
    motivo
)
VALUES (
    70001,
    1000001,
    CURRENT_TIMESTAMP(),
    'COMPRA_DUPLICADA'
);