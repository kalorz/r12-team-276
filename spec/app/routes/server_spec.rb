require 'spec_helper'

describe Main do
  include Rack::Test::Methods

  def app
    Main
  end

  it 'just #works ' do
    get '/?login=godot'
    last_response.status.should == 200
  end

  describe ' signatures ' do
    it 'renders default user signature' do
      get '/godot.png'

      last_response.status.should == 200
      last_response.should be_ok
    end
    it 'renders default user signature' do
      get '/godot'

      last_response.should be_ok
    end

  end
end
