require_relative '../event'

module Tasks
  class NewUser
    def initialize(username)
      @username = username
    end

    def perform
      { login: @username }.tap do |user_doc|
        user_doc[:score] = initial_score
        User.create(user_doc)
      end

      Task.schedule(,type: 'update_user')
    end

    def initial_score
      events.reduce(0) { |score, event| score + event.rank }
    end

    def events
      @events ||= Event::events_for(@username)
    end
  end
end

def Task::NewUser(username)
  Task::NewUser.new(username).perform
end
