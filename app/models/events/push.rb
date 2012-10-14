class Events::Push
  def initialize(event_data)
    @repo = Repo.find(event_data['repo']['name'])
    @commit_count = event_data['payload']['size']
  end

  def rank
    @repo.rank * @commit_count
  end
end

