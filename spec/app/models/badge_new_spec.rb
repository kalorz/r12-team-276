require 'spec_helper'

describe Badge do

  let(:user) {
    User.new login:'me'
  }
  
  it ' raises ZeroDivisionError ' do
    expect {
      Badge.new(user).level_percentage
    }.to_not raise_error(ZeroDivisionError)
  end

  
end
