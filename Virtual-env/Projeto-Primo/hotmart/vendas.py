import requests
import pandas as pd

api_url = "https://developers.hotmart.com/payments/api/v1/sales/history"

token = "H4sIAAAAAAAAAB2P2XaqMABFv6hdAQH1UQZpIoQLARleXDJIEpSpUCBfX2%2Ff997rnGpDNLcL5jFEIgElzOA3bAO1MKAGmz65Guj4WW1IpPJxyQjU4g1tWXxuIFtYuUN9aUcsIQvLErpA3q2YNxI2axWb1uYYiJZJ0OV%2F3PNZbH8%2BDKUA%2B1cUJeDsE4LKNzeUdvMeAVfPPjeZ6SouASKzLeCEvpLG1uTFEcAMrK6AIgvhgk3cuOGJvV2ev9t5Gzzusf%2F%2FyAuLjGGhN%2B%2BG4tro5YQBx2YxpZw%2B3Q2IlPu7LHQVLGqQmTV7%2BJ9p2RNPHYQRkJS50V4kmbq%2FVjOFt%2FKlMKyBQmhDFoyJ%2FNEifmZ7L7%2Feb46MlVN%2Bu1j58ELDcRsBhchB55BTKIwo9K1DSHgszY41grTNH8e7mTyaqpviSbZ9yA9fZsWs8XYy5x9TLme5SQ7xpYg4W2km89rSo8Gm3Uq2u6VPdIn3XEgmcDXfjYewssYusEjElvLZJdoiRZQ0u3%2B68xEcjKSv83k8zdOtUy1tpuDLoKPazOUaAnzHsm%2BbwigvxpgUgyvXUbdWP9HHaba%2FVA14vVLeR3Rd5kuqP3V9jb%2BPXr8o2G7VlEiOjnXzVpxP7GA3gzWNw0XVfL5jbR3uwNDTqjVmp%2F4FtUF9IV4CAAA%3D"

headers = {
    "Authorization": f"Bearer {token}"
}

response = requests.get(api_url, headers=headers)

if response.status_code == 200:
    data = response.json()

    contratos = data.get('items', [])

    if contratos:
        df = pd.DataFrame(contratos)

        excel_file = "hotmart.xlsx"
        sheet_name = "vendas"

        df.to_excel(excel_file, sheet_name=sheet_name, index=False)

        print(f"Dados salvos em {excel_file}")
    else:
        print("Não há dados para salvar.")
else:
    print(f"Erro na solicitação: {response.status_code} - {response.text}")
