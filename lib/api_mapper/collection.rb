module ApiMapper
  class Collection
    include Enumerable
    extend Forwardable

    def_delegator :@collection, :each

    def initialize(initial = [])
      @collection = initial
    end

    def add(item)
      @collection << item
      self
    end

    def match(element)
      select { |item| item.match?(element) }
    end
  end
end