require 'rails_helper'
RSpec.describe 'user manager', type: :system do
    before do
        @user = FactoryBot.create(:user)
        @user_admin = FactoryBot.create(:user_admin)
    end
    
    describe "User registration test" do
        context "Being able to newly register users" do
            it "register a new user" do
                visit new_user_path
                fill_in "Email",	with: "doe@fil.com" 
                fill_in "Password",	with: "password" 
                fill_in "Confirm Password",	with: "password" 
                click_on "Submit"
                expect(page).to have_content "Profile" 
            end
        end

        context "When the user tries to jump to the task list screen without logging in, transition to the login screen" do
            it "transit to login screen" do
                visit tasks_path
                expect(page).to have_content "Login" 
            end
            
        end
    end 

    describe "Testing session functionality" do
        context "Be able to log in" do
            it "log in" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                expect(page).to have_content "no.admin@gmail.com" 
            end
        end
        
        context "You can jump to your details screen (My Page)" do
            it "go to my page" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                visit user_path(@user.id)
                expect(page).to have_content "no.admin@gmail.com" 
            end
        end
        
        context "When a general user jumps to another person's details screen, it will transition to the task list screen" do
            it "not go to another person's details screen" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                visit user_path(@user_admin.id)
                expect(page).to have_content "Task List" 
            end
            
        end
        
        context "Be able to log out" do
            it "log out" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                click_on("Logout")
                expect(page).to have_content "Login" 
            end
            
        end
        
    end

    describe "Admin screen test" do
        context "Admin users should be able to access the admin screen" do
            it "access admin screen" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                expect(page).to have_content "Administration" 
            end
            
        end
        
        context "General users cannot access the management screen" do
            it "not access admin screen" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                expect(page).to have_no_content "Administration" 
            end
            
        end
        
        context "Admin users can register new users" do
            it "register new user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                click_on("Create user")
                fill_in "Email",	with: "doe@fil.com" 
                fill_in "Password",	with: "password" 
                fill_in "Confirm Password",	with: "password" 
                click_on "Submit"
                expect(page).to have_content "doe@fil.com" 
            end
            
        end
        
        context "Admin users should be able to access the user details screen" do
            it "user details screen" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                visit admin_user_path(@user.id)
                expect(page).to have_content "no.admin@gmail.com" 
            end
            
        end
        
        context "The admin user can edit the user from the user edit screen" do
            it "edit another user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                visit edit_admin_user_path(@user.id)
                fill_in "Email",	with: "doe@fil.com" 
                fill_in "Password",	with: "password" 
                fill_in "Confirm Password",	with: "password" 
                click_on "Submit"
                expect(page).to have_content "User credentials update" 
            end
            
        end
        
        context "Admin users can delete users" do
            it "delete another user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Submit")
                visit admin_users_path
                first(".delete").click
                expect(page).to have_content "Delete successfully" 
            end
            
        end
    end    
end