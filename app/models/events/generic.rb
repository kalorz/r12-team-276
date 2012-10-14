module Events
  class Generic
    # Do we really need events to be kept in mongo?
    include Mongoid::Document

    field :type, type: String
    field :payload, type: Hash
    field :public, type: Boolean
    field :repo, type: Hash

    field :action, type: Hash # it's an user
    field :id


    def initialize(attributes)
    end

    def rank
      1
    end
  end
end
