#bundle exec rspec spec/system/label_spec.rb
require 'rails_helper'
RSpec.describe 'Label management function', type: :system do
    describe 'New creation function' do
      before do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:user2)
        #@labelling = FactoryBot.create(:labelling)
        @label = FactoryBot.create(:label)
        @second_label = FactoryBot.create(:second_label)
      end
      context 'When creating a new task' do
        it 'Multiple labels can be registered with it' do
            visit new_session_path
          fill_in 'Email', with: @user.email
          fill_in 'Password', with: @user.password
          click_button "Sign in"
          task = FactoryBot.create(:task, task_name: 'task1', priority: "High", user_id: @user.id)
          task_label_relation = FactoryBot.create(:task_label_relation, label_id: @label.id , task_id: task.id)
        #   task_label_relation = FactoryBot.create(:task_label_relation, label_id: @label2.id , task_id: task.id)
          visit tasks_path
          expect(page).to have_content 'task1'
        end
      end
      context 'When going on the task details screen' do
        it 'Output the list of labels associated with the task' do
            visit new_session_path
          fill_in 'Email', with: @user.email
          fill_in 'Password', with: @user.password
          click_button "Sign in"
          task = FactoryBot.create(:task, task_name: 'Learning RoR', task_details: 'We are on rails', priority: "Low", user_id: @user.id)
          task_label_relation1 = FactoryBot.create(:task_label_relation, label_id: @label.id , task_id: task.id)
        #   task_label_relation2 = FactoryBot.create(:task_label_relation, label_id: @label2.id , task_id: task.id)
          visit task_path(task.id)
          expect(page).to have_content 'Learning RoR'
        end
      end

      context 'When you search for label' do
        it "Tasks contain the labels are narrowed down" do
            visit new_session_path
          fill_in 'Email', with: @user.email
          fill_in 'Password', with: @user.password
          click_button "Sign in"
          search_label = "Commercial"
          visit tasks_path(label_id: @label.id)
          expect(page).to have_content 'Commercial'
        end
      end
    end
  end










# RSpec.describe 'Label management function', type: :system do
    
#     describe "Label test" do
#         context 'Create new Label' do
#             it 'Labels are displayed' do
#                 visit new_user_path
#                 fill_in "Username",	with: "JOHN"
#                 fill_in "Email",	with: "doe@fil.com"
#                 fill_in "Password",	with: "password" 
#                 fill_in "Password confirmation",	with: "password" 
#                 click_on "Create an account"
#                 visit new_label_path
#                 fill_in "Label name",	with: "Alpha" 
#                 click_on "Create Label"
#                 expect(page).to have_content 'Label was successfully created.'
#             end
#         end
#         context 'Create task with labels' do    
#             it 'create new task and add Label' do
#                 visit new_user_path
#                 fill_in "Username",	with: "JOHN"
#                 fill_in "Email",	with: "doe@fil.com"
#                 fill_in "Password",	with: "password" 
#                 fill_in "Password confirmation",	with: "password" 
#                 click_on "Create an account"
#                 visit new_label_path
#                 fill_in "Label name",	with: "Alpha" 
#                 click_on "Create Label"

#                 visit new_task_path
#                 fill_in 'task[task_name]', with: "Learning RoR"
#                 fill_in 'task[task_details]', with: "We are on rails"
#                 check 'Alpha'
#                 click_on 'Create Task'

#                 expect(page).to have_content 'Learning RoR'
#             end
#         end
#         context 'Create task with labels' do    
#             it 'Do a research on Label' do
#                 visit new_user_path
#                 fill_in "Username",	with: "JOHN"
#                 fill_in "Email",	with: "doe@fil.com"
#                 fill_in "Password",	with: "password" 
#                 fill_in "Password confirmation",	with: "password" 
#                 click_on "Create an account"

#                 visit new_label_path
#                 fill_in "Label name",	with: "Alpha" 
#                 click_on "Create Label"

#                 visit new_label_path
#                 fill_in "Label name",	with: "Beta" 
#                 click_on "Create Label"

#                 visit new_task_path
#                 fill_in 'task[task_name]', with: "Learning RoR"
#                 fill_in 'task[task_details]', with: "We are on rails"
#                 check 'Alpha'
#                 click_on 'Create Task'

