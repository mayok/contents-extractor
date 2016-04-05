class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :update, :token]
  before_action :correct_user,   only: [:show, :update, :token]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome"
      redirect_to root_url
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'show'
    end
  end

  def destroy
  end

  def token
    user = User.find(params[:id])
    user.update_attribute(:token, User.new_token)
    redirect_to user
  end

  private
    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                  )
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
