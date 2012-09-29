class UserSessionsController < ApplicationController

  before_filter :require_user, :only => :destroy
  before_filter :require_no_user, :only => [:new, :create]

  def index
    redirect_to(new_user_session_path)
  end

  def new
    @user = User.new
    @user_session = UserSession.new

  end

  # POST /user_sessions
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      session[:id] = @user_session.id
      redirect_to posts_path, :notice => "Hello #{@user_session.user.name.capitalize}, you are now logged in."
    else
      redirect_to(login_path)
    end
  end

  # DELETE /user_sessions
  def destroy
    UserSession.destroy(@application_session)
    session[:id] = @user = nil
    redirect_to root_url, :notice => "You are now logged out."
  end
end
