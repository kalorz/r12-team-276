require_relative '../../app/models/events'

module Tasks
  class UpdateUser
    def initialize(username)
      @user = User.find_by(username: username)
    end

    def perform
      @user.update_attributes(score: new_score)
      Task.schedule(execute_at: Time.now() + 86400,
                    type: 'update_user',
                    payload: {username: @user.login})
    end

    def new_score
      events.reduce(@user.score) { |score, event| score + event.rank }
    end

    def events
      @events ||= Event::events_for(@user.login, newer_than: @user.latest_event)
    end
  end
end

def Task::NewUser(username)
  Task::NewUser.new(username).perform
end

