CREATE TABLE IF NOT EXISTS sicredi.novarota.estornos (
    id_estorno    BIGINT    NOT NULL,
    id_transacao  BIGINT    NOT NULL,
    data_estorno  TIMESTAMP,
    motivo        STRING
)
USING DELTA;