module Events
  class PullRequest
    def initialize(event_data)
      payload = {repo: event_data.repo.name,
                 number: event_data.payload.number,
                 timeout: 86400}
      Task::add_to_queue('check_pull_request', payload)
    end

    def rank
      1
    end
  end
end
