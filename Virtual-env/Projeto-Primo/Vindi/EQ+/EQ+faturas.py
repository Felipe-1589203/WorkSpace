import requests
import base64
from datetime import datetime
import pandas as pd
from pandas import json_normalize
import time
from concurrent.futures import ThreadPoolExecutor

usuario = "_rQhUUKLCNT_b4o5os9I0k0awIKIUXhgiWvnXC5Z53I"
senha = ""

base_url = "https://app.vindi.com.br/api/v1/bills"
per_page = 50
date_cri = "2023-09-01"
date_ate = datetime.now().strftime("%Y-%m-%d")

ultimo_id_coletado = 0

output_data = []

start_time = time.time()

def fetch_and_process_data(page, starting_after):
    url = f"{base_url}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

    headers = {
        "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
    }

    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        bills = data.get('bills', [])

        if not bills:
            return None
       
        for bill in bills:
            bill_items = bill.get('bill_items', [])
            product_ids = [item.get('product', {}).get('id') for item in bill_items]
            product_names = [item.get('product', {}).get('name') for item in bill_items]
            bill['product_id'] = product_ids
            bill['product_name'] = product_names
            
            charges = bill.get('charges',[])
            charge_ids = [charge.get('id') for charge in charges]
            bill['charge_id'] = charge_ids

        df = json_normalize(bills)
        
        df = df.rename(columns={"charge_id": "id-cobrança"})

        columns_to_keep = ["id","installments", "status", "created_at", "updated_at",  "product_name", "id-cobrança"]
        df = df[columns_to_keep]

        
        df = df.rename(columns={
            "id": "id-fatura",
            # "amount": "valor-fatura",
            "installments": "parcelas",
            "status": "status-fatura",
            "created_at": "criação-fatura",
            "updated_at": "atualização-fatura",
            # "product_id": "id-produto",
            "product_name": "nome-produto",
            # "charge_id": "id-cobrança"
        })

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].astype(str)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

        return df, bills[-1]['id']

    else:
        print(f"Erro na solicitação: {response.status_code} - {response.text}")
        return None

page = 1
ultimo_id_coletado = 0

with ThreadPoolExecutor() as executor:
    while True:
        future = executor.submit(fetch_and_process_data, page, ultimo_id_coletado)
        result = future.result()

        if result is None:
            print("Não há mais dados para salvar. Saindo do loop.")
            break

        df, ultimo_id_coletado = result
        output_data.append(df)
        page += 1

end_time = time.time()
elapsed_time_seconds = end_time - start_time
elapsed_time_minutes = elapsed_time_seconds / 60

print(f"Solicitação à API feita com sucesso!")
print(f"Tempo decorrido para salvar os dados: {elapsed_time_seconds:.2f} segundos ({elapsed_time_minutes:.2f} minutos)")

final_df = pd.concat(output_data, ignore_index=True)

# Nome do arquivo Excel e aba
excel_file = "relatorio-vindi-EQ+.xlsx"
sheet_name = "faturas"

try:
    # Tente carregar o arquivo Excel existente para obter o último ID de transação já registrado
    existing_data = pd.read_excel(excel_file, sheet_name=sheet_name)
    ultimo_id_coletado = existing_data['id-fatura'].max() if not existing_data.empty else 0
except FileNotFoundError:
    existing_data = None

with pd.ExcelWriter(excel_file, engine='openpyxl', mode='a', if_sheet_exists='overlay') as writer:
    if existing_data is not None:
        # Se o arquivo Excel existente foi carregado, anexe os novos dados abaixo dos dados existentes
        final_df = pd.concat([existing_data, final_df], ignore_index=True)
    final_df.to_excel(writer, sheet_name=sheet_name, index=False)

    # Remova colchetes dos campos de lista (product_ids, product_names e charge_ids)
    # final_df['id-produto'] = final_df['id-produto'].str.replace(r"\[|\]", '', regex=True)
    final_df['nome-produto'] = final_df['nome-produto'].str.replace(r"[\[\]()]", '', regex=True)
    final_df['id-cobrança'] = final_df['id-cobrança'].str.replace(r"\[|\]", '', regex=True)

    # Remova aspas simples dos campos de texto
    for col in final_df.columns:
        if final_df[col].dtype == 'object':
            final_df[col] = final_df[col].str.replace("'", "")

    final_df.to_excel(writer, sheet_name=sheet_name, index=False)

print(f"Dados salvos em {excel_file}")


