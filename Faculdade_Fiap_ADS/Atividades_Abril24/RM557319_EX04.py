valor_resgate = float(input("Digite o valor a ser resgatado: R$ "))
dias_investidos = int(
    input("Digite o número de dias que o valor permaneceu investido: "))
tipo_investimento = int(
    input("Digite o tipo de investimento (1 para CDB, 2 para LCI, 3 para LCA): "))

if tipo_investimento != 1 and tipo_investimento != 2 and tipo_investimento != 3:
    print('Tipo de investimento incorreto, por favor digite uma opção válida!')
else:
    if tipo_investimento == 1:
        if dias_investidos <= 180:
            aliquota_ir = 0.225
            imposto = valor_resgate * aliquota_ir
            valor_resgate = valor_resgate - imposto
            print(
                f'O valor do seu resgate é de {valor_resgate} com imposto de IR no valor de {imposto}')
        elif dias_investidos >= 181 and dias_investidos <= 360:
            aliquota_ir = 0.2
            imposto = valor_resgate * aliquota_ir
            valor_resgate = valor_resgate - imposto
            print(
                f'O valor do seu resgate é de {valor_resgate} com imposto de IR no valor de {imposto}')
        elif dias_investidos >= 361 and dias_investidos <= 720:
            aliquota_ir = 0.175
            imposto = valor_resgate * aliquota_ir
            valor_resgate = valor_resgate - imposto
            print(
                f'O valor do seu resgate é de {valor_resgate} com imposto de IR no valor de {imposto}')
        elif dias_investidos > 720:
            aliquota_ir = 0.15
            imposto = valor_resgate * aliquota_ir
            valor_resgate = valor_resgate - imposto
            print(
                f'O valor do seu resgate é de {valor_resgate} com imposto de IR no valor de {imposto}')
    else:
        print(
            f'O valor do seu resgate é de {valor_resgate} com isencção de IR para LCI´s e LCA´s.')
