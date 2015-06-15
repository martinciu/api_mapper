module ApiMapper
  class SourceElement
    attr_reader :key, :value

    def initialize(key, value)
      @key, @value = key, value
    end
  end
end