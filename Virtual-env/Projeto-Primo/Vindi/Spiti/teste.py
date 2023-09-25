import requests
import base64
from datetime import datetime
import pandas as pd
from pandas import json_normalize
import time
from concurrent.futures import ThreadPoolExecutor

usuario = "chave"
senha = ""

base_url_faturas = "https://app.vindi.com.br/api/v1/bills"
base_url_transacoes = "https://app.vindi.com.br/api/v1/transactions"
per_page = 50
date_cri = "2023-09-20"
date_ate = datetime.now().strftime("%Y-%m-%d")

ultimo_id_coletado_faturas = 0
ultimo_id_coletado_transacoes = 0

output_data_faturas = []
output_data_transacoes = []

start_time = time.time()

def fetch_and_process_faturas(page, starting_after):
    url = f"{base_url_faturas}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

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

        columns_to_keep = ["id", "amount", "installments", "status", "created_at", "updated_at","product_name","charge_id"]
        df = df[columns_to_keep]

        df = df.rename(columns={
            "id": "id-fatura",
            "amount": "valor-fatura",
            "installments": "parcelas",
            "status": "status-fatura",
            "created_at": "criação-fatura",
            "updated_at": "atualização-fatura",
            "charge_id": "id-cobrança",
            "product_name": "nome-produto"
        })

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].astype(str)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

        return df, bills[-1]['id']

    else:
        print(f"Erro na solicitação de faturas: {response.status_code} - {response.text}")
        return None

def fetch_and_process_transacoes(page, starting_after):
    url = f"{base_url_transacoes}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

    headers = {
        "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
    }

    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        transactions = data.get('transactions', [])

        if not transactions:
            return None

        df = json_normalize(transactions)

        columns_to_keep = ["id", "transaction_type", "status", "amount", "created_at", "updated_at", "charge.id", "customer.id", "customer.name", "customer.email"]
        df = df[columns_to_keep]

        df = df.rename(columns={
            "id": "id-transação",
            "transaction_type": "tipo-transação",
            "status": "status-transação",
            "amount": "valor-transação",
            "created_at": "criação-transação",
            "updated_at": "atualização-transação",
            "charge.id": "id-cobrança",
            "customer.id": "id-cliente",
            "customer.name": "nome-cliente",
            "customer.email": "email-cliente"
        })

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].astype(str)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

        return df, transactions[-1]['id']

    else:
        print(f"Erro na solicitação de transações: {response.status_code} - {response.text}")
        return None

page_transacoes = 1
ultimo_id_coletado_transacoes = 0

with ThreadPoolExecutor() as executor:
    while True:
        future = executor.submit(fetch_and_process_transacoes, page_transacoes, ultimo_id_coletado_transacoes)
        result = future.result()

        if result is None:
            print("Não há mais dados de transações para salvar. Saindo do loop.")
            break

        df_transacoes, ultimo_id_coletado_transacoes = result
        output_data_transacoes.append(df_transacoes)
        page_transacoes += 1

# Coleta os dados das faturas
page_faturas = 1
ultimo_id_coletado_faturas = 0

with ThreadPoolExecutor() as executor:
    while True:
        future = executor.submit(fetch_and_process_faturas, page_faturas, ultimo_id_coletado_faturas)
        result = future.result()

        if result is None:
            print("Não há mais dados de faturas para salvar. Saindo do loop.")
            break

        df_faturas, ultimo_id_coletado_faturas = result
        output_data_faturas.append(df_faturas)
        page_faturas += 1

# Converte as listas de saída em DataFrames
df_faturas = pd.concat(output_data_faturas, ignore_index=True)
df_transacoes = pd.concat(output_data_transacoes, ignore_index=True)

# Encontra as transações correspondentes às faturas
transacao_data = []

for _, fatura in df_faturas.iterrows():
    id_cobranca_fatura = fatura['id-cobrança']
    transacoes_correspondentes = df_transacoes[df_transacoes['id-cobrança'] == id_cobranca_fatura]
    
    if not transacoes_correspondentes.empty:
        transacao_data.append(transacoes_correspondentes)

