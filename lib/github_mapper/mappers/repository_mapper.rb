module GithubMapper
  class RepositoryMapper < ApiMapper::Mapper
    attributes :id, :name, :full_name
    relationship :owner, UserMapper
    entity Repository
  end
end