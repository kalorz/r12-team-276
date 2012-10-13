require 'spec_helper'

describe Signature::User do
  subject {
    described_class.create(login: "godotow")
  }
  
  its(:login) { should_not be_nil }
end
