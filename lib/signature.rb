ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler::require(:default)

Mongoid.load!("./config/mongoid.yml")

require_relative 'server'
require_relative 'user'

