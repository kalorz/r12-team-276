require 'spec_helper'

describe Badge do

  subject {
    Badge.new(user)
  }

  let(:user) {
    User.new login:'me'
  }
  
  it ' raises ZeroDivisionError ' do
    expect {
      subject.level_percentage
    }.to_not raise_error(ZeroDivisionError)
  end

  it ' should find correct upper level boundary in cornercase ' do
    subject.next_level_boundary(0).should == 100
  end

  it ' should find correct lower level boundary in cornercase ' do
    subject.prev_level_boundary(0).should == 0
  end

  it ' should find correct upper level boundary between levels' do
    subject.next_level_boundary(100).should == 300
  end

  it ' should find correct lower level boundary between levels ' do
    subject.prev_level_boundary(100).should == 100
  end

  it ' should find correct upper level boundary ' do
    subject.next_level_boundary(7).should == 100
  end

  it ' should find correct lower first level boundary ' do
    subject.prev_level_boundary(7).should == 0
  end

  it ' should find correct lower second level boundary ' do
    subject.prev_level_boundary(150).should == 100
  end
  
end
