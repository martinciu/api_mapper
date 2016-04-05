module DummyGithubMapper
  class Issue
    include ROM::Model::Attributes

    attribute :id, Integer
    attribute :number, Integer
    attribute :title
    attribute :user, User
  end
end
