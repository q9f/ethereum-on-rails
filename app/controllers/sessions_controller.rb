require 'eth'
require 'time'

class SessionsController < ApplicationController

  # no need to initialize the session
  def new; end

  # logs in a user using an ethereum account
  def create

    # users are indexed by eth address here
    user = User.find_by(eth_address: params[:eth_address])

    # if the user with the eth address is on record, proceed
    if user.present?

      # if the user signed the message, proceed
      if params[:eth_signature]

        # the message is random and has to be signed in the ethereum wallet
        message = params[:eth_message]
        signature = params[:eth_signature]

        # note, we use the user address from our database, not from the form
        user_address = user.eth_address

        # in future, to enhance security, the nonce should be persisted in
        # the database to avoid signature spoofing. instead of signing a
        # random nonce, make the user sign a specific nonce on log-in.
        # regenerate a new random nonce in the database only upon
        # successful log-in. currently, if someone is able to intercept
        # the nonce and the signature, they would be able to reuse them.
        #
        # for now:
        # to significantly reduce probability of signature spoofing, we embed
        # the time of the request in the signed message and make sure it's
        # not older than 5 minutes. expired signatures will be rejected.
        request_time, eth_nonce = message.split(',')
        request_time = Time.at(request_time.to_f / 1000.0)
        expiry_time = request_time + 300

        # also make sure the parsed request_time is sane
        # (not nil, not 0, not off by orders of magnitude)
        sane_checkpoint = Time.parse "2021-01-01 00:00:00 UTC"
        if request_time and request_time > sane_checkpoint and request_time < expiry_time

          # recover address from signature
          signature_pubkey = Eth::Key.personal_recover message, signature
          signature_address = Eth::Utils.public_key_to_address signature_pubkey

          # if the recovered address matches the user address on record, proceed
          if user_address.downcase.eql? signature_address.downcase

            # if this is true, the user is cryptographically authenticated!
            session[:user_id] = user.id

            # rotate the random nonce to prevent signature spoofing
            # (unimplemented: we do not use this, yet, but let's update it anyways)
            user.eth_nonce = SecureRandom.uuid
            user.save

            # send the logged in user back home
            redirect_to root_path, notice: "Logged in successfully!"
          else

            # signature address does not match our records
            flash.now[:alert] = "Signature verification failed!"
            render :new
          end
        else

          # signature expired, older than 5 minutes
          flash.now[:alert] = "Signature expired, please try again!"
          render :new
        end
      else

        # user did not sign the message
        flash.now[:alert] = "Please, sign the message in your Ethereum wallet!"
        render :new
      end
    else

      # user not found in database
      redirect_to signup_path, alert: "No such user exists, try to sign up!"
    end
  end

  # logs out the user
  def destroy

    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out.'
  end
end
