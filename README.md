# ApiMapper

[![Build Status](https://travis-ci.org/martinciu/api_mapper.svg?branch=master)](https://travis-ci.org/martinciu/api_mapper)
[![Code Climate](https://codeclimate.com/github/martinciu/api_mapper/badges/gpa.svg)](https://codeclimate.com/github/martinciu/api_mapper)
[![Test Coverage](https://codeclimate.com/github/martinciu/api_mapper/badges/coverage.svg)](https://codeclimate.com/github/martinciu/api_mapper/coverage)
[![Dependency Status](https://gemnasium.com/martinciu/api_mapper.svg)](https://gemnasium.com/martinciu/api_mapper)

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
class User
  include Virtus.model
  attribute :id, Integer
  attribute :login
  attribute :hireable, Boolean
end

class Repository
  include Virtus.model
  attribute :id, Integer
  attribute :name
  attribute :full_name
  attribute :owner, User
end

class UserMapper < ApiMapper::Mapper
  attributes :id, :login, :hireable
  entity User
end

class RepositoriesMapper < ApiMapper::ArrayMapper
  attributes :id, :name, :full_name
  relationship :owner, UserMapper
  entity Repository
end

class Router < ApiMapper::Router
  get "user", UserMapper
  patch "user", UserMapper
  get "repositories", RepositoriesMapper
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
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/martinciu]/api_mapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

