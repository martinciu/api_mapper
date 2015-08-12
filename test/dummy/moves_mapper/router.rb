module DummyMovesMapper
  class Router < ApiMapper::Router
    get "user/profile", ProfileMapper.build
  end
end
