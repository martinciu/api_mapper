module GithubMapper
  class EmojiMapper < ApiMapper::Mapper
    structure :symbol, :url

    list do
      wrap to: :attributes, only: [:symbol, :url]

      create from: [:attributes] do |attributes|
        Emoji.new(attributes)
      end
    end
  end
end
