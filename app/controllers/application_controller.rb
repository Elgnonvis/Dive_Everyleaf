class ApplicationController < ActionController::Base
    
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required
    
    private
    def login_required
        redirect_to new_session_path unless current_user   
    end
    def admin
        flash[:danger] = "Only for Admin!" unless current_user.admin
        redirect_to tasks_path   
    end
end