require "moves_test_helper"

class MovesActivityTypeTest < Minitest::Test
  include MovesTestClient

  def setup
    client.authorization("Bearer JUl5GCubYSBq_ThY7QGXQQ63eR_66Ok3c80Uq2LS0GD5TXQer2e720HhE4oi6cX_")
  end

  def teardown
    client.authorization(nil)
  end

  def test_summary_by_date
    VCR.use_cassette("moves/summary") do
      days = client.get("user/summary/daily/20150818")

      assert_equal 1, days.count

      day = days[0]

      assert_equal Date.parse("2015-08-18"), day.date

      summaries = day.summaries
      assert_equal 1, summaries.size

      summary = summaries[0]

      assert_equal "walking", summary.activity
    end
  end
end
