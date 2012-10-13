require 'mongoid'
require 'octokit'
require_relative '../app/models/user'
require_relative '../app/models/repo'
require_relative 'task'

def get_task # should pull newest task from mongodb by date
  {
    type: 'new_user',
    username: 'samuil'
  }
end

def perform_task
  get_task.tap do |task|
    case task[:type]
    when 'new_user'
      Task::NewUser(task[:username])
    end
  end
end

Mongoid.load!('config/mongoid.yml')

perform_task
