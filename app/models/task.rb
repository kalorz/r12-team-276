class Task
  include Mongoid::Document

  field :type, type: String
  field :payload, type: Hash
  field :execute_at, type: DateTime

  index execute_at: 1

  # Get newest task to perform, if it's timestamp is bigger than now().
  def self.get_latest
    {
      'type' => 'new_user',
      'payload' => {
        'username' => 'samuil'
      }
    }
  end

  # Add a task to schedule, with a given timestamp.
  def self.schedule(date, task)
  end
end
