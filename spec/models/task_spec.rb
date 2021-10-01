#bundle exec rspec spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'Validation test' do
    context 'If the task Name is empty' do
      it "Task registration must fail" do
        task = Task.new(task_name: '', task_details: 'Failure test')
        expect(task).not_to be_valid
      end
    end
    context 'If the task details are empty' do
      it 'Validation is caught' do
        task = Task.new(task_name: 'rspec', task_details:'')
        task.valid?
        expect(task.errors[:task_details]).to include("can't be blank")
      end
    end
    context 'If the task Title and details are described' do
      it 'Validation passes' do
        task = Task.new(task_name: 'Al right', task_details:'passing registration')
      end
    end
  end
end
