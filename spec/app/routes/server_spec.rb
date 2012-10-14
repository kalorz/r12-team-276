require 'spec_helper'

describe Main do
  include Rack::Test::Methods

  use_vcr_cassette :users

  def app
    Main
  end

  it 'just #works ' do
    get '/?login=godot'
    last_response.status.should == 200
  end

  describe ' signatures ' do
    before do
      User.destroy_all
      Task.destroy_all
    end
    it 'renders default user signature godot.png' do

      get '/godot.png'

      last_response.status.should == 200
      last_response.should be_ok
    end
    it 'renders default user signature /godot' do
      get '/godot'

      last_response.should be_ok
    end
  end
end
