module DummyMovesMapper
  class TrackPointMapper < ROM::Mapper
    reject_keys true

    attribute "created_at", from: "time"

    wrap :location do
      attribute "lat"
      attribute "lon"
    end

    model TrackPoint
  end
end
