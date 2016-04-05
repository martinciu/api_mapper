module DummyGithubMapper
  class Emoji
    include Virtus.model

    attribute :symbol
    attribute :url
  end
end
