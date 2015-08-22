module DummyMovesMapper
  class Router < ApiMapper::Router
    get "user/profile", ProfileMapper.build
    get "activities", ActivityTypeMapper.build
    get "user/summary/daily{/date}{?from,to,pastDays,updatedSince,timeZone}", DayMapper.build
  end
end
