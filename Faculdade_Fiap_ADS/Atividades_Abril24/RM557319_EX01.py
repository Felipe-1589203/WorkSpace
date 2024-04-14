voto1 = 0
voto2 = 0
voto3 = 0
voto4 = 0
voto5 = 0

numero_colaboradores = int(
    input('Digite quantos colaboradores irão participar da votação: '))

contador = 0
segunda_feira = 0
terca_feira = 0
quarta_feira = 0
quinta_feira = 0
sexta_feira = 0


while contador < numero_colaboradores:
    contador += 1
    print(f'\nColaborador {contador}')
    dia_preferido = input(
        'Seleciona de Segunda-feira a Sexta-feira o dia de sua preferência para participar'
        ' da live com o time de Mentoria Financeira: ')
    if dia_preferido.upper() == 'SEGUNDA-FEIRA':
        segunda_feira += 1
    elif dia_preferido.upper() == 'TERCA-FEIRA':
        terca_feira += 1
    elif dia_preferido.upper() == 'QUARTA-FEIRA':
        quarta_feira += 1
    elif dia_preferido.upper() == 'QUINTA-FEIRA':
        quinta_feira += 1
    elif dia_preferido.upper() == 'SEXTA-FEIRA':
        sexta_feira += 1
    else:
        print('O colaborador digitou um dia da semana inexistente e/ou não util')

dia_mais_votado = max(segunda_feira, terca_feira,
                      quarta_feira, quinta_feira, sexta_feira)

print(
    f'\nNa Segunda-Feira tivemos {segunda_feira} colaboradores votando')
print(
    f'\nNa Terça-Feira tivemos {terca_feira} colaboradores votando')
print(
    f'\nNa Quarta-Feira tivemos {quarta_feira} colaboradores votando')
print(
    f'\nNa Quinta-Feira tivemos {quinta_feira} colaboradores votando')
print(
    f'\nNa Sexta-Feira tivemos {sexta_feira} colaboradores votando')


if dia_mais_votado == segunda_feira:
    print(
        f'\nSendo assim o dia mais votado foi Segunda-Feira com {segunda_feira} votos!')
elif dia_mais_votado == terca_feira:
    print(
        f'\nSendo assim o dia mais votado foi Terça-feira com {terca_feira} votos!')
elif dia_mais_votado == quarta_feira:
    print(
        f'\nSendo assim o dia mais votado foi Quarta-Feira com {quarta_feira} votos!')
elif dia_mais_votado == quinta_feira:
    print(
        f'\nSendo assim o dia mais votado foi Quinta-Feira com {quinta_feira} votos!')
elif dia_mais_votado == sexta_feira:
    print(
        f'\nSendo assim o dia mais votado foi Sexta-Feira com {sexta_feira} votos!')
