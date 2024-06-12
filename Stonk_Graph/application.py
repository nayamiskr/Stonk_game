from flask import Flask, render_template, request
from matplotlib.ticker import FormatStrFormatter
from google.cloud import storage
import datetime
import time
import matplotlib.pyplot as plt
import yfinance as yf
import os
import io

app = Flask(__name__)
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "./stonkgraph-api-66e8c6b246b6.json"

class CandleStick:
    def __init__(self, date, open, high, low, close, volume):
        self.date = datetime.datetime.strptime(date, "%Y-%m-%d")
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume


class Stock:
    def __init__(self, code, name, closing_price, monthly_average_price, volume):
        self.code = code
        self.name = name
        self.closing_price = closing_price
        self.monthly_average_price = monthly_average_price
        self.candles = []
        self.volume = volume

    def calculate_moving_averages(self, window_sizes):
        """Calculates moving averages for specified window sizes."""
        self.moving_averages = {}
        for window_size in window_sizes:
            closes = [candle.close for candle in self.candles]
            self.moving_averages[window_size] = [
                sum(closes[i - window_size: i]) / window_size
                for i in range(window_size, len(closes) + 1)
            ]

def get_twstock_history(stock_id, start_date, end_date):
    try:
        stock_data = yf.download(stock_id + ".TW", start=start_date, end=end_date)
        candles = []
        for date, row in stock_data.iterrows():
            candles.append(CandleStick(date.strftime("%Y-%m-%d"), row["Open"], row["High"], row["Low"], row["Close"], row["Volume"]))
        return candles
    except Exception as e:
        print(f"Error fetching data for {stock_id}: {e}")
        return []


def plot_stock(stock):
    fig, ax = plt.subplots(figsize=(12, 7))
    ax.set_ylabel("Closing price")
    ax.xaxis.set_tick_params(rotation=45)

    # Plot candles
    for candle in stock.candles:
        plt.plot([candle.date, candle.date], [candle.low, candle.high], color="black")
        plt.axvline(candle.date, color="black", linewidth=0.5)
        plt.bar(
            candle.date,
            candle.close - candle.open,
            color="green" if candle.close >= candle.open else "red",
            bottom=candle.open,
            width=1,
        )
    # Plot moving averages
    for window_size, ma_values in stock.moving_averages.items():
        plt.plot(
            [candle.date for candle in stock.candles[window_size - 1:]],
            ma_values,
            label=f"MA{window_size}",
        )
    ax2 = ax.twinx()  # 共用x軸，新增y軸
    ax2.bar(
        [candle.date for candle in stock.candles],
        [candle.volume for candle in stock.candles],
        color="lightyellow",
        alpha=0.8,
        label='Final Price',
    )
    lines, labels = ax.get_legend_handles_labels()
    lines2, labels2 = ax2.get_legend_handles_labels()
    ax2.legend(lines + lines2, labels + labels2, loc='best')

    ax2.set_ylabel("Final Price")
    ax2.xaxis.set_tick_params(rotation=35)

    plt.title(f"{stock.name} ({stock.code})")
    buf = io.BytesIO()
    plt.savefig(buf, format='png')
    buf.seek(0)

    return buf

#return company name with stock_code
def getName(stock_code):
    try:
        stock_info = yf.Ticker(stock_code)
        return stock_info.info.get('longName', 'Company name not found')
    except Exception as e:
        print(f"Error fetching company name for {stock_code}: {e}")
        return None

#sace picture in gcloud
def upload_to_gcs(buf, destination_blob_name):
    client = storage.Client()
    bucket = client.bucket('stockapi-bucket')
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_file(buf, content_type='image/png')

def calculate_profit_or_loss(buy_price, sell_price, num_shares_buy, num_shares_sell, capital=1000000):
    """
    根據固定資本計算買入和賣出價格的利潤或損失。

    Args:
        buy_price (float): 買入價格。
        sell_price (float): 賣出價格。
        num_shares_buy (int): 買入股票的總數量（以單位表示）。
        num_shares_sell (int): 賣出股票的總數量（以單位表示）。
        capital (float): 初始資本。

    Returns:
        tuple: 包含利潤或損失百分比和最終資本的元組。
    """
    # 計算買入股票的總花費
    buy_cost = buy_price * num_shares_buy
    # 計算總賣出價值
    total_sell_value = num_shares_sell * sell_price
    # 計算賣出部分股票的成本
    cost_of_sold_shares = (buy_cost / num_shares_buy) * num_shares_sell
    # 計算利潤或損失
    profit_or_loss = total_sell_value - cost_of_sold_shares
    # 計算最終資本
    final_capital = capital + profit_or_loss
    # 計算初始資本和最終資本的變化
    initial_investment = buy_cost  # 初始投資資本是買入成本
    profit_or_loss_percentage = ((final_capital - capital) / initial_investment) * 100

    return profit_or_loss_percentage, int(final_capital)

#the work about the api
@app.route('/stonk_api/<api_code>')
def stonk_api(api_code):
    start_date = request.args.get('start', default="2023-01-01", type= str)
    end_date = request.args.get('end', default="2023-03-01", type = str)
    Buy = request.args.get('Buy', default=200, type= int)
    Sell = request.args.get('Sell', default=500, type= int)
    Share_Buy = request.args.get('SBuy', default=500, type= int) * 1000
    Share_Sell = request.args.get('SSell', default=500, type= int) * 1000

    url_code = api_code + ".TW"
    stockName = getName(url_code)
    stocks = [Stock(api_code, stockName, 131.25, 128.74, 48)]
    
    
    for stock in stocks:
        stock.candles = get_twstock_history(stock.code, start_date, end_date)
        stock.calculate_moving_averages([5, 10, 20]) 
        buf = plot_stock(stock)  
        blob_name = f'stonk_images/{api_code}.png'
        upload_to_gcs(buf, blob_name)
        buf.close()
        profit_or_loss_percentage, final_capital = calculate_profit_or_loss(Buy, Sell, Share_Buy, Share_Sell)
    return render_template('display_image.html', image_url=f'https://storage.googleapis.com/stockapi-bucket/{blob_name}?t={int(time.time())}', percentage=f'{profit_or_loss_percentage:.2f}', capital=f'{final_capital}')


if __name__ == "__main__":
    app.run(debug=True)
# ttkthemes==3.2.2
# pywin32==306
