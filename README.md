# Faraday::SchemeMapper

Faraday middleware to manage mapping schemes(https,http) to each endpoint.

This gem is a Faraday middleware that manages mapping schemes(https,http) to each endpoints. You can switch http/https more easily.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-scheme_mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday-scheme_mapper

## Usage

``` rb
require 'faraday/scheme_mapper'

mapping = { http: ['/'], https: ['/login', %r{\A/secure/.*}] }

connection = Faraday.new 'http://example.com/api' do |conn|
  conn.request :scheme_mapper, mapping
  conn.adapter Faraday.default_adapter
end

# request by http
connection.get('/')
connection.get('/login/hoge')

# request by https
connection.get('/login')
connection.get('/secure/hoge')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shioshiota/faraday-scheme\_mapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

