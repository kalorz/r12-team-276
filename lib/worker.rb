require 'mongoid'
require 'octokit'
require_relative '../app/models/user'

class Event
  def initialize(ed)
  end

  def rank
    1
  end
end

class Repo
  def self.find(data)
    new()
  end

  def initialize
  end

  def rank
    5
  end
end

class PushEvent
  def initialize(event_data)
    print 'P'
    @repo = Repo.find(event_data['repo']['name'])
    @commit_count = event_data['payload']['size']
  end

  def rank
    print 'r'
    @repo.rank * @commit_count
  end
end

def Event(event_data)
  print 'E'
  case event_data['type']
  when 'PushEvent'
    PushEvent.new(event_data)
  else
    Event.new(event_data)
  end
end

module Task
  class NewUser
    def initialize(username)
      @username = username
    end

    def perform
      print 'p'
      { login: @username }.tap do |user_doc|
        user_doc[:score] = initial_score
        puts user_doc
        User.create(user_doc)
      end
    end

    def initial_score
      print 'i'
      1.upto(2).
        flat_map { |n| Octokit.user_events(@username, page: n) }.
        reduce(0) { |score, event|
          score + Event(event).rank
        }
    end
  end

end

def Task::NewUser(username)
  print 'N'
  Task::NewUser.new(username).perform
end

def get_task # should pull newest task from mongodb by date
  print 'g'
  {
    type: 'new_user',
    username: 'samuil'
  }
end

def perform_task
  print 'p'
  get_task.tap do |task|
    case task[:type]
    when 'new_user'
      Task::NewUser(task[:username])
    end
  end
end

Mongoid.load!('../config/mongoid.yml')

perform_task
