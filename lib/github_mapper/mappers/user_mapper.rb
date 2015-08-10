module GithubMapper
  class UserMapper < Faceter::Mapper
    symbolize_keys

    wrap to: :attributes, only: [:id, :login]

    create nil, from: [:attributes] do |attributes|
      User.new(attributes)
    end
  end

end