class BasketCalculator
  module ItemFactory
    def self.for(item_class, collection_class: self, via: :<<)
      factory_module = Module.new do
        define_method :make do |&block|
          collection = self.new # self is the collection class where this module gets included
          item_class = item_class
          Factory.new(collection, item_class, via).instance_eval(&block)
          collection
        end
      end

      factory_module
    end

    class Factory
      def initialize(collection, item_class, add_method=:<<)
        @collection = collection
        @item_class = item_class
        @add_method = add_method
      end

      def item(*args)
        item_instance = item_class.new(*args)
        @collection.public_send(@add_method, item_instance)
      end

      private

      attr_reader :basket, :item_class
    end
  end
end
