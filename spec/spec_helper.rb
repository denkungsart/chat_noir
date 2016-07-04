$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'chat_noir'
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.default_cassette_options = {
    match_requests_on: [:uri, :path],
    record: :new_episodes
  }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
