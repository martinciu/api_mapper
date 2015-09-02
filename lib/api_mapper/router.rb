module ApiMapper
  ##
  # Router defines all routes available for an API
  #
  # @example
  #   class MyRouter < ApiMapper::Router
  #     get 'user/{id}', UserMapper.new
  #     patch 'user', UserMapper.new
  #     get 'user/{id}/messages', MessageMapper.new
  #   end
  # :reek:DataClump
  class Router
    class << self
      ##
      # Defines GET route
      #
      # @param (String) path URI template based on RFC 6570 (http://tools.ietf.org/html/rfc6570)
      # @param (Object) mapper mapper for the route
      #
      # @example
      #   get 'users/{id}', UserMapper.new
      def get(path, mapper)
        add_route(:get, path, mapper)
      end

      ##
      # Defines PATCH route
      #
      # @param (String) path URI template based on RFC 6570 (http://tools.ietf.org/html/rfc6570)
      # @param (Object) mapper mapper for the route
      #
      # @example
      #   post 'user', UserMapper.new
      def patch(path, mapper)
        add_route(:patch, path, mapper)
      end

      ##
      # Defines POST route
      #
      # @param (String) path URI template based on RFC 6570 (http://tools.ietf.org/html/rfc6570)
      # @param (Object) mapper mapper for the route
      #
      # @example
      #   patch 'user', UserMapper.new
      def post(path, mapper)
        add_route(:post, path, mapper)
      end

      ##
      # List of defined routes
      #
      # @return (Array[RouteMatcher]) defined routes
      #
      # @api private
      def routes
        @routes ||= []
      end

      private

      def add_route(method, mapper, path)
        routes << RouteMatcher.new(method, mapper, path)
      end
    end

    ##
    # Finds a defined mapper for given HTTP method and path
    #
    # @param (Symbol) method HTTP method one of :get, :patch, :post
    # @param (String) path request path
    #
    # @return (Object) mapper defined in the router
    #
    # @example
    #   router.resolve(:get, '/users/123')
    #
    # @api private
    def resolve(route)
      self.class.routes.find { |matcher| matcher.match(route) }
    end
  end

  ##
  # Represents route defined in router
  #
  # @attr_reader (Object) mapper mapper for the route
  #
  # @api private
  class RouteMatcher
    attr_reader :mapper

    ##
    # Creates new route
    #
    # @param (Symbol) method HTTP method one of :get, :patch, :post
    # @param (String) path URI template based on RFC 6570 (http://tools.ietf.org/html/rfc6570)
    # @param (Object) mapper mapper for the route
    #
    # @api private
    def initialize(method, path, mapper)
      @http_method = method
      @path = Addressable::Template.new(path)
      @mapper = mapper
    end

    ##
    # Check if given method and path matches a route
    #
    # @param (Symbol) method HTTP method one of :get, :patch, :post
    # @param (String) path request path
    # @return (Boolean)
    #
    # @api private
    def match(route)
      @http_method == route.http_method && @path.match(route.path)
    end
  end
end
