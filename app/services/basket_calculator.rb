require_relative 'basket_calculator/basket'
require_relative 'basket_calculator/prices'
require_relative 'basket_calculator/index'

class BasketCalculator
  def initialize(amount, index, prices)
    @amount = amount
    @index = index
    @prices = prices
  end

  # Solution idea:
  # 1. take the total amount available
  # 2. multiply by each constituent's percentage, you get how much money goes into that asset
  # 3. divide sum by constituent's share price, get how many shares you'll get
  # 4. find constituent with the lowest share number (between 0 and 1)
  # 5. calculate 1 / fractional shares to get coefficent -> by multiplying with this
  #     - you get this share up to 1
  # 6. multiply all other constituents with the same coefficent
  #     - because they had higher coefficent, they'll all go above 1 share
  # 7. next steps: store portfolio for future re-adjustment
  #     - because some shares will not be exact percentage described by ETF. Esp. higher priced ones
  def calculate_to_amount
    ss = shares.map do |stock, volume|
      BasketItem.new(
        name: stock.name,
        shares: volume.round(2),
        cost: (stock.price * volume).round(2)
        )
    end
    Basket.with_items ss
  end

  def calculate_to_full_shares
    min_shares = shares.min_by { |s| s[:shares] }
    coefficent = 1 / min_shares[:shares]
    calculate_to_amount.map do |c|
      whole_shares = c[:shares] * coefficent
      c.merge(shares: whole_shares, cost: whole_shares * c[:price])
    end
  end

  private

  attr_reader :amount, :prices, :index

  def shares
    index.map do |constituent|
      stock = prices[constituent.name]
      volume = (constituent.weight * amount) / stock.price
      [stock, volume]
    end
  end
end
