module DummyMovesMapper
  class TrackPoint
    include Virtus.model

    attribute :location, Location
    attribute :created_at, Time
  end
end
