require "test_helper"

require "support/github/client"
require "github_mapper"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes/github"
  config.hook_into :webmock
end
