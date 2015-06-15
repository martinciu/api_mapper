module ApiMapper
  class ObjectMapping
    def initialize(object_class)
      @object_class = object_class
    end

    def mappings
      @mapping ||= Collection.new
    end

    def add_mapping(mapping)
      mappings.add(mapping)
    end

    def extract(origin)
      origin.inject({}) do |mapped, (origin_key, origin_value)|
        mappings.match(origin_key).each do |mapping|
          value = mapping.extract(MappingOrigin.new(origin_key, origin_value))
          mapped[mapping.to] = value if value
        end
        mapped
      end
    end

    def map(origin)
      @object_class.new(extract(origin))
    end
  end
end
