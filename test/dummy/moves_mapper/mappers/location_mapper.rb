module DummyMovesMapper
  class LocationMapper < ROM::Mapper
    reject_keys true

    attribute "lat"
    attribute "lon"

    model Location
  end
end