if transacao_data:
    final_df_transacoes = pd.concat(transacao_data, ignore_index=True)
else:
    final_df_transacoes = pd.DataFrame()

end_time = time.time()
elapsed_time_seconds = end_time - start_time
elapsed_time_minutes = elapsed_time_seconds / 60

print(f"Solicitações à API feitas com sucesso!")
print(f"Tempo decorrido para salvar os dados: {elapsed_time_seconds:.2f} segundos ({elapsed_time_minutes:.2f} minutos)")

excel_file = "relatorio-vindi.xlsx"
sheet_name_faturas = "faturas"
sheet_name_transacoes = "transações"

try:
    existing_data_faturas = pd.read_excel(excel_file, sheet_name=sheet_name_faturas)
    ultimo_id_coletado_faturas = existing_data_faturas['id-fatura'].max() if not existing_data_faturas.empty else 0
except FileNotFoundError:
    existing_data_faturas = None

try:
    existing_data_transacoes = pd.read_excel(excel_file, sheet_name=sheet_name_transacoes)
    ultimo_id_coletado_transacoes = existing_data_transacoes['id-transação'].max() if not existing_data_transacoes.empty else 0
except FileNotFoundError:
    existing_data_transacoes = None

with pd.ExcelWriter(excel_file, engine='openpyxl', mode='a', if_sheet_exists='overlay') as writer:
    if existing_data_faturas is not None:
        final_df_faturas = pd.concat([existing_data_faturas, final_df_faturas], ignore_index=True)
    
    # final_df_faturas['id-produto'] = final_df_faturas['id-produto'].str.replace(r"\[|\]", '', regex=True)
    # final_df_faturas['nome-produto'] = final_df_faturas['nome-produto'].str.replace(r"[\[\]()]", '', regex=True)
    # final_df_faturas['id-cobrança'] = final_df_faturas['id-cobrança'].str.replace(r"\[|\]", '', regex=True)

    # for col in final_df_faturas.columns:
    #     if final_df_faturas[col].dtype == 'object':
    #         final_df_faturas[col] = final_df_faturas[col].str.replace("'", "")
        final_df_faturas.to_excel(writer, sheet_name=sheet_name_faturas, index=False)

    if existing_data_transacoes is not None:
        final_df_transacoes = pd.concat([existing_data_transacoes, final_df_transacoes], ignore_index=True)
        final_df_transacoes.to_excel(writer, sheet_name=sheet_name_transacoes, index=False)

print(f"Dados salvos em {excel_file}")


# import requests
# import base64
# from datetime import datetime
# import pandas as pd
# from pandas import json_normalize
# import time
# from concurrent.futures import ThreadPoolExecutor

# usuario = "chave"
# senha = ""

# base_url_faturas = "https://app.vindi.com.br/api/v1/bills"
# base_url_transacoes = "https://app.vindi.com.br/api/v1/transactions"
# per_page = 50
# date_cri = "2023-09-01"
# date_ate = datetime.now().strftime("%Y-%m-%d")

# ultimo_id_coletado_faturas = 0
# ultimo_id_coletado_transacoes = 0

# output_data_faturas = []
# output_data_transacoes = []

# start_time = time.time()

# def fetch_and_process_faturas(page, starting_after):
#     url = f"{base_url_faturas}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

#     headers = {
#         "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
#     }

#     response = requests.get(url, headers=headers)
    
#     if response.status_code == 200:
#         data = response.json()
#         bills = data.get('bills', [])

#         if not bills:
#             return None

#         for bill in bills:
#             bill_items = bill.get('bill_items', [])
#             product_ids = [item.get('product', {}).get('id') for item in bill_items]
#             product_names = [item.get('product', {}).get('name') for item in bill_items]
#             bill['product_id'] = product_ids
#             bill['product_name'] = product_names
            
#             charges = bill.get('charges',[])
#             charge_ids = [charge.get('id') for charge in charges]
#             bill['charge_id'] = charge_ids

#         df = json_normalize(bills)

#         columns_to_keep = ["id", "amount", "installments", "status", "created_at", "updated_at","product_name","charge_id"]
#         df = df[columns_to_keep]

