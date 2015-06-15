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

    def extract(*args)
      origin = MappingOrigin.new(*args)

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

end