faturamento_anual = float(input('Por favor informe o seu faturamento anual: '))
tipo_assinatura = input(
    'Por favor, informe o seu tipo de assinatura:\nBasic\nSilver\nGold\nPlatinum\n')

bonus = 0
valor_pago = 0

if tipo_assinatura.upper() == 'BASIC':
    bonus = 30/100 * faturamento_anual
    valor_pago = faturamento_anual - bonus
    print(
        f'O Seu plano é o "{tipo_assinatura}". Portanto voce pagara um valor de {bonus} a nossa empresa, e seu faturamento liquido é de {valor_pago}')
elif tipo_assinatura.upper() == 'SILVER':
    bonus = 20/100 * faturamento_anual
    valor_pago = faturamento_anual - bonus
    print(
        f'O Seu plano é o "{tipo_assinatura}". Portanto voce pagara um valor de {bonus} a nossa empresa, e seu faturamento liquido é de {valor_pago}')
elif tipo_assinatura.upper() == 'GOLD':
    bonus = 10/100 * faturamento_anual
    valor_pago = faturamento_anual - bonus
    print(
        f'O Seu plano é o "{tipo_assinatura}". Portanto voce pagara um valor de {bonus} a nossa empresa, e seu faturamento liquido é de {valor_pago}')
elif tipo_assinatura.upper() == 'PLATINUM':
    bonus = 5/100 * faturamento_anual
    valor_pago = faturamento_anual - bonus
    print(
        f'O Seu plano é o "{tipo_assinatura}". Portanto voce pagara um valor de {bonus} a nossa empresa, e seu faturamento liquido é de {valor_pago}')
else:
    print('Digite uma informação valida. Tente novamente!')
