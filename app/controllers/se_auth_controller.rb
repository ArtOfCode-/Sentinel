class SeAuthController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_no_auth

  def initiate
  end

  def redirect
    client_id = Rails.application.config.se_client_id
    redirect_uri = url_for(:controller => :se_auth, :action => :target)
    scope = 'no_expiry,write_access'
    auth_state = Digest::SHA256.hexdigest("#{current_user.username}#{rand(0..9e9)}")

    current_user.auth_state = auth_state
    if current_user.save
      redirect_to "https://stackexchange.com/oauth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}&state=#{auth_state}"
    else
      flash[:danger] = "Couldn't save a pre-auth token to your user account. Try again later, and contact a dev if the problem persists."
      redirect_to url_for(:controller => :se_auth, :action => :initiate)
    end
  end

  def target
    if current_user.auth_state.present? && current_user.auth_state == params[:state]
      token = current_user.get_access_token(params[:code], request.host_with_post)

      stack_user = StackUser.new(:user => current_user, :access_token => token)
      if stack_user.save
        if stack_user.update_details
          flash[:success] = "Authentication complete."
          redirect_to url_for(:controller => :se_auth, :action => :already_done)
        else
          flash[:danger] = "Can't update the user details on your user. Try again later, and contact a dev if the problem persists."
          redirect_to url_for(:controller => :se_auth, :action => :initiate)
        end
      else
        flash[:danger] = "Can't create a record for your Stack Exchange user. Try again later, and contact a dev if the problem persists."
        redirect_to url_for(:controller => :se_auth, :action => :initiate)
      end
    end
  end

  def already_done
  end

  private
  def verify_no_auth
    if current_user.stack_user.present?
      redirect_to url_for(:controller => :se_auth, :action => :already_done)
    end
  end
end
