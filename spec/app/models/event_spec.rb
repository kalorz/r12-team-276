require 'spec_helper'

describe Events do
  use_vcr_cassette :events

  before do
    Repo.stub! lookup: Repo.new(fullname: "stubbed-repo")
  end

  it ' connects to github and fetches 300 records ' do
    response = Events.for('godot')
    response.size.should <= 300
  end

  it ' connects to github and fetches 300 records ' do
    response = Events.for('tomas-stefano')
    response.size.should <= 300
  end

end
