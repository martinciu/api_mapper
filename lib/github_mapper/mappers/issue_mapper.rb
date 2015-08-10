module GithubMapper
  class IssueMapper < ApiMapper::ArrayMapper
    attributes :id, :number, :title
    relationship :user, UserMapper
    entity Issue
  end

end