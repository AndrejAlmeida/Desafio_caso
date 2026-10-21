%sql
CREATE TABLE sicredi.novarota.estabelecimento (
    id_estabelecimento BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_estabelecimento VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    cidade VARCHAR(150),
    uf CHAR(2),
    status_estabelecimento VARCHAR(50),
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
TBLPROPERTIES ('delta.feature.allowColumnDefaults' = 'supported');