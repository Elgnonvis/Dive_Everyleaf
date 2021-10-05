class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]
  before_action :is_admin

  def index
    # if current_user.admin
      @users = User.all
      # @users = @users.page(params[:page]).per(10)
    # else
      
    #   redirect_to tasks_path
    # end
  end
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User account has been successfully created"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:danger] = "User credentials has been successfully updated"
      redirect_to admin_users_path
    else
      render :new
    end
  end
  
  def show
  end

  def destroy
    @user.destroy
    flash[:danger] = "User account has been successfully destroyed"
    redirect_to admin_users_path
  end
  

  
  


  def role
    @user = User.find(params[:id])
    current = @user.admin
    @user.save(validate:false)

    if current == @user.admin
      flash[:danger] = "You cannot change your role. You are the only admin"
      redirect_to admin_users_path
    else
      flash[:warning] = "Role of #{@user.email} has been changed"
      redirect_to admin_users_path
    end
  end
  

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

  def is_admin
    if current_user
      unless current_user.admin?
        flash[:danger] = "Only the administrators can access it"
        redirect_to tasks_path
      end  
    else
      redirect_to new_session_path
    end
  end  
end