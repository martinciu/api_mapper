require "moves_test_helper"

class MovesActivityTypeTest < Minitest::Test
  include MovesTestClient

  def test_activity_types
    VCR.use_cassette("moves/activities") do
      activity_types = client.get("activities")

      assert_equal 88, activity_types.size

      activity_type = activity_types.first

      assert_equal "aerobics", activity_type.name
      assert_equal false, activity_type.geo
      assert_equal true, activity_type.place
      assert_equal "bc4fff", activity_type.color
      assert_equal ["duration", "calories"], activity_type.units.map(&:name)
    end
  end
end
