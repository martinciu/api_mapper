module GithubMapper
  class IssueMapper < ROM::Mapper
    attribute "id"
    attribute "number"
    attribute "title"

    embedded "user", type: :hash, mapper: UserMapper
    model Issue
  end
end
