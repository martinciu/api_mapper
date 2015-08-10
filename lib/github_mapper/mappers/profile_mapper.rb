module GithubMapper
  class ProfileMapper < ApiMapper::Mapper
    attributes :id, :login, :hireable
    entity Profile
  end

end