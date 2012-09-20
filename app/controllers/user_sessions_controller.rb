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

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      session[:id] = @user_session.id
      flash[:notice] = "Hello #{@user_session.user.name}, you are now logged in"
      redirect_to(posts_path)
    else
      redirect_to(login_path)
    end
  end

  def destroy
    UserSession.destroy(@application_session)
    session[:id] = @user = nil
    flash[:notice] = "You are now logged out"
    redirect_to(root_url)
  end
end
