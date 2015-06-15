module ApiMapper
  class AttributeMapping
    Error = Class.new(ApiMapper::Error)

    attr_reader :from, :to

    def initialize(from, to = nil)
      @from, @to = from, to
      @to ||= @from.split('.').last
    end

    def match?(key)
      parent_from == key
    end

    def parent_from
      from.to_s.split('.').first
    end

    def extract(origin)
      # Extractor.new(self, origin).call
      keys.inject(origin.value) { |val, msg| val.fetch(msg) } if match?(origin.key)
    rescue KeyError => exception
      raise Error.new(exception.message)
    end

    def keys
      keys = from.to_s.split('.')
      keys.shift
      keys
    end

  end

  class Extractor
    def initialize(mapping, origin)
      @mapping, @origin = mapping, origin
    end

    def call
      @mapping.keys.inject(@origin.value) { |val, msg| val.fetch(msg) } if @mapping.match?(@origin.key)
    rescue KeyError => exception
      raise ApiMapper::AttributeMapping::Error.new(exception.message)
    end
  end
end
