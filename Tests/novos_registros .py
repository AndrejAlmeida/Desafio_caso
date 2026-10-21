
from pyspark.sql import functions as F

# Valores obtidos da tabela de controle do pipeline.
watermark_anterior = "2026-03-01 00:00:00"
data_corte = "2026-03-02 00:00:00"

novos_registros = (
    spark.table("silver_transacao")
    .filter(
        (F.col("data_ingestao") > F.to_timestamp(
            F.lit(watermark_anterior)
        ))
        & (F.col("data_ingestao") <= F.to_timestamp(
            F.lit(data_corte)
        ))
    )
)

# Identificar os meses de referência que precisam ser recalculados.
meses_afetados = (
    novos_registros
    .filter(F.col("data_transacao").isNotNull())
    .select(
        F.trunc("data_transacao", "month")
        .alias("mes_referencia")
    )
    .distinct()
)

# Se a Gold calcula variação mensal usando LAG,
# incluir também o mês seguinte a cada mês afetado.
meses_dependentes = meses_afetados.select(
    F.explode(
        F.array(
            F.col("mes_referencia"),
            F.add_months("mes_referencia", 1),
        )
    ).alias("mes_referencia")
).distinct()

meses_dependentes.createOrReplaceTempView(
    "meses_reprocessar"
)
