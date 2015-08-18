module DummyMovesMapper
  class Router < ApiMapper::Router
    get "user/profile", ProfileMapper.build
    get "activities", ActivityTypeMapper.build
  end
end
