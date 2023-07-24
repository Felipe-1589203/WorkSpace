temp = int(input("Qual a temperatura da carne? "))

if temp < 48:
    print("Deixe mais uns minutinhos")
elif temp in range(48, 53):
    print("A carne esta selada")
elif temp in range(54, 59):
    print("Ao ponto para mal")
elif temp in range(60, 64):
    print("Ao ponto")
elif temp in range(65, 70):
    print("Ao ponto para bem passado")
elif temp >= 71:
    print("Bem passado")
