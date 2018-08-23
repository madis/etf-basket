FactoryBot.define do
  sequence(:constituent_symbol) { |n| ('AAA'..'ZZZ').take(n).last }

  factory :portfolio do
    name { 'Yolo investments' }
  end

  factory :etf do
    name { 'SPDR Portfolio S&P 500 Value ETF' }
    symbol { 'SPYV' }

    factory :etf_with_constituents do |instance|
      after(:create) do |etf, evaluator|
        create(:etf_constituent, etf: etf)
      end
    end

    factory :three_part_etf do |instance|
      after(:create) do |etf, evaluator|
        [
          {name: 'First 25', symbol: 'FST', weight: 0.25},
          {name: 'Second 50', symbol: 'SND', weight: 0.50},
          {name: 'Third 25', symbol: 'TRD', weight: 0.25}
        ].map { |c| create(:etf_constituent, {etf: etf}.merge(c)) }
          .each { |c| c.prices.create(amount: 10, currency: 'USD') }
      end
    end
  end

  factory :etf_constituent do
    transient { current_symbol { generate(:constituent_symbol) } }
    name { "International #{current_symbol} Corp." }
    symbol { current_symbol }
    etf
  end
end
