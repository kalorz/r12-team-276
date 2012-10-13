require 'spec_helper'

describe User do
  subject {
    described_class.new(login: 'godotow')
  }

  its(:login) { should_not be_nil }
end
