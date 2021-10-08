#bundle exec rspec spec/system/label_spec.rb
require 'rails_helper'
RSpec.describe 'Label management function', type: :system do
    before(:each) do
        @user=FactoryBot.create(:user, username: 'test',email: 'test@gmail.com',password: '123456789')
        @task = FactoryBot.create(:task)
        @second_task = FactoryBot.create(:second_task)
       
        label=Label.create(name:'A',user_id:nil)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456789'
        click_on'Sign in'
    end

    context 'Create new task' do
        it 'Labels are displayed' do
            visit new_session_path
            expect(page).to have_content 'A'
        end
        it 'create new task and add tag' do 
            visit new_task_path
            fill_in 'task[title]', with: 'new task'
            fill_in 'task[detail]', with: 'new task detail'
            check 'A'
            click_on 'Creer'
            expect(page).to have_content 'new task'
        end
        it 'You can search by label' do
            visit new_task_path
            fill_in 'task[title]', with: 'new task'
            fill_in 'task[detail]', with: 'new task detail'
            check 'A'
            click_on 'Creer'
            visit tasks_path
            select 'A',from: 'search_label'
            click_on 'search'
            expect(page).to have_content 'new task'
        end
    end
end

RSpec.describe 'Label management function', type: :system do
    
  
    describe 'When Creating a task ' do
      context 'We can attach multiple tags' do
        it 'allows to attach multiple tags' do
         user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
          tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
          tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
          task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
             priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
             FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
             FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
          visit tasks_path
          click_on 'Login'
          fill_in 'Email' , with: 'lora@gmail.com'
          fill_in 'Password' , with: '123456'
          click_on 'Se connecter'
  
          visit tasks_path
          click_on 'Task registration'
  
          visit task_path(task.id)
          expect(page).to have_content 'task1'
  
        end
      end
  
      context ' When Output a task details screen' do
        it 'shows the list of labels associated with the task on the screen' do
         user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
          tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
          tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
          task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
             priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
             FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
             FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
          visit tasks_path
          click_on 'Login'
          fill_in 'Email' , with: 'lora@gmail.com'
          fill_in 'Password' , with: '123456'
          click_on 'Se connecter'
  
          visit tasks_path
          click_on 'Task registration'
  
          visit task_path(task.id)
          expect(page).to have_content 'tag1'
          expect(page).to have_content 'tag2'
  
        end
      end
  
      context 'When searching by label' do
        it 'shows the list of labels associated with the task on the screen' do
         user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
          tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
          tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
          task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
             priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
             FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
             FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
          visit tasks_path
          click_on 'Login'
          fill_in 'Email' , with: 'lora@gmail.com'
          fill_in 'Password' , with: '123456'
          click_on 'Se connecter'
  
          visit tasks_path
          # select 'tag1', from: 'Tag'
          select "tag1", from: "task_label" # find by id
          click_on 'Chercher'
          expect(page).to have_content 'tag1'
  
        end
      end
  
      context 'A user can create a label by himsel' do
        it 'can create a label' do
          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
           visit tasks_path
           click_on 'Login'
           fill_in 'Email' , with: 'lora@gmail.com'
           fill_in 'Password' , with: '123456'
           click_on 'Se connecter'
  
           # visit tasks_path
            # click_on 'Tag management'
            visit new_tag_path
            fill_in 'Name' , with: 'macro'
            click_on 'Enregistrer'
            expect(page).to have_content 'macro'
        end
      end
  
      context 'A user can create a label' do
        it 'use it only by himsel' do
          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
          user1 =   FactoryBot.create(:user2, name: 'Loren', email: 'lori@gmail.com', password: '123456')
          tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user1.id)
           visit tasks_path
           click_on 'Login'
           fill_in 'Email' , with: 'lora@gmail.com'
           fill_in 'Password' , with: '123456'
           click_on 'Se connecter'
  
           # visit tasks_path
            # click_on 'Tag management'
            visit tags_path
  
            expect(page).to_not have_content 'tag1'
        end
      end
  
      context 'When editing a task' do
        it 'a label associated with the task can also be removed' do
          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
           tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
  
           task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
              priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
              tagging  = FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
  
  
  
  
           visit tasks_path
           click_on 'Login'
           fill_in 'Email' , with: 'lora@gmail.com'
           fill_in 'Password' , with: '123456'
           click_on 'Se connecter'
           tagging.destroy
           visit edit_task_path(task)
  
           click_on 'Enregistrer'
           visit task_path(task)
           expect(page).not_to have_content 'tag1'
  
        end
      end
    end
  
  
  
  end