class EtfConstituent < ApplicationRecord
  belongs_to :etf
  has_many :prices, dependent: :destroy

  accepts_nested_attributes_for :prices

  def price
    prices.order(created_at: :desc).limit(1).first
  end
end
