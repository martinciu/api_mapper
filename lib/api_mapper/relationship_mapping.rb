module ApiMapper
  class RelationshipMapping < AttributeMapping
    Error = Class.new(StandardError)

    def initialize(from, to, mapping)
      super(from, to)
      @mapping = mapping
    end

    def extract_mapped(*args)
      origin = MappingOrigin.new(*args)
      @mapping.map(extract_hash(*args)) if match?(origin.key)
    end

    alias_method :extract_hash, :extract
    alias_method :extract, :extract_mapped
  end

end