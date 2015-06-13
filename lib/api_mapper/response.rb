module ApiMapper
  class Response
    def initialize(raw)
      @raw = raw
    end

    def body
      JSON.parse(raw.body)
    end

    def request_url
      raw.env.url
    end

    def request_method
      raw.env.method
    end

    def status
      raw.status
    end

    private

    attr_reader :raw
  end
end