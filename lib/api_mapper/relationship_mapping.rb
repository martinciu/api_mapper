module ApiMapper
  class RelationshipMapping < AttributeMapping

    def initialize(from, to, mapping)
      super(from, to)
      @mapping = mapping
    end

    def extract_mapped(origin)
      @mapping.map(extract_hash(origin)) if match?(origin.key)
    end

    alias_method :extract_hash, :extract
    alias_method :extract, :extract_mapped
  end

end