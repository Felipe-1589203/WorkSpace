frutas1 = ['banana', 'abacate', 'morango', 'kiwi', 'abcaxi']


# for iten in frutas1:
#   if 'b' in iten:
#      frutas2.append(iten)

frutas2 = [iten for iten in frutas1 if 'b' in iten]

print(frutas2)
