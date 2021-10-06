class SessionsController < ApplicationController

  skip_before_action :login_required, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]
  
  def new
    @user = User.new
    redirect_to tasks_path if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Your are successfully connected (log in) !'
      redirect_to tasks_url
      else
        flash[:danger] = 'Identifiants incorrects'
        render :new
    end
  end

  def destroy
    session.destroy
    flash[:success] = 'Déconnexion réussie !'
    redirect_to new_session_path
  end
end