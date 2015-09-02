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
  # @attr_writer (ApiMapper::Router) router router used for processing requests
  class Client
    # A new instance of ApiMapper::Client
    #
    # @param (String) base_url base URL of all API endpoints
    # @return (ApiMapper::Client)
    def initialize(base_url, router = Router.new)
      @base_url = base_url
      @router = router
    end

    # Make HTTP GET request
    #
    # @example
    #   client.get('users')
    #
    # @param (String) path request path
    #
    # @return [Array, Object] mapped API response
    def get(path, payload = nil)
      route = Route.new(:get, path)

      response = response(route, payload)
      mapper = mapper(route, response)

      ResponseMapper.new(mapper).call(response)
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
    def patch(path, payload = nil)
      route = Route.new(:patch, path)

      response = response(route, payload)
      mapper = mapper(route, response)

      ResponseMapper.new(mapper).call(response)
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
    def post(path, payload = nil)
      route = Route.new(:post, path)

      response = response(route, payload)
      mapper = mapper(route, response)

      ResponseMapper.new(mapper).call(response)
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

    def mapper(route, _ )
      @router.resolve(route).mapper
    end

    def response(route, body = nil)
      Response.new(connection.__send__(route.http_method, route.path, Serializer.new(body).call))
    end

    def connection
      @connection ||= Faraday.new(url: @base_url) do |conn|
        conn.adapter :net_http
        conn.headers = headers
      end
    end

    def headers
      {
        "Content-Type"  => "application/json",
        "Accept"        => "application/json",
        "Authorization" => @authorization,
        "X-Client"      => "ApiMapper-v#{ApiMapper::VERSION}"
      }.select { |_, value| value }
    end

    # Maps response using given mapper
    # @api private
    class ResponseMapper
      def initialize(mapper)
        @mapper = mapper
      end

      def call(response)
        body = response.body
        if body.is_a? Hash
          @mapper.call([body])[0]
        else
          @mapper.call(body)
        end
      end
    end
  end

  # Route
  # @api private
  class Route
    attr_reader :http_method, :path

    def initialize(http_method, path)
      @http_method = http_method
      @path = path
    end
  end

  ##
  # HTTP response parser
  #
  # @api private
  class Response
    # Creates new Response
    #
    # @param response raw HTTP response
    def initialize(response)
      @raw = response
    end

    ##
    # Parsed response body
    #
    # @return (Hash)
    def body
      JSON.parse(@raw.body)
    end
  end
  ##
  # Serialized object before sending to API endpoint
  # Currently only simple attributes based serializer is available
  #
  # @api private
  class Serializer
    # Creates new serializer
    #
    # @param model model to serialize
    def initialize(model)
      @model = model
    end

    # Returns serialized model representation
    #
    # @return (String) model serialized to JSON string
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
      @model.attributes
    end
  end
end
