module GithubMapper
  class IssueMapper < ApiMapper::Mapper
    list do
      symbolize_keys

      create :user, from: [:user] do |owner|
        UserMapper.new.call(owner)
      end

      wrap to: :attributes, only: [:id, :number, :title, :user]

      create from: [:attributes] do |attributes|
        Issue.new(attributes)
      end
    end
  end
end
