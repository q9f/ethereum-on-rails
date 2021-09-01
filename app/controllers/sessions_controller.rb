class SessionsController < ApplicationController
  # create a new session for the login view
  def new
    @session = Session.new
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user and @user.authenticate(params[:digest])
      sessions[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
end
