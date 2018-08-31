require_relative '../../../app/services/basket_calculator/index'

RSpec.describe BasketCalculator::Index do
  it 'adds items using factory' do
    etf = described_class.make { item(name: 'AAPL', weight: 0.45) }
    expect(etf['AAPL'].weight).to eq 0.45
  end
end
