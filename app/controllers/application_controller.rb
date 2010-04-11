class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def authenticate
    login_success = authenticate_or_request_with_http_basic do |username, password|
      actual_password = ENV['ADMIN_PASSWORD'] || "secret"
      username == "admin" && password == actual_password
    end
    session[:admin] = "admin" if login_success == true
  end

  helper_method :admin?
  def admin?
    session[:admin] || false
  end

end
