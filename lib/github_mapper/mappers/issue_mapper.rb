module GithubMapper
  class IssueMapper < Faceter::Mapper
    list do
      symbolize_keys

      create :user, from: [:user] do |owner|
        UserMapper.new.call(owner)
      end

      wrap to: :attributes, only: [:id, :number, :title, :user]

      create nil, from: [:attributes] do |attributes|
        Issue.new(attributes)
      end
    end
  end

end