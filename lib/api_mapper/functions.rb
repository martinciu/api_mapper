module ApiMapper
  module Functions
    extend Transproc::Registry

    module Structure
      def self.structure(hash, key_name, value_name)
        hash.map { |key, value| { key_name => key, value_name => value } }
      end
    end

    module Factory
      def self.factory(attributes, klass)
        klass.new(attributes)
      end
    end

    import Transproc::ArrayTransformations
    import Structure
    import Factory
  end
end
