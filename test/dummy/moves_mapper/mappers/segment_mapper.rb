module DummyMovesMapper
  class SegmentMapper < ROM::Mapper
    reject_keys true

    attribute "type"
    attribute "started_at", from: "startTime"
    attribute "finished_at", from: "endTime"

    attribute :place, from: "place", default: {}
    attribute :activities, from: "activities", default: []

    # embedded :place, mapper: PlaceMapper, type: :hash
    embedded :activities, mapper: ActivityMapper

    model Segment
  end
end
