require_relative './events/generic'
require_relative './events/push'

# Event factory, that creates event based on it's type.
module Events
  def self.for(username, options = {})
    [].tap do |events|
      1.upto(10) do |page_number|
        events.concat(Octokit.user_events(username, page: page_number))
        if options[:newer_than]
          break if events.last.created_at < options[:newer_than]
        end
      end
      if options[:newer_than]
        events.select! { |e| e.created_at > options[:newer_than] }
      end
      events.map! { |e| Event(e) }
    end
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

