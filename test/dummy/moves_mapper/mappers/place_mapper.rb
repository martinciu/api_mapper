module DummyMovesMapper
  class PlaceMapper < ROM::Mapper
    # reject_keys true

    attribute "id"
    attribute "name"
    attribute "type"
    # attribute "foursquare_id", from: "foursquareId"

    # embedded "location", mapper: LocationMapper, type: :hash

    model Place
  end
end
