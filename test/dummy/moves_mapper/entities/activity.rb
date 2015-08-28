module DummyMovesMapper
  class Activity
    include Virtus.model

    attribute :name
    attribute :group
    attribute :started_at, Time
    attribute :finished_at, Time
    attribute :duration, Float
    attribute :distance, Float
    attribute :steps, Integer
    attribute :calories, Integer
    attribute :updated_at, Time
    attribute :manual, Boolean
    attribute :track_points, [TrackPoint]
  end
end
