class SessionsController < ApplicationController
  skip_authorization_check
  
  def new
    session[:return_to] = params[:return_to] if params[:return_to]
    redirect_to "/auth/github" # Use Omniauth to authenticate.    
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    logger.info omniauth.inspect
    @user = User.find_and_update_from_omniauth(omniauth) || User.create_from_omniauth(omniauth)
    session[:user_id] = @user.id
    redirect_to_target_or_default projects_url, :notice => "Signed in successfully"
  end
  
  def failure
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"    
  end
end
