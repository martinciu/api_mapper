module ApiMapper
  class ResponseMatcher
    def initialize(response, response_descriptor)
      @response, @response_descriptor = response, response_descriptor
    end

    def call
      match_url? && match_method? && match_status?
    end

    private

    def match_status?
      @response_descriptor.status_codes.include?(@response.status)
    end

    def match_method?
      @response_descriptor.method == @response.request_method
    end

    def match_url?
      !@response_descriptor.path.match(request_path_normalized).nil?
    end

    def request_path
      @response.request_url.path
    end

    def request_path_normalized
      request_path.gsub(/#{@response_descriptor.base_url.path}/, "")
    end
  end
end