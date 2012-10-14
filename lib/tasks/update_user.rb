require_relative '../../app/models/events'

module Tasks
  class UpdateUser
    def initialize(username)
      @user = User.find_by(login: username)
    end

    def perform
      @user.update_attributes(score: new_score)
      Task.add_to_queue('update_user', {username: @username}, Time.now() + 86400)
    end

    def new_score
      events.reduce(@user.score) { |score, event| score + event.rank }
    end

    def events
      @events ||= Events::for(@user.login, newer_than: @user.latest_event)
    end
  end
end

def Tasks::UpdateUser(username)
  Tasks::UpdateUser.new(username).perform
end

