module GithubMapper
  class UserMapper < ApiMapper::Mapper
    symbolize_keys

    wrap to: :attributes, only: [:id, :login, :hireable]

    create from: [:attributes] do |attributes|
      User.new(attributes)
    end
  end
end
