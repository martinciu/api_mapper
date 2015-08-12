module ApiMapper
  module Nodes
    class Structure < AbstractMapper::Branch
      attribute :key
      attribute :value

      def transproc
        Functions[:structure, key, value]
      end
    end
  end
end