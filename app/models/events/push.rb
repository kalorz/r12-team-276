module Events
  class Push
    def initialize(event_data)
      @repo = Repo.lookup(event_data['repo']['name'])
      @commit_count = event_data['payload']['size']
    end

    def rank
      @repo.rank * @commit_count
    end
  end
end
