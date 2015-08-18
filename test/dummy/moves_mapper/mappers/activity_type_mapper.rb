module DummyMovesMapper
  class ActivityTypeMapper < ROM::Mapper
    reject_keys true

    attribute :name, from: "activity"
    attribute :geo, from: "geo"
    attribute :place, from: "place"
    attribute :color, from: "color"
    attribute :units, from: "units"

    model ActivityType
  end
end
