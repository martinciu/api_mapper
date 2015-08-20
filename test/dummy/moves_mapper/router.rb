module DummyMovesMapper
  class Router < ApiMapper::Router
    get "user/profile", ProfileMapper.build
    get "activities", ActivityTypeMapper.build
    get "user/summary/daily/{date}", DayMapper.build
    get "user/summary/daily?{type}={value}", DayMapper.build
    get "user/summary/daily?from={from}&to={to}", DayMapper.build
  end
end
