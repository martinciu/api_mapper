require 'github_test_helper'

class GithubRepositoriesTest < Minitest::Test
  include GithubTestClient

  def setup
    client.authorization("token secret_token")
  end

  def teardown
    client.authorization(nil)
  end

  def test_repositories
    VCR.use_cassette("github/repositories") do
      repositories = client.get('repositories')

      assert_equal 100, repositories.count
      repository = repositories.first

      assert_equal 1, repository.id
      assert_equal "grit", repository.name
      assert_equal "mojombo/grit", repository.full_name

      user = repository.owner

      assert_equal 1, user.id
      assert_equal "mojombo", user.login
    end
  end

  def test_create
    VCR.use_cassette("github/repository_create") do
      new_repository = GithubMapper::Repository.new(name: 'dummy')
      repository = client.post('user/repos', new_repository)

      assert_equal "dummy", repository.name
      assert_equal "martinciu/dummy", repository.full_name

      user = repository.owner

      assert_equal "martinciu", user.login
    end
  end
end
