class Generic
  # Do we really need events to be kept in mongo?
  include Mongoid::Document

  field :type, type: String
  field :payload, type: Hash
  field :public, type: Boolean
  field :repo, type: Hash

  field :action, type: Hash # it's an user
  field :id


  def self.by_user(login, page = 1)
    src = Octokit.user_events(login, :page => page)

    src.map do |event_attributes|
      Event.new(event_attributes)
    end
  end

  def self.all_by_user(login)
    [].tap do |events|
      10.times do |i|
        events << Event::by_user(login,i+1)
      end
    end.flatten
  end

  def initialize(ed)
  end

  def rank
    1
  end
end
