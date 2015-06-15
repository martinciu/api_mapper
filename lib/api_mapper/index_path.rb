module ApiMapper
  class IndexPath
    extend Forwardable

    def_delegators :parsed, :first, :last

    def initialize(raw)
      @raw = raw
    end

    def traverse(initial, &block)
      all.inject(initial, &block)
    end

    private

    def all
      all = parsed.dup
      all.shift
      all
    end

    def parsed
      @parsed ||= @raw.split('.')
    end
  end
end