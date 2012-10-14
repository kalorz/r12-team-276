require 'mongoid'
require 'octokit'
require_relative '../app/models/user'
require_relative '../app/models/repo'
require_relative '../app/models/task'
require_relative 'tasks'

def perform_task
  Task::get_latest.tap do |task|
    case task['type']
    when 'new_user'
      Tasks::NewUser(task['payload']['username'])
    when 'update_user' # TODO
    when 'check_pull_request' # TODO
    end
  end
end

Mongoid.load!('config/mongoid.yml')

perform_task
