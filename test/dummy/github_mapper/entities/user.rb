module GithubMapper
  class User
    include Virtus.model

    attribute :id, Integer
    attribute :login
    attribute :hireable, Boolean
  end
end
