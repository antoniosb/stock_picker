class StockPicker
  
  def self.pick stock_prices
    raise ArgumentError unless stock_prices.is_a?(Array) && stock_prices.size > 0
    # Stores an array of stock prices for the subsequent days
    day_value_hash = slice_profits_by_day stock_prices

    # Buy price is the key, the value is an array of profits
    max_value_hash = max_profit_by_day day_value_hash

    # Get the highest profit
    result = max_value_hash.max_by { |k,v| v }

    [stock_prices.index(result.first.to_i), stock_prices.index(result.first.to_i + result.last)]
  end

  private

  # [1,2,3,4] will give you f.e. { '2': [3,4], (...) }
  def self.slice_profits_by_day(stock_prices)
    stock_prices.sort.each_with_object({}) do |day_value, day_value_hash|
      day_value_hash[day_value.to_s] = stock_prices[(stock_prices.index(day_value) + 1)..-1]
    end    
  end

  # { '2': [3,4] } will give you f.e. { '2': 2 }
  def self.max_profit_by_day(day_value_hash)
    day_value_hash.each_with_object({}) do |(day, values), max_value_hash|
      max_value_hash[day] = []
      values.each do |value|
        max_value_hash[day] << value - day.to_i
      end
      # Get the maximum profit for that buy price
      max_value_hash[day] = max_value_hash[day].max
    end.select! { |k,v| !v.nil? && v > 0 }
  end

end