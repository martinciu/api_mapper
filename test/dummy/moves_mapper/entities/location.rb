module DummyMovesMapper
  class Location
    include Virtus.value_object

    values do
      attribute :lat, Float
      attribute :lon, Float
    end
  end
end
