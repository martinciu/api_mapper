module GithubMapper
  class UserMapper < ApiMapper::Mapper
    attributes :id, :login
    entity User
  end

end