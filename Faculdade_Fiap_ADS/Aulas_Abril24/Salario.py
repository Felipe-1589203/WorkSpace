nome = input('Informe o Nome do funcionario: ')

salario = float(input('Informe o salario do funcionario: '))


if salario < 0:
    print(
        f'O valor {salario} nao pode ser armazenado pois e um valor negativo. Por favor Digite um valor positivo.')
else:
    print(
        f'O salario do {nome} foi armazenado com sucesso no valor de {salario}')
