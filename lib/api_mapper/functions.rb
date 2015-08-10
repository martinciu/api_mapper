module ApiMapper
  module Functions
    extend Transproc::Registry

    module HashTransformations
      def self.structure(hash, key_name, value_name)
        hash.map { |key, value| { key_name => key, value_name => value } }
      end
    end

    module Factory
      def self.factory(attributes, klass)
        klass.new(attributes)
      end
    end

    module Mapping
      def self.mapping(hash, mapper)
        mapper.new.call(hash)
      end
    end

    import Transproc::HashTransformations
    import Transproc::ArrayTransformations
    import Transproc::Conditional
    import HashTransformations
    import Factory
    import Mapping
  end
end
