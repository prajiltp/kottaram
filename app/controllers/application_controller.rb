class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_and_configure, :set_time_zone

  def authenticate_and_configure
  	redirect_to root_path unless current_user
  end

  alias devise_current_user current_user
  def current_user
    devise_current_user || token_user
  end

  def token_user
    @token_user ||= begin
      token = request.headers['AuthorizationToken']
      User.find_by_access_token(token) if token
    end
  end

  def set_time_zone
    Time.zone = 'Chennai'
  end
end
