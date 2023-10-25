import requests
import yfinance as yf
import pandas as pd
import matplotlib.pyplot as plt
from flask import Flask, send_file
import threading
import time
app = Flask(__name__)
image_path = "templates/chart/chart.png"
previous_data = None
data_cache = {}


@app.route('/chart', methods=['GET'])
def get_chart():
    return send_file(image_path, mimetype='image/png')

# 웹에 전달
def send_chart_to_springboot():
    with open(image_path, 'rb') as img:
        response = requests.post("http://localhost:8080/api/receiveChart", files={"chart": img})

    if response.status_code == 200:
        print("Chart sent successfully!")
    else:
        print(f"Failed to send chart. Status code: {response.status_code}. Response: {response.text}")

def fetch_and_plot_data():
    global previous_data
    while True:
        response = requests.get("http://localhost:8080/api/getModifiedTickers")
        if response.status_code != 200:
            print(f"Error {response.status_code}: {response.text}")
            time.sleep(1)
            continue
        try:
            modified_kor_tickers = response.json()
            if modified_kor_tickers != previous_data:
                print("New data received, fetching stock data...")

                # Extract tickers and weights from the server's data
                active_tickers = [entry['ticker'] for entry in modified_kor_tickers if entry.get('active')]
                weights = [float(entry['weight'].strip('%')) / 100 for entry in modified_kor_tickers if
                           entry.get('active')]

                # Fetch historical data
                start_date = '2020-01-01'
                end_date = '2022-12-31'

                data_frames = []
                for ticker in active_tickers:
                    if ticker in data_cache:
                        data_frame = data_cache[ticker]
                    else:
                        try:
                            data_frame = yf.download(ticker, start=start_date, end=end_date)['Adj Close']
                            data_cache[ticker] = data_frame  # Save to cache
                        except Exception as e:
                            print(f"Error fetching data for {ticker}: {e}")
                            continue
                    data_frames.append(data_frame)

                data = pd.concat(data_frames, axis=1)

                # Calculate daily returns
                data_returns = data.pct_change()

                # Compute the new index's daily return based on given weights
                data_returns['New_Index'] = data_returns.mul(weights, axis=1).sum(axis=1)

                # Fetch KOSPI data
                kospi_data = yf.download('^KS11', start=start_date, end=end_date)['Adj Close']
                kospi_returns = kospi_data.pct_change()

                # Calculate cumulative returns
                data_returns['Cumulative_New_Index'] = (1 + data_returns['New_Index']).cumprod()
                kospi_returns['Cumulative_KOSPI'] = (1 + kospi_returns).cumprod()

                # Plot
                plt.figure(figsize=(12, 7))
                data_returns['Cumulative_New_Index'].plot(label="Custom Index")
                kospi_returns['Cumulative_KOSPI'].plot(label="KOSPI", linestyle='--')
                plt.title('Cumulative Return Comparison: Custom Index vs KOSPI')
                plt.xlabel('Date')
                plt.ylabel('Cumulative Return')
                plt.legend()
                plt.grid(True)
                plt.tight_layout()
                plt.savefig(image_path)
                send_chart_to_springboot()
                plt.show()
                plt.close()
                previous_data = modified_kor_tickers
        except requests.exceptions.JSONDecodeError as e:
            print(f"Failed to decode JSON: {e}")
        time.sleep(1)


# Start the data fetching and plotting function in a separate thread.
threading.Thread(target=fetch_and_plot_data).start()

# Run the Flask server to serve the chart.
if __name__ == '__main__':
    app.run(port=5000)
