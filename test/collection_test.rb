require 'test_helper'

class ApiCollectionTest < Minitest::Test

  def mappings
    mappings = ApiMapper::Collection.new
    mappings.add id_mapping
    mappings.add name_mapping
    mappings
  end

  def id_mapping
    ApiMapper::AttributeMapping.new("id")
  end

  def name_mapping
    ApiMapper::AttributeMapping.new("myName", "name")
  end

  def test_find_for_implicit
    assert_equal id_mapping.to, mappings.match("id").first.to
  end

  def test_find_for_explicit
    assert name_mapping.to, mappings.match("myName").first.to
  end

end