require 'exceptions'

class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to projects_path, :alert => exception.message
    else
      require_user!
    end
  end

  rescue_from Github::NotFound do |exception|

    ActiveRecord::Base.logger.error{"\n\n\n\n *************** GITHUB ERROR"}
    ActiveRecord::Base.logger.error{"*************** #{exception.path}  ==  #{exception.query}"}
    ActiveRecord::Base.logger.error{"***************\n\n\n\n"}
    error_hash = { :error => exception.message }
    
    respond_to do |format|
      format.html   { redirect_to (current_user ? projects_path : root_path), :alert => exception.message }
      format.xml    { render :xml  => error_hash.to_xml,  :status => :unprocessable_entity }
      format.json   { render :json => error_hash.to_json, :status => :unprocessable_entity }
      format.js     { render :text => error_hash[:error], :status => :unprocessable_entity }
    end
    
  end

  private

  def require_user!
    unless current_user
      error = "You must be logged in to access this page."
      redirect_to root_path, :alert => error and return
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  def redirect_to_target_or_default(default, *options)
    redirect_to(session[:return_to] || default, *options)
    session[:return_to] = nil
  end

  def store_target_location
    session[:return_to] = request.url
  end
end
