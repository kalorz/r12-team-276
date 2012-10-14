require 'spec_helper'

describe User do
  subject {
    described_class.new(login: 'godotow')
  }

  its(:login) { should_not be_nil }
end



describe GitHubUser do
  use_vcr_cassette :users
  it 'creates valid user representation in local storage' do
    User.get('godot').should be
  end

  it 'raises error if user does not exist' do
    expect {
      User.get('godotowy').should_not be
    }.to_not raise_error()
  end
end
