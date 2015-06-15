require 'test_helper'

module ApiMapper
  class CollectionTest < Minitest::Test

    def test_add_returns_self
      adding_result = collection.add(Object.new)

      assert_equal collection, adding_result
    end

    def test_add_item
      item = Object.new

      assert_equal 0, collection.count
      collection.add item
      assert_equal 1, collection.count
      assert_includes collection, item
    end

    def test_iterating
      item = Minitest::Mock.new
      item.expect(:mark, true)
      collection.add item

      collection.each { |i| i.mark }

      item.verify
    end

    def test_match
      item1 = item_maching
      item2 = item_maching

      collection.add item1
      collection.add item2

      collection.add item_not_matching

      assert_equal [item1, item2], collection.match(:foo)
    end

    private

    class Item
      def initialize(key)
        @key = key
      end

      def match?(key)
        @key == key
      end
    end

    def item_maching
      Item.new(:foo)
    end

    def item_not_matching
      Item.new(:bar)
    end

    def collection
      @collection ||= ApiMapper::Collection.new
    end
  end

end
