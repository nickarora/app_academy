def stock_picker(prices_arr)
  max_profit = nil
  best_buy_date = nil
  best_sell_date = nil

  (0..prices_arr.length-1).each do |buy_date|
    (buy_date..prices_arr.length-1).each do |sell_date|
        price1 = prices_arr[buy_date]
        price2 = prices_arr[sell_date]

        profit = price2-price1
        if (max_profit == nil) || (profit > max_profit)
          max_profit = profit
          best_buy_date = buy_date
          best_sell_date = sell_date
        end
    end
  end

  [best_buy_date, best_sell_date]
end

if __FILE__ == $0
  puts "Stock Picker:"
  puts stock_picker([3,1,-5, 0, 8, 1]).inspect
end
