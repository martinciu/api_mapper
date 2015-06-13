module ApiMapper
  class ResponseDescriptor
    attr_reader :mapping

    def initialize(path, method, mapping, status_codes)
      @path = Addressable::Template.new(path)
      @method = method
      @mapping = mapping
      @status_codes = status_codes
    end

    def match?(response)
      !@path.match(response.request_url.path).nil? &&
        @method == response.request_method &&
        @status_codes.include?(response.status)
    end
  end
end