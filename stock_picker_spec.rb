require_relative 'stock_picker'

describe StockPicker do
  describe '#pick' do
    let(:stock_prices) { [17,3,6,9,15,8,6,1,10] }

    it 'receives an array as unique parameter' do
      expect(StockPicker).to receive(:pick).with(stock_prices)
      StockPicker.pick stock_prices
    end

    it 'raises error for unknown parameter' do
      expect { StockPicker.pick "17,3,6,9,15,8,6,1,10" }
        .to raise_error ArgumentError
      expect { StockPicker.pick [] }
        .to raise_error ArgumentError
      expect { StockPicker.pick nil }
        .to raise_error ArgumentError
    end

    it 'returns an array with two elements' do
      result = StockPicker.pick stock_prices
      expect(result).to be_a Array
      expect(result.size).to eq 2
    end

    it 'the first return element is the best day to buy' do
      result = StockPicker.pick stock_prices
      expect(result.first).to eq 1
    end

    it 'the second return element is the best day to sell' do
      result = StockPicker.pick stock_prices
      expect(result.last).to eq 4
    end

    it 'if the lowest day is the last, ignore it' do
      stock_prices = [17,3,6,9,15,8,6,2,10,1]
      expect(StockPicker.pick stock_prices).to eq [1, 4]
    end

    it 'if the highest day is the first, ignore it' do
      stock_prices = [22,17,3,6,9,15,8,6,1,10]
      expect(StockPicker.pick stock_prices).to eq [2, 5]
    end

  end
end