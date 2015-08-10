module GithubMapper
  class RepositoryMapper < Faceter::Mapper
    symbolize_keys

    create :owner, from: [:owner] do |owner|
      UserMapper.new.call(owner)
    end

    wrap to: :attributes, only: [:id, :name, :full_name, :owner]

    create nil, from: [:attributes] do |attributes|
      Repository.new(attributes)
    end
  end
end