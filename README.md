# Redshift::Client [![Build Status](https://travis-ci.org/dakatsuka/redshift-client.svg)](https://travis-ci.org/dakatsuka/redshift-client) [![Gem Version](https://badge.fury.io/rb/redshift-client.svg)](https://badge.fury.io/rb/redshift-client)

This gem provides a way to connect to AWS Redshift using the [ruby-pg](https://github.com/ged/ruby-pg).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redshift-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install redshift-client

## Usage

### Using with your application

```ruby
require 'rubygems'
require 'redshift/client'
```

After that you configure the url of Redshift:

```
$ export REDSHIFT_URL="redshift://user:password@*****.region.redshift.amazonaws.com:5439/dbname"
```

Please refer to the following code:

```ruby
Redshift::Client.establish_connection

Redshift::Client.connection # instance of PG::Connection
Redshift::Client.connection.exec("SELECT GETDATE()").first
# => {"getdate"=>"2015-10-08 05:17:40"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dakatsuka/redshift-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

