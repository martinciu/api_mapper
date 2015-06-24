module ApiMapper
  class ResponseDescriptor
    attr_reader :path, :method, :mapping, :status_codes

    attr_accessor :base_url

    def initialize(path, method, mapping, status_codes)
      @path = Addressable::Template.new(path)
      @method = method
      @mapping = mapping
      @status_codes = status_codes
      @base_url = URI("")
    end

    def match?(response)
      ApiMapper::ResponseMatcher.new(response, self).call
    end

  end
end