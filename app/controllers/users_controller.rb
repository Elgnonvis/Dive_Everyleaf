class UsersController < ApplicationController

  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Compte crée avec succès, vous pouvez vous connectez'
      redirect_to profil_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:avatar, :name, :username, :email, :password)
      if @user.update(user_params)
        flash[:success] = "Votre compte a été mis à jour avec succès"
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
