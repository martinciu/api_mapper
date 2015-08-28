module DummyMovesMapper
  class SegmentMapper < ROM::Mapper
    reject_keys true

    attribute "type"
    attribute "started_at", from: "startTime"
    attribute "finished_at", from: "endTime"
    attribute "updated_at", from: "lastUpdate"

    attribute "place", default: {}

    # embedded "place", mapper: PlaceMapper, type: :array
    embedded "activities", mapper: ActivityMapper

    model Segment
  end
end
