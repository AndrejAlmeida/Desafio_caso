classificados = classificar_transacoes(pedidos_df)

validos = classificados.filter(
    F.col("status_validacao") == "VALIDO"
)

invalidos = classificados.filter(
    F.col("status_validacao") == "INVALIDO"
)

(
    invalidos
    .withColumn("rejeitado_em", F.current_timestamp())
    .write.format("delta")
    .mode("append")
    .saveAsTable("main.control.quarentena_transacoes")
)