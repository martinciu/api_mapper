require 'test_helper'

class ApiMapper::IndexPathTest < Minitest::Test

  def test_first
    assert_equal "foo", index_path.first
  end

  def test_last
    assert_equal "baz", index_path.last
  end

  private

  def index_path
    @index_path = ApiMapper::IndexPath.new "foo.bar.baz"
  end

  def hash
    {
      foo: {
        bar: {
          baz: :qux
        },
        ble: {
          bla: :bla
        }
      },
      nofoo: {
        bar: :baz
      }
    }
  end
end