require 'octokit'

module GitRank
  class << self
    def repo(r)
      #(r.forks + 1) * (r.watchers_count + Octokit.stargazers(r.full_name).count + Octokit.collaborators(r.full_name).count) / 1000.0
      (r.forks + 1) * (r.watchers_count + Octokit.stargazers(r.full_name).count)
    end

    def user(username)
      Octokit.repos(username).reduce(0) do |acc, el|
        acc + repo(el)
      end
    end
  end
end

%w(janl defunkt dhh samuil konieczkow dfens godot karolsarnacki josevalim paneq).each do |name|
  puts("%24s #{GitRank::user(name)}" % name)
end
