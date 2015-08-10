module GithubMapper
  class Issue
    include Anima.new(:id, :number, :title, :user)
  end
end