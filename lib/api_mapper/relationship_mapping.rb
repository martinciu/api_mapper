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

    def extract_mapped(*args)
      key = args[0]
      @mapping.map(extract_hash(*args)) if match?(key)
    end

    alias_method :extract_hash, :extract
    alias_method :extract, :extract_mapped
  end

end