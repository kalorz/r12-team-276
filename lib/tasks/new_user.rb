require_relative '../../app/models/events'

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

      Task.schedule(execute_at: Time.now() + 86400, type: 'update_user', payload: {username: @username})
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
