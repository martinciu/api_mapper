module DummyMovesMapper
  class Segment
    include Virtus.model

    attribute :type
    attribute :started_at, Time
    attribute :finished_at, Time
    attribute :place, Place
    attribute :activities, [Activity]
  end
end
