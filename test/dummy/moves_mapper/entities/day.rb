module DummyMovesMapper
  class Day
    include Virtus.model

    attribute :date, Date
    attribute :updated_at, Time
    attribute :calories_idel, Integer
    attribute :summaries, [Summary]
  end
end
