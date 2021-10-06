class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]

  def index
    # @user = User.all
  end

  def new
    @user = User.new
    redirect_to tasks_path if current_user
  end

  def create
    @user = User.new(user_params)
    @user.admin = false
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are login in'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    # @user = current_user
    # @user = User.find(params[:id])
  end

  def update
    @user = current_user
    update_params = params.require(:user).permit(:lastname, :firstname, :email, :password)
      if @user.update(update_params)
        flash[:success] = "Profil edited successfuly!"
        redirect_to tasks_path
      else
        render :edit
      end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
