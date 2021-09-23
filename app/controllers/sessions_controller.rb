require 'eth'

class SessionsController < ApplicationController

  # no need to initialize the session
  def new; end

  # logs in a user
  def create

    # users are indexed by eth address here
    user = User.find_by(eth_address: params[:eth_address])

    # if the user with the eth address is on record, proceed
    if user.present?

      # if the user signed the message, proceed
      if params[:signature]

        # the nonce is random and the signature comes from the ethereum wallet
        signature = params[:signature]
        user_nonce = params[:eth_nonce]
        user_address = user.eth_address

        # in future, to provide security, the nonce should be persisted in
        # the database to avoid signature spoofing. instead of signing a
        # random nonce, make the user sign a specific nonce on log-in.
        # regenerate a new random nonce in the database only upon
        # successful log-in. currently, if someone is able to intercept
        # the nonce and the signature, they would be able to reuse them.

        # recover address from signature
        signature_pubkey = Eth::Key.personal_recover user_nonce, signature
        signature_address = Eth::Utils.public_key_to_address signature_pubkey

        # if the recovered address matches the user address on record, proceed
        if user_address.downcase.eql? signature_address.downcase

          # if this is true, the user is cryptographically authenticated!
          session[:user_id] = user.id

          # rotate the random nonce to prevent signature spoofing
          user.eth_nonce = SecureRandom.uuid
          user.save

          # send the logged in user back home
          redirect_to root_path, notice: "Logged in successfully"
        else

          # signature address does not match our records
          flash.now[:alert] = "Signature verification failed!"
          render :new
        end

      else

        # user did not sign the message
        flash.now[:alert] = "Please sign the messagein MetaMask!"
        render :new
      end
    else

      # user not found in database
      flash.now[:alert] = "No such user exists, try to sign up!"
      render :new
    end
  end

  # logs out the user
  def destroy

    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out.'
  end
end
