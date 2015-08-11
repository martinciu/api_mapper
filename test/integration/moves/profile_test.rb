require "moves_test_helper"

class MovesUserTest < Minitest::Test
  include MovesTestClient

  def setup
    client.authorization("Bearer secret_token")
  end

  def teardown
    client.authorization(nil)
  end

  def test_get_profile
    VCR.use_cassette("moves/user_get") do
      user = client.get("user/profile")

      assert_equal 19893780817643993, user.id
      assert_equal Date.parse("2013-11-14"), user.created_at
      assert_equal "en_PL", user.locale
      assert_equal true, user.metric
    end
  end
end
