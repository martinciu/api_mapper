require 'rubygems'
require 'bundler/setup'

require 'faraday'
require 'json'
require 'addressable/template'

require "api_mapper/version"

require "api_mapper/collection"
require "api_mapper/index_path"

require "api_mapper/error"
require "api_mapper/source_element"

require "api_mapper/attribute_mapping"
require "api_mapper/relationship_mapping"
require "api_mapper/object_manager"
require "api_mapper/object_mapping"
require "api_mapper/response_descriptor"
require "api_mapper/response_matcher"

require "api_mapper/response"

module ApiMapper
  # Your code goes here...
end
