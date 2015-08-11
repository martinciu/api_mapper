module MovesTestClient
  private

  def client
    @client ||= ApiMapper::Client.new("https://api.moves-app.com/api/1.1/").tap do |client|
      client.router = DummyMovesMapper::Router.new
    end
  end
end
