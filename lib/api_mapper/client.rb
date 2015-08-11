module ApiMapper
  class Client
    attr_writer :router

    def initialize(base_url)
      @base_url = base_url
      @router = Router.new
    end

    def get(path)
      mapper(:get, path).call(response(:get, path).body)
    end

    def patch(path, body)
      mapper(:patch, path).call(response(:patch, path, body).body)
    end

    def post(path, body)
      mapper(:post, path).call(response(:post, path, body).body)
    end

    def authorization(authorization)
      @authorization = authorization
    end

    private

    def mapper(method, path)
      @router.resolve(method, path).mapper.new
    end

    def response(method, path, body = nil)
      Response.new(connection.send(method, path, Serializer.new(body).call))
    end

    def connection
      @connection ||= Faraday.new(url: @base_url) do |conn|
        conn.adapter :net_http
        conn.headers["Content-Type"] = 'application/json'
        conn.headers["Accept"] = 'application/json'
        conn.headers["Authorization"] = @authorization if @authorization
        conn.headers["X-Client"] = "ApiMapper-v#{ApiMapper::VERSION}"
      end
    end
  end

  class Response
    def initialize(raw)
      @raw = raw
    end

    def body
      JSON.parse(@raw.body)
    end
  end

  class Serializer
    def initialize(model)
      @model = model
    end

    def call
      attributes.inject({}) do |response, (key, value)|
        response.merge(key => value)
      end.to_json if @model
    end

    private

    def attributes
      @model.attributes.select { |_, value| !value.nil? }
    end
  end
end
