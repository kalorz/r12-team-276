require_relative '../../app/models/events'
require_relative '../../app/models/task'

module Tasks
  class NewUser
    def initialize(username)
      @username = username
    end

    def perform
      { login: @username }.tap do |user_doc|
        user_doc[:score] = initial_score
        user_doc[:latest_event] = events.first.created_at
        puts 'About to create user'
        User.create(user_doc)
      end

      Task.add_to_queue('update_user', {username: @username}, Time.now() + 86400)
    end

    def initial_score
      events.reduce(0) { |score, event| score + event.rank }
    end

    def events
      @events ||= Events::for(@username)
    end
  end
end

def Tasks::NewUser(username)
  Tasks::NewUser.new(username).perform
end
