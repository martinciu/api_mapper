module DummyMovesMapper
  class DayMapper < ROM::Mapper
    reject_keys true

    attribute :date, from: "date"
    attribute :updated_at, from: "lastUpdate"
    attribute :calories_idle, from: "caloriesIdle"

    embedded :summaries, from: "summary", mapper: SummaryMapper

    model Day
  end
end
