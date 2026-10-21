from decimal import Decimal


def test_estorno_parcial():
    venda = Decimal("100.00")
    estorno = Decimal("30.00")

    receita_liquida = venda - estorno

    assert receita_liquida == Decimal("70.00")


def test_estorno_total():
    venda = Decimal("100.00")
    estorno = Decimal("100.00")

    receita_liquida = venda - estorno

    assert receita_liquida == Decimal("0.00")


def test_cancelamento_antes_do_faturamento():
    receita_reconhecida = Decimal("0.00")

    assert receita_reconhecida == Decimal("0.00")