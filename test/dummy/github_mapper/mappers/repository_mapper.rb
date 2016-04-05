module DummyGithubMapper
  class RepositoryMapper < ROM::Mapper
    attribute "id"
    attribute "name"
    attribute "full_name"

    embedded "owner", type: :hash, mapper: UserMapper
    model Repository
  end
end
