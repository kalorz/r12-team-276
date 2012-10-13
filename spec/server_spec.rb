require 'spec_helper'

describe Signature::Server do
  include Rack::Test::Methods

  def app
    Signature::Server
  end

  it 'just #works ' do
    get '/'
    puts last_response.inspect

    last_response.status.should == 200
  end


  describe ' GET /users ' do
    it ' returns success ' do
      get "/_users"
      last_response.should be_ok
    end
  end
end
