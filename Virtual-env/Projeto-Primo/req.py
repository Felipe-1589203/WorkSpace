import json
import csv


json_file = 'pagarme.json'

with open(json_file, 'r', encoding='utf-8') as json_data:
    data = json.load(json_data)


csv_file = 'pagarme2.csv'
data_list = data['data']


with open(csv_file, 'w', newline='', encoding='utf-8') as file:   
    csv_writer = csv.writer(file)    
    csv_writer.writerow(data_list[0].keys())


    for item in data_list:
        csv_writer.writerow(item.values())

print(f'O arquivo CSV "{csv_file}" foi gerado com sucesso a partir do JSON.')

