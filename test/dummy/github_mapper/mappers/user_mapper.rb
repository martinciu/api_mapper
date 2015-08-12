module GithubMapper
  class UserMapper < ROM::Mapper
    reject_keys true

    attribute "id"
    attribute "login"
    attribute "hireable"

    model User
  end
end
