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
    VCR.use_cassette("moves/summary_day") do
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

  def test_summary_by_week
    VCR.use_cassette("moves/summary_week") do
      days = client.get("user/summary/daily/2015-W10")

      assert_equal 7, days.count

      day = days[0]

      assert_equal Date.parse("2015-03-02"), day.date

      summaries = day.summaries
      assert_equal 2, summaries.size

      summary = summaries[0]

      assert_equal "walking", summary.activity
    end
  end

  def test_summary_by_month
    VCR.use_cassette("moves/summary_month") do
      days = client.get("user/summary/daily/201507")

      assert_equal 31, days.count

      day = days[0]

      assert_equal Date.parse("2015-07-01"), day.date

      summaries = day.summaries
      assert_equal 2, summaries.size

      summary = summaries[0]

      assert_equal "walking", summary.activity
    end
  end

  def test_summary_date_range
    VCR.use_cassette("moves/summary_range") do
      days = client.get("user/summary/daily?from=20150401&to=20150403")

      assert_equal 3, days.count

      day = days[0]

      assert_equal Date.parse("2015-04-01"), day.date

      summaries = day.summaries
      assert_equal 4, summaries.size

      summary = summaries[0]

      assert_equal "cycling", summary.activity
    end
  end

  def test_summary_past_days
    VCR.use_cassette("moves/summary_past_days") do
      days = client.get("user/summary/daily?pastDays=23")

      assert_equal 23, days.count

      day = days[0]

      assert_equal Date.parse("2015-07-29"), day.date

      summaries = day.summaries
      assert_equal 2, summaries.size

      summary = summaries[0]

      assert_equal "walking", summary.activity
    end
  end

end
