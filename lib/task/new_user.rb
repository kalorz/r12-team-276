require_relative '../event'

module Task
  class NewUser
    def initialize(username)
      @username = username
    end

    def perform
      { login: @username }.tap do |user_doc|
        user_doc[:score] = initial_score
        User.create(user_doc)
      end
    end

    def initial_score
      1.upto(2).
        flat_map { |n| Octokit.user_events(@username, page: n) }.
        reduce(0) { |score, event|
          score + Event(event).rank
        }
    end
  end
end

def Task::NewUser(username)
  Task::NewUser.new(username).perform
end
