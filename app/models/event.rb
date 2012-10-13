class Event
  include Mongoid::Document

  field :type, type: String
  field :payload, type: Hash
  field :public, type: Boolean
  field :repo, type: Hash

  field :action, type: Hash # it's an user
  field :id  
end
