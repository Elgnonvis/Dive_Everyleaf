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
         task = FactoryBot.create(:task, task_name: 'task', task_details: 'welcome to testing world')
         #Transition to task list page
         visit tasks_path
         # The text "task" appears on the visited (transitioned) page (task list page)
         # expect (confirm/expect) that have_content is included (is included)
         expect(page).to have_content 'testing world'
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

end