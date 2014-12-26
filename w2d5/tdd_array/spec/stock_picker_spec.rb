require 'stock_picker'

describe "Stock Picker" do
  it "outputs the most profitable pair of days to buy and sell" do
    prices = [-1, 3, 4, -2, 5, 8, 16, -500]
    expect(stock_picker(prices)).to match_array([3,6])
  end
end
