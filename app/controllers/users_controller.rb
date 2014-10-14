class UsersController < ApplicationController
  skip_before_filter :get_user, only: [:new, :create]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @marketposts = Marketpost.where(:hidden_marketpost => false).where(:user_id => @user.id)
    respond_to do |format|
      format.html
      format.json { render json: @user }
      format.mobile
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    redirect_to root_url if session[:user_id]

    respond_to do |format|
      format.html
      format.json { render json: @user }
      format.mobile
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to @user if @current_user != @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    redirect_to root_url if session[:user_id]
    @user.admin = false

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        flash[:alert] = t('main_page.message.welcome') + " " + @user.name
        format.html { redirect_to marketposts_all_path }
      else
        flash[:alert] = @user.errors.empty? ? "Error" : @user.errors.full_messages.to_sentence
        format.html { redirect_to root_url }
      end
    end
  end

end
