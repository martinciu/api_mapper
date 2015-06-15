module ApiMapper
  class AttributeMapping
    Error = Class.new(ApiMapper::Error)

    attr_reader :from, :to

    def initialize(from, to = nil)
      @from, @to = ApiMapper::IndexPath.new(from), to
      @to ||= @from.last
    end

    def match?(key)
      from.first == key
    end

    def extract(source_element)
      source_element.element_at(@from) if match?(source_element.key)
    rescue KeyError => exception
      raise Error.new(exception.message)
    end
  end
end
