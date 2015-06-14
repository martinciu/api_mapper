require 'test_helper'

class ApiAttributeMappingTest < Minitest::Test

  def test_mapping_from_array
    mapping = ApiMapper::AttributeMapping.new("id")

    assert_equal("123", mapping.extract("id", "123"))
  end

  def test_nested_extract
    mapping = ApiMapper::AttributeMapping.new("user.id.name")

    assert_equal("john", mapping.extract("user", { "id" => { "name" => "john" } }))
  end

  def test_nested_extract_with_change
    mapping = ApiMapper::AttributeMapping.new("user.id.firstName", "name")

    assert_equal("john", mapping.extract("user", { "id" => { "firstName" => "john" } }))
  end

  def test_nested_extract_nil
    mapping = ApiMapper::AttributeMapping.new("user.age", "age")

    assert_raises(ApiMapper::AttributeMapping::Error) { mapping.extract("user", { "name" => "john" }) }
  end
end
