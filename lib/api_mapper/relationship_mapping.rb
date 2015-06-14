module ApiMapper
  class RelationshipMapping
    Error = Class.new(StandardError)

    attr_reader :from, :to

    def initialize(from, to, mapping)
      @from, @to, @mapping = from, to, mapping
    end

    def match?(key)
      parent_from == key
    end

    def parent_from
      from.to_s.split('.').first
    end

    def extract(*args)
      key = args[0]
      value = args[1]

      keys = from.to_s.split('.')
      keys.shift

      @mapping.map(keys.inject(value) { |val, msg| val.fetch(msg) }) if match?(key)
    rescue KeyError => exception
      raise Error.new(exception.message)
    end
  end
end