require 'test_helper'

module ApiMapper
  class AttributeMappingTest < Minitest::Test

    def test_mapping_from_array
      mapping = ApiMapper::AttributeMapping.new("id")

      assert_equal("123", mapping.extract(SourceElement.new("id", "123")))
    end

    def test_nested_extract
      mapping = ApiMapper::AttributeMapping.new("user.id.name")

      assert_equal("john", mapping.extract(SourceElement.new("user", { "id" => { "name" => "john" } })))
    end

    def test_nested_extract_with_change
      mapping = ApiMapper::AttributeMapping.new("user.id.firstName", "name")

      assert_equal("john", mapping.extract(SourceElement.new("user", { "id" => { "firstName" => "john" } })))
    end

    def test_nested_extract_nil
      mapping = ApiMapper::AttributeMapping.new("user.age", "age")

      assert_raises(ApiMapper::AttributeMapping::Error) { mapping.extract(SourceElement.new("user", { "name" => "john" })) }
    end

    def test_attribute_matching
      mapping = ApiMapper::AttributeMapping.new("user",)

      assert mapping.match?("user")
    end

    def test_path_matching
      mapping = ApiMapper::AttributeMapping.new("user.id.firstName", "name")

      assert mapping.match?("user")
    end

    def test_no_mathcing
      mapping = ApiMapper::AttributeMapping.new("user.id.firstName", "name")

      refute mapping.match?("firstName")
    end
  end
end
