require "github_test_helper"

class GithubUserTest < Minitest::Test
  include GithubTestClient

  def setup
    client.authorization("token secret_token")
  end

  def teardown
    client.authorization(nil)
  end

  def test_get_user
    VCR.use_cassette("github/user_get") do
      user = client.get("user")

      assert_equal "martinciu", user.login
      assert_equal 34633, user.id
      assert_equal true, user.hireable
    end
  end

  def test_path_user
    VCR.use_cassette("github/user_patch") do
      user = client.get("user")

      assert_equal true, user.hireable

      user.hireable = false

      new_user = client.patch("user", user)

      assert_equal "martinciu", new_user.login
      assert_equal 34633, new_user.id
      assert_equal false, new_user.hireable
    end
  end

  class Mapper
    def call(elements)
      elements.map { |attributes| { github_id: attributes["id"], user_name: attributes["login"] } }
    end
  end

  class Router < ApiMapper::Router
    get "user", Mapper.new
  end

  def test_poro_mapper
    client = ApiMapper::Client.new("https://api.github.com")
    client.router = Router.new
    client.authorization("token secret_token")

    VCR.use_cassette("github/user_get") do
      user = client.get("user")

      assert_equal "martinciu", user[:user_name]
      assert_equal 34633, user[:github_id]
    end
  end
end
