class ApplicationController < ActionController::Base

  # for Authlogic
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = 'ログインしてください。'
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = 'ログアウトしてください。'
      redirect_to user_url
      return false
    end
  end

end
