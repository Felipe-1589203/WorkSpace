# # # valor_compra = float(input('Por favor, digite o valor total da compra: '))

# # # fomara_de_pagamento = int(
# # #     input('Forma de pagamento\n1 - Cartao de credito\n2 - Dinheiro\n Informe a forma adotada: '))

# # # if valor_compra > 100 and fomara_de_pagamento == 1:
# # #     print('O Cliente tem direito a desconto.')
# # #     valor_compra = valor_compra / 2
# # # else:
# # #     print('O Cliente nao tem direito a desconto!')

# # # print(f'O valor da compra é {valor_compra}')

# # faixa_bonus = int(input('\nQuantos foi o bonus desse funcionario? '))

# # bonus_1 = 1000
# # bonus_2 = 500
# # bonus_3 = 200
# # bonus_completo = bonus_1 + bonus_2 + bonus_3

# # if faixa_bonus > bonus_1:
# #     print('O cliente recebe 3gb adicionais!')
# # else:
# #     if faixa_bonus > bonus_2:
# #         print('O cliente recebe 1,5gb adcionais!')
# #     else:
# #         if faixa_bonus > bonus_3:
# #             print(f'O cliente recebe 500 gb adicionais!')
# #         else:
# #             print('Este cliente nada!')


# print('\nVerificador de frequencias cardiacas')

# idade = int(input('Por favor, informe sua idade: '))
# bpm = int(input('Por favor digite seus batimentos cardiacos: '))

# if idade <= 2:
#     if bpm >= 120 and bpm <= 140:
#         print('Batimentos normais para a idade fornecida!')
#     else:
#         print('Batimentos acima dos indicados da idade')
# elif idade >= 8 and idade <= 17:
#     if bpm >= 80 and bpm <= 100:
#         print('Batimentos normais para a idade fornecida')
#     else:
#         print('Batimentos acima para a idade fornecida')
# elif idade >= 18 and idade <= 60:
#     if bpm >= 70 and bpm <= 80:
#         print('Batimentos normais para a idade fornecida')
#     else:
#         print('Batimentos acima para a idade fornecida')
# elif idade > 60:
#     if bpm >= 50 and bpm <= 60:
#         print('Batimentos normais para a idade fornecida')
#     else:
#         print('Batimentos acima para a idade fornecida')
# else:
#     print('Não foi possivel verificar os batimentos para essa idade fornecida.')


valor_bruto = float(input('\nPor favor informe o valor bruto da viagem: '))
categoria = int(input(
    '\nPor favor, informe a categoria:\n1 para Economica\n2 para Executiva\n3 para Primeira Classe: '))
quantidade_viajantes = int(
    input('\nPor favor, informe a quantidade de viajantes: '))

desconto = 0
valor_liquido = 0

if categoria == 1:  # Economica
    if quantidade_viajantes == 2:
        desconto = 3/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de de R$ {valor_liquido} após ganhar 3% de desconto')
    elif quantidade_viajantes == 3:
        desconto = 4/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de R$ {valor_liquido} após ganhar 4% de desconto')
    elif quantidade_viajantes >= 4:
        desconto = 5/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Você pagou o valor pela viagem de R$ {valor_liquido} após ganhar um desconto de 5% ou mais')
elif categoria == 2:  # Executiva
    if quantidade_viajantes == 2:
        desconto = 5/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de de R$ {valor_liquido} após ganhar 3% de desconto')
    elif quantidade_viajantes == 3:
        desconto = 7/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de R$ {valor_liquido} após ganhar 4% de desconto')
    elif quantidade_viajantes >= 4:
        desconto = 8/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Você pagou o valor pela viagem de R$ {valor_liquido} após ganhar um desconto de 5% ou mais')
elif categoria == 3:  # Primeira Classe
    if quantidade_viajantes == 2:
        desconto = 10/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de de R$ {valor_liquido} após ganhar 3% de desconto')
    elif quantidade_viajantes == 3:
        desconto = 15/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Voce pagou o valor pela viagem de R$ {valor_liquido} após ganhar 4% de desconto')
    elif quantidade_viajantes >= 4:
        desconto = 20/100 * valor_bruto
        valor_liquido = valor_bruto - desconto
        print(
            f'Você pagou o valor pela viagem de R$ {valor_liquido} após ganhar um desconto de 5% ou mais')
else:
    print('Categoria inexistente, nao concedido nenhum desconto para essa viagem')
