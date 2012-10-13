require 'spec_helper'

describe Signature::Server do
  include Rack::Test::Methods

  def app
    described_class
  end

  it 'just works ' do
    get '/'
    last_response.should be_ok
  end
end
