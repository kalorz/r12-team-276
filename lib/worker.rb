require 'mongoid'
require 'octokit'
require_relative '../app/models/user'
require_relative '../app/models/repo'
require_relative '../app/models/task'
require_relative 'tasks'

def perform_task
  Task::pop.tap do |task|
    return false unless task
    case task['type']
    when 'new_user'
      Tasks::NewUser(task['payload']['username'])
    when 'update_user' # TODO
      Tasks::UpdateUser(task['payload']['username'])
    when 'check_pull_request' # TODO
      Tasks::CheckPullRequest(task['payload'])
    end
  end
end

Mongoid.load!('config/mongoid.yml')

while true
  print '.'
  sleep(1) unless perform_task
end
