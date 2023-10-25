import requests
import time

previous_data = None

while True:
    response = requests.get("http://localhost:8080/api/getModifiedTickers")

    if response.status_code != 200:  # 서버에서 정상 응답이 오지 않았을 경우
        print(f"Error {response.status_code}: {response.text}")
        time.sleep(1)
        continue

    try:
        modified_kor_tickers = response.json()

        if modified_kor_tickers != previous_data:  # 새로운 데이터가 있는 경우
            print(modified_kor_tickers)
            previous_data = modified_kor_tickers
    except requests.exceptions.JSONDecodeError as e:
        print(f"Failed to decode JSON: {e}")

    time.sleep(1)