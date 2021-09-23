class ApplicationController < ActionController::Base

  # make the helper methods available in our views
  helper_method :current_user
  helper_method :logged_in?
  helper_method :get_new_nonce

  # handle current user information
  def current_user
    User.find_by(id: session[:user_id])
  end

  # is anybody here? ;)
  def logged_in?
    !current_user.nil?
  end

  # need to generate new nonce for sign ups
  def get_new_nonce
    SecureRandom.uuid
  end
end
