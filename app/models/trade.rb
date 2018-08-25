class Trade < ApplicationRecord
  self.inheritance_column = :_not_used # Overwrite default :type to avoid it being used by rails for STI

  belongs_to :etf_constituent
  belongs_to :tracking
  has_one :etf, through: :tracking
  has_one :portfolio, through: :tracking

  scope :buys, ->(constituent) { where(type: :buy, etf_constituent: constituent) }
  scope :sells, ->(constituent) { where(type: :sell, etf_constituent: constituent) }

  def cost
    amount * price
  end
end
