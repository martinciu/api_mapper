module GithubMapper
  class Router < ApiMapper::Router
    get "emojis", EmojiMapper
    get "repositories", RepositoriesMapper
    post "user/repos", RepositoryMapper
    get "repos/{owner}/{repo}/issues", IssueMapper
    get "user", UserMapper
    patch "user", UserMapper
  end
end
