module GithubTestClient
  private

  def client
    @client ||= ApiMapper::Client.new("https://api.github.com", DummyGithubMapper::Router.new)
  end
end
