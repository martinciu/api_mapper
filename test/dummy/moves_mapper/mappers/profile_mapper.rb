module DummyMovesMapper
  class ProfileMapper < ROM::Mapper
    reject_keys true

    attribute :id, from: "userId"
    unwrap "profile" do
      attribute :created_at, from: "firstDate"
      attribute :metric
      attribute :locale
      unwrap "localization" do
        attribute :metric, from: "metric"
        attribute :locale, from: "locale"
      end
    end
    model Profile
  end
end
