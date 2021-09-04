class UsersController < ApplicationController
  # create a new user for the sign up view
  def new
    @user = User.new
  end

  # create a new user based on the sign up form
  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