#         df = df.rename(columns={
#             "id": "id-fatura",
#             "amount": "valor-fatura",
#             "installments": "parcelas",
#             "status": "status-fatura",
#             "created_at": "criação-fatura",
#             "updated_at": "atualização-fatura",
#             "charge.id": "id-cobrança",
#             "product.name": "nome-produto"
#         })

#         for coluna in df.columns:
#             if df[coluna].dtype == 'object':
#                 df[coluna] = df[coluna].astype(str)

#         for coluna in df.columns:
#             if df[coluna].dtype == 'object':
#                 df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

#         return df, bills[-1]['id']

#     else:
#         print(f"Erro na solicitação de faturas: {response.status_code} - {response.text}")
#         return None

# def fetch_and_process_transacoes(page, starting_after):
#     url = f"{base_url_transacoes}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

#     headers = {
#         "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
#     }

#     response = requests.get(url, headers=headers)
    
#     if response.status_code == 200:
#         data = response.json()
#         transactions = data.get('transactions', [])

#         if not transactions:
#             return None

#         df = json_normalize(transactions)

#         columns_to_keep = ["id", "transaction_type", "status", "amount", "created_at", "updated_at", "charge.id", "customer.id", "customer.name", "customer.email"]
#         df = df[columns_to_keep]

#         df = df.rename(columns={
#             "id": "id-transação",
#             "transaction_type": "tipo-transação",
#             "status": "status-transação",
#             "amount": "valor-transação",
#             "created_at": "criação-transação",
#             "updated_at": "atualização-transação",
#             "charge.id": "id-cobrança",
#             "customer.id": "id-cliente",
#             "customer.name": "nome-cliente",
#             "customer.email": "email-cliente"
#         })

#         for coluna in df.columns:
#             if df[coluna].dtype == 'object':
#                 df[coluna] = df[coluna].astype(str)

#         for coluna in df.columns:
#             if df[coluna].dtype == 'object':
#                 df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

#         return df, transactions[-1]['id']

#     else:
#         print(f"Erro na solicitação de transações: {response.status_code} - {response.text}")
#         return None

# page_faturas = 1
# ultimo_id_coletado_faturas = 0

# with ThreadPoolExecutor() as executor:
#     while True:
#         future = executor.submit(fetch_and_process_faturas, page_faturas, ultimo_id_coletado_faturas)
#         result = future.result()

#         if result is None:
#             print("Não há mais dados de faturas para salvar. Saindo do loop.")
#             break

#         df_faturas, ultimo_id_coletado_faturas = result
#         output_data_faturas.append(df_faturas)
#         page_faturas += 1

# page_transacoes = 1
# ultimo_id_coletado_transacoes = 0

# with ThreadPoolExecutor() as executor:
#     while True:
#         future = executor.submit(fetch_and_process_transacoes, page_transacoes, ultimo_id_coletado_transacoes)
#         result = future.result()

#         if result is None:
#             print("Não há mais dados de transações para salvar. Saindo do loop.")
#             break

#         df_transacoes, ultimo_id_coletado_transacoes = result
#         output_data_transacoes.append(df_transacoes)
#         page_transacoes += 1

# end_time = time.time()
# elapsed_time_seconds = end_time - start_time
# elapsed_time_minutes = elapsed_time_seconds / 60

# print(f"Solicitações à API feitas com sucesso!")
# print(f"Tempo decorrido para salvar os dados: {elapsed_time_seconds:.2f} segundos ({elapsed_time_minutes:.2f} minutos)")

# final_df_faturas = pd.concat(output_data_faturas, ignore_index=True)
# final_df_transacoes = pd.concat(output_data_transacoes, ignore_index=True)


# output_data_faturas = []
# output_data_transacoes = []

# for fatura in bills:
#     id_cobranca_fatura = fatura.get('id-cobrança')
    
#     transacoes_correspondentes = [transacao for transacao in transactions if transacao.get('id-cobrança') == id_cobranca_fatura]
    
#     transacao_data.extend(transacoes_correspondentes)

# final_df_transacoes = pd.DataFrame(transacao_data)

