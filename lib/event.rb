require_relative 'push_event'

def Event(event_data)
  case event_data['type']
  when 'PushEvent'
    PushEvent.new(event_data)
  else
    Event.new(event_data)
  end
end

