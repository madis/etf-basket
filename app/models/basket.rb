require_relative './basket_item'
require_relative './item_factory'

class Basket
  extend ItemFactory.for(BasketItem)

  attr_reader :constituents

  def self.with_items(items)
    basket = self.new
    items.each { |i| basket << i }
    basket
  end

  def initialize
    @constituents = {}
  end

  def <<(constituent)
    @constituents[constituent.name] = constituent
  end

  def ==(o)
    o.is_a?(self.class) && @constituents == o.constituents
  end

  def hash
    [@name, @shares, @cost]
  end
end
