class Task
  include Mongoid::Document

  field :type, type: String
  field :payload, type: Hash
  field :execute_at, type: DateTime

  index execute_at: 1

  # Get newest task to perform, if it's timestamp is bigger than now().
  def self.pop
    task = Task.where(:execute_at => {"$lte" => Time.now}).order_by(execute_at: 1).first

    return nil unless task

    new_task = Task.new(task.attributes)
    task.destroy
    new_task
  end

  def self.add_to_queue(type, payload, execute_at = Time.now)
    create(type: type, payload: payload, execute_at: execute_at)
  end
end
