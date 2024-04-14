divida = float(input('Digite o valor da divida:'))

for contador in range(1, 6):
    if contador == 1:
        juros = 0.0 * divida
        total = divida + juros
        valor_parcela = total / 1
        print(
            f'Total R$: {total} Juros:R$ {juros} Numero de parcelas:1 Valor da Parcela:R$ {valor_parcela:.2f}')
    if contador == 2:
        juros = 0.10 * divida
        total = divida + juros
        valor_parcela = total / 3
        print(
            f'Total R$: {total} Juros:R$ {juros} Numero de parcelas:3 Valor da Parcela:R$ {valor_parcela:.2f}')
    if contador == 3:
        juros = 0.15 * divida
        total = divida + juros
        valor_parcela = total / 6
        print(
            f'Total R$: {total} Juros:R$ {juros} Numero de parcelas:6 Valor da Parcela:R$ {valor_parcela:.2f}')
    if contador == 4:
        juros = 0.20 * divida
        total = divida + juros
        valor_parcela = total / 9
        print(
            f'Total R$: {total} Juros:R$ {juros} Numero de parcelas:9 Valor da Parcela:R$ {valor_parcela:.2f}')
    if contador == 5:
        juros = 0.25 * divida
        total = divida + juros
        valor_parcela = total / 12
        print(
            f'Total R$: {total} Juros:R$ {juros} Numero de parcelas:12 Valor da Parcela:R$ {valor_parcela:.2f}')
