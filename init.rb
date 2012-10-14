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

require 'securerandom'
require './lib/core_ext'

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
  set :sessions, true

  if development?
    # Needed for shotgun, see http://stackoverflow.com/questions/5631862/sinatra-and-session-variables-which-are-not-being-set
    set :session_secret, '652af8389d1f5a20b07adf093e1261360da0741e7022e444560dbc73b9a715333008740487cfc6502c018a1416b1d93bd79118f44c3974fcbc62bc74f014edd5'
  end

  use OmniAuth::Builder do
    provider :github, Main.settings.github['client_id'], Main.settings.github['client_secret'],
             provider_ignores_state: true, scope: 'public', path_prefix: '/_/auth', callback_path: '/_/auth/callback'
  end

end

Dir[root_path('app/**/*.rb')].each do |file|
  require file
end

Main.run! if Main.run?
