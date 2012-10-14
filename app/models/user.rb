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
    create( GitHubUser::attributes_for(login) )
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
  end
end
