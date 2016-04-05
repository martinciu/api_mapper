module DummyGithubMapper
  class Router < ApiMapper::Router
    get "emojis", EmojiMapper.new
    get "repositories", RepositoryMapper.build
    post "user/repos", RepositoryMapper.build
    get "repos/{owner}/{repo}/issues", IssueMapper.build
    get "user", UserMapper.build
    patch "user", UserMapper.build
  end
end
