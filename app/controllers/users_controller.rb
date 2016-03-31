class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome"
      redirect_to @user
    else
      render new_user_path
    end
  end

  def show
  end

  def edit
  end

  def udpate
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation
                                  )
    end
end
