module DummyMovesMapper
  class Summary
    include Virtus.model

    attribute :activity
    attribute :group
    attribute :duration, Integer
    attribute :distance, Integer
    attribute :steps, Integer
    attribute :calories, Integer
  end
end
