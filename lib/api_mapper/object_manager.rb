module ApiMapper
  class ObjectManager
    def initialize(base_url)
      @base_url = base_url
      @response_descriptors = Collection.new
    end

    def get(path)
      response = ApiMapper::Response.new(api.get("#{path}"))
      @response_descriptors.match(response).inject(Collection.new) do |collection, response_descriptor|
        collection.add response_descriptor.mapping.map(response.body)
      end
    end

    def add_response_descriptor(response_descriptor)
      @response_descriptors.add(response_descriptor)
    end

    def authorize_with_bearer(token)
      @token = token
    end

    private

    def api
      @api = Faraday.new(@base_url).tap do |connection|
        connection.authorization "Bearer", @token if @token
      end
    end
  end
end