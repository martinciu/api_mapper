module DummyMovesMapper
  class SummaryMapper < ROM::Mapper
    reject_keys true

    attribute :activity, from: "activity"
    attribute :group, from: "group"
    attribute :duration, from: "duration"
    attribute :distance, from: "distance"
    attribute :steps, from: "steps"
    attribute :calories, from: "calories"

    model Summary
  end
end
