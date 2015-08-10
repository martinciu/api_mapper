module GithubMapper
  class Repository
    include Virtus.model
    attribute :id, Integer
    attribute :name
    attribute :full_name
    attribute :owner, GithubMapper::User
  end
end