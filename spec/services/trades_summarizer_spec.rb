require 'rails_helper'

RSpec.describe TradesSummarizer do
  let(:constituent) { create(:etf_constituent, etf: tracking.etf) }
  let(:tracking) { create(:tracking) }

  before { buy(10); buy(5); sell(3) }

  subject { described_class.new(constituent, tracking) }

  it '#owned_count' do
    expect(subject.owned_count).to eq 12
  end

  it '#owned_weight' do
    other_constituent = create(:etf_constituent, name: 'Other', symbol: 'OXX', etf: tracking.etf)
    create(:trade, :buy, amount: 12, etf_constituent: other_constituent, tracking: tracking)
    expect(subject.owned_weight).to eq 0.5
  end

  it '#value' do
    create(:price, amount: 12, currency: 'USD', etf_constituent: constituent)
    expect(subject.value).to eq 12*12
  end

  it '#cost' do
    expect(subject.cost).to eq 120
  end

  def buy(amount, price: 10)
    create(:trade, :buy, amount: amount, etf_constituent: constituent, tracking: tracking, price: price)
  end

  def sell(amount, price: 10)
    create(:trade, :sell, amount: amount, etf_constituent: constituent, tracking: tracking, price: price)
  end
end
