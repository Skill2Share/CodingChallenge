class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_user
  before_filter :set_locale
  
  def default_url_options(options = {})
    {locale: I18n.locale}
  end
  
  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    session[:redirect_url] = request.url unless @current_user or request.method == "POST"
    redirect_to new_session_path unless @current_user
  end

end
