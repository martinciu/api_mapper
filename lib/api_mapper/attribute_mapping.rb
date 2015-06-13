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

    def parent_from
      from.to_s.split('.').first
    end

    def extract(*args)
      key = args[0]
      value = args[1]

      keys = from.to_s.split('.')
      keys.shift
      ret_val = keys.inject(value) { |val, msg| val.is_a?(Hash) ? val.fetch(msg, {}) : val } if match?(key)
      ret_val unless ret_val == {}
    end

  end

end