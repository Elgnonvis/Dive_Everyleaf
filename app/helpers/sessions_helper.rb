module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    def logged_in?
        current_user.present?
    end
    def only_signed_out
        redirect_to profil_path if logged_in?
    end
end
