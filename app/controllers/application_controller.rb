class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :api_url

  protected
  def verify_bot_authorized
    @bot = AuthorizedBot.find_by_key(params[:authorization])
    unless @bot.present?
      render :plain => "YOU SHALL NOT PASS!", :status => 403
    end
  end

  def verify_admin
    unless current_user.has_role?(:admin)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def api_url(path, user = nil, params = {})
    url = "https://api.stackexchange.com/2.2#{path}?key=#{AppConfig['se_api_key']}"
    if user&.stack_user
      url += "&access_token=#{user.stack_user.access_token}"
    end

    params.each do |key, val|
      url += "&#{key.to_s}=#{val.to_s}"
    end

    url
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
