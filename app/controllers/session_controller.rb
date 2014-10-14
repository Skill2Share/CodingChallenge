class SessionController < ApplicationController
  skip_before_filter :get_user, only: [:new, :login]
  before_filter :redirect_logged_in, only: [:new, :login]

  def new
  end

  def redirect_logged_in
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to marketposts_all_path
    end
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:redirect_url]
        redirect_to session[:redirect_url] and return
      else
        redirect_to marketposts_all_path, :notice => t('main_page.message.welcome') + " " + user.name and return
      end
    else
      flash.now.alert = t('login_page.error_login')
      render "new"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
