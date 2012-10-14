class Repo
  include Mongoid::Document

  field :fullname, type: String
  field :watchers, type: Integer
  field :forks, type: Integer

  def self.lookup(fullname)
    find_or_yield(fullname) do
      new.tap do |new_repo|
        Octokit.repo(fullname).tap do |response|
          new_repo.fullname = fullname
          new_repo.watchers = response.watchers
          new_repo.forks = response.forks
        end
        new_repo.save
      end
    end
  end

  def self.find_or_yield(fullname)
    where(fullname: fullname).first or yield
  end

  def initialize
  end

  def rank
    watchers * forks
  end
end

