module Tasks
  class CheckPullRequest
    def initialize(payload)
      @payload = payload
      @pull_request = Octokit.pull_request(payload['repo'], payload['number'])
      @user = User.find_by(@pull_request.user.login)
    end

    def perform
      if merged?
        @user.update(score: new_score)
      else
        @payload['timeout'] = @payload['timeout'] * 2
        Task.add_to_queue('check_pull_request', @payload, Time.now() + @payload['timeout'])
      end
    end

    def new_score
      Repo.lookup(@pull_request.base.repo.full_name).rank * @pull_request.commits + @user.score
    end

    def merged?
      @pull_request.merged
    end
  end
end
