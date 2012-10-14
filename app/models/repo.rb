class Repo
  include Mongoid::Document

  field :fullname, type: String
  field :watchers, type: Integer, default: 0
  field :forks, type: Integer, default: 0

  def self.lookup(fullname)
    find_or_yield(fullname) do
      Repo.create(fetch_repo_attrs(fullname))
    end
  end

  def self.find_or_yield(fullname)
    where(fullname: fullname).first or yield
  end

  def self.fetch_repo_attrs(fullname)
    Octokit.repo(fullname).slice(:watchers,:forks).tap do |attr|
      attr[:fullname] = fullname
    end
  rescue Octokit::NotFound
    Repo.new(fullname: fullname).attributes
  end

  def rank
    Math::log((watchers + 1) * (forks + 1)).to_i
  end
end

