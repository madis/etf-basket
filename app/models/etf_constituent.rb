class EtfConstituent < ApplicationRecord
  belongs_to :etf
  has_many :prices, dependent: :destroy

  accepts_nested_attributes_for :prices

  def price
    prices.order(created_at: :desc).limit(1).first
  end

  def owned_count
    100
  end

  def owned_weight
    0.3
  end

  def owned_value
    owned_count * price.amount
  end
end
