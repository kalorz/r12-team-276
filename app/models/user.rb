class User
  include Mongoid::Document

  field :login, type: String
  field :score, type: Integer
end
