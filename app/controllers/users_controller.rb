require 'eth'

class UsersController < ApplicationController

  # instantiate a new user
  def new
    @user = User.new
  end

  # create a new user based on user input
  def create

    # create new user from allowed params
    @user = User.new(user_params)

    # create randome nonce
    @user.eth_nonce = SecureRandom.uuid

    # usually, we want to let the user sign the nonce to make sure
    # they are authorized to create a new user account for the
    # given 4thereum address. for the demo, we skip this for the
    # sake of keeping it simple.

    # only proceed with eth address
    if @user.eth_address

      # make sure the eth address is valid
      address = Eth::Address.new @user.eth_address
      if address.valid?

        # save to database
        if @user.save

          # create user session and send them back to home
          session[:user_id] = @user.id
          redirect_to root_path, notice: 'Successfully created account.'
        else

          # if it fails, eth address is already in database, stay on signup
          flash.now[:alert] = "Account already exists! Try to log in instead!"
          render :new
        end
      else

        # if it fails, the eth address is not valid, stay on signup
        flash.now[:alert] = "Invalid Ethereum address!"
        render :new
      end
    else

      # if it fails, the process was interupted, stay on signup
      flash.now[:alert] = "Failed to get Ethereum address!"
      render :new
    end
  end

  private
  def user_params
    # only allow user to control name, password, signature, and address
    params.require(:user).permit(:username, :password, :signature, :eth_nonce, :eth_address)
  end
end
