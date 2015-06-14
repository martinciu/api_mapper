require 'test_helper'

module ApiMapper
  class RelationshipMappingTest < Minitest::Test

    class Address
      include Lift
      include Equalizer.new(:street, :city)

      attr_accessor :street, :city
    end

    def test_relationship
      mapping = ApiMapper::RelationshipMapping.new("myAddress", "address", address_mapping)

      assert_equal Address.new(street: "Gran Via", city: "Barcelona"), mapping.extract("myAddress", original)
    end

    def test_relationship_not_found
      mapping = ApiMapper::RelationshipMapping.new("myAddress", "address", address_mapping)

      assert_equal nil, mapping.extract("address", original)
    end

    def test_relationship_key_not_found
      mapping = ApiMapper::RelationshipMapping.new("myAddress.home", "address", address_mapping)

      assert_raises(ApiMapper::RelationshipMapping::Error) { mapping.extract("myAddress", original) }
    end

    private

    def address_mapping
      address_mapping = ApiMapper::ObjectMapping.new Address
      address_mapping.add_mapping(ApiMapper::AttributeMapping.new("street"))
      address_mapping.add_mapping(ApiMapper::AttributeMapping.new("town", "city"))
      address_mapping
    end

    def original
      { "street" => "Gran Via", "town" => "Barcelona" }
    end
  end
end