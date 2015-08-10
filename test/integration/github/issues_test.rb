require 'github_test_helper'

class GithubIssuesTest < Minitest::Test
  include GithubTestClient

  def test_issues_rails
    VCR.use_cassette("github/issues_rails") do
      issues = client.get('repos/rails/rails/issues')

      assert_equal 30, issues.count
      issue = issues.first

      assert_equal 97284917, issue.id
      assert_equal 21031, issue.number
      assert_equal "Fix params_wrapper doc [ci skip]", issue.title

      user = issue.user

      assert_equal 1840945, user.id
      assert_equal "meinac", user.login
    end
  end

  def test_issues_emberjs
    VCR.use_cassette("github/issues_emberjs") do
      issues = client.get('repos/emberjs/ember.js/issues')

      assert_equal 30, issues.count
      issue = issues.first

      assert_equal 97332421, issue.id
      assert_equal 11903, issue.number
      assert_equal "[BUGFIX release] upgrade rsvp + backburner", issue.title

      user = issue.user

      assert_equal 1377, user.id
      assert_equal "stefanpenner", user.login
    end
  end

end