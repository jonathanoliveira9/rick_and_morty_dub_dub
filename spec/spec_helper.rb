# frozen_string_literal: true


require 'bundler/setup'
require 'webmock'
require 'vcr'
require 'pry'
require 'pry-remote'
require 'byebug'
require 'simplecov'
require 'faraday'

SimpleCov.minimum_coverage 100
SimpleCov.use_merging false
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.coverage_dir 'coverage'
SimpleCov.add_filter '/spec/'
SimpleCov.add_filter '/lib/rick_and_morty_dub_dub/version.rb'
SimpleCov.start 'rails'

require "rick_and_morty_dub_dub"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  c.default_cassette_options = { match_requests_on: %i[method uri path body headers] }
  # c.debug_logger = $stderr
  # your HTTP request service.
  c.hook_into :faraday
  c.configure_rspec_metadata!
  c.before_http_request do |request|
    if request.uri == 'http://fake.url'
      raise SocketError.new('Failed to open TCP connection to fake.url 80 (getaddrinfo: Name or service not know)')
    end
  end
end

# Load support files
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.{rb,yml}').to_s].each { |path| require path }
Dir[File.join(File.dirname(__FILE__), 'factories', '**', '*_factory.rb').to_s].each { |path| require path }
