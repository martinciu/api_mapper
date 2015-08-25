module DummyMovesMapper
  class ActivityMapper < ROM::Mapper
    # reject_keys true

    attribute "activity"
    attribute "group"
    attribute "started_at", from: "startTime"
    attribute "finished_at", from: "endTime"
    attribute "duration"
    attribute "distance"
    attribute "steps"
    attribute "calories"
    attribute "updated_at"
    attribute "manual"
    attribute "trackPoints"

    # embedded "track_points", from: "trackPoints", mapper: TrackPointMapper

    model Activity
  end
end
