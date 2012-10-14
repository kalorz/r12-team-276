Events = Module.new

require_relative './events/generic'
require_relative './events/push'
#
# Event factory, that creates event based on it's type.
module Event
  def self.events_for(username)
    1.upto(10).
      flat_map { |n| Octokit.user_events(@username, page: n) }.
      map { |e| Event(e) }
  end
end

def Event(event_data)
  case event_data['type']
  when 'PushEvent'
    Events::Push.new(event_data)
  else
    Events::Generic.new(event_data)
  end
end

