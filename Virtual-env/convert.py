import json
import csv


with open('primo.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)


with open('primo.csv', 'a', newline='', encoding='utf-8') as csv_file:
    writer = csv.writer(csv_file)

   
    if csv_file.tell() == 0:
        header = data["products"][0].keys()
        writer.writerow(header)

    
    for product in data["products"]:
        writer.writerow(product.values())
        print(f"Escrevendo linha para o produto: {', '.join(map(str, product.values()))}")

print("Conversão para CSV concluída.")
