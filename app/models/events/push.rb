module Events
  class Push
    attr_accessor :created_at

    def initialize(event_data)
      @repo = Repo.lookup(event_data['repo']['name'])
      @commit_count = event_data['payload']['size']
      @created_at = event_data.created_at
    end

    def rank
      @repo.rank * @commit_count
    end
  end
end
