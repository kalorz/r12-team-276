require 'spec_helper'

describe Event do
  use_vcr_cassette :events

  it ' connects to github and fetches some crappy data ' do
    response = Event.by_user('godot', 1)

    response.first.should be_instance_of Event
  end

  it ' connects to github and fetches 300 records ' do
    response = Event.all_by_user('godot')
    response.size.should <= 300
  end

  it ' connects to github and fetches 300 records ' do
    response = Event.all_by_user('tomas-stefano')
    response.size.should <= 300
  end

end
