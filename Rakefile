ENV["RACK_ENV"] ||= 'development'

require "rubygems"
require "bundler"

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require './init'


task :reset do
  puts 'cleanup storage started'
  User.destroy_all
  Task.destroy_all
  Repo.destroy_all
  puts 'collection destroyed.'

  puts 'deleting badges'
  puts 'todo'
end
  
