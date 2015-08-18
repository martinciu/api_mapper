module DummyMovesMapper
  class ActivityType
    include Virtus.model

    attribute :name
    attribute :geo, Boolean
    attribute :place, Boolean
    attribute :color
    attribute :units, [Unit]

    def units=(param)
      if param.is_a? String
        param = param.split(',').map { |name| Unit.new(name: name) }
      end
      super(param)
    end
  end
end
