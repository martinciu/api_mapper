module ApiMapper
  module Functions
    extend Transproc::Registry

    module Structure
      def self.structure(hash, key_name, value_name)
        hash.map { |key, value| { key_name => key, value_name => value } }
      end
    end

    import ApiMapper::Functions::Structure
  end
end
