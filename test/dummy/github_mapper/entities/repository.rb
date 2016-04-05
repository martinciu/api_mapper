module DummyGithubMapper
  class Repository
    include Virtus.model

    attribute :id, Integer
    attribute :name
    attribute :full_name
    attribute :owner, DummyGithubMapper::User
  end
end
