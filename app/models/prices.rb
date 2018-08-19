require_relative './stock'
require_relative './item_factory'

class Prices
  include Enumerable
  extend ItemFactory.for(Stock)

  def initialize
    @constituents = {}
  end

  def <<(constituent)
    @constituents[constituent.name] = constituent
  end

  def each(&block)
    @constituents.values.each(&block)
  end

  def [](name)
    @constituents[name]
  end
end
