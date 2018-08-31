require_relative '../../../app/services/basket_calculator/item_factory'

RSpec.describe BasketCalculator::ItemFactory do
  SimpleItem = Struct.new(:name)

  class KeywordItem
    attr_reader :name, :amount

    def initialize(name:, amount:)
      @name = name
      @amount = amount
    end

    def ==(o)
      o.is_a?(self.class) && [@name, @amount] == [o.name, o.amount]
    end

    def hash
      [@name, @amount].hash
    end
  end

  class MyCollection
    attr_reader :items

    def initialize
      @items = []
    end

    def add(item)
      @items << item
    end
  end

  it 'provides class with #make method allowing item DSL' do
    collection_class = Class.new(MyCollection)
    collection_class.extend(described_class.for(String, collection_class: collection_class, via: :add))
    collection = collection_class.make { item('Hello'); item('World') }
    expect(collection.items).to contain_exactly 'Hello', 'World'
  end

  it 'added make method allows keyword args' do
    collection_class = Class.new(MyCollection)
    collection_class.extend(described_class.for(KeywordItem, collection_class: collection_class, via: :add))
    collection = collection_class.make { item(name: 'Hello', amount: 100) }
    expect(collection.items).to contain_exactly KeywordItem.new(name: 'Hello', amount: 100)
  end

  it 'works with multiple classes' do
  end
end
