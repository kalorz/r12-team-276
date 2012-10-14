require 'spec_helper'

describe Task do

  it ' register task ' do
    #Task.should_receive(:create).and_return(true)
    Task::add_to_queue('task-type',{name: 'payload-object'}, Time.now)
  end

  context ' pop taks - find and destroy ' do
    before do
      Task::destroy_all
      
      Task::add_to_queue('1',{name: 'payload-object'}, Time.now-10)
      Task::add_to_queue('2',{name: 'payload-object'}, Time.now+100)
    end

    it ' remove task from db ' do
      expect {
        Task::pop
      }.to change(Task,:count).from(2).to(1)
    end

    it ' returns task ' do
      Task::pop.tap do |task|
        task.type.should == "1"
        task.payload.should == {"name" => 'payload-object'}
        task.execute_at.should be_instance_of DateTime
        
      end
    end

    it ' returns newest task ' do
      Task::pop.type.should == "1"
      Task::pop.should_not be
    end

  end
end
