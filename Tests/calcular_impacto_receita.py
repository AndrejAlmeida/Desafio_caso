from pyspark.sql import functions as F

def calcular_impacto_receita(df):
    tipo = F.upper(F.col("tipo_evento"))

    return df.withColumn(
        "impacto_receita",
        F.when(
            (tipo == "VENDA")
            & (F.col("status_validacao") == "VALIDO"),
            F.col("valor_bruto")
        )
        .when(
            (tipo == "ESTORNO")
            & (F.col("status_validacao") == "VALIDO"),
            -F.abs(F.col("valor_estorno"))
        )
        .when(
            (tipo == "DEVOLUCAO")
            & (F.col("status_validacao") == "VALIDO"),
            -F.abs(F.col("valor_devolucao"))
        )
        .when(
            tipo == "CANCELAMENTO",
            F.lit(0).cast("decimal(18,2)")
        )
        .otherwise(
            F.lit(None).cast("decimal(18,2)")
        )
    )