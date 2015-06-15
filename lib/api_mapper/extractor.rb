module ApiMapper
  class Extractor
    Error = Class.new(ApiMapper::Error)

    def initialize(value, path)
      @path, @value = path, value
    end

    def call
      @path.inject(@value) { |value, path_element| value.fetch(path_element) }
    rescue KeyError => exception
      raise Error.new(exception.message)
    end
  end
end