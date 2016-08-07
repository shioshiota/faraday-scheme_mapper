require "faraday"

module Faraday
  class SchemeMapper < Faraday::Middleware
    SUPPORTED_SCHEMES = [:http, :https].freeze
    def initialize(app, mapping)
      super(app)
      raise 'mapping should be HASH!' unless mapping.is_a? Hash
      unless mapping.keys.all? { |v| SUPPORTED_SCHEMES.member? v }
        raise 'supported schemes are only http and https!'
      end
      @mapping = mapping
    end

    def call(env)
      original_url = env.url
      new_scheme = matched_scheme(original_url.path) || original_url.scheme
      env.url = rebuild_url(original_url, new_scheme)
      @app.call env
    end

    private

    def matched_scheme(path)
      matched_mapping = @mapping.select do |_, patterns|
        patterns.any? { |p| p === path }
      end
      schemes = matched_mapping.keys
      return nil if schemes.count.zero?
      return schemes.first.to_s if schemes.count == 1
      STDERR.puts "[Faraday::SchemeMapper] not unique matched. path: #{path}"
      :https.to_s
    end

    def rebuild_url(url, scheme)
      params = {
        scheme: scheme,
        userinfo: url.userinfo,
        host: url.host,
        path: url.path,
        opaque: url.opaque,
        query: url.query,
        fragment: url.fragment
      }
      return URI::HTTP.build(params) if scheme == 'http'
      return URI::HTTPS.build(params) if scheme == 'https'
      raise 'unknown scheme'
    end
  end
end
Faraday::Request.register_middleware scheme_mapper: -> { Faraday::SchemeMapper }
