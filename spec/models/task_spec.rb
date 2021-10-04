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
    # Step 3 tests
    describe 'Search function' do
      # You can change the contents of the test data as needed.
      let!(:task) { FactoryBot.create(:task, task_name: 'task', task_details: 'some content', priority: 'Low', status: 'In progress', deadline: Date.new(2021,10,11)) }
      let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample", priority: 'High', status: 'Completed', deadline: Date.new(2021,10,10)) }
      context 'Title is performed by scope method' do
        it "Tasks containing search keywords are narrowed down" do
          # title_seach is a Title search method presented by scope. The method name can be arbitrary.
          expect(Task.task_name_search('task')).to include(task)
          expect(Task.task_name_search('task')).not_to include(second_task)
          expect(Task.task_name_search('task').count).to eq 1
        end
      end
      context 'When the status is searched with the scope method' do
        it "Tasks that exactly match the status are narrowed down" do
          expect(Task.status_search('In progress')).to include(task)
          expect(Task.status_search('In progress')).not_to include(second_task)
          expect(Task.status_search('In progress').count).to eq 1
        end
      end
      context 'When performing fuzzy search and status search Title' do
        it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
          # Write content here
          expect(Task.task_name_search('task').status_search('In progress')).to include(task)
          expect(Task.task_name_search('task').status_search('In progress')).not_to include(second_task)
          expect(Task.task_name_search('task').status_search('In progress').count).to eq 1
          # expect(Task.task_name_status_search('task','In progress')).to include(task)
          # expect(Task.task_name_status_search('task','In progress')).not_to include(second_task)
          # expect(Task.task_name_status_search('task','In progress').count).to eq 1
        end
      end
    end
  end
end









# describe "Pagination function" do
#   before do
#     200.times do |n|
#       FactoryBot.create(:second_task, name: "sample")
#     end 
#   end
  
#   context "Verify the gem kaminari" do
#     it "is 200 task page per 25" do
#       expect(Task.count).to eq 200
#       expect(Task.page(5).next_page).to eq 6
#     end
#   end
# end
