require_relative '../../app/services/basket_calculator'
require_relative '../../app/models/basket'
require_relative '../../app/models/prices'
require_relative '../../app/models/index'

module NumericWithPercent
  refine Numeric do
    def percent
      self / 100.0
    end
  end
end

RSpec.describe BasketCalculator do
  using NumericWithPercent

  it "$100 basket for 1 constituent" do
    prices = Prices.make { item(name: 'One', price: 10) }
    index = Index.make { item(name: 'One', weight: 100.percent) }
    expected_basket = Basket.make { item(name: 'One', shares: 10, cost: 100) }
    expect(BasketCalculator.new(100, index, prices).calculate_to_amount).to eq(expected_basket)
  end

  it "$100 basket for 2 equal constituents" do
    prices = Prices.make { item(name: 'One', price: 10); item(name: 'Two', price: 10) }
    index = Index.make { item(name: 'One', weight: 50.percent); item(name: 'Two', weight: 50.percent) }
    expected_basket = Basket.make { item(name: 'One', shares: 5, cost: 50); item(name: 'Two', shares: 5, cost: 50) }
    expect(BasketCalculator.new(100, index, prices).calculate_to_amount).to eq(expected_basket)
  end

  it "$100 basket for 2 differently priced constituents" do
    prices = Prices.make { item(name: 'One', price: 10); item(name: 'Two', price: 20) }
    index = Index.make { item(name: 'One', weight: 50.percent); item(name: 'Two', weight: 50.percent) }
    expected_basket = Basket.make { item(name: 'One', shares: 5, cost: 50); item(name: 'Two', shares: 2.5, cost: 50) }
    expect(BasketCalculator.new(100, index, prices).calculate_to_amount).to eq(expected_basket)
  end

  it "$100 basket for 3 differently weighted & priced constituents" do
    prices = Prices.make { item(name: 'One', price: 10); item(name: 'Two', price: 20); item(name: 'Three', price: 30) }
    index = Index.make { item(name: 'One', weight: 25.percent); item(name: 'Two', weight: 50.percent); item(name: 'Three', weight: 25.percent) }
    expected_basket = Basket.make { item(name: 'One', shares: 2.5, cost: 25); item(name: 'Two', shares: 2.5, cost: 50); item(name: 'Three', shares: 0.83, cost: 25) }
    expect(BasketCalculator.new(100, index, prices).calculate_to_amount).to eq(expected_basket)
  end
end
