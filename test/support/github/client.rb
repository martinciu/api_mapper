module GithubTestClient
  private

  def client
    @client ||= ApiMapper::Client.new("https://api.github.com", GithubMapper::Router.new)
  end
end
