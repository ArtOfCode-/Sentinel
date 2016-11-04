class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def verify_bot_authorized
    unless AuthorizedBot.find_by_key(params[:authorization]).present?
      render :plain => "YOU SHALL NOT PASS!", :status => 403
    end
  end

  def verify_admin
    unless current_user.has_role?(:admin)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
