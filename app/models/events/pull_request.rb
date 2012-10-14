module Events
  class PullRequest
    attr_accessor :created_at

    def initialize(event_data)
      payload = {repo: event_data.repo.name,
                 number: event_data.payload.number,
                 timeout: 86400}
      Task::add_to_queue('check_pull_request', payload) if ['opened', 'reopened'].include? event_data.payload.action
      @created_at = event_data.created_at
    end

    def rank
      1
    end
  end
end
