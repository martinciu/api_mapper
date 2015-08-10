module ApiMapper
  class Router
    class << self
      def get(path, mapper)
        add_route(:get, path, mapper)
      end

      def patch(path, mapper)
        add_route(:patch, path, mapper)
      end

      def post(path, mapper)
        add_route(:post, path, mapper)
      end

      def add_route(method, mapper, path)
        routes << Route.new(method, mapper, path)
      end

      def routes
        @routes ||= []
      end
    end

    def resolve(method, path)
      self.class.routes.find { |route| route.match(method, path) }
    end
  end

  class Route
    attr_reader :mapper

    def initialize(method, path, mapper)
      @method = method
      @path = Addressable::Template.new(path)
      @mapper = mapper
    end

    def match(method, path)
      @method == method && @path.match(path)
    end
  end
end
