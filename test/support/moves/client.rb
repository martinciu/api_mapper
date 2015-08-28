module MovesTestClient
  private

  def client
    @client ||= ApiMapper::Client.new("https://api.moves-app.com/api/1.1/", DummyMovesMapper::Router.new)
  end
end
