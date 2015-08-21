module DummyMovesMapper
  class SummariesRepository
    def initialize(client)
      @client = client
    end

    def find_by_date(date)
      @client.get("user/summary/daily/#{date.strftime('%Y%m%d')}")
    end
  end
end