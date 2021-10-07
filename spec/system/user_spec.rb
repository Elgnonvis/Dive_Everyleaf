#bundle exec rspec spec/system/user_spec.rb
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
                fill_in "Username",	with: "JOHN"
                fill_in "Email",	with: "doe@fil.com"
                fill_in "Password",	with: "password" 
                fill_in "Password confirmation",	with: "password" 
                click_on "Create an account"
                expect(page).to have_content "General tasks list" 
            end
        end

        context "When the user tries to jump to the task list screen without logging in, transition to the login screen" do
            it "transit to login screen" do
                visit tasks_path
                expect(page).to have_content "Sign in" 
            end
            
        end
    end 

    describe "Testing session functionality" do
        context "Be able to log in" do
            it "log in" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "no.admin" 
                click_on("Sign in")
                expect(page).to have_content "General tasks list" 
            end
        end
        
        context "You can jump to your details screen (My Page)" do
            it "go to my page" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "no.admin" 
                click_on("Sign in")
                visit profil_path
                expect(page).to have_content "no.admin@gmail.com" 
            end
        end
    
        context "When a general user jumps to another person's details screen, it will transition to the task list screen" do
            it "not go to another person's details screen" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "no.admin" 
                click_on("Sign in")
                visit admin_users_path
                expect(page).to have_content "General tasks list" 
            end
            
        end
        
        context "Be able to log out" do
            it "log out" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "no.admin" 
                click_on("Sign in")

                # # page.find(:xpath, "//a[@href='/users/sign_out']").click
                # # select "Log Out", :from => "dropdownUser"
                # # select("Log Out", from: "dropdownUser").select_option
                # # find(:option, value, options).select_option
                # find('#dropdownUser').all(:css, 'dropdown').find { |o| o.value == 'Log Out' }.select_option

                # find('#dropdownUser').click
                click_on 'Log out'
                # click_on("Logout")
                expect(page).to have_content "Sign in" 
            end
            
        end
        
    end

    describe "Admin screen test" do
        context "Admin users should be able to access the admin screen" do
            it "access admin screen" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Sign in")
                click_on("Users Management")
                # visit admin_users_path
            # expect(page).not_to have_content 'List Users'
                expect(page).to have_content "Users Management's Page" 
            end
            
        end
        
        context "General users cannot access the management screen" do
            it "not access admin screen" do
                visit new_session_path
                fill_in "Email",	with: "no.admin@gmail.com" 
                fill_in "Password",	with: "no.admin" 
                click_on("Sign in")
                click_on("Users Management")
                expect(page).to have_content "General tasks list" 
            end
            
        end
        
        context "Admin users can register new users" do
            it "register new user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Sign in")
                visit admin_users_path
                click_on("Add new User")
                fill_in "Username",	with: "JOHN"
                fill_in "Email",	with: "doe@fil.com" 
                fill_in "Password",	with: "password"
                click_on "Create account"
                expect(page).to have_content "doe@fil.com" 
            end
            
        end
        
        context "Admin users should be able to access the user details screen" do
            it "user details screen" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Sign in")
                visit admin_user_path(@user.id)
                expect(page).to have_content "no.admin@gmail.com" 
            end
            
        end
        
        context "The admin user can edit the user from the user edit screen" do
            it "edit another user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Sign in")
                visit edit_admin_user_path(@user.id)
                fill_in "Username",	with: "JOHN"
                fill_in "Email",	with: "doe@fil.com" 
                fill_in "Password",	with: "password"
                click_on "Update account"
                expect(page).to have_content "User credentials has been successfully updated" 
            end
            
        end
        
        context "Admin users can delete users" do
            it "delete another user" do
                visit new_session_path
                fill_in "Email",	with: "admin@gmail.com" 
                fill_in "Password",	with: "password" 
                click_on("Sign in")
                visit admin_users_path
                expect(page).to have_content "Destroy" 
            end
            
        end
    end    
end


# context "Vous pouvez accéder à votre écran de détails (Ma page)" do
#     it "L'utilisateur connecté peut accéder à ses taches" do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@mail.com'
#         fill_in 'session[password]', with: '123456'
#         click_on 'Log in'
#         click_on 'My Tasks'
#         expect(page).to have_content 'test'
#     end
# end