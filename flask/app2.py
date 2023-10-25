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


def send_chart_to_springboot():
    with open(image_path, 'rb') as img:
        response = requests.post("http://localhost:8080/api/receiveChart", files={"chart": img})

    if response.status_code == 200:
        print("Chart sent successfully!")
    else:
        print(f"Failed to send chart. Status code: {response.status_code}. Response: {response.text}")


def send_metrics_to_springboot(metrics, kospi_metrics):
    combined_metrics = {
        'custom_index': metrics,
        'kospi': kospi_metrics
    }
    response = requests.post("http://localhost:8080/api/receiveMetrics", json=combined_metrics)
    if response.status_code == 200:
        print("Metrics sent successfully!")
    else:
        print(f"Failed to send metrics. Status code: {response.status_code}. Response: {response.text}")


def compute_annualized_return(cumulative_returns):
    total_days = len(cumulative_returns)
    return (cumulative_returns.iloc[-1] / cumulative_returns.iloc[0]) ** (252.0 / total_days) - 1


def compute_volatility(returns):
    return returns.std() * (252 ** 0.5)


# 추가적인 지표 계산 함수들
def compute_sharpe_ratio(returns, rf_rate=0.02):
    """ rf_rate는 2%로 가정 (연간 무위험률) """
    excess_returns = returns - rf_rate / 252  # 일일 무위험 수익률을 뺍니다.
    return excess_returns.mean() / excess_returns.std() * (252 ** 0.5)


def monthly_returns(returns):
    return returns.resample('M').apply(lambda x: (1 + x).prod() - 1)


def compute_mdd(returns):
    cumulative_returns = (1 + returns).cumprod()
    rolling_max = cumulative_returns.expanding(min_periods=1).max()
    drawdown = cumulative_returns / rolling_max - 1
    mdd = drawdown.min()
    return mdd


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
                active_tickers = [entry['ticker'] for entry in modified_kor_tickers if entry.get('active')]
                weights = [float(entry['weight'].strip('%')) / 100 for entry in modified_kor_tickers if
                           entry.get('active')]
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
                data_returns = data.pct_change()
                data_returns.iloc[0] = 0  # 첫날의 수익률을 0으로 설정
                data_returns['New_Index'] = data_returns.mul(weights, axis=1).sum(axis=1)
                kospi_data = yf.download('^KS11', start=start_date, end=end_date)['Adj Close']
                kospi_returns = kospi_data.pct_change()
                kospi_returns.iloc[0] = 0  # 첫날의 수익률을 0으로 설정

                custom_cumulative = (1 + data_returns['New_Index']).cumprod()
                kospi_cumulative = (1 + kospi_returns).cumprod()

                custom_cumulative_data = list(
                    zip(custom_cumulative.index.strftime('%Y-%m-%d'), custom_cumulative.values))
                kospi_cumulative_data = list(zip(kospi_cumulative.index.strftime('%Y-%m-%d'), kospi_cumulative.values))

                # Custom Index 지표들
                metrics = {
                    "Cumulative Return": (1 + data_returns['New_Index']).cumprod().iloc[-1] - 1,
                    "Annualized Return": compute_annualized_return((1 + data_returns['New_Index']).cumprod()),
                    "Volatility": compute_volatility(data_returns['New_Index']),
                    "MDD": compute_mdd(data_returns['New_Index']),
                    "Sharpe Ratio": compute_sharpe_ratio(data_returns['New_Index']),
                    "Monthly Returns": monthly_returns(data_returns['New_Index']).tolist(),
                    "Cumulative Returns Data": custom_cumulative_data
                }
                print("Custom Index Metrics:", metrics)

                # KOSPI 지표들
                kospi_metrics = {
                    "Cumulative Return": (1 + kospi_returns).cumprod().iloc[-1] - 1,
                    "Annualized Return": compute_annualized_return((1 + kospi_returns).cumprod()),
                    "Volatility": compute_volatility(kospi_returns),
                    "MDD": compute_mdd(kospi_returns),
                    "Sharpe Ratio": compute_sharpe_ratio(kospi_returns),
                    "Monthly Returns": monthly_returns(kospi_returns).tolist(),
                    "Cumulative Returns Data": kospi_cumulative_data
                }
                print("KOSPI Metrics:", kospi_metrics)

                custom_cumulative = (1 + data_returns['New_Index']).cumprod()
                kospi_cumulative = (1 + kospi_returns).cumprod()

                print("Custom Index Cumulative Returns:\n", custom_cumulative)
                print("\nKOSPI Cumulative Returns:\n", kospi_cumulative)

                plt.figure(figsize=(12, 7))
                custom_cumulative.plot(label="Custom Index")
                kospi_cumulative.plot(label="KOSPI", linestyle='--')
                plt.title('Cumulative Return Comparison: Custom Index vs KOSPI')
                plt.xlabel('Date')
                plt.ylabel('Cumulative Return')
                plt.legend()
                plt.grid(True)
                plt.tight_layout()
                plt.savefig(image_path, dpi=100)
                plt.close()
                previous_data = modified_kor_tickers
                send_chart_to_springboot()
                # 메트릭 전송 부분 추가
                send_metrics_to_springboot(metrics, kospi_metrics)
        except Exception as e:
            print("Error:", e)
        time.sleep(1)


# Start the data fetching and plotting function in a separate thread.
threading.Thread(target=fetch_and_plot_data).start()

# Run the Flask server to serve the chart.
if __name__ == '__main__':
    app.run(port=5000)
