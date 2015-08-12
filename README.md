# ApiMapper

[![Gem Version](https://badge.fury.io/rb/api_mapper.svg)](http://badge.fury.io/rb/api_mapper)
[![Build Status](https://travis-ci.org/martinciu/api_mapper.svg?branch=master)](https://travis-ci.org/martinciu/api_mapper)
[![Code Climate](https://codeclimate.com/github/martinciu/api_mapper/badges/gpa.svg)](https://codeclimate.com/github/martinciu/api_mapper)
[![Test Coverage](https://codeclimate.com/github/martinciu/api_mapper/badges/coverage.svg)](https://codeclimate.com/github/martinciu/api_mapper/coverage)
[![Dependency Status](https://gemnasium.com/martinciu/api_mapper.svg)](https://gemnasium.com/martinciu/api_mapper)
[![Inline docs](http://inch-ci.org/github/martinciu/api_mapper.svg?branch=master)](http://inch-ci.org/github/martinciu/api_mapper)

ApiMapper converts API resources into ruby objects

## Installation

**Warning: This is work in progress. Public API will probably change** 

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

# Github example

class User
  attr_reader :id, :login
  def initialize(id, login)
    @id, @login = id, login
  end
end

# simple mapper
# Mapper have to provide `call` method that accepts array as an argument
class UserMapper
  def call(origin)
    origin.map { |attributes| User.new(attributes["id"], attributes["login"]) }
  end
end

class Repository
  include Virtus.model
  attribute :id, Integer
  attribute :name
  attribute :full_name
  attribute :owner, User
end

# Example of complex mapper using  faceter gem (https://github.com/nepalez/faceter)
class RepositoriesMapper < Faceter::Mapper
  list do
    symbolize_keys
    create :owner, from: [:owner] do |owner|
      UserMapper.new.call(owner)
    end
    wrap to: :attributes, only: [:id, :name, :full_name, :owner]
    create from: [:attributes] do |attributes|
      Repository.new(attributes)
    end
  end
end

class Router < ApiMapper::Router
  get "user", UserMapper.new
  patch "user", UserMapper.new
  get "repositories", RepositoryMapper.build
end

# client setup
client = ApiMapper::Client.new('https://api.github.com')
client.router = Router.new
client.authorization("token secret_token")

# get profile
profile = client.get('user')
profile.login                 # martinciu
profile.hireable              # false

# update profile
profile.hireable = true
updated_profile = client.patch('user', profile)
updated_profile.hireable = true

# get list of repositories
repositories = client.get('repositories')
repository = repositories.first

repository.id                 # 1
repository.name               # grit
repository.full_name          # mojombo/grit
repository.user.id            # 1
repository.user.login         # mojombo

# Moves app example (complex mapper)

class Profile
  include Virtus.model
  
  attribute :id, Integer
  attribute :created_at, Date
  attribute :locale, String
  attribute :metric, Boolean
end

# {
#    "userId": 23138311640030064,
#    "profile": {
#        "firstDate": "20121211",
#        "currentTimeZone": {
#            "id": "Europe/Helsinki",
#            "offset": 10800
#        },
#        "localization": {
#            "language": "en",
#            "locale": "fi_FI",
#            "firstWeekDay": 2,
#            "metric": true
#        },
#        "caloriesAvailable": true,
#        "platform": "ios"
#    }
# }

# Example of complex mapper using rom-mapper gem (https://github.com/rom-rb/rom-mapper)
class ProfileMapper < ROM::Mapper
  reject_keys true
  attribute :id, from: "userId"
  unwrap "profile" do
    attribute :created_at, from: "firstDate"
    attribute :metric
    attribute :locale
    unwrap "localization" do
      attribute :metric, from: "metric"
      attribute :locale, from: "locale"
    end
  end
  model Profile
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/martinciu/api_mapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

