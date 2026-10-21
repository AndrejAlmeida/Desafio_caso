CREATE TABLE IF NOT EXISTS sicredi.novarota.clientes (
    id_cliente       BIGINT         NOT NULL,
    cpf              STRING,
    nome             STRING,
    cidade           STRING,
    estado           STRING,
    renda            DECIMAL(15,2),
    segmento         STRING,
    data_atualizacao TIMESTAMP,
    operacao         STRING
)
USING DELTA;