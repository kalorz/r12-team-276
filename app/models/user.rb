class User
  include Mongoid::Document

  field :uid, type: String
  field :login, type: String
  field :score, type: Integer, default: 0
  field :avatar_url, type: String
  field :github_url, type: String
  field :latest_event, type: Time

  index({login: 1}, {unique: true})

  def self.get(login)
    find_by(login: login)
  rescue Mongoid::Errors::DocumentNotFound
    attr = GitHubUser::attributes_for(login)
    create(attr) if attr
  end

  #todo use observer
  after_create do |user|
    Task::add_to_queue('new_user', {username: user.login})
  end
  after_save do |user|
    Badge.new(user).render(true, root_path('public', 'system', 'badges', "#{user.login}.png"))
  end
end

module GitHubUser
  def self.attributes_for(login)
    gh_user = Octokit.user(login)

    {
      login: login,
      github_url: gh_user.html_url,
      avatar_url: gh_user.avatar_url
    }
  rescue Octokit::NotFound
    nil
  end
end
