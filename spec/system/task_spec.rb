#bundle exec rspec spec/system/task_spec.rb
require 'rails_helper'
RSpec.describe 'Task management function', type: :system do

  before(:each) do
    visit new_user_path
    fill_in "Username",	with: "JOHN"
    fill_in "Email",	with: "doe@fil.com"
    fill_in "Password",	with: "password" 
    fill_in "Password confirmation",	with: "password" 
    click_on "Create an account"
    # FactoryBot.create(:task)
    # FactoryBot.create(:second_task)

  end  
  #   # @user=FactoryBot.create(:user, username: 'test', email: 'test@gmail.com', password: '123456789')
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)

 
  # end

  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
         # Create a task for use in testing
        
         visit new_session_path
         fill_in "Email",	with: "doe@fil.com" 
         fill_in "Password",	with: "password" 
         click_on("Sign in")

         date = DateTime.now.to_date
         task = FactoryBot.create(:task, task_name: 'task', task_details: 'welcome to testing world', status: 'Completed', deadline: date)
         #Transition to task list page
         visit tasks_path
         # The text "task" appears on the visited (transitioned) page (task list page)
         # expect (confirm/expect) that have_content is included (is included)
         expect(page).to have_content 'testing world'
         expect(page).to have_content 'Completed'
         expect(page).to have_content date
         # The result of expect is true Then test successful, false If so, the result is output as a failure
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do

        visit new_session_path
        fill_in "Email",	with: "doe@fil.com" 
        fill_in "Password",	with: "password" 
        click_on("Sign in")

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
          visit new_session_path
          fill_in "Email",	with: "doe@fil.com" 
          fill_in "Password",	with: "password" 
          click_on("Sign in")
          task = FactoryBot.create(:task, task_name: 'task', task_details: 'some content')
          visit task_path(task.id)
          expect(page).to have_content 'some content'
       end
     end
  end

  context 'When tasks are arranged in descending order of creation date and time' do
    it 'New task is displayed at the top' do
      visit new_session_path
      fill_in "Email",	with: "doe@fil.com" 
      fill_in "Password",	with: "password" 
      click_on("Sign in")
      FactoryBot.create(:task, task_name: 'Test_task1', task_details: 'some details about Test_task1', priority: 'High', deadline: Date.new(2021,10,10))
      FactoryBot.create(:task, task_name: 'Test_task2', task_details: 'some details about Test_task2', priority: 'Medium', deadline: Date.new(2021,10,10))
      FactoryBot.create(:task, task_name: 'Must be on top', task_details: 'some details about the task', priority: 'Low', deadline: Date.new(2021,10,10))
      visit tasks_path
      tasks = all('.task_row')
      expect(tasks[0]).to have_content 'on top'
    end
  end

   #Les tests de l'??tape 3
   describe 'Search function' do
    
    context 'If you do a fuzzy search by Name' do
      it "Filter by tasks that include search keywords" do
        visit new_session_path
        fill_in "Email",	with: "doe@fil.com" 
        fill_in "Password",	with: "password" 
        click_on("Sign in")
        visit tasks_path
        fill_in 'Task name' , with: 'Task'
        click_on 'Search'
        tasks = all('.task_row')
        expect(tasks[0]).to have_content 'Task'
      end
    end
    context 'When you search for status' do
      it "Tasks that exactly match the status are narrowed down" do
        visit new_session_path
        fill_in "Email",	with: "doe@fil.com" 
        fill_in "Password",	with: "password" 
        click_on("Sign in")
        visit tasks_path
        select 'In progress', from: 'Status'
        click_on 'Search'
        tasks = all('.task_status')
        tasks.each do |task|
        expect(task).to have_content 'In progress'
        end
      end
    end
    context 'Name performing fuzzy search of name and status search' do
      it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
        visit new_session_path
        fill_in "Email",	with: "doe@fil.com" 
        fill_in "Password",	with: "password" 
        click_on("Sign in")
        visit tasks_path
        fill_in 'Task name' , with: 'Task'
        select 'In progress', from: 'Status'
        click_on 'Search'
        expect(page).to have_content 'Task'
        expect(page).to have_content 'In progress'
      end
    end
  end
  

end