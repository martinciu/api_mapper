require 'test_helper'

module ApiMapper
  class ErrorTest < Minitest::Test
    def test_ancestor
      assert_kind_of StandardError, Error.new
    end
  end
end