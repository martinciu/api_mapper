module MovesTestClient
  private

  def client
    @client ||= ApiMapper::Client.new('https://api.moves-app.com/api/1.1/').tap do |client|
      client.router = MovesMapper::Router.new
    end
  end
end