#                 visit new_task_path
#                 fill_in 'task[task_name]', with: "Let's check"
#                 fill_in 'task[task_details]', with: "Ruby"
#                 check 'Beta'
#                 click_on 'Create Task'

#                 select 'Alpha',from: 'Label'
#                 click_on 'Search'
#                 expect(page).to have_content 'Learning RoR'
#             end
#         end
#     end
# end

# RSpec.describe 'Label management function', type: :system do
    
  
#     describe 'When Creating a task ' do
#       context 'We can attach multiple tags' do
#         it 'allows to attach multiple tags' do
#          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#           tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
#           tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
#           task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
#              priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
#              FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
#              FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
#           visit tasks_path
#           click_on 'Login'
#           fill_in 'Email' , with: 'lora@gmail.com'
#           fill_in 'Password' , with: '123456'
#           click_on 'Se connecter'
  
#           visit tasks_path
#           click_on 'Task registration'
  
#           visit task_path(task.id)
#           expect(page).to have_content 'task1'
  
#         end
#       end
  
#       context ' When Output a task details screen' do
#         it 'shows the list of labels associated with the task on the screen' do
#          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#           tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
#           tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
#           task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
#              priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
#              FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
#              FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
#           visit tasks_path
#           click_on 'Login'
#           fill_in 'Email' , with: 'lora@gmail.com'
#           fill_in 'Password' , with: '123456'
#           click_on 'Se connecter'
  
#           visit tasks_path
#           click_on 'Task registration'
  
#           visit task_path(task.id)
#           expect(page).to have_content 'tag1'
#           expect(page).to have_content 'tag2'
  
#         end
#       end
  
#       context 'When searching by label' do
#         it 'shows the list of labels associated with the task on the screen' do
#          user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#           tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
#           tag2 = FactoryBot.create(:tag2, name: 'tag2', user_id: user.id )
#           task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
#              priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
#              FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
#              FactoryBot.create(:tagging2, task_id: task.id, tag_id: tag2.id)
  
#           visit tasks_path
#           click_on 'Login'
#           fill_in 'Email' , with: 'lora@gmail.com'
#           fill_in 'Password' , with: '123456'
#           click_on 'Se connecter'
  
#           visit tasks_path
#           # select 'tag1', from: 'Tag'
#           select "tag1", from: "task_label" # find by id
#           click_on 'Chercher'
#           expect(page).to have_content 'tag1'
  
#         end
#       end
  
#       context 'A user can create a label by himsel' do
#         it 'can create a label' do
#           user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#            visit tasks_path
#            click_on 'Login'
#            fill_in 'Email' , with: 'lora@gmail.com'
#            fill_in 'Password' , with: '123456'
#            click_on 'Se connecter'
  
#            # visit tasks_path
#             # click_on 'Tag management'
#             visit new_tag_path
#             fill_in 'Name' , with: 'macro'
#             click_on 'Enregistrer'
#             expect(page).to have_content 'macro'
#         end
#       end
  
#       context 'A user can create a label' do
#         it 'use it only by himsel' do
#           user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#           user1 =   FactoryBot.create(:user2, name: 'Loren', email: 'lori@gmail.com', password: '123456')
#           tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user1.id)
#            visit tasks_path
#            click_on 'Login'
#            fill_in 'Email' , with: 'lora@gmail.com'
#            fill_in 'Password' , with: '123456'
#            click_on 'Se connecter'
  
#            # visit tasks_path
#             # click_on 'Tag management'
#             visit tags_path
  
#             expect(page).to_not have_content 'tag1'
#         end
#       end
  
#       context 'When editing a task' do
#         it 'a label associated with the task can also be removed' do
#           user =   FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
#            tag1 = FactoryBot.create(:tag1, name: 'tag1',user_id: user.id)
  
#            task = FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted',
#               priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
#               tagging  = FactoryBot.create(:tagging1, task_id: task.id, tag_id: tag1.id)
  
  
  
  
#            visit tasks_path
#            click_on 'Login'
#            fill_in 'Email' , with: 'lora@gmail.com'
#            fill_in 'Password' , with: '123456'
#            click_on 'Se connecter'
#            tagging.destroy
#            visit edit_task_path(task)
  
#            click_on 'Enregistrer'
#            visit task_path(task)
#            expect(page).not_to have_content 'tag1'
  
#         end
#       end
#     end
  
  
  
#   end