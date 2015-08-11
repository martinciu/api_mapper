module MovesMapper
  class Profile
    include Virtus.model
    attribute :id, Integer
    attribute :created_at, Date
    attribute :locale, String
    attribute :metric, Boolean
  end
end