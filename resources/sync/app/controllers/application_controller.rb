class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_time_zone
  check_authorization :unless => :devise_controller?

  private

  def stored_location_for(resource_or_scope)
    params[:return_to] || super
  end

  helper_method :user_root_path
  def user_root_path
    contents_path :action => 'home'
  end

  def set_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end
end
