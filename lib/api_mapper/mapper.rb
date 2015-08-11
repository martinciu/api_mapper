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

  class Structure < AbstractMapper::Branch
    attribute :key
    attribute :value

    def transproc
      Functions[:structure, key, value]
    end
  end

  module Coerces
    extend Transproc::Registry

    def self.structure(key, value)
      { key: key, value: value }
    end
  end

  class Mapper < Faceter::Mapper
    configure do
      command :symbolize_keys, Faceter::Nodes::SymbolizeKeys
      command :structure,      ApiMapper::Structure,         &ApiMapper::Coerces[:structure]
      command :wrap,           Faceter::Nodes::Wrap,         &Faceter::Coercers[:wrap]
      command :create,         Faceter::Nodes::Create,       &Faceter::Coercers[:create]
      command :list,           Faceter::Nodes::List
      command :rename,         Faceter::Nodes::Rename,       &Faceter::Coercers[:rename]
      command :unwrap,         Faceter::Nodes::Unwrap,       &Faceter::Coercers[:unwrap]
    end
  end
end
