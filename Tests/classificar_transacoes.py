from pyspark.sql import functions as F

def classificar_transacoes(df):
    status = F.upper(F.trim(F.col("Status")))

    return (
        df
        .withColumn(
            "status_normalizado",
            F.when(status.isin("FATURADO", "PAGO"), "CONCLUIDO")
             .when(status.isin("CANCELADO", "CANCELADA"), "CANCELADO")
             .when(status.isin("ESTORNADO", "ESTORNADA"), "ESTORNADO")
             .when(status.isin("ABERTO", "PENDENTE"), "PENDENTE")
             .otherwise("DESCONHECIDO")
        )
        .withColumn(
            "motivo_invalidade",
            F.when(F.col("PedidoID").isNull(), "PEDIDO_ID_NULO")
             .when(F.col("DataAlteracao").isNull(), "DATA_ALTERACAO_NULA")
             .when(F.col("ValorTotal") < 0, "VALOR_NEGATIVO")
             .when(
                 F.col("status_normalizado") == "DESCONHECIDO",
                 "STATUS_DESCONHECIDO"
             )
        )
        .withColumn(
            "status_validacao",
            F.when(F.col("motivo_invalidade").isNotNull(), "INVALIDO")
             .otherwise("VALIDO")
        )
    )