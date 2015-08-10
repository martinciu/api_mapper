module GithubMapper
  class User
    include Anima.new(:id, :login)
  end
end