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
        # create_list(:etf_constituent, 1, etf: etf)
        create(:etf_constituent, etf: etf)
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
