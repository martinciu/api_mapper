require 'test_helper'

class ObjectManagerTest < Minitest::Test
  def test_instance
    object_manager = ApiMapper::ObjectManager.new('http://api.foo.com')

    assert_instance_of ApiMapper::ObjectManager, object_manager
  end

end