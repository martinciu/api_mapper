module ApiMapper
  class IndexPath
    extend Forwardable

    def_delegators :parsed, :first, :last, :inject

    def initialize(raw)
      @raw = raw
    end

    private

    def parsed
      @parsed ||= @raw.to_s.split('.')
    end
  end
end