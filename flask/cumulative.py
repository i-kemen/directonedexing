import yfinance as yf
import pandas as pd
import matplotlib.pyplot as plt

# Fetch data
start_date = '2020-01-01'
end_date = '2022-12-31'
tickers = ["AAPL", "MS", "^KS11"]

data = yf.download(tickers, start=start_date, end=end_date)['Adj Close']

# Calculate daily returns
data_returns = data.pct_change()

# Compute the new index's daily return (50% AAPL, 50% MS)
data_returns['New_Index'] = 0.5 * data_returns['AAPL'] + 0.5 * data_returns['MS']

# Calculate cumulative returns
data_returns['Cumulative_New_Index'] = (1 + data_returns['New_Index']).cumprod()
data_returns['Cumulative_KS11'] = (1 + data_returns['^KS11']).cumprod()

# Plot
plt.figure(figsize=(12, 7))
data_returns['Cumulative_New_Index'].plot(label="Custom Index (AAPL + MS)")
data_returns['Cumulative_KS11'].plot(label="KOSPI (^KS11)", linestyle='--')
plt.title('Cumulative Return Comparison: Custom Index vs KOSPI')
plt.xlabel('Date')
plt.ylabel('Cumulative Return')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
