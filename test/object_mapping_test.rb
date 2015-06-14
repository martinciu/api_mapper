require 'test_helper'

class ApiObjectMappingTest < Minitest::Test

  class Address
    include Lift
    include Equalizer.new(:street, :city)

    attr_accessor :street, :city
  end


  def test_simple
    mapping = ApiMapper::ObjectMapping.new Address
    mapping.add_mapping(ApiMapper::AttributeMapping.new("id"))
    mapping.add_mapping(ApiMapper::AttributeMapping.new("email"))
    mapping.add_mapping(ApiMapper::AttributeMapping.new("firstName", "first_name"))

    assert_equal({ "id" => 123, "email" => "john@example.com", "first_name" => "John" }, mapping.extract(original))
  end

  def test_path
    mapping = ApiMapper::ObjectMapping.new Address
    mapping.add_mapping(ApiMapper::AttributeMapping.new("id"))
    mapping.add_mapping(ApiMapper::AttributeMapping.new("myAddress.home.street"))
    mapping.add_mapping(ApiMapper::AttributeMapping.new("myAddress.home.city", "town"))

    assert_equal({ "id" => 123, "town" => "Barcelona", "street" => "Gran Via" }, mapping.extract(original))
  end

  def test_relations
    address_mapping = ApiMapper::ObjectMapping.new Address
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("street"))
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("city"))

    mapping = ApiMapper::ObjectMapping.new Address
    mapping.add_mapping(ApiMapper::AttributeMapping.new("id"))
    mapping.add_mapping(ApiMapper::RelationshipMapping.new("myAddress.home", "address", address_mapping))

    assert_equal({ "id" => 123, "address" => Address.new(street: "Gran Via", city: "Barcelona")}, mapping.extract(original))
  end

  def test_relation_not_found
    address_mapping = ApiMapper::ObjectMapping.new Address
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("street"))
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("city"))

    mapping = ApiMapper::ObjectMapping.new Address
    mapping.add_mapping(ApiMapper::AttributeMapping.new("id"))
    mapping.add_mapping(ApiMapper::RelationshipMapping.new("address.home", "address", address_mapping))

    assert_equal({ "id" => 123 }, mapping.extract(original))
  end

  private

  def original
    {
      "id" => 123,
      "email" => "john@example.com",
      "firstName" => "John",
      "myAddress" => {
        "home" => {
          "street" => "Gran Via",
          "city" => "Barcelona"
        }
      }
    }
  end

end