require 'spec_helper'

describe Main do
  include Rack::Test::Methods

  def app
    Main
  end

  it 'just #works ' do
    get '/'
    last_response.status.should == 200
  end

  describe ' GET /users ' do
    it ' returns success ' do
      User.should_receive(:all).and_return([])
      get "/_users"
      last_response.should be_ok
    end
  end

  describe ' signatures ' do
    it 'renders default user signature' do
      get '/login.png'

      last_response.should be_ok
    end

    it 'renders big user signature' do
      get '/login/big.png'

      last_response.should be_ok
    end
  end
end
