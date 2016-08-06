require 'spec_helper'
require 'webmock/rspec'

describe Faraday::SchemeMapper do
  before do
    stub_request(:get, "#{BASE_URL}/").to_return(body: 'HTTP')
    stub_request(:get, "#{BASE_URL}/login").to_return(body: 'HTTP')
    stub_request(:get, "#{BASE_URL}/login/hoge").to_return(body: 'HTTP')
    stub_request(:get, "#{BASE_URL}/secure/hoge").to_return(body: 'HTTP')
    stub_request(:get, "#{SSL_BASE_URL}/").to_return(body: 'HTTPS')
    stub_request(:get, "#{SSL_BASE_URL}/login").to_return(body: 'HTTPS')
    stub_request(:get, "#{SSL_BASE_URL}/login/hoge").to_return(body: 'HTTPS')
    stub_request(:get, "#{SSL_BASE_URL}/secure/hoge").to_return(body: 'HTTPS')
  end
  it 'supports empty mapping' do
    mapping = {}
    connection = create_connection(mapping)
    expect(connection.get('/').body).to eq('HTTP')
  end

  it 'supports mapping specified by string' do
    mapping = { http: ['/'], https: ['/login'] }
    connection = create_connection(mapping)
    expect(connection.get('/').body).to eq('HTTP')
    expect(connection.get('/login').body).to eq('HTTPS')
    expect(connection.get('/login/hoge').body).to eq('HTTP')
  end

  it 'supports mapping specified by regex' do
    mapping = { http: ['/'], https: [%r{\A/login.*\Z}] }
    connection = create_connection(mapping)
    expect(connection.get('/').body).to eq('HTTP')
    expect(connection.get('/login').body).to eq('HTTPS')
    expect(connection.get('/login/hoge').body).to eq('HTTPS')
  end

  it 'supports mapping specified by regex and string in same time' do
    mapping = { http: ['/'], https: ['/login', %r{\A/secure/.*}] }
    connection = create_connection(mapping)
    expect(connection.get('/').body).to eq('HTTP')
    expect(connection.get('/login/hoge').body).to eq('HTTP')
    expect(connection.get('/login').body).to eq('HTTPS')
    expect(connection.get('/secure/hoge').body).to eq('HTTPS')
  end
end
