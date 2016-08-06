$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'faraday/scheme_mapper'

BASE_URL = 'http://example.com'.freeze
SSL_BASE_URL = 'https://example.com'.freeze

def create_connection(mapping)
  Faraday.new(url: BASE_URL) do |conn|
    conn.request :scheme_mapper, mapping
    conn.adapter Faraday.default_adapter
  end
end
