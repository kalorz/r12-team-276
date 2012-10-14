class User
  include Mongoid::Document

  field :login, type: String
  field :score, type: Integer
  field :latest_event, type: Time
end
