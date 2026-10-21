
from datetime import datetime, timezone
from pyspark.sql import functions as F

# Configuração da execução.
# O orquestrador deve reutilizar estes valores em retries
# do mesmo lote.
batch_id = "transacoes-2026-10-21-lote-001"
schema_version = "transacao-v1"

# Em produção, obtenha este timestamp do controle da execução
# e reutilize-o nos retries do mesmo lote.
timestamp_execucao = datetime.now(timezone.utc).strftime(
    "%Y-%m-%d %H:%M:%S"
)

spark.conf.set("spark.sql.session.timeZone", "UTC")

origem = "/Volumes/main/landing/transacoes/"
schema_path = "/Volumes/main/controle/schema/transacoes/"
checkpoint_path = (
    "/Volumes/main/controle/checkpoints/transacoes/"
)

schema = """
    id_transacao STRING,
    id_cliente STRING,
    data_transacao STRING,
    valor STRING,
    tipo_movimento STRING
"""

df = (
    spark.readStream
    .format("cloudFiles")
    .option("cloudFiles.format", "csv")
    .option("cloudFiles.schemaLocation", schema_path)
    .option("cloudFiles.schemaEvolutionMode", "rescue")
    .option("rescuedDataColumn", "_rescued_data")
    .option("header", "true")
    .schema(schema)
    .load(origem)
)

# Hash determinístico do registro parseado.
# Inclui campos conhecidos e dados resgatados.
colunas_dados = sorted([
    c for c in df.columns
    if c != "_metadata"
])

payload = F.to_json(
    F.struct(*[F.col(c) for c in colunas_dados]),
    options={"ignoreNullFields": "false"},
)

bronze = (
    df
    .withColumn(
        "arquivo_origem",
        F.col("_metadata.file_path")
    )
    .withColumn(
        "data_ingestao",
        F.to_date(F.lit(timestamp_execucao))
    )
    .withColumn(
        "timestamp_ingestao",
        F.to_timestamp(F.lit(timestamp_execucao))
    )
    .withColumn("batch_id", F.lit(batch_id))
    .withColumn("hash_linha", F.sha2(payload, 256))
    .withColumn("schema_version", F.lit(schema_version))
)

(
    bronze.writeStream
    .format("delta")
    .outputMode("append")
    .option("checkpointLocation", checkpoint_path)
    .trigger(availableNow=True)
    .toTable("main.bronze.transacao_raw")
    .awaitTermination()
)
