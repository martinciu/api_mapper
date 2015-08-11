module GithubMapper
  class Issue
    include Virtus.model

    attribute :id, Integer
    attribute :number, Integer
    attribute :title
    attribute :user, User
  end
end
