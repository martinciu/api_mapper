require 'test_helper'

module ApiMapper
  class ObjectManagerTest < Minitest::Test
    def test_instance
      assert_instance_of ApiMapper::ObjectManager, object_manager
    end

    def test_base_path
      assert_equal "/v1/public", object_manager.base_path
    end

    def test_authorize_with_bearer

    end

    def test_url

    end

    private

    def object_manager
      ApiMapper::ObjectManager.new('http://api.foo.com/v1/public')
    end

  end
end