voto1 = input(
    'Informe o premio que deseja ganhar: Playtation, Xbox ou Nitendo ')
voto2 = input(
    'Informe o premio que deseja ganhar: Playtation, Xbox ou Nitendo ')
voto3 = input(
    'Informe o premio que deseja ganhar: Playtation, Xbox ou Nitendo ')
voto4 = input(
    'Informe o premio que deseja ganhar: Playtation, Xbox ou Nitendo ')
voto5 = input(
    'Informe o premio que deseja ganhar: Playtation, Xbox ou Nitendo ')


playtation = 0
xbox = 0
nitendo = 0

if voto1.upper() == 'PLAplasyYSTATION':
    playtation = + 1
elif voto1.upper() == 'XBOX':
    xbox = + 1
elif voto1.upper() == 'NITENDO':
    nitendo = + 1
else:
    print('O colaborador 1 digitou um console inexistente e seu voto sera desconsiderado')


if voto2.upper() == 'PLAYSTATION':
    playtation = + 1
elif voto2.upper() == 'XBOX':
    xbox = + 1
elif voto2.upper() == 'NITENDO':
    nitendo = + 1
else:
    print('O colaborador 1 digitou um console inexistente e seu voto sera desconsiderado')


if voto3.upper() == 'PLAYSTATION':
    playtation = + 1
elif voto3.upper() == 'XBOX':
    xbox = + 1
elif voto3.upper() == 'NITENDO':
    nitendo = + 1
else:
    print('O colaborador 1 digitou um console inexistente e seu voto sera desconsiderado')


if voto4.upper() == 'PLAYSTATION':
    playtation = + 1
elif voto4.upper() == 'XBOX':
    xbox = + 1
elif voto4.upper() == 'NITENDO':
    nitendo = + 1
else:
    print('O colaborador 1 digitou um console inexistente e seu voto sera desconsiderado')


if voto5.upper() == 'PLAYSTATION':
    playtation = + 1
elif voto5.upper() == 'XBOX':
    xbox = + 1
elif voto5.upper() == 'NITENDO':
    nitendo = + 1
else:
    print('O colaborador 1 digitou um console inexistente e seu voto sera desconsiderado')


if playtation > xbox and playtation > nitendo:
    print('O console escolhido foi o playstation')
