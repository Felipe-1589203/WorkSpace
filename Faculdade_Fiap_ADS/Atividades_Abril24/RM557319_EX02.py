valor_veiculo = float(
    input('Digite o preço do carro:'))

for contador in range(1, 12):
    if contador == 1:
        valor_carro = 0.20 * valor_veiculo
        a_vista = valor_veiculo - valor_carro
        print(f'O preço final á vista com desconto de 20% é de {a_vista}')
        contador += 1
    elif contador == 2:
        valor_carro = 0.03 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 6
        print(
            f'O preço final parcelado em 6 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 3:
        valor_carro = 0.06 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 12
        print(
            f'O preço final parcelado em 12 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 4:
        valor_carro = 0.09 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 18
        print(
            f'O preço final parcelado em 18 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 5:
        valor_carro = 0.12 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 24
        print(
            f'O preço final parcelado em 24 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 6:
        valor_carro = 0.15 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 30
        print(
            f'O preço final parcelado em 30 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 7:
        valor_carro = 0.18 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 36
        print(
            f'O preço final parcelado em 36 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 8:
        valor_carro = 0.21 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 42
        print(
            f'O preço final parcelado em 42 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 9:
        valor_carro = 0.24 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 48
        print(
            f'O preço final parcelado em 48 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 10:
        valor_carro = 0.27 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 54
        print(
            f'O preço final parcelado em 54 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
        contador += 1
    elif contador == 11:
        valor_carro = 0.30 * valor_veiculo
        valor_acrescimo = valor_veiculo + valor_carro
        parcelas = valor_acrescimo / 60
        print(
            f'O preço final parcelado em 60 x é de R$ {valor_acrescimo} com parcelas de {parcelas:.2f}')
