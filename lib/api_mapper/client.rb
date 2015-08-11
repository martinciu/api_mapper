module ApiMapper
  # API client class
  #
  # Provides methods to access API endpoints
  # @example
  #   client = ApiMapper::Client.new('http://api.example.com')
  #   client.authorization("token super_secret_token")
  #   user = client.get("user")
  #   user.login = 'Incognito'
  #   incognito_user = client.patch("user", user)
  #
  # @attr_writer [ApiMapper::Router] router router used for processing requests
  class Client
    attr_writer :router

    # A new instance of ApiMapper::Client
    #
    # @param (String) base_url base URL of all API endpoints
    # @return (ApiMapper::Client)
    def initialize(base_url)
      @base_url = base_url
      @router = Router.new
    end

    # Make HTTP GET request
    #
    # @example
    #   client.get('users')
    #
    # @param (String) path request path
    #
    # @return [Array, Object] mapped API response
    def get(path)
      mapper(:get, path).call(response(:get, path).body)
    end

    # Make HTTP PATCH request
    #
    # @example
    #   client.patch('users', user)
    #
    # @param (String) path request path
    # @param (Object) payload request payload
    #
    # @return [Array, Object] mapped API response
    def patch(path, payload)
      mapper(:patch, path).call(response(:patch, path, payload).body)
    end

    # Make HTTP POST request
    #
    # @example
    #   client.post('users', user)
    #
    # @param (String) path request path
    # @param (Object) payload request payload
    #
    # @return [Array, Object] mapped API response
    def post(path, payload)
      mapper(:post, path).call(response(:post, path, payload).body)
    end

    # Authorize client using `Authorization` HTTP header
    #
    # @example
    #   client.authorize("Bearer secret_token")
    #
    # @param (String) authorization authorization header
    # @return (String) authorization header
    def authorization(authorization)
      @authorization = authorization
    end

    private

    def mapper(method, path)
      @router.resolve(method, path).mapper.new
    end

    def response(method, path, body = nil)
      Response.new(connection.__send__(method, path, Serializer.new(body).call))
    end

    def connection
      @connection ||= Faraday.new(url: @base_url) do |conn|
        conn.adapter :net_http
        conn.headers["Content-Type"] = "application/json"
        conn.headers["Accept"] = "application/json"
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
      serialize.to_json if @model
    end

    private

    def serialize
      attributes.reduce({}) do |response, (key, value)|
        response.merge(key => value)
      end
    end

    def attributes
      @model.attributes.select { |_, value| !value.nil? }
    end
  end
end
