def manual_input():
    """
    手動輸入買入價和賣出價，以及買入和賣出股票的數量。

    Returns:
        tuple: 包含浮動買入價、賣出價、買入股票數量和賣出股票數量的元組。
    """
    buy_price = float(input("輸入買入價："))
    num_shares_buy = int(input("輸入要買入的股票張數（每張1000股）：")) * 1000  # 將張數轉換為股數
    sell_price = float(input("輸入賣出價格："))
    num_shares_sell = int(input("輸入要賣出的股票張數（每張1000股）：")) * 1000  # 將張數轉換為股數

    return buy_price, sell_price, num_shares_buy, num_shares_sell

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

if __name__ == "__main__":
    # 設定初始資本
    capital = 1000000

    while True:
        # 手動輸入買入和賣出價格以及要買入和賣出的股票張數
        buy_price, sell_price, num_shares_buy, num_shares_sell = manual_input()

        # 計算利潤或損失百分比和最終資金
        profit_or_loss_percentage, final_capital = calculate_profit_or_loss(buy_price, sell_price, num_shares_buy, num_shares_sell, capital)
        print(f"買入價格： {buy_price}")
        print(f"賣出價格： {sell_price}")
        print(f"買入股票張數： {num_shares_buy / 1000}")
        print(f"賣出股票張數： {num_shares_sell / 1000}")
        print(f"報酬率： {profit_or_loss_percentage:.2f}%")
        print(f"交易後最終資金：{final_capital}")
