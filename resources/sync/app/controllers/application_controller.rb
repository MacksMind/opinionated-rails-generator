class ApplicationController < ActionController::Base
  include ::SslRequirement
  protect_from_forgery
  before_filter :set_time_zone

  private

  def set_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end

  def ssl_required?
    return super if Rails.env.production?
    false
  end
end
