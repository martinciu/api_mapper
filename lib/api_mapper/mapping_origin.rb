module ApiMapper
  class MappingOrigin
    attr_reader :key, :value

    def initialize(*args)
      @key = args[0]
      @value = args[1]
    end
  end
end