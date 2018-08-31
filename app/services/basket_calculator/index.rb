require_relative './index_constituent'
require_relative './item_factory'

class BasketCalculator
  class Index
    include Enumerable
    extend ItemFactory.for(IndexConstituent)

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
end
