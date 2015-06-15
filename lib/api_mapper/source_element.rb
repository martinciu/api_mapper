module ApiMapper
  class SourceElement
    attr_reader :key, :value

    def initialize(key, value)
      @key, @value = key, value
    end

    def element_at(index_path)
      index_path.traverse(@value) { |value, path_element| value.fetch(path_element) }
    end
  end
end