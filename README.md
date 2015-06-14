# ApiMapper

[![Build Status](https://travis-ci.org/martinciu/api_mapper.svg?branch=master)](https://travis-ci.org/martinciu/api_mapper)
[![Code Climate](https://codeclimate.com/github/martinciu/api_mapper/badges/gpa.svg)](https://codeclimate.com/github/martinciu/api_mapper)

ApiMapper converts API resources into ruby objects

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_mapper

## Usage

```ruby

module Moves
  class Profile
    include Virtus.model

    attribute :id, String
    attribute :platform, String
  end
end

object_manager = ApiMapper::ObjectManager.new('https://api.moves-app.com/api/1.1/')
object_managet.authorize_with_bearer(ACCESS_TOKEN)

profile_mapping = ApiMapper::ObjectMapping.new(Moves::Profile)
profile_mapping.add_mapping(ApiMapper::AttributeMapping.new("userId", "id"))
profile_mapping.add_mapping(ApiMapper::AttributeMapping.new("profile.platform", "platform"))

response_descriptor = ApiMapper::ResponseDescriptor.new("user/profile", :get, profile_mapping, [200])

object_manager.add_response_descriptor response_descriptor

object_manager.get('user/profile')

# #<ApiMapper::Collection:0x007f92f2bff1d0 @collection=[#<Moves::Profile:0x007f92f2bfce80 @id="19893780817643993", @platform="ios">]>

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/api_mapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

