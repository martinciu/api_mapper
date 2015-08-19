module DummyMovesMapper
  class Router < ApiMapper::Router
    get "user/profile", ProfileMapper.build
    get "activities", ActivityTypeMapper.build
    get "user/summary/daily/{date}", DayMapper.build
  end
end
