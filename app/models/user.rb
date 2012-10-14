class User
  include Mongoid::Document

  field :uid, type: String
  field :login, type: String
  field :score, type: Integer
  field :avatar_url, type: String
  field :github_url, type: String

end
