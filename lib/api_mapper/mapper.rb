module ApiMapper
  class HashMapper

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

      def transformation
        mapping >> factory
      end

      def mapping
        raise "Only one key, pair allowed" if @attributes.count > 1
        @map = t(:structure, @attributes.first.keys.first, @attributes.first.values.first)
      end

      private

      def factory
        t(:map_array, t(:factory, @entity))
      end

      def t(*args)
        Functions[*args]
      end
    end
  end

end
