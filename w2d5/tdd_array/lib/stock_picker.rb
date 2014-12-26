def stock_picker(prices)

  max_profit = nil
  best_buy_day = nil
  best_sell_day = nil

  (0...prices.length).each do |buy_date|
    (buy_date + 1...prices.length).each do |sell_date|
      if max_profit.nil? || prices[sell_date] - prices[buy_date] > max_profit
        max_profit = prices[buy_date] + prices[sell_date]
        best_buy_day = buy_date
        best_sell_day = sell_date
      end
    end
  end
  [best_buy_day, best_sell_day]
end
