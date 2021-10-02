#bundle exec rspec spec/system/task_spec.rb
require 'rails_helper'
RSpec.describe 'Task management function', type: :system do

  # before do
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end

  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
         # Create a task for use in testing
         date = DateTime.now.to_date
         task = FactoryBot.create(:task, task_name: 'task', task_details: 'welcome to testing world', deadline: date)
         #Transition to task list page
         visit tasks_path
         # The text "task" appears on the visited (transitioned) page (task list page)
         # expect (confirm/expect) that have_content is included (is included)
         expect(page).to have_content 'testing world'
         expect(page).to have_content date
         # The result of expect is true Then test successful, false If so, the result is output as a failure
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        visit new_task_path
        fill_in 'task[task_name]', with: "Learning RoR"
        fill_in 'task[task_details]', with: "We are on rails"
        click_on 'Create Task'
        expect(page).to have_content 'on rails'
      end
    end
  end
  
  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the relevant task is displayed' do
          task = FactoryBot.create(:task, task_name: 'task', task_details: 'some content')
          visit task_path(task.id)
          expect(page).to have_content 'some content'
       end
     end
  end

  context 'When tasks are arranged in descending order of creation date and time' do
    it 'New task is displayed at the top' do
      FactoryBot.create(:task, task_name: 'Test_task1', task_details: 'some details about Test_task1', deadline: Date.new(2021,10,10))
      FactoryBot.create(:task, task_name: 'Test_task2', task_details: 'some details about Test_task2', deadline: Date.new(2021,10,10))
      FactoryBot.create(:task, task_name: 'Must be on top', task_details: 'some details about the task', deadline: Date.new(2021,10,10))
      visit tasks_path
      tasks = all('.task_row')
      expect(tasks[0]).to have_content 'on top'
    end
  end

end