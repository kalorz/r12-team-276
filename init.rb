ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

# Helper method for file references.
#
# @param args [Array] Path components relative to ROOT_DIR.
# @example Referencing a file in config called settings.yml:
#   root_path("config", "settings.yml")
def root_path(*args)
  File.join(ROOT_DIR, *args)
end

require 'bundler/setup'
Bundler::require(:default)

Mongoid.load! root_path('config', 'mongoid.yml')

class Main < Sinatra::Base
  register Sinatra::ConfigFile
  register Sinatra::RespondWith

  config_file root_path('config', 'settings.yml')

  set :root,     root_path
  set :app_file, __FILE__
  set :run,      Proc.new { $0 == app_file }
  set :static,   true
  set :views,    root_path('app', 'views')

end

Dir[root_path('app/**/*.rb')].each do |file|
  require file
end

Main.run! if Main.run?

