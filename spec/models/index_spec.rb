require_relative '../../app/models/index'

RSpec.describe Index do
  it 'adds items using factory' do
    etf = described_class.make { item(name: 'AAPL', weight: 0.45) }
    expect(etf['AAPL'].weight).to eq 0.45
  end
end
