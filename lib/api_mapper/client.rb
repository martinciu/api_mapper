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
      response = response(:get, path)
      mapper = mapper(:get, path)

      map_response(mapper, response)
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
      mapper = mapper(:patch, path)
      response = response(:patch, path, payload)

      map_response(mapper, response)
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
      mapper = mapper(:post, path)
      response = response(:post, path, payload)

      map_response(mapper, response)
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

    def map_response(mapper, response)
      body = response.body
      if body.is_a? Hash
        mapper.call([body])[0]
      else
        mapper.call(body)
      end
    end

    def mapper(method, path)
      @router.resolve(method, path).mapper
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
      @model.attributes.select { |_, value| !value.nil? }
    end
  end
end
