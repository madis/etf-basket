class TradesSummarizer
  def initialize(constituent, tracking)
    @constituent = constituent
    @tracking = tracking
  end

  def owned_count
    Trade.buys(constituent).sum(:amount) - Trade.sells(constituent).sum(:amount)
  end

  def owned_weight
    total_buys = buys.sum(:amount)
    total_sells = sells.sum(:amount)
    total_balance = total_buys - total_sells

    return 0 if total_balance == 0
    owned_count.to_r / total_balance.to_r # Divide using rational numbers
  end

  # Money spent for owning current amount
  def cost
    buys_cost = buys.map(&:cost).reduce(&:+) || 0
    sells_cost = sells.map(&:cost).reduce(&:+) || 0

    buys_cost - sells_cost
  end

  # Money gotten if sold now with latest prices
  def value
    buys_amount = buys.sum(:amount)
    sells_amount = sells.sum(:amount)
    (buys_amount - sells_amount) * constituent.price.amount
  end

  private

  def buys
    Trade.where(tracking: tracking, type: :buy)
  end

  def sells
    Trade.where(tracking: tracking, type: :sell)
  end

  attr_reader :constituent, :tracking
end
