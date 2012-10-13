class Event
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
    # we are able to rich 300 event from gh
    # default per_page = 30
    # so 
    events = []
    
    (1..10).times do |i|
      events + by_user(login,i)
    end

    events

  end
end
