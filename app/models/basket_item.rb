class BasketItem
  attr_reader :name, :shares, :cost

  def initialize(name:, shares:, cost:)
    @name = name
    @shares = shares
    @cost = cost
  end

  def ==(o)
    o.is_a?(self.class) && [@name, @shares, @cost] == [o.name, o.shares, o.cost]
  end

  def hash
    [@name, @shares, @cost]
  end
end
