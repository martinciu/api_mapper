module ApiMapper
  class Mapper

    def call(origin)
       self.class.transformation.call(origin)
    end

    class << self
      def attributes(*attributes)
        @attributes ||= Array(@attributes) + attributes
      end

      def entity(klass)
        @entity = klass
      end

      def relationship(name, mapper = nil)
        @relationships ||= []
        @relationships << Relationship.new(name, mapper)
      end

      def transformation
        mapping >> factory
      end

      private

      def all_attributes
        Array(@attributes) + Array(@relationships).map(&:name)
      end

      def mapping
        Array(@relationships).inject(t(:symbolize_keys) >> t(:accept_keys, all_attributes)) do |mapping, relationship|
          mapping >> t(:map_value, relationship.name, t(:mapping, relationship.mapper))
        end
      end

      def factory
        t(:factory, @entity)
      end

      def t(*args)
        Functions[*args]
      end
    end
  end

  class HashMapper < Mapper
    def self.mapping
      raise "Only one key, pair allowed" if @attributes.count > 1
      @map = t(:structure, @attributes.first.keys.first, @attributes.first.values.first)
    end

    def self.factory
      t(:map_array, super)
    end
  end

  class ArrayMapper < Mapper
    def self.mapping
      t(:map_array, t(:symbolize_keys) >> super)
    end

    def self.factory
      t(:map_array, super)
    end
  end

  class Relationship
    attr_reader :name, :mapper

    def initialize(name, mapper)
      @name = name
      @mapper = mapper
    end
  end
end
