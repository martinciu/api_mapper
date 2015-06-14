module ApiMapper
  class RelationshipMapping
    attr_reader :from, :to

    def initialize(from, to, mapping)
      @from, @to, @mapping = from, to, mapping
    end

    def match?(key)
      @from == key
    end

    def extract(*args)
      key = args[0]
      value = args[1]
      value if match?(key)
      @mapping.map(value) if match?(key)
    end
  end
end