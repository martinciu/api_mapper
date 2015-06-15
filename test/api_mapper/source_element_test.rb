module ApiMapper
  class SourceElementTest < Minitest::Test
    def test_element_at
      assert_equal "qux", source_element.element_at(ApiMapper::IndexPath.new("abc.foo.bar.baz"))
    end

    private

    def source_element
      ApiMapper::SourceElement.new("abc", hash)
    end

    def hash
      {
        "foo" =>  {
          "bar" =>  {
            "baz" =>  "qux"
          },
          "ble" =>  {
            "bla" =>  "bla"
          }
        },
        "nofoo" =>  {
          "bar" =>  "baz"
        }
      }
    end
  end
end