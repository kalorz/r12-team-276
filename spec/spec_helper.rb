require './init'
require 'rack/test'
require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
  config.extend VCR::RSpec::Macros
end

VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                  :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end
