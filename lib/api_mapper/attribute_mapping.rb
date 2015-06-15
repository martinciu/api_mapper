module ApiMapper
  class AttributeMapping
    attr_reader :from, :to

    def initialize(from, to = nil)
      @from, @to = from, to
      @to ||= @from.split('.').last
    end

    def match?(key)
      parent_from == key
    end

    def extract(source_element)
      ApiMapper::Extractor.new(source_element.value, from_elements).call if match?(source_element.key)
    end

    private

    def parent_from
      from.to_s.split('.').first
    end

    def from_elements
      from_elements = from.to_s.split('.')
      from_elements.shift
      from_elements
    end

  end

end
