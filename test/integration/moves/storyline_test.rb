require "moves_test_helper"

class MovesStorylineTest < Minitest::Test
  include MovesTestClient

  def setup
    client.authorization("Bearer JUl5GCubYSBq_ThY7QGXQQ63eR_66Ok3c80Uq2LS0GD5TXQer2e720HhE4oi6cX_")
  end

  def teardown
    client.authorization(nil)
  end

  def test_summary_by_date
    VCR.use_cassette("moves/storyline_day") do
      days = repository.find_by_date(Date.parse("2015-08-18"))

      assert_equal 1, days.count

      day = days[0]

      assert_equal Date.parse("2015-08-18"), day.date

      segments = day.segments
      assert_equal 5, segments.size

      place_segment = segments[0]

      assert_equal "place", place_segment.type
      assert_equal "Home", place_segment.place.name
      assert_equal "home", place_segment.place.type

      move_segment = segments[1]
      assert_equal "move", move_segment.type
      activities = move_segment.activities

      activity = activities[0]
      assert_equal "walking", activity.activity

      track_points = activity.trackPoints
      assert_equal 10, track_points.count


    end
  end

  # def test_summary_by_week
  #   VCR.use_cassette("moves/summary_week") do
  #     days = repository.find_by_week(Date.parse("2015-03-10"))
  #
  #     assert_equal 7, days.count
  #
  #     day = days[0]
  #
  #     assert_equal Date.parse("2015-03-02"), day.date
  #
  #     summaries = day.summaries
  #     assert_equal 2, summaries.size
  #
  #     summary = summaries[0]
  #
  #     assert_equal "walking", summary.activity
  #   end
  # end
  #
  # def test_summary_by_month
  #   VCR.use_cassette("moves/summary_month") do
  #     days = repository.find_by_month(Date.parse("2015-07-01"))
  #
  #     assert_equal 31, days.count
  #
  #     day = days[0]
  #
  #     assert_equal Date.parse("2015-07-01"), day.date
  #
  #     summaries = day.summaries
  #     assert_equal 2, summaries.size
  #
  #     summary = summaries[0]
  #
  #     assert_equal "walking", summary.activity
  #   end
  # end
  #
  # def test_summary_date_range
  #   VCR.use_cassette("moves/summary_range") do
  #     days = repository.find_by_date_range(Date.parse("20150401"), Date.parse("20150403"))
  #
  #     assert_equal 3, days.count
  #
  #     day = days[0]
  #
  #     assert_equal Date.parse("2015-04-01"), day.date
  #
  #     summaries = day.summaries
  #     assert_equal 4, summaries.size
  #
  #     summary = summaries[0]
  #
  #     assert_equal "cycling", summary.activity
  #   end
  # end
  #
  # def test_summary_past_days
  #   VCR.use_cassette("moves/summary_past_days") do
  #     days = repository.find_by_past_days(23)
  #
  #     assert_equal 23, days.count
  #
  #     day = days[0]
  #
  #     assert_equal Date.parse("2015-07-29"), day.date
  #
  #     summaries = day.summaries
  #     assert_equal 2, summaries.size
  #
  #     summary = summaries[0]
  #
  #     assert_equal "walking", summary.activity
  #   end
  # end

  def repository
    @repository ||= DummyMovesMapper::StorylinesRepository.new(client)
  end
end
