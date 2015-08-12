module ApiMapper
  module Coerces
    extend Transproc::Registry

    def self.structure(key, value)
      { key: key, value: value }
    end
  end
end