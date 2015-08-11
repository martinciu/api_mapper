module GithubTestClient
  private

  def client
    @client ||= ApiMapper::Client.new("https://api.github.com").tap do |client|
      client.router = GithubMapper::Router.new
    end
  end
end
