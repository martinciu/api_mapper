module GithubMapper
  class EmojiMapper
    def call(elements)
      [elements[0].map { |key, value| Emoji.new(symbol: key, url: value) }]
    end
  end
end
