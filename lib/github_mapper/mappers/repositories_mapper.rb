module GithubMapper
  class RepositoriesMapper < ApiMapper::ArrayMapper
    attributes :id, :name, :full_name
    relationship :owner, UserMapper
    entity Repository
  end
end