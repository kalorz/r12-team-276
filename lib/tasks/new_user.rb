require_relative '../../app/models/events'
require_relative '../../app/models/task'

module Tasks
  class NewUser
    def initialize(username)
      @username = username
    end

    def perform
      User.find_by(login:@username)
        .update_attributes(latest_event: latest_event, score: initial_score)

      Task.add_to_queue('update_user', {username: @username}, Time.now() + 86400)
    end

    private
    def latest_event
      events.first && events.first.created_at
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
