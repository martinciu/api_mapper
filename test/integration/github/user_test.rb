require 'github_test_helper'

class GithubUserTest < Minitest::Test
  include GithubTestClient

  def setup
    client.authorization("token secret_token")
  end

  def teardown
    client.authorization(nil)
  end

  def test_get_user
    VCR.use_cassette("user_get") do
      user = client.get('user')

      assert_equal "martinciu", user.login
      assert_equal 34633, user.id
      assert_equal true, user.hireable
    end
  end

  def test_path_user
    VCR.use_cassette("user_patch") do
      user = client.get('user')

      assert_equal true, user.hireable

      user.hireable = false

      new_user = client.patch('user', user)

      assert_equal "martinciu", new_user.login
      assert_equal 34633, new_user.id
      assert_equal false, new_user.hireable
    end
  end

end