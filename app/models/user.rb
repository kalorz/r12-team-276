class User
  include Mongoid::Document

  field :login, type: String
end
