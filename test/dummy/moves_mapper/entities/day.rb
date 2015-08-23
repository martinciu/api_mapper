module DummyMovesMapper
  class Day
    include Virtus.model

    attribute :date, Date
    attribute :updated_at, Time
    attribute :calories_idle, Integer
    attribute :summaries, [Summary]
    attribute :segments, [Segment]
  end
end
