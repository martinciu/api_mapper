module DummyMovesMapper
  class DayMapper < ROM::Mapper
    reject_keys true

    attribute :date, from: "date"
    attribute :updated_at, from: "lastUpdate"
    attribute :calories_idle, from: "caloriesIdle"

    embedded :summaries, from: "summary", mapper: SummaryMapper
    embedded :segments, from: "segments", mapper: SegmentMapper

    model Day
  end
end
