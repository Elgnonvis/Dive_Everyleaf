class UsersController < ApplicationController

  skip_before_action :login_required, only: [:new, :create]


  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are login in'
      redirect_to user_path
    else
      render :new
    end
  end

  def show
    @user = current_user
    
  end

  def edit
    @user = current_user
    # @user = User.find(params[:id])
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:firstname, :email, :lastname, :admin)
      if @user.update(user_params)
        flash[:warning] = "Profil edited successfuly!"
        render :show
      else
        render :edit
      end
  end


  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname)
  end
end