# excel_file = "relatorio-vindi.xlsx"
# sheet_name_faturas = "faturas"
# sheet_name_transacoes = "transações"

# try:
#     existing_data_faturas = pd.read_excel(excel_file, sheet_name=sheet_name_faturas)
#     ultimo_id_coletado_faturas = existing_data_faturas['id-fatura'].max() if not existing_data_faturas.empty else 0
# except FileNotFoundError:
#     existing_data_faturas = None

# try:
#     existing_data_transacoes = pd.read_excel(excel_file, sheet_name=sheet_name_transacoes)
#     ultimo_id_coletado_transacoes = existing_data_transacoes['id-transação'].max() if not existing_data_transacoes.empty else 0
# except FileNotFoundError:
#     existing_data_transacoes = None

# with pd.ExcelWriter(excel_file, engine='openpyxl', mode='a', if_sheet_exists='overlay') as writer:
#     if existing_data_faturas is not None:
#         final_df_faturas = pd.concat([existing_data_faturas, final_df_faturas], ignore_index=True)
    
#     final_df_faturas['id-produto'] = final_df_faturas['id-produto'].str.replace(r"\[|\]", '', regex=True)
#     final_df_faturas['nome-produto'] = final_df_faturas['nome-produto'].str.replace(r"[\[\]()]", '', regex=True)
#     final_df_faturas['id-cobrança'] = final_df_faturas['id-cobrança'].str.replace(r"\[|\]", '', regex=True)

#     for col in final_df_faturas.columns:
#         if final_df_faturas[col].dtype == 'object':
#             final_df_faturas[col] = final_df_faturas[col].str.replace("'", "")
#             final_df_faturas.to_excel(writer, sheet_name=sheet_name_faturas, index=False)

#     if existing_data_transacoes is not None:
#         final_df_transacoes = pd.concat([existing_data_transacoes, final_df_transacoes], ignore_index=True)
#     final_df_transacoes.to_excel(writer, sheet_name=sheet_name_transacoes, index=False)

# print(f"Dados salvos em {excel_file}")


# # excel_file = "relatorio-vindi.xlsx"
# # sheet_name_faturas = "faturas"
# # sheet_name_transacoes = "transações"

# # try:
# #     existing_data_faturas = pd.read_excel(excel_file, sheet_name=sheet_name_faturas)
# #     ultimo_id_coletado_faturas = existing_data_faturas['id-fatura'].max() if not existing_data_faturas.empty else 0
# # except FileNotFoundError:
# #     existing_data_faturas = None

# # try:
# #     existing_data_transacoes = pd.read_excel(excel_file, sheet_name=sheet_name_transacoes)
# #     ultimo_id_coletado_transacoes = existing_data_transacoes['id-transação'].max() if not existing_data_transacoes.empty else 0
# # except FileNotFoundError:
# #     existing_data_transacoes = None

# # with pd.ExcelWriter(excel_file, engine='openpyxl', mode='a', if_sheet_exists='overlay') as writer:
# #     if existing_data_faturas is not None:
# #         final_df_faturas = pd.concat([existing_data_faturas, final_df_faturas], ignore_index=True)
    
# #     final_df_faturas['id-produto'] = final_df_faturas['id-produto'].str.replace(r"\[|\]", '', regex=True)
# #     final_df_faturas['nome-produto'] = final_df_faturas['nome-produto'].str.replace(r"[\[\]()]", '', regex=True)
# #     final_df_faturas['id-cobrança'] = final_df_faturas['id-cobrança'].str.replace(r"\[|\]", '', regex=True)

# #     for col in final_df.columns:
# #         if final_df[col].dtype == 'object':
# #             final_df[col] = final_df[col].str.replace("'", "")
# #     final_df_faturas.to_excel(writer, sheet_name=sheet_name_faturas, index=False)

# #     if existing_data_transacoes is not None:
# #         final_df_transacoes = pd.concat([existing_data_transacoes, final_df_transacoes], ignore_index=True)
# #     final_df_transacoes.to_excel(writer, sheet_name=sheet_name_transacoes, index=False)

