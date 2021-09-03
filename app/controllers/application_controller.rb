class ApplicationController < ActionController::Base

  # make the helper methods available in our views
  helper_method :current_user
  helper_method :logged_in?

  # handle current user information
  def current_user
    User.find_by(id: session[:user_id])
  end

  # is anybody here? ;)
  def logged_in?
    !current_user.nil?
  end
end
