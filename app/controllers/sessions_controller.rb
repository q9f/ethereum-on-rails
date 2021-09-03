class SessionsController < ApplicationController
  # create a new session for the login view
  def create
    @user = User.find_by(username: params[:username])
    if @user and @user.authenticate(params[:password_digest])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # login failed - handle later (@TODO: @q9f)
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
