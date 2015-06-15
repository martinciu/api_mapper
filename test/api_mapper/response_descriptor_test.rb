require 'test_helper'

module ApiMapper
  class ResponseDescriptorTest < Minitest::Test
    def test_matching_response
      response = fake_response.new(200, URI('http://api.example.com/user/123'), :get)
      assert response_descriptor.match?(response)
    end

    def test_matching_response_with_base_path
      response = fake_response.new(200, URI('http://api.example.com/v1/user/123'), :get)
      response_descriptor.base_url = URI('http://api.example.com/v1')

      assert response_descriptor.match?(response)
    end

    def test_bad_url
      response = fake_response.new(200, URI('http://api.example.com/profile/123'), :get)
      refute response_descriptor.match?(response)
    end

    def test_bad_status
      response = fake_response.new(404, URI('http://api.example.com/user/123'), :get)
      refute response_descriptor.match?(response)
    end

    def test_bad_method
      response = fake_response.new(200, URI('http://api.example.com/user/123'), :head)
      refute response_descriptor.match?(response)
    end

    private

    def response_descriptor
      @response_descriptor ||= ResponseDescriptor.new("/user/{id}", :get, mapping, [200])
    end

    def mapping
      Object.new
    end

    def fake_response
      Struct.new(:status, :request_url, :request_method)
    end

  end
end