require 'test_helper'

class ApiRelationshipMappingTest < Minitest::Test

  class Address
    include Lift
    include Equalizer.new(:street, :city)

    attr_accessor :street, :city
  end

  def test_relationship
    address_mapping = ApiMapper::ObjectMapping.new Address
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("street"))
    address_mapping.add_mapping(ApiMapper::AttributeMapping.new("town", "city"))

    mapping = ApiMapper::RelationshipMapping.new("myAddress", "address", address_mapping)

    assert_equal Address.new(street: "Gran Via", city: "Barcelona"), mapping.extract("myAddress", original)
  end

  private

  def original
    { "street" => "Gran Via", "town" => "Barcelona" }
  end
end
