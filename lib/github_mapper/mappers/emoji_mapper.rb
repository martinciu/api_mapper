module GithubMapper
  class EmojiMapper < ApiMapper::HashMapper
    attributes symbol: :url
    entity Emoji
  end
end