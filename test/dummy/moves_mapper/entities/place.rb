module DummyMovesMapper
  class Place
    include Virtus.model
    attribute :id, Integer
    attribute :name
    attribute :type
    attribute :foursquare_id
    attribute :location, Location
  end
end
