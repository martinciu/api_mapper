require 'api_mapper/mapper/functions'
require 'api_mapper/mapper/nodes/structure'
require 'api_mapper/mapper/coercers'

module ApiMapper

  class Mapper < Faceter::Mapper
    configure do
      command :symbolize_keys, Faceter::Nodes::SymbolizeKeys
      command :structure,      ApiMapper::Nodes::Structure,  &ApiMapper::Coerces[:structure]
      command :wrap,           Faceter::Nodes::Wrap,         &Faceter::Coercers[:wrap]
      command :create,         Faceter::Nodes::Create,       &Faceter::Coercers[:create]
      command :list,           Faceter::Nodes::List
      command :rename,         Faceter::Nodes::Rename,       &Faceter::Coercers[:rename]
      command :unwrap,         Faceter::Nodes::Unwrap,       &Faceter::Coercers[:unwrap]
    end
  end
end
