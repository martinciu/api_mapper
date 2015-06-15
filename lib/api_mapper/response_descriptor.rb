module ApiMapper
  class ResponseDescriptor
    attr_reader :mapping

    attr_accessor :base_path

    def initialize(path, method, mapping, status_codes)
      @path = Addressable::Template.new(path)
      @method = method
      @mapping = mapping
      @status_codes = status_codes
    end

    def match?(response)
      match_url?(response) && match_method?(response) && match_status?(response)
    end

    private

    def match_status?(response)
      @status_codes.include?(response.status)
    end

    def match_method?(response)
      @method == response.request_method
    end

    def match_url?(response)
      !@path.match(request_path_normalized(response)).nil?
    end

    def request_path(response)
      response.request_url.path
    end

    def request_path_normalized(response)
      request_path(response).gsub(/#{base_path}/, "")
    end

  end
end