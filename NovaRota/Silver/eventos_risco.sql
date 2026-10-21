CREATE TABLE IF NOT EXISTS sicredi.novarota.eventos_risco (
    id_evento     BIGINT    NOT NULL,
    id_transacao  BIGINT,
    tipo_evento   STRING,
    severidade    STRING,
    data_evento   TIMESTAMP
)
USING DELTA;